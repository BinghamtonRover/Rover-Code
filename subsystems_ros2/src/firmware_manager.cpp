#include <glob.h>
#include <memory>
#include <string>
#include <thread>
#include <vector>
#include <deque>
#include <mutex>

#include "boost/asio.hpp"
#include "rclcpp/rclcpp.hpp"
#include "subsystems_ros2/msg/wrapped_protobuf.hpp"
#include "subsystems_ros2/utils.hpp"
#include "subsystems_ros2/generated/arm.pb.h"
#include "subsystems_ros2/generated/control.pb.h"
#include "subsystems_ros2/generated/core.pb.h"
#include "subsystems_ros2/generated/drive.pb.h"
#include "subsystems_ros2/generated/relays.pb.h"
#include "subsystems_ros2/generated/science.pb.h"
#include "subsystems_ros2/generated/wrapper.pb.h"

namespace subsystems_ros2
{

// Simple length-prefixed framing: [0xAA 0xBB][uint16_t length][payload]
class SerialFramer
{
public:
  static std::vector<uint8_t> frame(const std::string & payload)
  {
    std::vector<uint8_t> result;
    if (payload.size() > UINT16_MAX) {
      return result;
    }
    result.push_back(0xAA);
    result.push_back(0xBB);
    uint16_t length = static_cast<uint16_t>(payload.size());
    result.push_back(static_cast<uint8_t>(length >> 8));
    result.push_back(static_cast<uint8_t>(length & 0xFF));
    result.insert(result.end(), payload.begin(), payload.end());
    return result;
  }

  // Returns true if a complete frame was extracted.
  bool deframe(std::vector<uint8_t> & out_payload)
  {
    out_payload.clear();
    while (true) {
      if (buffer_.size() < HEADER_SIZE) {
        return false;
      }
      if (buffer_[0] != 0xAA || buffer_[1] != 0xBB) {
        buffer_.erase(buffer_.begin());
        continue;
      }
      uint16_t length = (static_cast<uint16_t>(buffer_[2]) << 8) | static_cast<uint16_t>(buffer_[3]);
      if (buffer_.size() < HEADER_SIZE + length) {
        return false;
      }
      out_payload.assign(buffer_.begin() + HEADER_SIZE, buffer_.begin() + HEADER_SIZE + length);
      buffer_.erase(buffer_.begin(), buffer_.begin() + HEADER_SIZE + length);
      return true;
    }
  }

  void append(const std::vector<uint8_t> & data)
  {
    buffer_.insert(buffer_.end(), data.begin(), data.end());
  }

private:
  static constexpr size_t HEADER_SIZE = 4;
  std::vector<uint8_t> buffer_;
};

class FirmwareDevice : public std::enable_shared_from_this<FirmwareDevice>
{
public:
  using DataCallback = std::function<void(FirmwareDevice *, const std::vector<uint8_t> &)>;
  using ErrorCallback = std::function<void(const std::string &)>;
  using ConnectedCallback = std::function<void(FirmwareDevice *)>;

  enum class State { UNINITIALIZED, CONNECTED, ERROR };

  FirmwareDevice(
    boost::asio::io_context & io,
    const std::string & port,
    rclcpp::Logger logger,
    DataCallback data_cb,
    ErrorCallback error_cb,
    ConnectedCallback connected_cb)
  : io_context_(io), port_(port), logger_(logger), data_callback_(std::move(data_cb)),
    error_callback_(std::move(error_cb)), connected_callback_(std::move(connected_cb)),
    device_(FIRMWARE), serial_port_(io_context_), timer_(io_context_)
  {
  }

  ~FirmwareDevice()
  {
    dispose();
  }

  void start()
  {
    try {
      serial_port_.open(port_);
      serial_port_.set_option(boost::asio::serial_port_base::baud_rate(9600));
      serial_port_.set_option(boost::asio::serial_port_base::character_size(8));
      serial_port_.set_option(boost::asio::serial_port_base::parity(boost::asio::serial_port_base::parity::none));
      serial_port_.set_option(boost::asio::serial_port_base::stop_bits(boost::asio::serial_port_base::stop_bits::one));
    } catch (const std::exception & e) {
      RCLCPP_WARN(logger_, "Could not open firmware device on port %s: %s", port_.c_str(), e.what());
      transitionError("open failed");
      return;
    }

    doResetWrite();
  }

  void doResetWrite()
  {
    static const char reset_code[] = {0, 0, 0, 0};
    boost::asio::async_write(
      serial_port_, boost::asio::buffer(reset_code, sizeof(reset_code)),
      [this, self = shared_from_this()](const boost::system::error_code & error, std::size_t)
      {
        if (error) {
          transitionError("reset write failed");
          return;
        }
        timer_.expires_after(std::chrono::milliseconds(100));
        timer_.async_wait([this, self = shared_from_this()](const boost::system::error_code & timer_error)
        {
          if (timer_error) {
            return;
          }
          doResetRead();
        });
      });
  }

  void doResetRead()
  {
    init_read_buffer_.assign(4, 0);
    boost::asio::async_read(
      serial_port_, boost::asio::buffer(init_read_buffer_),
      [this, self = shared_from_this()](const boost::system::error_code & error, std::size_t)
      {
        if (error) {
          transitionError("reset read failed");
          return;
        }
        for (char c : init_read_buffer_) {
          if (c != 1) {
            transitionError("reset response invalid");
            return;
          }
        }
        doHandshakeWrite();
      });
  }

  void doHandshakeWrite()
  {
    Connect handshake;
    handshake.set_sender(SUBSYSTEMS);
    handshake.set_receiver(FIRMWARE);
    handshake_write_buffer_ = handshake.SerializeAsString();
    boost::asio::async_write(
      serial_port_, boost::asio::buffer(handshake_write_buffer_),
      [this, self = shared_from_this()](const boost::system::error_code & error, std::size_t)
      {
        if (error) {
          transitionError("handshake write failed");
          return;
        }
        timer_.expires_after(std::chrono::milliseconds(200));
        timer_.async_wait([this, self = shared_from_this()](const boost::system::error_code & timer_error)
        {
          if (timer_error) {
            return;
          }
          doHandshakeRead();
        });
      });
  }

  void doHandshakeRead()
  {
    init_read_buffer_.assign(4, 0);
    boost::asio::async_read(
      serial_port_, boost::asio::buffer(init_read_buffer_),
      [this, self = shared_from_this()](const boost::system::error_code & error, std::size_t)
      {
        if (error) {
          transitionError("handshake read failed");
          return;
        }
        Connect message;
        if (!message.ParseFromArray(init_read_buffer_.data(), static_cast<int>(init_read_buffer_.size()))) {
          transitionError("handshake parse failed");
          return;
        }
        if (message.receiver() != SUBSYSTEMS) {
          transitionError("handshake receiver mismatch");
          return;
        }
        device_ = message.sender();
        {
          std::lock_guard<std::mutex> lock(state_mutex_);
          state_ = State::CONNECTED;
        }
        RCLCPP_INFO(logger_, "Connected to the %s Teensy on port %s", Device_Name(device_).c_str(), port_.c_str());
        if (connected_callback_) {
          connected_callback_(this);
        }
        startRead();
      });
  }

  void dispose()
  {
    timer_.cancel();
    if (serial_port_.is_open()) {
      boost::system::error_code ec;
      serial_port_.close(ec);
    }
  }

  void sendBytes(const std::string & data)
  {
    {
      std::lock_guard<std::mutex> lock(state_mutex_);
      if (state_ != State::CONNECTED) {
        return;
      }
    }
    auto framed = SerialFramer::frame(data);
    if (framed.empty()) {
      return;
    }
    {
      std::lock_guard<std::mutex> lock(write_queue_mutex_);
      bool writing = !write_queue_.empty();
      write_queue_.push_back(std::move(framed));
      if (!writing) {
        doWrite();
      }
    }
  }

  Device device() const { return device_; }
  const std::string & port() const { return port_; }
  State state() const
  {
    std::lock_guard<std::mutex> lock(state_mutex_);
    return state_;
  }

private:
  void startRead()
  {
    read_buffer_.resize(1024);
    serial_port_.async_read_some(
      boost::asio::buffer(read_buffer_),
      [this](const boost::system::error_code & error, std::size_t bytes_transferred)
      {
        if (error || bytes_transferred == 0) {
          transitionError("read error");
          return;
        }
        framer_.append(std::vector<uint8_t>(read_buffer_.begin(), read_buffer_.begin() + bytes_transferred));
        std::vector<uint8_t> payload;
        while (framer_.deframe(payload)) {
          if (data_callback_) {
            data_callback_(this, payload);
          }
        }
        startRead();
      });
  }

  void doWrite()
  {
    {
      std::lock_guard<std::mutex> lock(write_queue_mutex_);
      if (write_queue_.empty()) {
        return;
      }
      current_write_data_ = std::move(write_queue_.front());
      write_queue_.pop_front();
    }
    boost::asio::async_write(
      serial_port_, boost::asio::buffer(current_write_data_),
      [this, self = shared_from_this()](const boost::system::error_code & error, std::size_t)
      {
        if (error) {
          transitionError("write error");
          return;
        }
        doWrite();
      });
  }

  void transitionError(const std::string & reason)
  {
    {
      std::lock_guard<std::mutex> lock(state_mutex_);
      if (state_ == State::ERROR) {
        return;
      }
      state_ = State::ERROR;
    }
    RCLCPP_WARN(logger_, "Device on port %s entered error state: %s", port_.c_str(), reason.c_str());
    dispose();
    if (error_callback_) {
      error_callback_(port_);
    }
  }

  boost::asio::io_context & io_context_;
  std::string port_;
  rclcpp::Logger logger_;
  DataCallback data_callback_;
  ErrorCallback error_callback_;
  ConnectedCallback connected_callback_;
  Device device_;
  State state_ = State::UNINITIALIZED;
  mutable std::mutex state_mutex_;

  boost::asio::serial_port serial_port_;
  boost::asio::steady_timer timer_;
  std::vector<char> read_buffer_;
  std::vector<char> init_read_buffer_;
  std::string handshake_write_buffer_;
  SerialFramer framer_;

  std::mutex write_queue_mutex_;
  std::deque<std::vector<uint8_t>> write_queue_;
  std::vector<uint8_t> current_write_data_;
};

class FirmwareManager : public rclcpp::Node
{
public:
  FirmwareManager()
  : Node("firmware_manager")
  {
    this->declare_parameter<std::vector<std::string>>("port_patterns", std::vector<std::string>{"/dev/ttyACM*", "/dev/ttyUSB*"});

    incoming_sub_ = this->create_subscription<WrappedProtobuf>(
      "/burt/incoming", 100,
      std::bind(&FirmwareManager::onIncoming, this, std::placeholders::_1));
    outgoing_pub_ = this->create_publisher<WrappedProtobuf>("/burt/outgoing", 100);

    discovery_timer_ = this->create_wall_timer(
      std::chrono::seconds(5), std::bind(&FirmwareManager::discoverDevices, this));

    io_thread_ = std::thread([this]() { io_context_.run(); });
  }

  ~FirmwareManager()
  {
    discovery_timer_.reset();
    io_context_.stop();
    if (io_thread_.joinable()) {
      io_thread_.join();
    }
    std::lock_guard<std::mutex> lock(devices_mutex_);
    for (auto & pair : devices_) {
      pair.second->dispose();
    }
    devices_.clear();
  }

private:
  using WrappedProtobuf = subsystems_ros2::msg::WrappedProtobuf;

  void discoverDevices()
  {
    std::vector<std::string> patterns = this->get_parameter("port_patterns").as_string_array();
    std::vector<std::string> ports;
    {
      std::lock_guard<std::mutex> lock(devices_mutex_);
      for (const auto & pattern : patterns) {
        glob_t glob_result;
        if (glob(pattern.c_str(), GLOB_TILDE, nullptr, &glob_result) == 0) {
          for (size_t i = 0; i < glob_result.gl_pathc; ++i) {
            std::string port(glob_result.gl_pathv[i]);
            if (devices_.count(port) == 0 && pending_ports_.count(port) == 0) {
              ports.push_back(port);
              pending_ports_.insert(port);
            }
          }
        }
        globfree(&glob_result);
      }
    }

    for (const auto & port : ports) {
      auto data_cb = [this](FirmwareDevice * device, const std::vector<uint8_t> & data) {
        this->onDeviceData(device, data);
      };
      auto error_cb = [this](const std::string & port) {
        this->onDeviceError(port);
      };
      auto connected_cb = [this](FirmwareDevice * device) {
        std::lock_guard<std::mutex> lock(devices_mutex_);
        devices_[device->port()] = device->shared_from_this();
        pending_ports_.erase(device->port());
      };
      auto device = std::make_shared<FirmwareDevice>(
        io_context_, port, this->get_logger(), data_cb, error_cb, connected_cb);
      device->start();
    }
  }

  void onDeviceData(FirmwareDevice * device, const std::vector<uint8_t> & data)
  {
    auto data_name = deviceToDataName(device->device());
    if (data_name.empty()) {
      return;
    }
    WrappedMessage wrapper;
    wrapper.set_name(data_name);
    wrapper.set_data(std::string(data.begin(), data.end()));
    publishWrapper(wrapper);
  }

  void onDeviceError(const std::string & port)
  {
    std::lock_guard<std::mutex> lock(devices_mutex_);
    pending_ports_.erase(port);
    auto it = devices_.find(port);
    if (it != devices_.end()) {
      it->second->dispose();
      devices_.erase(it);
    }
    RCLCPP_INFO(this->get_logger(), "Removed disconnected device on port %s", port.c_str());
  }

  std::string deviceToDataName(Device device)
  {
    switch (device) {
      case ARM: return ArmData::descriptor()->full_name();
      case DRIVE: return DriveData::descriptor()->full_name();
      case SCIENCE: return ScienceData::descriptor()->full_name();
      case RELAY: return RelaysData::descriptor()->full_name();
      case CONTROL_BOARD: return ControlData::descriptor()->full_name();
      default: return "";
    }
  }

  void onIncoming(const WrappedProtobuf::SharedPtr msg)
  {
    WrappedMessage wrapper;
    wrapper.set_name(msg->name);
    wrapper.set_data(std::string(msg->data.begin(), msg->data.end()));
    sendToSerial(wrapper);
  }

  void sendToSerial(const WrappedMessage & wrapper)
  {
    bool control_connected = false;
    {
      std::lock_guard<std::mutex> lock(devices_mutex_);
      for (const auto & pair : devices_) {
        if (pair.second->device() == CONTROL_BOARD) {
          control_connected = true;
          break;
        }
      }
    }

    Device device = FIRMWARE;
    std::string bytes_to_send = wrapper.data();

    if (wrapper.name() == ControlCommand::descriptor()->full_name()) {
      ControlCommand command;
      command.ParseFromString(wrapper.data());
      if (command.has_drive()) {
        device = DRIVE;
        bytes_to_send = command.drive().SerializeAsString();
      } else if (command.has_relays()) {
        device = RELAY;
        bytes_to_send = command.relays().SerializeAsString();
      } else {
        return;
      }
    } else if (control_connected) {
      if (wrapper.name() == DriveCommand::descriptor()->full_name()) {
        DriveCommand drive_cmd;
        drive_cmd.ParseFromString(wrapper.data());
        ControlCommand control_cmd;
        *control_cmd.mutable_drive() = drive_cmd;
        bytes_to_send = control_cmd.SerializeAsString();
        device = CONTROL_BOARD;
      } else if (wrapper.name() == RelaysCommand::descriptor()->full_name()) {
        RelaysCommand relays_cmd;
        relays_cmd.ParseFromString(wrapper.data());
        ControlCommand control_cmd;
        *control_cmd.mutable_relays() = relays_cmd;
        bytes_to_send = control_cmd.SerializeAsString();
        device = CONTROL_BOARD;
      }
    }

    std::shared_ptr<FirmwareDevice> target;
    {
      std::lock_guard<std::mutex> lock(devices_mutex_);
      for (const auto & pair : devices_) {
        if (pair.second->device() == device) {
          target = pair.second;
          break;
        }
      }
    }
    if (target) {
      target->sendBytes(bytes_to_send);
    }
  }

  void publishWrapper(const WrappedMessage & wrapper)
  {
    WrappedProtobuf msg;
    msg.name = wrapper.name();
    msg.data.assign(wrapper.data().begin(), wrapper.data().end());
    outgoing_pub_->publish(msg);
  }

  rclcpp::Subscription<WrappedProtobuf>::SharedPtr incoming_sub_;
  rclcpp::Publisher<WrappedProtobuf>::SharedPtr outgoing_pub_;
  rclcpp::TimerBase::SharedPtr discovery_timer_;

  boost::asio::io_context io_context_;
  std::thread io_thread_;

  std::mutex devices_mutex_;
  std::unordered_map<std::string, std::shared_ptr<FirmwareDevice>> devices_;
  std::unordered_set<std::string> pending_ports_;
};

}  // namespace subsystems_ros2

int main(int argc, char ** argv)
{
  rclcpp::init(argc, argv);
  rclcpp::spin(std::make_shared<subsystems_ros2::FirmwareManager>());
  rclcpp::shutdown();
  return 0;
}
