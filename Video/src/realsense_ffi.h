#pragma once

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#if _WIN32
#define FFI_PLUGIN_EXPORT __declspec(dllexport)
#else
#define FFI_PLUGIN_EXPORT
#endif

#ifdef __cplusplus
extern "C" {
#endif

typedef enum {
	BurtRsStatus_ok,
	BurtRsStatus_no_device,
	BurtRsStatus_too_many_devices,
	BurtRsStatus_resolution_unknown,
	BurtRsStatus_scale_unknown,
} BurtRsStatus;

typedef struct {
	int depth_width;
	int depth_height;
	int rgb_width;
	int rgb_height;
	float scale;
} BurtRsConfig;

typedef struct {
	const uint8_t* depth_data;
	int depth_length;
	const uint8_t* colorized_data;
	int colorized_length;
	const uint8_t* rgb_data;
	int rgb_length;
} NativeFrames;

// A fake ("opaque") C-friendly struct that we'll use a pointer to.
// This pointer will actually represent the RealSense class in C++
struct NativeRealSense;
typedef struct NativeRealSense NativeRealSense;

// Initialization
FFI_PLUGIN_EXPORT NativeRealSense* RealSense_create();
FFI_PLUGIN_EXPORT void RealSense_free(NativeRealSense* ptr);
FFI_PLUGIN_EXPORT BurtRsStatus RealSense_init(NativeRealSense* ptr);
FFI_PLUGIN_EXPORT const char* RealSense_getDeviceName(NativeRealSense* ptr);
FFI_PLUGIN_EXPORT BurtRsConfig RealSense_getDeviceConfig(NativeRealSense* ptr);

// Streams
FFI_PLUGIN_EXPORT BurtRsStatus RealSense_startStream(NativeRealSense* ptr);
FFI_PLUGIN_EXPORT void RealSense_stopStream(NativeRealSense* ptr);

// Frames
FFI_PLUGIN_EXPORT NativeFrames* RealSense_getDepthFrame(NativeRealSense* ptr);
FFI_PLUGIN_EXPORT void NativeFrames_free(NativeFrames* ptr);

#ifdef __cplusplus
}
#endif
