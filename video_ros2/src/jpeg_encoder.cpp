#include "video_ros2/jpeg_encoder.hpp"

#include <cstring>

#include "opencv2/imgcodecs.hpp"

#ifdef HAS_TURBOJPEG
#include <turbojpeg.h>
#endif

namespace video_ros2
{

class JpegEncoder::Impl
{
public:
#ifdef HAS_TURBOJPEG
  Impl()
  : handle_(tjInitCompress())
  {
  }

  ~Impl()
  {
    if (handle_) {
      tjDestroy(handle_);
    }
  }

  std::vector<uint8_t> encode(const cv::Mat & mat, int quality)
  {
    std::vector<uint8_t> result;
    if (!handle_ || mat.empty()) {
      return result;
    }

    // TurboJPEG expects BGR or grayscale. OpenCV default is BGR.
    int pixel_format = TJPF_BGR;
    int subsamp = TJSAMP_420;
    if (mat.channels() == 1) {
      pixel_format = TJPF_GRAY;
      subsamp = TJSAMP_GRAY;
    }

    unsigned char * out_buf = nullptr;
    unsigned long out_size = 0;
    if (tjCompress2(
          handle_,
          mat.data,
          mat.cols,
          static_cast<int>(mat.step),
          mat.rows,
          pixel_format,
          &out_buf,
          &out_size,
          subsamp,
          quality,
          TJFLAG_FASTDCT) == 0)
    {
      result.resize(out_size);
      std::memcpy(result.data(), out_buf, out_size);
      tjFree(out_buf);
    }
    return result;
  }

private:
  tjhandle handle_;
#else
  std::vector<uint8_t> encode(const cv::Mat & mat, int quality)
  {
    std::vector<uint8_t> result;
    std::vector<int> params = {cv::IMWRITE_JPEG_QUALITY, quality};
    if (!cv::imencode(".jpg", mat, result, params)) {
      result.clear();
    }
    return result;
  }
#endif
};

JpegEncoder::JpegEncoder()
: impl_(std::make_unique<Impl>())
{
}

JpegEncoder::~JpegEncoder() = default;

std::vector<uint8_t> JpegEncoder::encode(const cv::Mat & mat, int quality)
{
  return impl_->encode(mat, quality);
}

}  // namespace video_ros2
