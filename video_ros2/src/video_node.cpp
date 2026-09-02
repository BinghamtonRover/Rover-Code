#include "video_ros2/video_node.hpp"

#include <memory>
#include <string>

#include "rclcpp/rclcpp.hpp"

#include "video_ros2/aruco_detector.hpp"
#include "video_ros2/opencv_camera.hpp"
#include "video_ros2/realsense_camera.hpp"
#include "video_ros2/virtual_camera.hpp"

namespace video_ros2
{

VideoNode::VideoNode()
: Node("video_node")
{
  this->declare_parameter<std::vector<std::string>>("camera_names", std::vector<std::string>{});
  this->declare_parameter<std::vector<std::string>>("camera_devices", std::vector<std::string>{});
  this->declare_parameter<std::vector<int64_t>>("camera_types", std::vector<int64_t>{});
  this->declare_parameter<std::string>("screenshot_dir", "/home/rover/shared/screenshots");
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
  std::lock_guard<std::mutex> lock(cameras_mutex_);
  for (auto & pair : cameras_) {
    pair.second->stop();
  }
  cameras_.clear();
}

void VideoNode::initializeCameras()
{
  std::vector<std::string> names = this->get_parameter("camera_names").as_string_array();
  std::vector<std::string> devices = this->get_parameter("camera_devices").as_string_array();
  std::vector<int64_t> types = this->get_parameter("camera_types").as_integer_array();
  std::string screenshot_dir = this->get_parameter("screenshot_dir").as_string();

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
        RCLCPP_ERROR(this->get_logger(), "Invalid camera_type value: %ld", types[i]);
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
      RCLCPP_ERROR(this->get_logger(), "Invalid camera_type value: %ld", types[i]);
      continue;
    }
    CameraName name = static_cast<CameraName>(types[i]);
    CameraDetails details;
    details.set_name(name);
    details.set_status(CameraStatus::CAMERA_ENABLED);
    details.set_quality(75);
    details.set_fps(30);

    // A "virtual" device path selects the synthetic camera for this entry only.
    std::unique_ptr<Camera> camera;
    if (devices[i] == "virtual") {
      camera = std::make_unique<VirtualCamera>(name, details, screenshot_dir);
    } else if (name == CameraName::AUTONOMY_DEPTH || name == CameraName::ROVER_FRONT) {
      camera = std::make_unique<RealSenseCamera>(name, details);
    } else {
      camera = std::make_unique<OpenCvCamera>(devices[i], name, details, screenshot_dir);
    }

    camera->setArucoDetector(aruco_detector);
    camera->start([this](const VideoData & data) { onVideoData(data); });
    {
      std::lock_guard<std::mutex> lock(cameras_mutex_);
      cameras_[static_cast<int>(name)] = std::move(camera);
    }
  }
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
  std::lock_guard<std::mutex> lock(cameras_mutex_);
  auto it = cameras_.find(name_value);
  if (it == cameras_.end()) {
    RCLCPP_WARN(this->get_logger(), "Camera %d not found", name_value);
    return;
  }

  if (command.take_snapshot()) {
    it->second->takeSnapshot();
  } else {
    it->second->updateDetails(command.details());
  }
}

void VideoNode::onVideoData(const VideoData & data)
{
  WrappedProtobuf msg;
  msg.name = VideoData::descriptor()->full_name();
  std::string serialized = data.SerializeAsString();
  msg.data.assign(serialized.begin(), serialized.end());
  video_pub_->publish(msg);

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
  }
}

}  // namespace video_ros2
