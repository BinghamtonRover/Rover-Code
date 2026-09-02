#include "video_ros2/aruco_detector.hpp"

#include <cmath>
#include <iostream>

#include "opencv2/imgproc.hpp"

#ifdef HAVE_OPENCV_ARUCO
#include "opencv2/aruco.hpp"
#endif

namespace video_ros2
{

namespace
{

constexpr float kDefaultHorizontalFovDeg = 60.0f;

void computeYawPitch(
  int center_x, int center_y, int width, int height,
  float horizontal_fov_deg, float & yaw, float & pitch)
{
  const float fov_rad = horizontal_fov_deg * static_cast<float>(M_PI) / 180.0f;
  const float focal = (width > 0) ? (width / (2.0f * std::tan(fov_rad / 2.0f))) : 1.0f;
  const float cx = width / 2.0f;
  const float cy = height / 2.0f;
  yaw = std::atan2(center_x - cx, focal) * 180.0f / static_cast<float>(M_PI);
  pitch = std::atan2(center_y - cy, focal) * 180.0f / static_cast<float>(M_PI);
}

}  // namespace

class ArucoDetector::Impl
{
public:
#ifdef HAVE_OPENCV_ARUCO
  explicit Impl(const ArucoConfig & config)
  {
    dictionary_ = cv::aruco::getPredefinedDictionary(parseDictionary(config.dictionary));
    params_ = cv::aruco::DetectorParameters::create();
    params_->adaptiveThreshWinSizeMin = config.adaptive_thresh_win_size_min;
    params_->adaptiveThreshWinSizeMax = config.adaptive_thresh_win_size_max;
    params_->adaptiveThreshWinSizeStep = config.adaptive_thresh_win_size_step;
    params_->adaptiveThreshConstant = config.adaptive_thresh_constant;
    params_->minMarkerPerimeterRate = config.min_marker_perimeter_rate;
    params_->maxMarkerPerimeterRate = config.max_marker_perimeter_rate;
    params_->polygonalApproxAccuracyRate = config.polygonal_approx_accuracy_rate;
    params_->minCornerDistanceRate = config.min_corner_distance_rate;
    params_->minDistanceToBorder = config.min_distance_to_borders;
    params_->cornerRefinementMethod = config.corner_refinement_method;
  }

  static cv::aruco::PREDEFINED_DICTIONARY_NAME parseDictionary(const std::string & name)
  {
    if (name == "DICT_4X4_50") return cv::aruco::DICT_4X4_50;
    if (name == "DICT_4X4_100") return cv::aruco::DICT_4X4_100;
    if (name == "DICT_4X4_250") return cv::aruco::DICT_4X4_250;
    if (name == "DICT_4X4_1000") return cv::aruco::DICT_4X4_1000;
    if (name == "DICT_5X5_50") return cv::aruco::DICT_5X5_50;
    if (name == "DICT_5X5_100") return cv::aruco::DICT_5X5_100;
    if (name == "DICT_5X5_250") return cv::aruco::DICT_5X5_250;
    if (name == "DICT_5X5_1000") return cv::aruco::DICT_5X5_1000;
    if (name == "DICT_6X6_50") return cv::aruco::DICT_6X6_50;
    if (name == "DICT_6X6_100") return cv::aruco::DICT_6X6_100;
    if (name == "DICT_6X6_250") return cv::aruco::DICT_6X6_250;
    if (name == "DICT_6X6_1000") return cv::aruco::DICT_6X6_1000;
    if (name == "DICT_7X7_50") return cv::aruco::DICT_7X7_50;
    if (name == "DICT_7X7_100") return cv::aruco::DICT_7X7_100;
    if (name == "DICT_7X7_250") return cv::aruco::DICT_7X7_250;
    if (name == "DICT_7X7_1000") return cv::aruco::DICT_7X7_1000;
    if (name == "DICT_ARUCO_ORIGINAL") return cv::aruco::DICT_ARUCO_ORIGINAL;
    std::cerr << "[ArucoDetector] Unknown dictionary '" << name
              << "'. Falling back to DICT_4X4_50." << std::endl;
    return cv::aruco::DICT_4X4_50;
  }

  std::vector<DetectedObject> detect(const cv::Mat & frame, const CameraDetails & details)
  {
    std::vector<std::vector<cv::Point2f>> corners;
    std::vector<int> ids;
    cv::aruco::detectMarkers(frame, dictionary_, corners, ids, params_);

    std::vector<DetectedObject> objects;
    if (ids.empty()) {
      return objects;
    }

    const float horizontal_fov = details.horizontal_fov() > 0 ? details.horizontal_fov() : kDefaultHorizontalFovDeg;
    const int width = frame.cols;
    const int height = frame.rows;
    const double frame_area = static_cast<double>(width) * height;

    for (size_t i = 0; i < ids.size(); ++i) {
      const auto & marker_corners = corners[i];
      if (marker_corners.size() != 4) {
        continue;
      }

      float center_x = 0.0f;
      float center_y = 0.0f;
      for (const auto & p : marker_corners) {
        center_x += p.x;
        center_y += p.y;
      }
      center_x /= 4.0f;
      center_y /= 4.0f;

      std::vector<cv::Point2f> contour(marker_corners.begin(), marker_corners.end());
      const double area = cv::contourArea(contour);

      float yaw = 0.0f;
      float pitch = 0.0f;
      computeYawPitch(
        static_cast<int>(center_x), static_cast<int>(center_y), width, height,
        horizontal_fov, yaw, pitch);

      DetectedObject obj;
      obj.set_object_type(DetectedObjectType::ARUCO);
      obj.set_aruco_tag_id(ids[i]);
      obj.set_center_x(static_cast<int32_t>(center_x));
      obj.set_center_y(static_cast<int32_t>(center_y));
      obj.set_relative_size(static_cast<float>(area / frame_area));
      obj.set_yaw(yaw);
      obj.set_pitch(pitch);
      objects.push_back(obj);
    }

    return objects;
  }

  cv::Ptr<cv::aruco::Dictionary> dictionary_;
  cv::Ptr<cv::aruco::DetectorParameters> params_;
#else
  Impl() = default;

  std::vector<DetectedObject> detect(const cv::Mat &, const CameraDetails &)
  {
    return {};
  }
#endif
};

ArucoDetector::ArucoDetector(const ArucoConfig & config)
: impl_(std::make_unique<Impl>(config))
{
}

ArucoDetector::~ArucoDetector() = default;

std::vector<DetectedObject> ArucoDetector::detect(const cv::Mat & frame, const CameraDetails & details)
{
  return impl_->detect(frame, details);
}

}  // namespace video_ros2
