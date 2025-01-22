
#if defined(_WIN32) && defined(__cplusplus)
#define FFI_PLUGIN_EXPORT extern "C" __declspec(dllexport)
#define NON_FFI __declspec(dllexport)
#else
#define FFI_PLUGIN_EXPORT
#endif


#include "sick_scan_api.h"
#include <stdint.h>


typedef struct Image{
  uint64_t height;
  uint64_t width;
  uint8_t* data;
  double* OneDArray;
} Image;

FFI_PLUGIN_EXPORT void init();
FFI_PLUGIN_EXPORT void dispose();
FFI_PLUGIN_EXPORT void updateLatestImage(SickScanApiHandle apiHandle, const SickScanPointCloudMsg* pointCloudMsg);
FFI_PLUGIN_EXPORT Image getLatestImage();
FFI_PLUGIN_EXPORT void addHiddenArea();
FFI_PLUGIN_EXPORT void addCross(const SickScanPointCloudMsg* pixels);
FFI_PLUGIN_EXPORT void make_matrix(const SickScanPointCloudMsg* msg);
FFI_PLUGIN_EXPORT void getLatestData();
FFI_PLUGIN_EXPORT void updateLatestData(const SickScanPointCloudMsg* pointCloudMsg);

