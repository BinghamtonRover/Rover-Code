#ifndef VIDEO_ROS2_ARUCO_DETECTOR_HPP_
#define VIDEO_ROS2_ARUCO_DETECTOR_HPP_

#include <memory>
#include <string>
#include <vector>

#include "opencv2/core.hpp"
#include "subsystems_ros2/generated/vision.pb.h"
#include "subsystems_ros2/generated/video.pb.h"

namespace video_ros2
{

/// Configuration for the ArUco detector.
struct ArucoConfig
{
  /// OpenCV predefined dictionary name, e.g. "DICT_4X4_50", "DICT_5X5_100", etc.
  std::string dictionary = "DICT_4X4_50";

  /// Adaptive threshold window size minimum.
  int adaptive_thresh_win_size_min = 3;

  /// Adaptive threshold window size maximum.
  int adaptive_thresh_win_size_max = 23;

  /// Adaptive threshold window size step.
  int adaptive_thresh_win_size_step = 10;

  /// Adaptive threshold constant.
  double adaptive_thresh_constant = 7.0;

  /// Minimum marker perimeter rate.
  double min_marker_perimeter_rate = 0.03;

  /// Maximum marker perimeter rate.
  double max_marker_perimeter_rate = 4.0;

  /// Polygonal approximation accuracy rate.
  double polygonal_approx_accuracy_rate = 0.05;

  /// Minimum corner distance rate.
  double min_corner_distance_rate = 0.05;

  /// Minimum distance to borders.
  int min_distance_to_borders = 3;

  /// Corner refinement method (0 = NONE, 1 = SUBPIX, 2 = CONTOUR).
  int corner_refinement_method = 0;
};

/// Detects ArUco markers in a frame and returns protobuf DetectedObject entries.
///
/// The implementation is guarded by HAVE_OPENCV_ARUCO. When OpenCV's aruco module
/// is unavailable, detect() returns an empty vector.
class ArucoDetector
{
public:
  explicit ArucoDetector(const ArucoConfig & config = {});
  ~ArucoDetector();

  /// Run detection on a BGR frame. The caller's CameraDetails are used for
  /// field-of-view and default intrinsics when computing yaw/pitch.
  std::vector<DetectedObject> detect(const cv::Mat & frame, const CameraDetails & details);

private:
  class Impl;
  std::unique_ptr<Impl> impl_;
};

}  // namespace video_ros2

#endif  // VIDEO_ROS2_ARUCO_DETECTOR_HPP_
