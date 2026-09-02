#ifndef VIDEO_ROS2_JPEG_ENCODER_HPP_
#define VIDEO_ROS2_JPEG_ENCODER_HPP_

#include <memory>
#include <string>
#include <vector>

#include "opencv2/core.hpp"

namespace video_ros2
{

/// Encodes OpenCV cv::Mat frames into JPEG bytes.
///
/// Uses libjpeg-turbo when available for SIMD/NEON acceleration.
/// Falls back to OpenCV's imencode when libjpeg-turbo is unavailable.
class JpegEncoder
{
public:
  JpegEncoder();
  ~JpegEncoder();

  /// Encode a BGR or grayscale cv::Mat into JPEG.
  /// @param mat The input image.
  /// @param quality JPEG quality, 0-100.
  /// @return JPEG-encoded bytes.
  std::vector<uint8_t> encode(const cv::Mat & mat, int quality);

private:
  class Impl;
  std::unique_ptr<Impl> impl_;
};

}  // namespace video_ros2

#endif  // VIDEO_ROS2_JPEG_ENCODER_HPP_
