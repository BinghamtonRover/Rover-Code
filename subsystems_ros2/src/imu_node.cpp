#include <cmath>
#include <cstring>
#include <memory>
#include <string>
#include <thread>
#include <vector>

#include "boost/asio.hpp"
#include "rclcpp/rclcpp.hpp"
#include "subsystems_ros2/msg/wrapped_protobuf.hpp"
#include "subsystems_ros2/utils.hpp"
#include "subsystems_ros2/generated/geometry.pb.h"
#include "subsystems_ros2/generated/gps.pb.h"
#include "subsystems_ros2/generated/subsystems.pb.h"
#include "subsystems_ros2/generated/version.pb.h"
#include "subsystems_ros2/generated/wrapper.pb.h"

namespace subsystems_ros2
{

class ImuNode : public rclcpp::Node
{
public:
  ImuNode()
  : Node("imu_node")
  {
    this->declare_parameter<std::string>("port", IMU_PORT);
    this->declare_parameter<bool>("use_imu", true);

    std::string port = this->get_parameter("port").as_string();
    bool use_imu = this->get_parameter("use_imu").as_bool();

    outgoing_pub_ = this->create_publisher<WrappedProtobuf>("/burt/outgoing", 100);
    imu_pub_ = this->create_publisher<WrappedProtobuf>("/burt/imu_position", 100);
    incoming_sub_ = this->create_subscription<WrappedProtobuf>(
      "/burt/incoming", 100,
      std::bind(&ImuNode::onIncoming, this, std::placeholders::_1));

    if (use_imu) {
      try {
        serial_port_.open(port);
        serial_port_.set_option(boost::asio::serial_port_base::baud_rate(115200));
        serial_port_.set_option(boost::asio::serial_port_base::character_size(8));
        serial_port_.set_option(boost::asio::serial_port_base::parity(boost::asio::serial_port_base::parity::none));
        serial_port_.set_option(boost::asio::serial_port_base::stop_bits(boost::asio::serial_port_base::stop_bits::one));
        startRead();
        io_thread_ = std::thread([this]() { io_context_.run(); });
        RCLCPP_INFO(this->get_logger(), "Reading IMU on port %s", port.c_str());
      } catch (const std::exception & e) {
        RCLCPP_ERROR(this->get_logger(), "Could not open IMU on port %s: %s", port.c_str(), e.what());
      }
    }
  }

  ~ImuNode()
  {
    io_context_.stop();
    if (io_thread_.joinable()) {
      io_thread_.join();
    }
    if (serial_port_.is_open()) {
      serial_port_.close();
    }
  }

private:
  using WrappedProtobuf = subsystems_ros2::msg::WrappedProtobuf;

  void startRead()
  {
    read_buffer_.resize(1024);
    serial_port_.async_read_some(
      boost::asio::buffer(read_buffer_),
      [this](const boost::system::error_code & error, std::size_t bytes_transferred)
      {
        if (!error && bytes_transferred > 0) {
          std::lock_guard<std::mutex> lock(buffer_mutex_);
          buffer_.insert(buffer_.end(), read_buffer_.begin(), read_buffer_.begin() + bytes_transferred);
          processBuffer();
        }
        startRead();
      });
  }

  void processBuffer()
  {
    std::vector<std::vector<uint8_t>> packets;
    {
      std::lock_guard<std::mutex> lock(buffer_mutex_);
      size_t pos = 0;
      while ((pos = buffer_.find(static_cast<char>(0xC0))) != std::string::npos) {
        packets.emplace_back(buffer_.begin(), buffer_.begin() + pos);
        buffer_.erase(buffer_.begin(), buffer_.begin() + pos + 1);
      }
    }
    for (const auto & packet : packets) {
      handlePacket(packet);
    }
  }

  void handlePacket(const std::vector<uint8_t> & packet)
  {
    std::string data(packet.begin(), packet.end());
    size_t offset = 0;
    std::string address = parseOscString(data, offset);
    if (address != "/euler") {
      return;
    }
    std::string tags = parseOscString(data, offset);
    if (tags.size() < 4 || tags[0] != ',' || tags[1] != 'f' || tags[2] != 'f' || tags[3] != 'f') {
      return;
    }
    if (offset + 3 * sizeof(float) > data.size()) {
      return;
    }
    float pitch, roll, yaw;
    std::memcpy(&pitch, data.data() + offset, sizeof(float));
    offset += sizeof(float);
    std::memcpy(&roll, data.data() + offset, sizeof(float));
    offset += sizeof(float);
    std::memcpy(&yaw, data.data() + offset, sizeof(float));

    RoverPosition position;
    position.mutable_orientation()->set_pitch(pitch);
    position.mutable_orientation()->set_roll(roll);
    position.mutable_orientation()->set_yaw(yaw);
    position.mutable_version()->set_major(1);
    position.mutable_version()->set_minor(0);

    WrappedMessage wrapper = wrapMessage(position);
    WrappedProtobuf msg;
    msg.name = wrapper.name();
    msg.data.assign(wrapper.data().begin(), wrapper.data().end());
    outgoing_pub_->publish(msg);
    imu_pub_->publish(msg);
  }

  void onIncoming(const WrappedProtobuf::SharedPtr msg)
  {
    if (msg->name != SubsystemsCommand::descriptor()->full_name()) {
      return;
    }
    SubsystemsCommand command;
    command.ParseFromArray(msg->data.data(), static_cast<int>(msg->data.size()));
    if (command.zero_imu() && serial_port_.is_open()) {
      std::vector<uint8_t> osc = buildOscMessage("/ahrs/zero", {});
      boost::asio::write(serial_port_, boost::asio::buffer(osc));
    }
  }

  rclcpp::Publisher<WrappedProtobuf>::SharedPtr outgoing_pub_;
  rclcpp::Publisher<WrappedProtobuf>::SharedPtr imu_pub_;
  rclcpp::Subscription<WrappedProtobuf>::SharedPtr incoming_sub_;

  boost::asio::io_context io_context_;
  boost::asio::serial_port serial_port_{io_context_};
  std::thread io_thread_;
  std::vector<char> read_buffer_;
  std::string buffer_;
  std::mutex buffer_mutex_;
};

}  // namespace subsystems_ros2

int main(int argc, char ** argv)
{
  rclcpp::init(argc, argv);
  rclcpp::spin(std::make_shared<subsystems_ros2::ImuNode>());
  rclcpp::shutdown();
  return 0;
}
