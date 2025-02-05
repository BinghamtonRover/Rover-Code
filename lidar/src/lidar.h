
#if defined(_WIN32)
#define FFI_PLUGIN_EXPORT __declspec(dllexport)
#else
#define FFI_PLUGIN_EXPORT
#endif

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>

#include "sick_scan_api.h"
#include "image.h"

/// The different outcomes of the API.
///
/// Should remain in sync with [SickScanApiErrorCodes](https://github.com/SICKAG/sick_scan_xd/blob/8e560a865ea3642bb0230183b71ac149219978dd/include/sick_scan_xd_api/sick_scan_api.h#L607).
/// Casting the SickScan codes to this enum should be safe.
typedef enum LidarStatus : int {
  SUCCESS = 0,
  ERROR = 1,
  NOT_LOADED = 2,
  NOT_INITIALIZED = 3,
  NOT_IMPLEMENTED = 4,
  TIMEOUT = 5,
} LidarStatus;

typedef struct Lidar {
  SickScanApiHandle api;
  Image image;  // Unused but populated. Leave as-is for now.
  double* angleData = nullptr;
  LidarStatus statusCode = SUCCESS;
  char* statusBuffer = nullptr;
  bool hasNewData = false;
} Lidar;

FFI_PLUGIN_EXPORT LidarStatus init(Lidar* lidar);
FFI_PLUGIN_EXPORT void dispose(Lidar* lidar);

FFI_PLUGIN_EXPORT LidarStatus registerCallback(Lidar* lidar);
FFI_PLUGIN_EXPORT void deregisterCallback(Lidar* lidar);

FFI_PLUGIN_EXPORT void updateStatus(Lidar* lidar);

#ifdef  __cplusplus
} // extern "C"
#endif
