
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
  uint32_t height;
  uint32_t width;
  uint8_t* data;
} Image;

typedef struct LidarHandle {
  SickScanApiHandle api;
  int lock;
  Image image;
  double* OneDArray;
  int isReady;
  int32_t statusCode;
  char* statusBuffer;
} LidarHandle;

FFI_PLUGIN_EXPORT LidarHandle* Lidar_create();
FFI_PLUGIN_EXPORT void Lidar_delete(LidarHandle* handle);

FFI_PLUGIN_EXPORT void deregisterCallback(LidarHandle* handle);
FFI_PLUGIN_EXPORT void registerCallback(LidarHandle* handle);

FFI_PLUGIN_EXPORT void getStatus(LidarHandle* handle);

void updateLatestImage(SickScanApiHandle apiHandle, const SickScanPointCloudMsg* pointCloudMsg);
void updateLatestData(const SickScanPointCloudMsg* pointCloudMsg);
void make_matrix(const SickScanPointCloudMsg* msg);
void addCross(const SickScanPointCloudMsg* pixels);
void addHiddenArea();

#ifdef  __cplusplus
} // extern "C"
#endif