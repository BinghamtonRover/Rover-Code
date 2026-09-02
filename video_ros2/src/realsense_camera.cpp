#include "video_ros2/realsense_camera.hpp"

#include "rclcpp/rclcpp.hpp"

#ifdef HAS_REALSENSE
#include <librealsense2/rs.hpp>
#endif

#include "video_ros2/aruco_detector.hpp"
#include "video_ros2/jpeg_encoder.hpp"

namespace video_ros2
{

class RealSenseCamera::Impl
{
public:
#ifdef HAS_REALSENSE
  rs2::context ctx;
  rs2::pipeline pipe;
  rs2::config cfg;
  std::unique_ptr<JpegEncoder> encoder;
  int rgb_width = 640;
  int rgb_height = 480;
  int depth_width = 640;
  int depth_height = 480;
  int fps = 30;
#endif
};

RealSenseCamera::RealSenseCamera(CameraName name, const CameraDetails & details)
: Camera(name, details), impl_(std::make_unique<Impl>())
{
}

RealSenseCamera::~RealSenseCamera()
{
  stop();
}

void RealSenseCamera::setArucoDetector(std::shared_ptr<ArucoDetector> detector)
{
  aruco_detector_ = std::move(detector);
}

bool RealSenseCamera::openDevice()
{
#ifdef HAS_REALSENSE
  try {
    impl_->encoder = std::make_unique<JpegEncoder>();
    {
      std::lock_guard<std::mutex> lock(details_mutex_);
      impl_->rgb_width = details_.resolution_width() > 0 ? details_.resolution_width() : 640;
      impl_->rgb_height = details_.resolution_height() > 0 ? details_.resolution_height() : 480;
      impl_->depth_width = details_.stream_width() > 0 ? details_.stream_width() : 640;
      impl_->depth_height = details_.stream_height() > 0 ? details_.stream_height() : 480;
      impl_->fps = details_.fps() > 0 ? details_.fps() : 30;
    }
    impl_->cfg.enable_stream(RS2_STREAM_COLOR, impl_->rgb_width, impl_->rgb_height, RS2_FORMAT_BGR8, impl_->fps);
    impl_->cfg.enable_stream(RS2_STREAM_DEPTH, impl_->depth_width, impl_->depth_height, RS2_FORMAT_Z16, impl_->fps);
    impl_->pipe.start(impl_->cfg);
    setStatus(CameraStatus::CAMERA_ENABLED);
    return true;
  } catch (const std::exception & e) {
    RCLCPP_ERROR(rclcpp::get_logger("video_ros2"), "RealSense open failed: %s", e.what());
    setStatus(CameraStatus::CAMERA_DISCONNECTED);
    return false;
  }
#else
  RCLCPP_WARN(rclcpp::get_logger("video_ros2"), "RealSense support not compiled in");
  setStatus(CameraStatus::CAMERA_DISCONNECTED);
  return false;
#endif
}

void RealSenseCamera::closeDevice()
{
#ifdef HAS_REALSENSE
  try {
    impl_->pipe.stop();
  } catch (...) {
  }
#endif
}

void RealSenseCamera::runLoop()
{
  if (!openDevice()) {
    return;
  }

#ifdef HAS_REALSENSE
  while (running()) {
    if (snapshot_requested_.exchange(false)) {
      captureSnapshot();
    }

    rs2::frameset frames;
    try {
      // Block efficiently until frames arrive (or 100 ms timeout).
      frames = impl_->pipe.wait_for_frames(100);
    } catch (const rs2::error & e) {
      // Timeout or transient error; loop back and check running().
      continue;
    } catch (const std::exception & e) {
      RCLCPP_ERROR(rclcpp::get_logger("video_ros2"), "RealSense wait_for_frames failed: %s", e.what());
      setStatus(CameraStatus::CAMERA_NOT_RESPONDING);
      continue;
    }

    setStatus(CameraStatus::CAMERA_ENABLED);
    publishFrames(frames);
  }
#endif

  closeDevice();
  setStatus(CameraStatus::CAMERA_DISABLED);
}

#ifdef HAS_REALSENSE
void RealSenseCamera::publishFrames(const rs2::frameset & frames)
{
  int quality = 75;
  {
    std::lock_guard<std::mutex> lock(details_mutex_);
    quality = details_.quality() > 0 ? details_.quality() : 75;
  }

  // RGB frame
  if (rs2::frame color = frames.first_or_default(RS2_STREAM_COLOR)) {
    cv::Mat rgb_mat(cv::Size(impl_->rgb_width, impl_->rgb_height), CV_8UC3, const_cast<void *>(color.get_data()), cv::Mat::AUTO_STEP);

    std::vector<DetectedObject> detected_objects;
    if (aruco_detector_) {
      CameraDetails details = this->details();
      details.set_name(CameraName::ROVER_FRONT);
      detected_objects = aruco_detector_->detect(rgb_mat, details);
    }

    auto jpeg = impl_->encoder->encode(rgb_mat, quality);
    if (!jpeg.empty()) {
      VideoData data;
      data.set_id("ROVER_FRONT");
      CameraDetails details = this->details();
      details.set_name(CameraName::ROVER_FRONT);
      *data.mutable_details() = details;
      data.set_frame(jpeg.data(), jpeg.size());
      for (const auto & obj : detected_objects) {
        *data.add_detected_objects() = obj;
      }
      publish(data);
    }
  }

  // Colorized depth frame
  if (rs2::frame depth = frames.first_or_default(RS2_STREAM_DEPTH)) {
    rs2::colorizer color_map;
    rs2::frame colorized = color_map(depth);
    cv::Mat depth_mat(cv::Size(impl_->depth_width, impl_->depth_height), CV_8UC3, const_cast<void *>(colorized.get_data()), cv::Mat::AUTO_STEP);
    auto jpeg = impl_->encoder->encode(depth_mat, quality);
    if (!jpeg.empty()) {
      VideoData data;
      data.set_id("AUTONOMY_DEPTH");
      CameraDetails details = this->details();
      details.set_name(CameraName::AUTONOMY_DEPTH);
      *data.mutable_details() = details;
      data.set_frame(jpeg.data(), jpeg.size());
      publish(data);
    }
  }
}
#endif

void RealSenseCamera::captureSnapshot()
{
#ifdef HAS_REALSENSE
  try {
    rs2::frameset frames = impl_->pipe.wait_for_frames(5000);
    publishFrames(frames);
  } catch (const std::exception & e) {
    RCLCPP_ERROR(rclcpp::get_logger("video_ros2"), "RealSense snapshot failed: %s", e.what());
  }
#endif
}

}  // namespace video_ros2
