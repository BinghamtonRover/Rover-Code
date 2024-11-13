
#if defined(_WIN32) && defined(__cplusplus)
#define FFI_PLUGIN_EXPORT __declspec(dllexport) extern "C" 
#else
#define FFI_PLUGIN_EXPORT
#endif


#include "sick_scan_api.h"
#include <stdint.h>

typedef struct Image{
  uint64_t height;
  uint64_t width;

  // uint64_t capacity;
  // SickScanUint8Array buffer;
  uint8_t* data;
} Image;

FFI_PLUGIN_EXPORT void init();
FFI_PLUGIN_EXPORT void dispose();
FFI_PLUGIN_EXPORT void updateLatestImage(SickScanApiHandle apiHandle, const SickScanPointCloudMsg* pointCloudMsg);
FFI_PLUGIN_EXPORT Image getLatestImage();
FFI_PLUGIN_EXPORT void addHiddenArea();
FFI_PLUGIN_EXPORT void addCross(SickScanPointCloudMsg* pixels);
FFI_PLUGIN_EXPORT void make_matrix(SickScanPointCloudMsg* imageData);