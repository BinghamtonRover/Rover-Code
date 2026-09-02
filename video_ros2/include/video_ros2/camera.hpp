#ifndef VIDEO_ROS2_CAMERA_HPP_
#define VIDEO_ROS2_CAMERA_HPP_

#include <atomic>
#include <functional>
#include <memory>
#include <string>
#include <thread>

#include "subsystems_ros2/generated/video.pb.h"

namespace video_ros2
{

class ArucoDetector;

/// Callback invoked when a camera produces a VideoData message.
using VideoDataCallback = std::function<void(const VideoData &)>;

/// Abstract base class for a camera managed by the video node.
class Camera
{
public:
  explicit Camera(CameraName name, const CameraDetails & details);
  virtual ~Camera();

  /// Set an optional ArUco detector. Derived classes may override.
  virtual void setArucoDetector(std::shared_ptr<ArucoDetector> detector);

  /// Start the camera capture thread.
  void start(VideoDataCallback callback);

  /// Stop the camera capture thread.
  void stop();

  /// Update camera details (resolution, fps, quality, etc.).
  void updateDetails(const CameraDetails & details);

  /// Take a high-quality screenshot and publish it via the callback.
  void takeSnapshot();

  CameraName name() const { return name_; }
  CameraStatus status() const { return status_.load(); }
  CameraDetails details() const;

protected:
  /// Derived classes implement the actual frame capture loop.
  virtual void runLoop() = 0;

  /// Derived classes implement high-quality screenshot capture.
  virtual void captureSnapshot() = 0;

  /// Set the current camera status thread-safely.
  void setStatus(CameraStatus status);

  /// Publish a VideoData message to the callback.
  void publish(const VideoData & data);

  /// Return true if the camera should keep running.
  bool running() const { return running_.load(); }

  /// Thread-safe access to mutable details.
  mutable std::mutex details_mutex_;
  CameraDetails details_;

  const CameraName name_;
  std::atomic<bool> snapshot_requested_{false};

private:
  std::atomic<bool> running_{false};
  std::atomic<CameraStatus> status_{CameraStatus::CAMERA_LOADING};
  std::thread thread_;
  VideoDataCallback callback_;
};

}  // namespace video_ros2

#endif  // VIDEO_ROS2_CAMERA_HPP_
