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

Lidar* globalLidar;
void cartesianCallback(SickScanApiHandle apiHandle, const SickScanPointCloudMsg* pointCloudMsg);

LidarStatus init(Lidar* lidar) {
  /// Initialize and allocate data for the struct.
  lidar->api = SickScanApiCreate(0, nullptr);
  lidar->angleData = new double[270];
  lidar->statusBuffer = new char[sickScanMessageSize];
  memset(lidar->angleData, -1, 270 * sizeof(double));
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

void cartesianCallback(SickScanApiHandle apiHandle, const SickScanPointCloudMsg* pointCloudMsg) {
  if (globalLidar == nullptr || globalLidar->hasNewData) return;
  globalLidar->hasNewData = true;
  if(pointCloudMsg->height == 0 || pointCloudMsg->width == 0 || globalLidar->image.data == nullptr){
    return;
  }
  auto image = globalLidar->image;
  auto angleData = globalLidar->angleData;
  makeMatrix(image, angleData, pointCloudMsg);
  addCross(image, pointCloudMsg);
  addHiddenArea(image);
}

void updateStatus(Lidar* lidar) {
  auto statusPtr = new int;
  SickScanApiGetStatus(lidar->api, statusPtr, lidar->statusBuffer, 128);
  lidar->statusCode = static_cast<LidarStatus>(*statusPtr);
  delete statusPtr;
}
