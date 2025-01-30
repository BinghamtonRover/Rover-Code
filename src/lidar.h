
#if defined(_WIN32) 
#define FFI_PLUGIN_EXPORT __declspec(dllexport)
#else
#define FFI_PLUGIN_EXPORT
#endif

#ifdef  __cplusplus
extern "C" {
#endif

#include "sick_scan_api.h"
#include <stdint.h>
typedef struct Image{
  uint64_t height;
  uint64_t width;
  uint8_t* data;
  double* OneDArray;
} Image;

FFI_PLUGIN_EXPORT int32_t init();
FFI_PLUGIN_EXPORT int32_t dispose();
FFI_PLUGIN_EXPORT void updateLatestImage(SickScanApiHandle apiHandle, const SickScanPointCloudMsg* pointCloudMsg);
FFI_PLUGIN_EXPORT Image getLatestImage();
FFI_PLUGIN_EXPORT void addHiddenArea();
FFI_PLUGIN_EXPORT void addCross(const SickScanPointCloudMsg* pixels);
FFI_PLUGIN_EXPORT void make_matrix(const SickScanPointCloudMsg* msg);
FFI_PLUGIN_EXPORT double* getLatestData();
FFI_PLUGIN_EXPORT void updateLatestData(const SickScanPointCloudMsg* pointCloudMsg);
FFI_PLUGIN_EXPORT int getStatus();

#ifdef  __cplusplus
} // extern "C"
#endif