#include "video_ros2/virtual_camera.hpp"

#include <chrono>
#include <ctime>
#include <filesystem>
#include <fstream>
#include <iomanip>
#include <sstream>
#include <thread>

#include <opencv2/imgproc.hpp>

#include "video_ros2/jpeg_encoder.hpp"

namespace fs = std::filesystem;

namespace video_ros2
{

VirtualCamera::VirtualCamera(
  CameraName name,
  const CameraDetails & details,
  const std::string & screenshot_dir)
: Camera(name, details), screenshot_dir_(screenshot_dir)
{
  encoder_ = std::make_unique<JpegEncoder>();
}

VirtualCamera::~VirtualCamera()
{
  stop();
}

cv::Mat VirtualCamera::renderFrame(int frame_index)
{
  CameraDetails current;
  {
    std::lock_guard<std::mutex> lock(details_mutex_);
    current = details_;
  }
  const int width = current.resolution_width() > 0 ? current.resolution_width() : 640;
  const int height = current.resolution_height() > 0 ? current.resolution_height() : 480;
  const int fps = current.fps() > 0 ? current.fps() : 30;

  // Diagonal color gradient background.
  cv::Mat frame(height, width, CV_8UC3);
  for (int y = 0; y < height; ++y) {
    auto * row = frame.ptr<cv::Vec3b>(y);
    for (int x = 0; x < width; ++x) {
      row[x][0] = static_cast<uchar>((x * 255) / width);            // blue increases ->
      row[x][1] = static_cast<uchar>((y * 255) / height);           // green increases v
      row[x][2] = static_cast<uchar>(((x + y) * 255) / (width + height));  // red diagonal
    }
  }

  // Moving element so motion is visible on the stream.
  const int radius = std::max(10, std::min(width, height) / 12);
  const int orbit = std::max(width, height) / 4;
  const double angle = (frame_index % fps) * 2.0 * CV_PI / fps;
  const cv::Point center(
    width / 2 + static_cast<int>(orbit * std::cos(angle)),
    height / 2 + static_cast<int>(orbit * std::sin(angle)));
  cv::circle(frame, center, radius, cv::Scalar(255, 255, 255), -1, cv::LINE_AA);
  cv::circle(frame, center, radius / 2, cv::Scalar(0, 0, 255), -1, cv::LINE_AA);

  // Frame counter in a corner.
  cv::putText(
    frame, "frame " + std::to_string(frame_index), cv::Point(10, 25),
    cv::FONT_HERSHEY_SIMPLEX, 0.7, cv::Scalar(255, 255, 255), 2, cv::LINE_AA);

  // Label with camera name and resolution.
  const std::string label =
    CameraName_Name(name()) + "  " + std::to_string(width) + "x" + std::to_string(height);
  cv::putText(
    frame, label, cv::Point(10, height - 12),
    cv::FONT_HERSHEY_SIMPLEX, 0.7, cv::Scalar(255, 255, 255), 2, cv::LINE_AA);

  return frame;
}

void VirtualCamera::runLoop()
{
  setStatus(CameraStatus::CAMERA_ENABLED);

  int frame_index = 0;
  while (running()) {
    const auto frame_start = std::chrono::steady_clock::now();

    if (snapshot_requested_.exchange(false)) {
      captureSnapshot();
    }

    cv::Mat frame = renderFrame(frame_index);

    // Encode and publish at the current quality setting.
    int quality = 75;
    {
      std::lock_guard<std::mutex> lock(details_mutex_);
      quality = details_.quality() > 0 ? details_.quality() : 75;
    }
    auto jpeg = encoder_->encode(frame, quality);
    if (!jpeg.empty()) {
      VideoData data;
      data.set_id(CameraName_Name(name()));
      *data.mutable_details() = details();
      data.set_frame(jpeg.data(), jpeg.size());
      publish(data);
    }

    ++frame_index;

    // Pace to the configured fps, accounting for render/encode time.
    int fps = 30;
    {
      std::lock_guard<std::mutex> lock(details_mutex_);
      fps = details_.fps() > 0 ? details_.fps() : 30;
    }
    const auto frame_interval = std::chrono::milliseconds(1000 / fps);
    std::this_thread::sleep_until(frame_start + frame_interval);
  }

  setStatus(CameraStatus::CAMERA_DISABLED);
}

void VirtualCamera::captureSnapshot()
{
  // A fresh full-resolution render.
  cv::Mat frame = renderFrame(0);

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
  data.set_id(CameraName_Name(name()));
  *data.mutable_details() = details();
  data.set_frame(jpeg.data(), jpeg.size());
  data.set_image_path(path.string());
  publish(data);
}

}  // namespace video_ros2
