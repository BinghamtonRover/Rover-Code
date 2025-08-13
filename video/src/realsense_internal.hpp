#include "realsense_ffi.h"
#include <librealsense2/rs.hpp>

namespace burt_rs {
  class RealSense {
    public: 
      BurtRsConfig config;

      RealSense();
      ~RealSense();
      BurtRsStatus init();
      const char* getDeviceName();

      BurtRsStatus startStream();
      void stopStream();

      NativeFrames* getDepthFrame();

    private:
      rs2::device device;
      rs2::pipeline pipeline;
      bool streaming = false;
      bool hasDevice = false;
  };
}

static rs2::colorizer colorizer = rs2::colorizer();
static rs2::align align = rs2::align(RS2_STREAM_COLOR);
void freeFrame(NativeFrames* frames);
