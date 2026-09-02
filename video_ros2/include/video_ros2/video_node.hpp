#ifndef VIDEO_ROS2_VIDEO_NODE_HPP_
#define VIDEO_ROS2_VIDEO_NODE_HPP_

#include <memory>
#include <mutex>
#include <string>
#include <unordered_map>
#include <vector>

#include "rclcpp/rclcpp.hpp"
#include "subsystems_ros2/msg/wrapped_protobuf.hpp"

#include "video_ros2/camera.hpp"
#include "video_ros2/udp_socket.hpp"

namespace video_ros2
{

/// ROS2 node that manages multiple cameras and publishes VideoData messages.
class VideoNode : public rclcpp::Node
{
public:
  VideoNode();
  ~VideoNode() override;

private:
  using WrappedProtobuf = subsystems_ros2::msg::WrappedProtobuf;

  void onCommand(const WrappedProtobuf::SharedPtr msg);
  void onVideoData(const VideoData & data);
  void publishStatus();

  /// Load camera configuration from ROS parameters and create cameras.
  void initializeCameras();

  rclcpp::Publisher<WrappedProtobuf>::SharedPtr video_pub_;
  rclcpp::Publisher<WrappedProtobuf>::SharedPtr command_echo_pub_;
  rclcpp::Subscription<WrappedProtobuf>::SharedPtr command_sub_;
  rclcpp::TimerBase::SharedPtr status_timer_;

  std::mutex cameras_mutex_;
  std::unordered_map<int, std::unique_ptr<Camera>> cameras_;

  // UDP forwarding to the auxiliary program (e.g. arm auxillary).
  std::unique_ptr<UdpSocket> command_forwarder_;
  std::string aux_address_;
  uint16_t aux_port_ = 8011;
  bool echo_commands_ = true;

  // UDP forwarding to the vision/object-detection program.
  std::unique_ptr<UdpSocket> vision_forwarder_;
  std::string vision_address_;
  uint16_t vision_port_ = 8006;
  std::vector<std::string> vision_camera_names_;
};

}  // namespace video_ros2

#endif  // VIDEO_ROS2_VIDEO_NODE_HPP_
