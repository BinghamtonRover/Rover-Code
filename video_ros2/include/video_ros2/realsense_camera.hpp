#ifndef VIDEO_ROS2_REALSENSE_CAMERA_HPP_
#define VIDEO_ROS2_REALSENSE_CAMERA_HPP_

#include <memory>
#include <string>

#include "video_ros2/camera.hpp"

// Forward declarations for librealsense2 when available.
#ifdef HAS_REALSENSE
namespace rs2
{
class frameset;
}  // namespace rs2
#endif

namespace video_ros2
{

class ArucoDetector;

/// RealSense depth camera implementation.
///
/// Publishes both RGB frames (as ROVER_FRONT) and colorized depth frames
/// (as AUTONOMY_DEPTH). Disabled at compile time when librealsense2 is absent.
class RealSenseCamera : public Camera
{
public:
  RealSenseCamera(CameraName name, const CameraDetails & details);
  ~RealSenseCamera() override;

  /// Set an optional ArUco detector. If set, markers are detected on the RGB frame.
  void setArucoDetector(std::shared_ptr<ArucoDetector> detector);

private:
  void runLoop() override;
  void captureSnapshot() override;

  bool openDevice();
  void closeDevice();
#ifdef HAS_REALSENSE
  void publishFrames(const rs2::frameset & frames);
#endif

  class Impl;
  std::unique_ptr<Impl> impl_;
  std::shared_ptr<ArucoDetector> aruco_detector_;
};

}  // namespace video_ros2

#endif  // VIDEO_ROS2_REALSENSE_CAMERA_HPP_
