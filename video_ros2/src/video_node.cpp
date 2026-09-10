#include "video_ros2/video_node.hpp"

#include <cinttypes>
#include <cstddef>
#include <memory>
#include <string>

#include "rclcpp/rclcpp.hpp"

#include "subsystems_ros2/generated/wrapper.pb.h"

#include "video_ros2/aruco_detector.hpp"
#include "video_ros2/gstreamer_camera.hpp"
#include "video_ros2/opencv_camera.hpp"
#include "video_ros2/realsense_camera.hpp"
#include "video_ros2/virtual_camera.hpp"

namespace video_ros2
{

namespace
{

// The largest VideoData message put on the wire, in bytes. The legacy Dart
// video program used the same cap (video/lib/src/isolates/child.dart,
// maxPacketLength): UDP datagrams larger than this cannot reach the Dashboard,
// so sending them only wastes CPU and bandwidth on the Pi Zero 2 W.
constexpr size_t kMaxPacketSize = 60000;

// The legacy program lowers JPEG quality one point per oversized frame until
// the frame fits; below this floor it reports FRAME_TOO_LARGE instead.
constexpr int kMinJpegQuality = 25;

}  // namespace

VideoNode::VideoNode()
: Node("video_node")
{
  this->declare_parameter<std::vector<std::string>>("camera_names", std::vector<std::string>{});
  this->declare_parameter<std::vector<std::string>>("camera_devices", std::vector<std::string>{});
  this->declare_parameter<std::vector<int64_t>>("camera_types", std::vector<int64_t>{});
  this->declare_parameter<std::string>("screenshot_dir", "/home/rover/shared/screenshots");

  // Defaults applied to cameras that do not set an explicit resolution/fps.
  // Useful for CSI cameras, where an unsupported mode makes libcamera fail.
  this->declare_parameter<int>("default_width", 0);
  this->declare_parameter<int>("default_height", 0);
  this->declare_parameter<int>("default_fps", 0);
  this->declare_parameter<std::string>("aux_address", "");
  this->declare_parameter<int>("aux_port", 8011);
  this->declare_parameter<bool>("echo_commands", true);
  this->declare_parameter<std::string>("vision_address", "");
  this->declare_parameter<int>("vision_port", 8006);

  // Virtual camera options.
  this->declare_parameter<bool>("virtual_mode", false);
  this->declare_parameter<int>("virtual_width", 640);
  this->declare_parameter<int>("virtual_height", 480);
  this->declare_parameter<int>("virtual_fps", 30);
  this->declare_parameter<int>("virtual_quality", 75);
  this->declare_parameter<std::string>("virtual_label", "");
  this->declare_parameter<std::vector<std::string>>("vision_camera_names", std::vector<std::string>{});

  // Standalone dashboard server: when enabled, the node impersonates the video
  // program on UDP (port 8002 by default) so a single-board computer like the
  // Raspberry Pi Zero 2 W can stream straight to the Dashboard without the
  // udp_bridge on the main rover. Several boards can do this at once.
  this->declare_parameter<bool>("udp_server_enabled", false);
  this->declare_parameter<int>("udp_server_port", 8002);
  this->declare_parameter<int>("udp_server_max_clients", 5);

  // ArUco detector parameters.
  this->declare_parameter<std::string>("aruco_dictionary", "DICT_4X4_50");
  this->declare_parameter<int>("aruco_adaptive_thresh_win_size_min", 3);
  this->declare_parameter<int>("aruco_adaptive_thresh_win_size_max", 23);
  this->declare_parameter<int>("aruco_adaptive_thresh_win_size_step", 10);
  this->declare_parameter<double>("aruco_adaptive_thresh_constant", 7.0);
  this->declare_parameter<double>("aruco_min_marker_perimeter_rate", 0.03);
  this->declare_parameter<double>("aruco_max_marker_perimeter_rate", 4.0);
  this->declare_parameter<double>("aruco_polygonal_approx_accuracy_rate", 0.05);
  this->declare_parameter<double>("aruco_min_corner_distance_rate", 0.05);
  this->declare_parameter<int>("aruco_min_distance_to_borders", 3);
  this->declare_parameter<int>("aruco_corner_refinement_method", 0);

  video_pub_ = this->create_publisher<WrappedProtobuf>("/burt/video_data", 10);
  command_echo_pub_ = this->create_publisher<WrappedProtobuf>("/burt/video_command_echo", 10);
  command_sub_ = this->create_subscription<WrappedProtobuf>(
    "/burt/video_command", 10,
    std::bind(&VideoNode::onCommand, this, std::placeholders::_1));
  status_timer_ = this->create_wall_timer(
    std::chrono::seconds(5), std::bind(&VideoNode::publishStatus, this));

  aux_address_ = this->get_parameter("aux_address").as_string();
  aux_port_ = static_cast<uint16_t>(this->get_parameter("aux_port").as_int());
  echo_commands_ = this->get_parameter("echo_commands").as_bool();
  vision_address_ = this->get_parameter("vision_address").as_string();
  vision_port_ = static_cast<uint16_t>(this->get_parameter("vision_port").as_int());
  vision_camera_names_ = this->get_parameter("vision_camera_names").as_string_array();

  udp_server_enabled_ = this->get_parameter("udp_server_enabled").as_bool();
  udp_server_port_ = static_cast<uint16_t>(this->get_parameter("udp_server_port").as_int());
  udp_server_max_clients_ =
    static_cast<int>(this->get_parameter("udp_server_max_clients").as_int());

  if (udp_server_enabled_) {
    dashboard_server_ = std::make_unique<DashboardServer>(
      udp_server_port_, udp_server_max_clients_, this->get_logger());
    dashboard_server_->setMessageCallback(
      [this](const WrappedMessage & wrapper, const std::string & address, uint16_t port) {
        onDashboardMessage(wrapper, address, port);
      });
    if (!dashboard_server_->start()) {
      RCLCPP_ERROR(
        this->get_logger(), "Failed to start the standalone dashboard server on port %u",
        static_cast<unsigned>(udp_server_port_));
      dashboard_server_.reset();
    }
  }

  if (!aux_address_.empty()) {
    command_forwarder_ = std::make_unique<UdpSocket>();
    if (!command_forwarder_->setDestination(aux_address_, aux_port_)) {
      RCLCPP_WARN(this->get_logger(), "Could not resolve aux_address %s", aux_address_.c_str());
      command_forwarder_.reset();
    }
  }
  if (!vision_address_.empty()) {
    vision_forwarder_ = std::make_unique<UdpSocket>();
    if (!vision_forwarder_->setDestination(vision_address_, vision_port_)) {
      RCLCPP_WARN(this->get_logger(), "Could not resolve vision_address %s", vision_address_.c_str());
      vision_forwarder_.reset();
    }
  }

  initializeCameras();
}

VideoNode::~VideoNode()
{
  if (dashboard_server_) {
    dashboard_server_->stop();
  }
  std::unordered_map<int, std::unique_ptr<Camera>> cameras;
  {
    std::lock_guard<std::mutex> lock(cameras_mutex_);
    cameras.swap(cameras_);
  }
  // Stop the cameras (joining their threads) without holding cameras_mutex_:
  // the camera threads take that mutex when they publish a frame.
  cameras.clear();
}

void VideoNode::onDashboardMessage(
  const WrappedMessage & wrapper, const std::string & address, uint16_t port)
{
  // The only dashboard message the video program cares about is VideoCommand.
  if (wrapper.name() != VideoCommand::descriptor()->full_name()) {
    RCLCPP_DEBUG(
      this->get_logger(), "Ignoring dashboard message '%s' from %s:%u",
      wrapper.name().c_str(), address.c_str(), static_cast<unsigned>(port));
    return;
  }

  VideoCommand command;
  if (!command.ParseFromString(wrapper.data())) {
    RCLCPP_WARN(this->get_logger(), "Received malformed VideoCommand");
    return;
  }

  // Echo the command back to the dashboard, like the Dart video program does.
  if (echo_commands_ && command_echo_pub_) {
    WrappedProtobuf echo;
    echo.name = wrapper.name();
    echo.data.assign(wrapper.data().begin(), wrapper.data().end());
    command_echo_pub_->publish(echo);
  }

  // The echo above reaches dashboards over the ROS graph (udp_bridge), but the
  // standalone dashboard server is a separate transport: echo to that client
  // directly as well.
  if (echo_commands_ && dashboard_server_) {
    dashboard_server_->sendTo(wrapper, address, port);
  }

  // Forward the raw command to the auxiliary program (e.g. arm auxillary).
  if (command_forwarder_) {
    command_forwarder_->send(wrapper.data().data(), wrapper.data().size());
  }

  int name_value = command.details().name();
  Camera * camera = nullptr;
  bool restart_requested = false;
  {
    std::lock_guard<std::mutex> lock(cameras_mutex_);
    auto it = cameras_.find(name_value);
    if (it == cameras_.end()) {
      RCLCPP_WARN(this->get_logger(), "Camera %d not found", name_value);
      return;
    }
    camera = it->second.get();
    if (command.take_snapshot()) {
      camera->takeSnapshot();
    } else {
      // Disabling a camera stops its streaming thread; re-enabling it starts
      // a new one. Both match the behavior of the Dart video program.
      restart_requested =
        command.details().status() == CameraStatus::CAMERA_ENABLED &&
        camera->status() == CameraStatus::CAMERA_DISABLED;
      camera->updateDetails(command.details());
    }
  }
  // Restart (which joins the camera thread) outside the mutex: the camera
  // thread takes cameras_mutex_ when it publishes a frame.
  if (restart_requested) {
    camera->restart();
  }
}

void VideoNode::initializeCameras()
{
  std::vector<std::string> names = this->get_parameter("camera_names").as_string_array();
  std::vector<std::string> devices = this->get_parameter("camera_devices").as_string_array();
  std::vector<int64_t> types = this->get_parameter("camera_types").as_integer_array();
  std::string screenshot_dir = this->get_parameter("screenshot_dir").as_string();
  const int default_width = static_cast<int>(this->get_parameter("default_width").as_int());
  const int default_height = static_cast<int>(this->get_parameter("default_height").as_int());
  const int default_fps = static_cast<int>(this->get_parameter("default_fps").as_int());

  if (names.empty()) {
    RCLCPP_WARN(this->get_logger(), "No cameras configured. Set camera_names, camera_devices, and camera_types parameters.");
    return;
  }

  ArucoConfig aruco_config;
  aruco_config.dictionary = this->get_parameter("aruco_dictionary").as_string();
  aruco_config.adaptive_thresh_win_size_min = this->get_parameter("aruco_adaptive_thresh_win_size_min").as_int();
  aruco_config.adaptive_thresh_win_size_max = this->get_parameter("aruco_adaptive_thresh_win_size_max").as_int();
  aruco_config.adaptive_thresh_win_size_step = this->get_parameter("aruco_adaptive_thresh_win_size_step").as_int();
  aruco_config.adaptive_thresh_constant = this->get_parameter("aruco_adaptive_thresh_constant").as_double();
  aruco_config.min_marker_perimeter_rate = this->get_parameter("aruco_min_marker_perimeter_rate").as_double();
  aruco_config.max_marker_perimeter_rate = this->get_parameter("aruco_max_marker_perimeter_rate").as_double();
  aruco_config.polygonal_approx_accuracy_rate = this->get_parameter("aruco_polygonal_approx_accuracy_rate").as_double();
  aruco_config.min_corner_distance_rate = this->get_parameter("aruco_min_corner_distance_rate").as_double();
  aruco_config.min_distance_to_borders = this->get_parameter("aruco_min_distance_to_borders").as_int();
  aruco_config.corner_refinement_method = this->get_parameter("aruco_corner_refinement_method").as_int();

  auto aruco_detector = std::make_shared<ArucoDetector>(aruco_config);

  if (names.size() != devices.size() || names.size() != types.size()) {
    RCLCPP_ERROR(this->get_logger(), "Camera parameter arrays must have the same length");
    return;
  }

  // Virtual mode: create synthetic cameras for every configured name and skip hardware entirely.
  bool virtual_mode = this->get_parameter("virtual_mode").as_bool();
  if (virtual_mode) {
    const int width = static_cast<int>(this->get_parameter("virtual_width").as_int());
    const int height = static_cast<int>(this->get_parameter("virtual_height").as_int());
    const int fps = static_cast<int>(this->get_parameter("virtual_fps").as_int());
    const int quality = static_cast<int>(this->get_parameter("virtual_quality").as_int());
    const std::string label = this->get_parameter("virtual_label").as_string();
    if (!label.empty()) {
      RCLCPP_INFO(this->get_logger(), "Virtual camera mode: %s", label.c_str());
    }

    for (size_t i = 0; i < names.size(); ++i) {
      if (!CameraName_IsValid(static_cast<int>(types[i]))) {
        RCLCPP_ERROR(
          this->get_logger(), "Invalid camera_type value: %" PRId64, types[i]);
        continue;
      }
      CameraName name = static_cast<CameraName>(types[i]);
      CameraDetails details;
      details.set_name(name);
      details.set_status(CameraStatus::CAMERA_ENABLED);
      details.set_quality(quality);
      details.set_fps(fps);
      details.set_resolution_width(width);
      details.set_resolution_height(height);

      auto camera = std::make_unique<VirtualCamera>(name, details, screenshot_dir);
      camera->setArucoDetector(aruco_detector);
      camera->start([this](const VideoData & data) { onVideoData(data); });
      {
        std::lock_guard<std::mutex> lock(cameras_mutex_);
        cameras_[static_cast<int>(name)] = std::move(camera);
      }
    }
    if (!cameras_.empty()) {
      return;
    }
    RCLCPP_WARN(
      this->get_logger(),
      "virtual_mode is enabled but no cameras were created; falling back to hardware");
  }

  for (size_t i = 0; i < names.size(); ++i) {
    if (!CameraName_IsValid(static_cast<int>(types[i]))) {
      RCLCPP_ERROR(
        this->get_logger(), "Invalid camera_type value: %" PRId64, types[i]);
      continue;
    }
    CameraName name = static_cast<CameraName>(types[i]);
    CameraDetails details;
    details.set_name(name);
    details.set_status(CameraStatus::CAMERA_ENABLED);
    details.set_quality(75);
    if (default_fps > 0) {
      details.set_fps(default_fps);
    }
    if (default_width > 0 && default_height > 0) {
      details.set_resolution_width(default_width);
      details.set_resolution_height(default_height);
    }

    auto camera = createCamera(devices[i], name, details, screenshot_dir, aruco_detector);

    camera->setArucoDetector(aruco_detector);
    camera->start([this](const VideoData & data) { onVideoData(data); });
    {
      std::lock_guard<std::mutex> lock(cameras_mutex_);
      cameras_[static_cast<int>(name)] = std::move(camera);
    }
  }
}

std::unique_ptr<Camera> VideoNode::createCamera(
  const std::string & device, CameraName name, const CameraDetails & details,
  const std::string & screenshot_dir, const std::shared_ptr<ArucoDetector> & aruco_detector)
{
  (void)aruco_detector;

  // A "virtual" device path selects the synthetic camera for this entry only.
  if (device == "virtual") {
    return std::make_unique<VirtualCamera>(name, details, screenshot_dir);
  }

  // Explicit GStreamer selections: "csi"/"libcamera" for the Raspberry Pi
  // camera connector, "v4l2:/dev/videoN" for a V4L2 device through GStreamer,
  // or "test" for a GStreamer test source.
  if (device == "csi" || device == "libcamera" || device == "test" ||
    device.rfind("v4l2:", 0) == 0)
  {
    return std::make_unique<GStreamerCamera>(device, name, details, screenshot_dir);
  }

  // RealSense remains the default for the depth/rover-front logical cameras
  // when no explicit device path is configured.
  if (name == CameraName::AUTONOMY_DEPTH || name == CameraName::ROVER_FRONT) {
#ifdef HAS_REALSENSE
    return std::make_unique<RealSenseCamera>(name, details);
#else
    RCLCPP_WARN(
      rclcpp::get_logger("video_ros2"),
      "No RealSense support compiled in; treating %s as a regular device camera",
      device.c_str());
#endif
  }

  return std::make_unique<OpenCvCamera>(device, name, details, screenshot_dir);
}

void VideoNode::onCommand(const WrappedProtobuf::SharedPtr msg)
{
  VideoCommand command;
  if (!command.ParseFromArray(msg->data.data(), static_cast<int>(msg->data.size()))) {
    RCLCPP_WARN(this->get_logger(), "Received malformed VideoCommand");
    return;
  }

  // Forward the raw command to the auxiliary program (e.g. arm auxillary).
  if (command_forwarder_) {
    command_forwarder_->send(msg->data.data(), msg->data.size());
  }

  // Echo the command back to the dashboard.
  if (echo_commands_ && command_echo_pub_) {
    command_echo_pub_->publish(*msg);
  }

  int name_value = command.details().name();
  Camera * camera = nullptr;
  bool restart_requested = false;
  {
    std::lock_guard<std::mutex> lock(cameras_mutex_);
    auto it = cameras_.find(name_value);
    if (it == cameras_.end()) {
      RCLCPP_WARN(this->get_logger(), "Camera %d not found", name_value);
      return;
    }
    camera = it->second.get();
    if (command.take_snapshot()) {
      camera->takeSnapshot();
    } else {
      // Disabling a camera stops its streaming thread; re-enabling it starts
      // a new one. Both match the behavior of the Dart video program.
      restart_requested =
        command.details().status() == CameraStatus::CAMERA_ENABLED &&
        camera->status() == CameraStatus::CAMERA_DISABLED;
      camera->updateDetails(command.details());
    }
  }
  // Restart (which joins the camera thread) outside the mutex: the camera
  // thread takes cameras_mutex_ when it publishes a frame.
  if (restart_requested) {
    camera->restart();
  }
}

void VideoNode::onVideoData(const VideoData & data)
{
  // Frames larger than a UDP datagram can never reach the Dashboard. Mirroring
  // the Dart video program (CameraIsolate.sendFrame), drop them and lower the
  // JPEG quality for the next frame instead of wasting bandwidth on traffic no
  // one can receive.
  if (data.frame().size() >= kMaxPacketSize) {
    handleOversizedFrame(data);
    return;
  }

  WrappedProtobuf msg;
  msg.name = VideoData::descriptor()->full_name();
  std::string serialized = data.SerializeAsString();
  msg.data.assign(serialized.begin(), serialized.end());
  video_pub_->publish(msg);

  // When running standalone, stream the frame straight to every dashboard.
  // With no dashboard connected there is nothing to send, so skip the work.
  if (dashboard_server_ && dashboard_server_->connectedClients() > 0) {
    WrappedMessage wrapper;
    wrapper.set_name(VideoData::descriptor()->full_name());
    wrapper.set_data(serialized);
    dashboard_server_->broadcast(wrapper);
  }

  // Forward frames from selected cameras to the vision/object-detection program.
  if (vision_forwarder_ && !vision_camera_names_.empty()) {
    const std::string & id = data.id();
    bool should_forward = false;
    for (const auto & name : vision_camera_names_) {
      if (id == name) {
        should_forward = true;
        break;
      }
    }
    if (should_forward) {
      vision_forwarder_->send(serialized.data(), serialized.size());
    }
  }
}

void VideoNode::publishStatus()
{
  std::lock_guard<std::mutex> lock(cameras_mutex_);
  for (const auto & pair : cameras_) {
    VideoData data;
    data.set_id(CameraName_Name(pair.second->name()));
    CameraDetails details;
    details.set_name(pair.second->name());
    details.set_status(pair.second->status());
    *data.mutable_details() = details;

    WrappedProtobuf msg;
    msg.name = VideoData::descriptor()->full_name();
    std::string serialized = data.SerializeAsString();
    msg.data.assign(serialized.begin(), serialized.end());
    video_pub_->publish(msg);

    if (dashboard_server_ && dashboard_server_->connectedClients() > 0) {
      WrappedMessage wrapper;
      wrapper.set_name(VideoData::descriptor()->full_name());
      wrapper.set_data(serialized);
      dashboard_server_->broadcast(wrapper);
    }
  }
}

void VideoNode::handleOversizedFrame(const VideoData & data)
{
  CameraDetails details = data.details();
  const int quality = details.quality() > 0 ? details.quality() : 75;
  if (quality > kMinJpegQuality) {
    details.set_status(CameraStatus::CAMERA_ENABLED);
    details.set_quality(quality - 1);
    RCLCPP_DEBUG(
      this->get_logger(), "Frame from %s too large (%zu bytes); lowering quality to %d",
      data.id().c_str(), data.frame().size(), quality - 1);
  } else {
    // Quality cannot be lowered any further; tell the Dashboard.
    details.set_status(CameraStatus::FRAME_TOO_LARGE);
    RCLCPP_WARN(
      this->get_logger(), "Frame from %s too large (%zu bytes) at minimum quality",
      data.id().c_str(), data.frame().size());
  }

  // Apply the change to the camera so the next frame is smaller. The cameras
  // re-read quality (and the encoder picks it up) every frame.
  std::lock_guard<std::mutex> lock(cameras_mutex_);
  auto it = cameras_.find(static_cast<int>(details.name()));
  if (it != cameras_.end()) {
    it->second->updateDetails(details);
  }
}

}  // namespace video_ros2
