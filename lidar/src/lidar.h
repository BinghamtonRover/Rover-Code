
#if defined(_WIN32)
#define FFI_PLUGIN_EXPORT __declspec(dllexport)
#else
#define FFI_PLUGIN_EXPORT
#endif

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>

#include "sick_scan_api.h"

typedef enum SickScanApiErrorCodes LidarStatus;

typedef struct Lidar {
  SickScanApiHandle api;
  Image image;  // Unused but populated. Leave as-is for now.
  double* angleData;
  double* coordinateData;
  int coordinateLength;
  LidarStatus statusCode;
  char* statusBuffer;
  bool hasNewData;
} Lidar;

FFI_PLUGIN_EXPORT LidarStatus init(Lidar* lidar);
FFI_PLUGIN_EXPORT void dispose(Lidar* lidar);

FFI_PLUGIN_EXPORT LidarStatus registerCallback(Lidar* lidar);
FFI_PLUGIN_EXPORT void deregisterCallback(Lidar* lidar);

FFI_PLUGIN_EXPORT void updateStatus(Lidar* lidar);

#ifdef  __cplusplus
} // extern "C"
#endif
