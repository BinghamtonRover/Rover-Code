#include "video_ros2/opencv_camera.hpp"

#include <chrono>
#include <ctime>
#include <filesystem>
#include <fstream>
#include <iomanip>
#include <sstream>
#include <thread>

#include "opencv2/imgproc.hpp"

#include "video_ros2/aruco_detector.hpp"
#include "video_ros2/jpeg_encoder.hpp"

namespace fs = std::filesystem;


namespace video_ros2
{

OpenCvCamera::OpenCvCamera(
  const std::string & device_path,
  CameraName name,
  const CameraDetails & details,
  const std::string & screenshot_dir)
: Camera(name, details), device_path_(device_path), screenshot_dir_(screenshot_dir)
{
  encoder_ = std::make_unique<JpegEncoder>();
}

void OpenCvCamera::setArucoDetector(std::shared_ptr<ArucoDetector> detector)
{
  aruco_detector_ = std::move(detector);
}

OpenCvCamera::~OpenCvCamera()
{
  stop();
}

bool OpenCvCamera::openDevice()
{
  closeDevice();
  CameraDetails current;
  {
    std::lock_guard<std::mutex> lock(details_mutex_);
    current = details_;
  }

  capture_.open(device_path_, cv::CAP_V4L2);
  if (!capture_.isOpened()) {
    setStatus(CameraStatus::CAMERA_DISCONNECTED);
    return false;
  }

  // Prefer MJPEG pixel format to reduce USB bandwidth and CPU load.
  capture_.set(cv::CAP_PROP_FOURCC, cv::VideoWriter::fourcc('M', 'J', 'P', 'G'));
  if (current.resolution_width() > 0 && current.resolution_height() > 0) {
    capture_.set(cv::CAP_PROP_FRAME_WIDTH, current.resolution_width());
    capture_.set(cv::CAP_PROP_FRAME_HEIGHT, current.resolution_height());
  }
  if (current.fps() > 0) {
    capture_.set(cv::CAP_PROP_FPS, current.fps());
  }
  capture_.set(cv::CAP_PROP_AUTOFOCUS, current.autofocus() ? 1 : 0);
  if (current.focus() != 0) {
    capture_.set(cv::CAP_PROP_FOCUS, current.focus());
  }
  if (current.zoom() != 0) {
    capture_.set(cv::CAP_PROP_ZOOM, current.zoom());
  }
  if (current.pan() != 0) {
    capture_.set(cv::CAP_PROP_PAN, current.pan());
  }
  if (current.tilt() != 0) {
    capture_.set(cv::CAP_PROP_TILT, current.tilt());
  }

  // Read back actual properties.
  CameraDetails updated;
  {
    std::lock_guard<std::mutex> lock(details_mutex_);
    updated = details_;
    updated.set_resolution_width(static_cast<int>(capture_.get(cv::CAP_PROP_FRAME_WIDTH)));
    updated.set_resolution_height(static_cast<int>(capture_.get(cv::CAP_PROP_FRAME_HEIGHT)));
    updated.set_fps(static_cast<int>(capture_.get(cv::CAP_PROP_FPS)));
    details_ = updated;
  }

  setStatus(CameraStatus::CAMERA_ENABLED);
  return true;
}

void OpenCvCamera::closeDevice()
{
  if (capture_.isOpened()) {
    capture_.release();
  }
}

void OpenCvCamera::runLoop()
{
  if (!openDevice()) {
    return;
  }

  CameraDetails current;
  {
    std::lock_guard<std::mutex> lock(details_mutex_);
    current = details_;
  }

  const auto frame_interval = std::chrono::milliseconds(current.fps() > 0 ? 1000 / current.fps() : 33);
  auto next_frame_time = std::chrono::steady_clock::now() + frame_interval;

  while (running()) {
    std::this_thread::sleep_until(next_frame_time);

    cv::Mat frame;
    if (!capture_.read(frame) || frame.empty()) {
      setStatus(CameraStatus::CAMERA_NOT_RESPONDING);
      // Avoid busy-looping on a disconnected camera.
      std::this_thread::sleep_for(std::chrono::milliseconds(100));
      next_frame_time = std::chrono::steady_clock::now() + frame_interval;
      continue;
    }
    setStatus(CameraStatus::CAMERA_ENABLED);

    // Handle snapshot request.
    if (snapshot_requested_.exchange(false)) {
      captureSnapshot();
    }

    // Optionally detect ArUco markers on the raw frame.
    std::vector<DetectedObject> detected_objects;
    if (aruco_detector_) {
      detected_objects = aruco_detector_->detect(frame, details());
    }

    // Determine stream dimensions.
    int stream_width = frame.cols;
    int stream_height = frame.rows;
    {
      std::lock_guard<std::mutex> lock(details_mutex_);
      if (details_.stream_width() > 0 && details_.stream_width() < stream_width) {
        stream_width = details_.stream_width();
      }
      if (details_.stream_height() > 0 && details_.stream_height() < stream_height) {
        stream_height = details_.stream_height();
      }
    }

    cv::Mat resized = frame;
    if (stream_width < frame.cols || stream_height < frame.rows) {
      cv::Mat tmp;
      cv::resize(frame, tmp, cv::Size(stream_width, stream_height), 0, 0, cv::INTER_AREA);
      resized = tmp;
    }

    int quality = 75;
    {
      std::lock_guard<std::mutex> lock(details_mutex_);
      quality = details_.quality() > 0 ? details_.quality() : 75;
    }
    auto jpeg = encoder_->encode(resized, quality);
    if (jpeg.empty()) {
      continue;
    }

    VideoData data;
    data.set_id(CameraName_Name(name()));
    *data.mutable_details() = details();
    data.set_frame(jpeg.data(), jpeg.size());
    for (const auto & obj : detected_objects) {
      *data.add_detected_objects() = obj;
    }
    publish(data);

    next_frame_time += frame_interval;
  }

  closeDevice();
  setStatus(CameraStatus::CAMERA_DISABLED);
}

void OpenCvCamera::captureSnapshot()
{
  if (!capture_.isOpened()) {
    return;
  }
  cv::Mat frame;
  if (!capture_.read(frame) || frame.empty()) {
    return;
  }

  auto jpeg = encoder_->encode(frame, 95);
  if (jpeg.empty()) {
    return;
  }

  // Save screenshot to configured folder using a timestamped filename.
  std::string camera_name = CameraName_Name(name());
  fs::path dir = fs::path(screenshot_dir_) / camera_name;
  std::error_code ec;
  fs::create_directories(dir, ec);
  auto now = std::chrono::system_clock::now();
  auto time_t = std::chrono::system_clock::to_time_t(now);
  std::stringstream ss;
  ss << std::put_time(std::localtime(&time_t), "%Y%m%d_%H%M%S");
  fs::path path = dir / ("screenshot_" + ss.str() + ".jpg");
  {
    std::ofstream file(path, std::ios::binary);
    if (file) {
      file.write(reinterpret_cast<const char *>(jpeg.data()), jpeg.size());
    }
  }

  VideoData data;
  data.set_id(CameraName_Name(name_));
  *data.mutable_details() = details();
  data.set_frame(jpeg.data(), jpeg.size());
  data.set_image_path(path.string());
  publish(data);
}

}  // namespace video_ros2
