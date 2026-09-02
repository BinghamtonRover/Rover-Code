#ifndef VIDEO_ROS2_VIRTUAL_CAMERA_HPP_
#define VIDEO_ROS2_VIRTUAL_CAMERA_HPP_

#include <string>

#include <opencv2/core.hpp>

#include "video_ros2/camera.hpp"

namespace video_ros2
{

/// A camera that generates synthetic frames instead of reading from hardware.
///
/// Useful for testing the video pipeline (JPEG encoding, topic transport, UDP
/// bridging, and Dashboard rendering) on machines without real cameras.
/// Each frame shows a color gradient background, a moving element so motion is
/// visible, a frame counter, and a label with the camera name and resolution.
class VirtualCamera : public Camera
{
public:
  /// @param name Logical camera name.
  /// @param details Initial camera details (resolution, fps, quality).
  /// @param screenshot_dir Directory to save screenshots.
  VirtualCamera(
    CameraName name,
    const CameraDetails & details,
    const std::string & screenshot_dir = "/home/rover/shared/screenshots");
  ~VirtualCamera() override;

private:
  void runLoop() override;
  void captureSnapshot() override;

  /// Render one synthetic frame for the given frame index.
  cv::Mat renderFrame(int frame_index);

  std::string screenshot_dir_;
  std::unique_ptr<class JpegEncoder> encoder_;
};

}  // namespace video_ros2

#endif  // VIDEO_ROS2_VIRTUAL_CAMERA_HPP_
