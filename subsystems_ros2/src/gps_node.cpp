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
#include "subsystems_ros2/generated/version.pb.h"
#include "subsystems_ros2/generated/wrapper.pb.h"

namespace subsystems_ros2
{

class GpsNode : public rclcpp::Node
{
public:
  GpsNode()
  : Node("gps_node")
  {
    this->declare_parameter<std::string>("port", GPS_PORT);
    this->declare_parameter<bool>("use_gps", true);

    std::string port = this->get_parameter("port").as_string();
    bool use_gps = this->get_parameter("use_gps").as_bool();

    outgoing_pub_ = this->create_publisher<WrappedProtobuf>("/burt/outgoing", 100);
    gps_pub_ = this->create_publisher<WrappedProtobuf>("/burt/gps_position", 100);
    incoming_sub_ = this->create_subscription<WrappedProtobuf>(
      "/burt/incoming", 100,
      std::bind(&GpsNode::onIncoming, this, std::placeholders::_1));

    if (use_gps) {
      try {
        serial_port_.open(port);
        serial_port_.set_option(boost::asio::serial_port_base::baud_rate(38400));
        serial_port_.set_option(boost::asio::serial_port_base::character_size(8));
        serial_port_.set_option(boost::asio::serial_port_base::parity(boost::asio::serial_port_base::parity::none));
        serial_port_.set_option(boost::asio::serial_port_base::stop_bits(boost::asio::serial_port_base::stop_bits::one));
        startRead();
        io_thread_ = std::thread([this]() { io_context_.run(); });
        RCLCPP_INFO(this->get_logger(), "Reading GPS over port %s", port.c_str());
      } catch (const std::exception & e) {
        RCLCPP_ERROR(this->get_logger(), "Could not open GPS on port %s: %s", port.c_str(), e.what());
      }
    }
  }

  ~GpsNode()
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
    std::vector<std::string> lines;
    {
      std::lock_guard<std::mutex> lock(buffer_mutex_);
      size_t pos = 0;
      while ((pos = buffer_.find('\n')) != std::string::npos) {
        lines.emplace_back(buffer_.begin(), buffer_.begin() + pos);
        buffer_.erase(buffer_.begin(), buffer_.begin() + pos + 1);
      }
    }
    for (const auto & line : lines) {
      handleLine(line);
    }
  }

  void handleLine(const std::string & line)
  {
    auto coordinates = parseNmea(line);
    if (!coordinates) {
      return;
    }
    if (coordinates->latitude() == 0 || coordinates->longitude() == 0) {
      return;
    }

    RoverPosition position;
    *position.mutable_gps() = *coordinates;
    position.mutable_version()->set_major(1);
    position.mutable_version()->set_minor(0);

    WrappedMessage wrapper = wrapMessage(position);
    WrappedProtobuf msg;
    msg.name = wrapper.name();
    msg.data.assign(wrapper.data().begin(), wrapper.data().end());
    outgoing_pub_->publish(msg);
    gps_pub_->publish(msg);
  }

  void onIncoming(const WrappedProtobuf::SharedPtr msg)
  {
    if (msg->name != RoverPosition::descriptor()->full_name()) {
      return;
    }
    RoverPosition position;
    position.ParseFromArray(msg->data.data(), static_cast<int>(msg->data.size()));
    if (!position.rtk_message().empty() && serial_port_.is_open()) {
      boost::asio::write(serial_port_, boost::asio::buffer(position.rtk_message()));
    }
  }

  rclcpp::Publisher<WrappedProtobuf>::SharedPtr outgoing_pub_;
  rclcpp::Publisher<WrappedProtobuf>::SharedPtr gps_pub_;
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
  rclcpp::spin(std::make_shared<subsystems_ros2::GpsNode>());
  rclcpp::shutdown();
  return 0;
}
