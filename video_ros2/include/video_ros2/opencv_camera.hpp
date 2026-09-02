#ifndef VIDEO_ROS2_OPENCV_CAMERA_HPP_
#define VIDEO_ROS2_OPENCV_CAMERA_HPP_

#include <memory>
#include <string>

#include "opencv2/videoio.hpp"

#include "video_ros2/camera.hpp"

namespace video_ros2
{

class ArucoDetector;

/// OpenCV-backed V4L2 camera implementation.
class OpenCvCamera : public Camera
{
public:
  /// @param device_path Path to the V4L2 device (e.g. /dev/video0).
  /// @param name Logical camera name.
  /// @param details Initial camera details.
  /// @param screenshot_dir Directory to save screenshots.
  OpenCvCamera(
    const std::string & device_path,
    CameraName name,
    const CameraDetails & details,
    const std::string & screenshot_dir = "/home/rover/shared/screenshots");
  ~OpenCvCamera() override;

  /// Set an optional ArUco detector. If set, markers are detected on each frame.
  void setArucoDetector(std::shared_ptr<ArucoDetector> detector);

private:
  void runLoop() override;
  void captureSnapshot() override;

  /// Open the underlying V4L2 device with current details.
  bool openDevice();
  void closeDevice();

  std::string device_path_;
  std::string screenshot_dir_;
  cv::VideoCapture capture_;
  std::unique_ptr<class JpegEncoder> encoder_;
  std::shared_ptr<ArucoDetector> aruco_detector_;
};

}  // namespace video_ros2

#endif  // VIDEO_ROS2_OPENCV_CAMERA_HPP_
