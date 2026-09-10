#include "video_ros2/camera.hpp"

#include <chrono>

#include "rclcpp/rclcpp.hpp"

namespace video_ros2
{

Camera::Camera(CameraName name, const CameraDetails & details)
: name_(name)
{
  details_ = details;
  details_.set_name(name);
}

Camera::~Camera()
{
  stop();
}

void Camera::start(VideoDataCallback callback)
{
  callback_ = std::move(callback);
  running_.store(true);
  status_.store(CameraStatus::CAMERA_LOADING);
  thread_ = std::thread(&Camera::runLoop, this);
}

void Camera::restart()
{
  // Re-enable a camera that was disabled by a VideoCommand. Called from the
  // ROS executor thread while the camera thread is exiting or has exited.
  {
    std::lock_guard<std::mutex> lock(details_mutex_);
    if (details_.status() == CameraStatus::CAMERA_DISABLED) {
      details_.set_status(CameraStatus::CAMERA_ENABLED);
    }
  }
  if (thread_.joinable()) {
    thread_.join();
  }
  running_.store(true);
  status_.store(CameraStatus::CAMERA_LOADING);
  thread_ = std::thread(&Camera::runLoop, this);
}

void Camera::stop()
{
  running_.store(false);
  if (thread_.joinable()) {
    thread_.join();
  }
}

void Camera::updateDetails(const CameraDetails & details)
{
  std::lock_guard<std::mutex> lock(details_mutex_);
  details_.MergeFrom(details);

  // The Dashboard can disable a camera to free CPU and bandwidth (e.g. on the
  // Pi Zero 2 W). This mirrors CameraIsolate.updateDetails in the Dart video
  // program: stop streaming, and stay stopped until re-enabled.
  if (details_.status() == CameraStatus::CAMERA_DISABLED) {
    status_.store(CameraStatus::CAMERA_DISABLED);
    running_.store(false);
  }
}

void Camera::takeSnapshot()
{
  snapshot_requested_.store(true);
}

void Camera::setArucoDetector(std::shared_ptr<ArucoDetector>)
{
  // Default implementation does nothing; derived classes may override.
}

CameraDetails Camera::details() const
{
  std::lock_guard<std::mutex> lock(details_mutex_);
  return details_;
}

void Camera::setStatus(CameraStatus status)
{
  status_.store(status);
}

void Camera::publish(const VideoData & data)
{
  if (callback_) {
    callback_(data);
  }
}

}  // namespace video_ros2
