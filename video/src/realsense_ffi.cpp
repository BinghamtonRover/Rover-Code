#include "realsense_ffi.h"
#include "realsense_internal.hpp"

#include <iostream>

using namespace std;

// realsense_ffi.h declares global C functions and an empty struct called RealSense
// realsense.hpp declares a class burt_rs::RealSense with methods and fields
// This file implements the C functions by calling the C++ methods
//   1. Convert C RealSense* to the C++ burt_rs::RealSense* using reinterpret_cast()
//   2. Call the function on the C++ class as normal

NativeRealSense* RealSense_create() {
  // This method is different because it goes from C++ --> C instead of C --> C++
  auto ptr = new burt_rs::RealSense();
  return reinterpret_cast<NativeRealSense*>(ptr);
}

void RealSense_free(NativeRealSense* ptr) {
  cout << "Trying to delete..." << endl;
  delete reinterpret_cast<burt_rs::RealSense*>(ptr);
  cout << "Deleted" << endl;
}

BurtRsStatus RealSense_init(NativeRealSense* ptr) {
  return reinterpret_cast<burt_rs::RealSense*>(ptr)->init();
}

const char* RealSense_getDeviceName(NativeRealSense* ptr) {
  return reinterpret_cast<burt_rs::RealSense*>(ptr)->getDeviceName();
}

BurtRsConfig RealSense_getDeviceConfig(NativeRealSense* ptr) {
  return reinterpret_cast<burt_rs::RealSense*>(ptr)->config;
}

BurtRsStatus RealSense_startStream(NativeRealSense* ptr) {
  return reinterpret_cast<burt_rs::RealSense*>(ptr)->startStream();
}

void RealSense_stopStream(NativeRealSense* ptr) {
  reinterpret_cast<burt_rs::RealSense*>(ptr)->stopStream();
}

NativeFrames* RealSense_getDepthFrame(NativeRealSense* ptr) {
  return reinterpret_cast<burt_rs::RealSense*>(ptr)->getDepthFrame();
}

void NativeFrames_free(NativeFrames* ptr) {
  freeFrame(ptr);
}
