#include <stdint.h>

#include <sick_scan_api.h>

#ifdef  __cplusplus
extern "C" {
#endif

typedef struct Image {
  uint32_t height;
  uint32_t width;
  uint8_t* data;
} Image;

void makeMatrix(Image imageStruct, double* angleData, const SickScanPointCloudMsg* message);
void addCross(Image imageStruct, const SickScanPointCloudMsg* message);
void addHiddenArea(Image imageStruct);

#ifdef __cplusplus
}
#endif
