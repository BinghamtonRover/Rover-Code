#include <iostream>
#include <cassert>
#include <cstring>
#include <cmath>
#include <vector>

#include "lidar.h"

const int imageWidth = 1'000;
const int imageHeight = 1'000;
const int imageSize = 3 * imageHeight * imageWidth;
const int sickScanMessageSize = 128;

const double pi = 3.141592653589293;

typedef struct CartesianFieldOffsets {
  int x;
  int y;
  int z;
  int intensity;
} CartesianFieldOffsets;

Lidar* globalLidar;
void cartesianCallback(SickScanApiHandle apiHandle, const SickScanPointCloudMsg* pointCloudMsg);

LidarStatus init(Lidar* lidar) {
  /// Initialize and allocate data for the struct.
  lidar->api = SickScanApiCreate(0, nullptr);
  lidar->angleData = new double[271];
  lidar->coordinateData = new double[542];
  lidar->statusBuffer = new char[sickScanMessageSize];
  memset(lidar->angleData, 0, 271 * sizeof(double));
  memset(lidar->coordinateData, 0, 542 * sizeof(double));
  lidar->image.height = imageHeight;
  lidar->image.width = imageWidth;
  lidar->image.data = new uint8_t[imageSize];

  // Initialize the SickScan API.
  SickScanApiSetVerboseLevel(lidar->api, 3); // 0=DEBUG, 1=INFO, 2=WARN, 3=ERROR, 4=FATAL or 5=QUIET
  const char* args[3] = {"lidar.dart", "lidar.launch", "hostname:=192.168.1.71"};
  auto argsPtr = const_cast<char**>(args);  // it's a C API, it cannot take the const-ness
  int statusInt = SickScanApiInitByCli(lidar->api, 3, argsPtr);
  auto status = static_cast<LidarStatus>(statusInt);
  if (status != SICK_SCAN_API_SUCCESS) {
    return status;
  }
  statusInt = SickScanApiRegisterCartesianPointCloudMsg(lidar->api, cartesianCallback);
  status = static_cast<LidarStatus>(statusInt);
  if (status != SICK_SCAN_API_SUCCESS) {
    return status;
  }
  globalLidar = lidar;
  return status;
}

void dispose(Lidar* lidar) {
  deregisterCallback(lidar);
  SickScanApiDeregisterCartesianPointCloudMsg(lidar->api, cartesianCallback);
  SickScanApiClose(lidar->api);
  SickScanApiRelease(lidar->api);
  delete lidar->image.data;
  delete lidar->angleData;
  delete lidar->coordinateData;
  delete lidar->statusBuffer;
  delete lidar;
  globalLidar = nullptr;
}

LidarStatus registerCallback(Lidar* handle) {
  int status = SickScanApiRegisterCartesianPointCloudMsg(handle->api, cartesianCallback);
  return static_cast<LidarStatus>(status);
}

void deregisterCallback(Lidar* handle) {
  SickScanApiDeregisterCartesianPointCloudMsg(handle->api, cartesianCallback);
}

bool fieldHasName(SickScanPointFieldMsg field, const char* name) {
  // TODO: Check if we can hard-code this to use indexes instead of checking names.
  return std::strcmp(field.name, name) == 0 && field.datatype == SICK_SCAN_POINTFIELD_DATATYPE_FLOAT32;
}

CartesianFieldOffsets getOffsets(const SickScanPointCloudMsg* message) {
  // Get offsets for x, y, z, intensity values
  auto fields = message->fields.buffer;
  CartesianFieldOffsets result;
  for (int i = 0; i < message->fields.size; i++) {
    auto field = fields[i];
    if (fieldHasName(field, "x")) {
      result.x = field.offset;
    } else if (fieldHasName(field, "y")) {
      result.y = field.offset;
    } else if (fieldHasName(field, "z")) {
      result.z = field.offset;
    } else if (fieldHasName(field, "intensity")) {
      result.intensity = field.offset;
    }
  }
  return result;
}

float readFloat(const SickScanPointCloudMsg* message, int point, int field) {
  // The fields are floats, stored in a list of bytes. First find the byte, then cast.
  auto bytePtr = message->data.buffer[point + field];

  auto floatPtr = reinterpret_cast<float*>(bytePtr);

  return *floatPtr;
}

void cartesianCallback(SickScanApiHandle apiHandle, const SickScanPointCloudMsg* pointCloudMsg) {
  if (globalLidar == nullptr || globalLidar->hasNewData) return;
  globalLidar->hasNewData = true;
  if(pointCloudMsg->height == 0 || pointCloudMsg->width == 0 || globalLidar->image.data == nullptr){
    return;
  }
  
  auto image = globalLidar->image;
  auto angleData = globalLidar->angleData;
  auto coordinateData = globalLidar->coordinateData;

  // Initialize some variables
  double angle = 0;
  auto offsets = getOffsets(pointCloudMsg);

  memset(angleData, 0, 271 * sizeof(double));
  memset(coordinateData, 0, 542 * sizeof(double));

  /// Plot all points in pointcloud
  int count = 0; 
  for (int row = 0; row < pointCloudMsg->height; row++) {
    for (int col = 0; col < pointCloudMsg->width; col++) {
      // Get cartesian point coordinates
      int point = row * pointCloudMsg->row_step + col * pointCloudMsg->point_step;
      float x = *((float*)(pointCloudMsg->data.buffer + point + offsets.x));
      float y = *((float*)(pointCloudMsg->data.buffer + point + offsets.y));

      // TODO: Can/should we use intensity?
      // float intensity = readFloat(message, point, offsets.intensity);
      
      // Convert point coordinates in meter to image coordinates in pixel
      int xPixel = 250.0 * (-y + 2.0);
      int yPixel = 250.0 * (-x + 2.0);
      if (xPixel >= 0 && xPixel < 1000 && yPixel >= 0 && yPixel < 1000) {
        coordinateData[count] = x;
        coordinateData[count+1] = y;
        count += 2;

        angle  = std::atan2(y,  x);
        angle = angle * 180 / pi;

        angle += 135;
              // Record the angle data for this point (TODO: Move this logic to the polar callback)
        if (angle >=0 && angle <= 270){
          auto distance = sqrt(pow(x, 2) + pow(y, 2));
          angleData[static_cast<int>(angle)] = distance;
        }
      }
    }
  }
  globalLidar->coordinateLength = count;
}

void updateStatus(Lidar* lidar) {
  auto statusPtr = new int;
  SickScanApiGetStatus(lidar->api, statusPtr, lidar->statusBuffer, 128);
  lidar->statusCode = static_cast<LidarStatus>(*statusPtr);
  delete statusPtr;
}
