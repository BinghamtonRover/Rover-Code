#ifndef VIDEO_ROS2_GSTREAMER_CAMERA_HPP_
#define VIDEO_ROS2_GSTREAMER_CAMERA_HPP_

#include <memory>
#include <string>

#include "opencv2/core.hpp"

#include "video_ros2/camera.hpp"

namespace video_ros2
{

class ArucoDetector;
class JpegEncoder;

/// GStreamer-backed camera implementation.
///
/// Captures frames through a GStreamer pipeline instead of a V4L2 device.
/// This is the only way to reach the Raspberry Pi camera connector (CSI) on
/// Raspberry Pi OS Bullseye/Bullseye+, where the camera is exposed through the
/// libcamera stack (libcamerasrc) rather than a /dev/video device.
///
/// Compiled in only when GStreamer development libraries are found; the node
/// falls back to OpenCvCamera otherwise. V4L2 USB cameras can still use this
/// class with device path "v4l2:/dev/video0" if desired.
class GStreamerCamera : public Camera
{
public:
  /// @param device_path Camera selector:
  ///   - "csi" or "libcamera" -> libcamerasrc (Pi camera connector)
  ///   - "v4l2:/dev/videoN"   -> v4l2src on the given device
  ///   - "test"               -> videotestsrc (diagnostics)
  /// @param name Logical camera name.
  /// @param details Initial camera details (resolution, fps, quality).
  /// @param screenshot_dir Directory to save screenshots.
  GStreamerCamera(
    const std::string & device_path,
    CameraName name,
    const CameraDetails & details,
    const std::string & screenshot_dir = "/home/rover/shared/screenshots");
  ~GStreamerCamera() override;

  /// Set an optional ArUco detector. If set, markers are detected on each frame.
  void setArucoDetector(std::shared_ptr<ArucoDetector> detector);

private:
  void runLoop() override;
  void captureSnapshot() override;

  /// Build and start the pipeline from current camera details.
  bool openPipeline();
  void closePipeline();

  std::string device_path_;
  std::string screenshot_dir_;
  class Impl;
  std::unique_ptr<Impl> impl_;
  std::unique_ptr<JpegEncoder> encoder_;
  std::shared_ptr<ArucoDetector> aruco_detector_;
};

}  // namespace video_ros2

#endif  // VIDEO_ROS2_GSTREAMER_CAMERA_HPP_
