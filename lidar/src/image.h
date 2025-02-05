#include <stdint.h>

#include "sick_scan_api.h"

typedef struct Image{
  uint32_t height;
  uint32_t width;
  uint8_t* data;
} Image;

void make_matrix(Image imageStruct, double* angleData, const SickScanPointCloudMsg* message);
void addCross(Image imageStruct, const SickScanPointCloudMsg* message);
void addHiddenArea(Image imageStruct);
