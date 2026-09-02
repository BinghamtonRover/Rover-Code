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
