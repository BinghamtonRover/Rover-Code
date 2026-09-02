#include <chrono>
#include <cmath>
#include <cstdint>
#include <vector>

#include "gtest/gtest.h"
#include "opencv2/core.hpp"
#include "opencv2/imgproc.hpp"

#include "video_ros2/aruco_detector.hpp"
#include "video_ros2/jpeg_encoder.hpp"

namespace video_ros2
{
namespace
{

constexpr int kWarmupIterations = 5;
constexpr int kBenchmarkIterations = 100;

/// Generate a noisy BGR image of the requested size.
cv::Mat generateImage(int width, int height)
{
  cv::Mat image(height, width, CV_8UC3);
  cv::randu(image, cv::Scalar::all(0), cv::Scalar::all(256));
  return image;
}

/// Draw a simple 4x4 ArUco-style marker into the center of the image.
/// The pattern is deterministic and should be detected by cv::aruco::detectMarkers
/// when the OpenCV aruco module is available.
cv::Mat embedArucoMarker(cv::Mat & image, int id)
{
  const int cells = 6;  // 4 data + 2 border cells
  const int marker_size = std::min(image.cols, image.rows) / 4;
  const int cell_size = marker_size / cells;
  const int x0 = (image.cols - marker_size) / 2;
  const int y0 = (image.rows - marker_size) / 2;

  cv::RNG rng(id);
  for (int row = 0; row < cells; ++row) {
    for (int col = 0; col < cells; ++col) {
      // Border cells are black; inner cells are random black/white.
      bool black = (row == 0 || row == cells - 1 || col == 0 || col == cells - 1) ||
        (rng.uniform(0, 2) == 0);
      cv::Rect cell(x0 + col * cell_size, y0 + row * cell_size, cell_size, cell_size);
      cv::Mat roi = image(cell);
      roi.setTo(black ? cv::Scalar(0, 0, 0) : cv::Scalar(255, 255, 255));
    }
  }
  return image;
}

}  // namespace

class JpegPerformanceTest : public ::testing::Test
{
};

TEST_F(JpegPerformanceTest, EncodeThroughput)
{
  JpegEncoder encoder;
  const std::vector<std::pair<int, int>> resolutions = {
    {640, 480},
    {1280, 720},
    {1920, 1080},
  };
  const std::vector<int> qualities = {50, 75, 95};

  for (const auto & res : resolutions) {
    cv::Mat image = generateImage(res.first, res.second);
    for (int quality : qualities) {
      // Warmup.
      for (int i = 0; i < kWarmupIterations; ++i) {
        auto encoded = encoder.encode(image, quality);
        EXPECT_FALSE(encoded.empty());
      }

      auto start = std::chrono::high_resolution_clock::now();
      for (int i = 0; i < kBenchmarkIterations; ++i) {
        auto encoded = encoder.encode(image, quality);
        EXPECT_FALSE(encoded.empty());
      }
      auto end = std::chrono::high_resolution_clock::now();

      double elapsed_ms = std::chrono::duration<double, std::milli>(end - start).count();
      double ms_per_frame = elapsed_ms / kBenchmarkIterations;
      double fps = 1000.0 / ms_per_frame;
      double mbytes_per_sec = (static_cast<double>(res.first) * res.second * 3 * fps) / (1024.0 * 1024.0);

      std::cout << "[JPEG] " << res.first << "x" << res.second
                << " quality=" << quality
                << " " << ms_per_frame << " ms/frame"
                << " " << fps << " fps"
                << " " << mbytes_per_sec << " MB/s input" << std::endl;

      EXPECT_GT(fps, 10.0) << "JPEG encoding too slow at " << res.first << "x" << res.second;
    }
  }
}

class ArucoPerformanceTest : public ::testing::Test
{
};

TEST_F(ArucoPerformanceTest, DetectionThroughput)
{
  ArucoDetector detector;
  CameraDetails details;
  details.set_horizontal_fov(60.0f);

  const std::vector<std::pair<int, int>> resolutions = {
    {640, 480},
    {1280, 720},
  };

  for (const auto & res : resolutions) {
    cv::Mat image = generateImage(res.first, res.second);
    embedArucoMarker(image, 1);

    // Warmup.
    for (int i = 0; i < kWarmupIterations; ++i) {
      auto objects = detector.detect(image, details);
      (void)objects;
    }

    auto start = std::chrono::high_resolution_clock::now();
    for (int i = 0; i < kBenchmarkIterations; ++i) {
      auto objects = detector.detect(image, details);
      (void)objects;
    }
    auto end = std::chrono::high_resolution_clock::now();

    double elapsed_ms = std::chrono::duration<double, std::milli>(end - start).count();
    double ms_per_frame = elapsed_ms / kBenchmarkIterations;
    double fps = 1000.0 / ms_per_frame;

    std::cout << "[ArUco] " << res.first << "x" << res.second
              << " " << ms_per_frame << " ms/frame"
              << " " << fps << " fps" << std::endl;

    EXPECT_GT(fps, 5.0) << "ArUco detection too slow at " << res.first << "x" << res.second;
  }
}

class CombinedPerformanceTest : public ::testing::Test
{
};

TEST_F(CombinedPerformanceTest, EncodeAndDetectPipeline)
{
  JpegEncoder encoder;
  ArucoDetector detector;
  CameraDetails details;
  details.set_horizontal_fov(60.0f);

  cv::Mat image = generateImage(1280, 720);

  // Warmup.
  for (int i = 0; i < kWarmupIterations; ++i) {
    auto objects = detector.detect(image, details);
    auto encoded = encoder.encode(image, 75);
    (void)objects;
    (void)encoded;
  }

  auto start = std::chrono::high_resolution_clock::now();
  for (int i = 0; i < kBenchmarkIterations; ++i) {
    auto objects = detector.detect(image, details);
    auto encoded = encoder.encode(image, 75);
    (void)objects;
    (void)encoded;
  }
  auto end = std::chrono::high_resolution_clock::now();

  double elapsed_ms = std::chrono::duration<double, std::milli>(end - start).count();
  double ms_per_frame = elapsed_ms / kBenchmarkIterations;
  double fps = 1000.0 / ms_per_frame;

  std::cout << "[Pipeline] 1280x720 detect+encode " << ms_per_frame << " ms/frame " << fps << " fps" << std::endl;

  EXPECT_GT(fps, 5.0) << "Combined detect+encode pipeline too slow";
}

}  // namespace video_ros2

int main(int argc, char ** argv)
{
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}
