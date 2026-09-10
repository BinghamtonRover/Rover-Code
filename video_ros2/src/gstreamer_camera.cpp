#include "video_ros2/gstreamer_camera.hpp"

#include <chrono>
#include <ctime>
#include <filesystem>
#include <fstream>
#include <iomanip>
#include <sstream>
#include <thread>
#include <utility>
#include <vector>

#include "rclcpp/rclcpp.hpp"

#include "opencv2/imgproc.hpp"

#ifdef HAS_GSTREAMER
#include <gst/app/app.h>
#include <gst/gst.h>
#endif

#include "video_ros2/aruco_detector.hpp"
#include "video_ros2/jpeg_encoder.hpp"

namespace fs = std::filesystem;

namespace video_ros2
{

class GStreamerCamera::Impl
{
public:
#ifdef HAS_GSTREAMER
  GstElement * pipeline = nullptr;
  GstElement * appsink = nullptr;
#endif
};

#ifdef HAS_GSTREAMER

/// RAII guard for GStreamer sample buffers.
class SampleGuard
{
public:
  explicit SampleGuard(GstSample * sample)
  : sample_(sample) {}
  ~SampleGuard()
  {
    if (sample_) {
      gst_sample_unref(sample_);
    }
  }
  SampleGuard(const SampleGuard &) = delete;
  SampleGuard & operator=(const SampleGuard &) = delete;
  GstSample * get() const { return sample_; }

private:
  GstSample * sample_;
};

#endif  // HAS_GSTREAMER

GStreamerCamera::GStreamerCamera(
  const std::string & device_path,
  CameraName name,
  const CameraDetails & details,
  const std::string & screenshot_dir)
: Camera(name, details),
  device_path_(device_path),
  screenshot_dir_(screenshot_dir),
  impl_(std::make_unique<Impl>())
{
  encoder_ = std::make_unique<JpegEncoder>();
#ifdef HAS_GSTREAMER
  gst_init(nullptr, nullptr);
#endif
}

GStreamerCamera::~GStreamerCamera()
{
  stop();
}

void GStreamerCamera::setArucoDetector(std::shared_ptr<ArucoDetector> detector)
{
  aruco_detector_ = std::move(detector);
}

bool GStreamerCamera::openPipeline()
{
#ifndef HAS_GSTREAMER
  RCLCPP_ERROR(
    rclcpp::get_logger("video_ros2"),
    "GStreamerCamera: GStreamer support not compiled in (install libgstreamer1.0-dev "
    "libgstreamer-plugins-base1.0-dev gstreamer1.0-libcamera)");
  setStatus(CameraStatus::CAMERA_DISCONNECTED);
  return false;
#else
  closePipeline();

  CameraDetails current;
  {
    std::lock_guard<std::mutex> lock(details_mutex_);
    current = details_;
  }

  const int width = current.resolution_width() > 0 ? current.resolution_width() : 640;
  const int height = current.resolution_height() > 0 ? current.resolution_height() : 480;
  const int fps = current.fps() > 0 ? current.fps() : 30;

  // Select the source element from the device path.
  std::string source;
  if (device_path_ == "csi" || device_path_ == "libcamera") {
    // Raspberry Pi camera connector (CSI) through the libcamera stack.
    source = "libcamerasrc";
  } else if (device_path_.rfind("v4l2:", 0) == 0) {
    source = "v4l2src device=" + device_path_.substr(5);
  } else if (device_path_ == "test") {
    source = "videotestsrc";
  } else {
    // Convenience: bare /dev/videoN paths behave like OpenCvCamera's V4L2.
    source = "v4l2src device=" + device_path_;
  }

  // Build a pipeline that hands raw BGR frames to the appsink. max-buffers=1
  // with drop=true keeps only the freshest frame so the encode loop never
  // falls behind the capture rate on the slow Zero 2 W.
  const std::string desc =
    source + " ! video/x-raw,width=" + std::to_string(width) +
    ",height=" + std::to_string(height) + ",framerate=" + std::to_string(fps) +
    "/1 ! videoconvert ! video/x-raw,format=BGR ! appsink name=sink emit-signals=false "
    "sync=false max-buffers=1 drop=true";

  GError * error = nullptr;
  GstElement * pipeline = gst_parse_launch(desc.c_str(), &error);
  if (!pipeline || error) {
    RCLCPP_ERROR(
      rclcpp::get_logger("video_ros2"), "GStreamerCamera: failed to build pipeline '%s': %s",
      desc.c_str(), error ? error->message : "unknown error");
    if (error) {
      g_error_free(error);
    }
    if (pipeline) {
      gst_object_unref(pipeline);
    }
    setStatus(CameraStatus::CAMERA_DISCONNECTED);
    return false;
  }

  GstElement * appsink = gst_bin_get_by_name(reinterpret_cast<GstBin *>(pipeline), "sink");
  if (!appsink) {
    RCLCPP_ERROR(rclcpp::get_logger("video_ros2"), "GStreamerCamera: appsink missing");
    gst_object_unref(pipeline);
    setStatus(CameraStatus::CAMERA_DISCONNECTED);
    return false;
  }

  if (gst_element_set_state(pipeline, GST_STATE_PLAYING) == GST_STATE_CHANGE_FAILURE) {
    RCLCPP_ERROR(
      rclcpp::get_logger("video_ros2"), "GStreamerCamera: pipeline failed to start (%s)",
      desc.c_str());
    gst_object_unref(appsink);
    gst_object_unref(pipeline);
    setStatus(CameraStatus::CAMERA_DISCONNECTED);
    return false;
  }

  // Wait (briefly) for the pipeline to reach PLAYING so open failures are
  // reported here instead of silently timing out in the capture loop.
  GstState state = GST_STATE_NULL;
  gst_element_get_state(pipeline, &state, nullptr, 2 * GST_SECOND);
  if (state != GST_STATE_PLAYING) {
    RCLCPP_ERROR(rclcpp::get_logger("video_ros2"), "GStreamerCamera: pipeline did not reach PLAYING");
    gst_object_unref(appsink);
    gst_object_unref(pipeline);
    setStatus(CameraStatus::CAMERA_DISCONNECTED);
    return false;
  }

  impl_->pipeline = pipeline;
  impl_->appsink = appsink;

  {
    std::lock_guard<std::mutex> lock(details_mutex_);
    CameraDetails updated = details_;
    updated.set_resolution_width(width);
    updated.set_resolution_height(height);
    updated.set_fps(fps);
    details_ = updated;
  }

  setStatus(CameraStatus::CAMERA_ENABLED);
  return true;
#endif
}

void GStreamerCamera::closePipeline()
{
#ifdef HAS_GSTREAMER
  if (impl_->pipeline) {
    gst_element_set_state(impl_->pipeline, GST_STATE_NULL);
    if (impl_->appsink) {
      gst_object_unref(impl_->appsink);
      impl_->appsink = nullptr;
    }
    gst_object_unref(impl_->pipeline);
    impl_->pipeline = nullptr;
  }
#endif
}

void GStreamerCamera::runLoop()
{
#ifndef HAS_GSTREAMER
  (void)openPipeline();
  return;
#else
  if (!openPipeline()) {
    return;
  }

  CameraDetails current;
  {
    std::lock_guard<std::mutex> lock(details_mutex_);
    current = details_;
  }

  auto frame_interval =
    std::chrono::milliseconds(current.fps() > 0 ? 1000 / current.fps() : 33);
  auto next_frame_time = std::chrono::steady_clock::now() + frame_interval;

  while (running()) {
    std::this_thread::sleep_until(next_frame_time);

    // Re-read the pacing interval each frame so detail updates take effect.
    {
      std::lock_guard<std::mutex> lock(details_mutex_);
      current = details_;
    }
    frame_interval =
      std::chrono::milliseconds(current.fps() > 0 ? 1000 / current.fps() : 33);

    GstSample * raw = gst_app_sink_try_pull_sample(
      reinterpret_cast<GstAppSink *>(impl_->appsink), 100 * GST_MSECOND);
    SampleGuard sample(raw);
    if (!sample.get()) {
      setStatus(CameraStatus::CAMERA_NOT_RESPONDING);
      next_frame_time = std::chrono::steady_clock::now() + frame_interval;
      continue;
    }
    setStatus(CameraStatus::CAMERA_ENABLED);

    GstCaps * caps = gst_sample_get_caps(sample.get());
    GstStructure * structure = caps ? gst_caps_get_structure(caps, 0) : nullptr;
    int width = 0;
    int height = 0;
    if (structure) {
      gst_structure_get_int(structure, "width", &width);
      gst_structure_get_int(structure, "height", &height);
    }
    GstBuffer * buffer = gst_sample_get_buffer(sample.get());
    GstMapInfo map {};
    if (width <= 0 || height <= 0 || !buffer || !gst_buffer_map(buffer, &map, GST_MAP_READ)) {
      next_frame_time += frame_interval;
      continue;
    }

    cv::Mat frame(height, width, CV_8UC3, map.data, cv::Mat::AUTO_STEP);
    if (frame.empty()) {
      gst_buffer_unmap(buffer, &map);
      next_frame_time += frame_interval;
      continue;
    }

    // Handle snapshot request with a dedicated high-quality capture.
    if (snapshot_requested_.exchange(false)) {
      gst_buffer_unmap(buffer, &map);
      captureSnapshot();
      next_frame_time += frame_interval;
      continue;
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
    if (!jpeg.empty()) {
      VideoData data;
      data.set_id(CameraName_Name(name()));
      *data.mutable_details() = details();
      data.set_frame(jpeg.data(), jpeg.size());
      for (const auto & obj : detected_objects) {
        *data.add_detected_objects() = obj;
      }
      publish(data);
    }

    gst_buffer_unmap(buffer, &map);
    next_frame_time += frame_interval;
  }

  closePipeline();
  setStatus(CameraStatus::CAMERA_DISABLED);
#endif
}

void GStreamerCamera::captureSnapshot()
{
#ifndef HAS_GSTREAMER
  return;
#else
  if (!impl_->appsink) {
    return;
  }

  // Pull the freshest frame (blocking) for a high-quality shot.
  GstSample * raw = gst_app_sink_pull_sample(reinterpret_cast<GstAppSink *>(impl_->appsink));
  SampleGuard sample(raw);
  if (!sample.get()) {
    return;
  }

  GstCaps * caps = gst_sample_get_caps(sample.get());
  GstStructure * structure = caps ? gst_caps_get_structure(caps, 0) : nullptr;
  int width = 0;
  int height = 0;
  if (structure) {
    gst_structure_get_int(structure, "width", &width);
    gst_structure_get_int(structure, "height", &height);
  }
  GstBuffer * buffer = gst_sample_get_buffer(sample.get());
  GstMapInfo map {};
  if (width <= 0 || height <= 0 || !buffer || !gst_buffer_map(buffer, &map, GST_MAP_READ)) {
    return;
  }

  cv::Mat frame(height, width, CV_8UC3, map.data, cv::Mat::AUTO_STEP);
  auto jpeg = encoder_->encode(frame, 95);
  gst_buffer_unmap(buffer, &map);
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
#endif
}

}  // namespace video_ros2
