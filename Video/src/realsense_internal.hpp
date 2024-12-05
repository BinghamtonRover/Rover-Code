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
  };
}

static rs2::colorizer colorizer = rs2::colorizer();
void freeFrame(NativeFrames* frames);
