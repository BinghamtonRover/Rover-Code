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
#include "video_ros2/dashboard_server.hpp"
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

  /// Handle a frame too large for a UDP datagram: lower the camera's JPEG
  /// quality (like the Dart video program) or report FRAME_TOO_LARGE when the
  /// quality floor is reached. Dropped instead of sent, because the Dashboard
  /// could never receive it.
  void handleOversizedFrame(const VideoData & data);

  /// Load camera configuration from ROS parameters and create cameras.
  void initializeCameras();

  /// Handle dashboard messages received by the standalone server (VideoCommand).
  void onDashboardMessage(const WrappedMessage & wrapper, const std::string & address, uint16_t port);

  /// Create the right Camera implementation for one configured entry.
  std::unique_ptr<Camera> createCamera(
    const std::string & device, CameraName name, const CameraDetails & details,
    const std::string & screenshot_dir, const std::shared_ptr<ArucoDetector> & aruco_detector);

  rclcpp::Publisher<WrappedProtobuf>::SharedPtr video_pub_;
  rclcpp::Publisher<WrappedProtobuf>::SharedPtr command_echo_pub_;
  rclcpp::Subscription<WrappedProtobuf>::SharedPtr command_sub_;
  rclcpp::TimerBase::SharedPtr status_timer_;

  // Optional standalone dashboard server: when enabled, the video node serves
  // the BURT video protocol (UDP :8002) directly, which is how a Raspberry Pi
  // Zero 2 W streams to the Dashboard without a central video streamer.
  std::unique_ptr<DashboardServer> dashboard_server_;
  bool udp_server_enabled_ = false;
  uint16_t udp_server_port_ = 8002;
  int udp_server_max_clients_ = 5;

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
