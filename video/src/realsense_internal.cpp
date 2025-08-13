#include "realsense_internal.hpp"
#include <librealsense2/rs.hpp>

#include <algorithm>
#include <iostream>
#include <unistd.h>

#define DEPTH_WIDTH 640
#define RGB_WIDTH 640
#define HEIGHT 0

// -------------------- Device methods --------------------
burt_rs::RealSense::RealSense() { }
burt_rs::RealSense::~RealSense() { }

BurtRsStatus burt_rs::RealSense::init() {
  rs2::context context;
  rs2::device_list devices = context.query_devices();
  if (devices.size() == 0) {
    std::cout << "[BurtRS] No devices found" << std::endl;
    hasDevice = false;
    return BurtRsStatus::BurtRsStatus_no_device;
  } else if (devices.size() > 1) {
    std::cout << "[BurtRS] Multiple devices found!" << std::endl;
    hasDevice = false;
    return BurtRsStatus::BurtRsStatus_too_many_devices;
  }
  device = devices[0];
  rs2::depth_sensor sensor = device.first<rs2::depth_sensor>();
  auto scale = sensor.get_depth_scale();
  if (scale == 0) {
    return BurtRsStatus::BurtRsStatus_scale_unknown;
  } else {
    config.scale = scale;
  }
  hasDevice = true;

  return BurtRsStatus::BurtRsStatus_ok;
}

const char* burt_rs::RealSense::getDeviceName() {
  if (device.supports(RS2_CAMERA_INFO_NAME)) {
    return device.get_info(RS2_CAMERA_INFO_NAME);
  } else {
    return "Unknown device";
  }
}

// -------------------- Stream methods --------------------
BurtRsStatus burt_rs::RealSense::startStream() {
  rs2::config rs_config;
  rs_config.enable_stream(RS2_STREAM_DEPTH, DEPTH_WIDTH, HEIGHT);
  rs_config.enable_stream(RS2_STREAM_COLOR, RGB_WIDTH, HEIGHT, RS2_FORMAT_BGR8);

  auto profile = pipeline.start(rs_config);
  auto frames = pipeline.wait_for_frames();
  auto depth_frame = frames.get_depth_frame();
  auto rgb_frame = frames.get_color_frame();
  auto depth_width = depth_frame.get_width();
  auto depth_height = depth_frame.get_height();
  auto rgb_width = rgb_frame.get_width();
  auto rgb_height = rgb_frame.get_height();

  streaming = hasDevice;

  if (rgb_width == 0 || rgb_height == 0 || depth_width == 0 || depth_height == 0) {
    return BurtRsStatus::BurtRsStatus_resolution_unknown;
  } else {
    config.depth_width = depth_width;
    config.depth_height = depth_height;
    config.rgb_width = rgb_width;
    config.rgb_height = rgb_height;
    return BurtRsStatus::BurtRsStatus_ok;
  }
}

void burt_rs::RealSense::stopStream() {
  if (streaming) {
    pipeline.stop();
  }
  streaming = false;
  hasDevice = false;
}

// -------------------- Frame methods --------------------

NativeFrames* burt_rs::RealSense::getDepthFrame() {
  if (!streaming) {
    return nullptr;
  }
  // Get the depth and color frames
  rs2::frameset frames;
  if (!pipeline.poll_for_frames(&frames)) return nullptr;
  rs2::depth_frame depth_frame = frames.get_depth_frame();
  rs2::frame colorized_frame = colorizer.colorize(depth_frame);

  rs2::frameset aligned_frames = align.process(frames);
  rs2::depth_frame aligned_depth_frame = aligned_frames.get_depth_frame();
  rs2::frame rgb_frame = frames.get_color_frame();

  // Copy frames into a new uint8_t[]
  int depth_length = depth_frame.get_data_size();
  int aligned_depth_length = aligned_depth_frame.get_data_size();
  int colorized_length = colorized_frame.get_data_size();
  int rgb_length = rgb_frame.get_data_size();

  if (depth_length == 0 || colorized_length == 0 || rgb_length == 0) return nullptr;

  const uint8_t* depth_data = static_cast<const uint8_t*>(depth_frame.get_data());
  const uint8_t* aligned_depth_data = static_cast<const uint8_t*>(aligned_depth_frame.get_data());
  const uint8_t* colorized_data = static_cast<const uint8_t*>(colorized_frame.get_data());
  const uint8_t* rgb_data = static_cast<const uint8_t*>(rgb_frame.get_data());

  uint8_t* depth_copy = new uint8_t[depth_length];
  uint8_t* aligned_depth_copy = new uint8_t[aligned_depth_length];
  uint8_t* colorized_copy = new uint8_t[colorized_length];
  uint8_t* rgb_copy = new uint8_t[rgb_length];

  std::copy(depth_data, depth_data + depth_length, depth_copy);
  std::copy(aligned_depth_data, aligned_depth_data + aligned_depth_length, aligned_depth_copy);
  std::copy(colorized_data, colorized_data + colorized_length, colorized_copy);
  std::copy(rgb_data, rgb_data + rgb_length, rgb_copy);

  // Return both frames
  return new NativeFrames {
    depth_data: depth_copy,
    depth_length: depth_length,
    colorized_data: colorized_copy,
    colorized_length: colorized_length,
    rgb_data: rgb_copy,
    rgb_length: rgb_length,
    aligned_depth_data: aligned_depth_copy,
    aligned_depth_length: aligned_depth_length,
  };
}

void freeFrame(NativeFrames* frames) {
  delete[] frames->depth_data;
  delete[] frames->aligned_depth_data;
  delete[] frames->colorized_data;
  delete[] frames->rgb_data;
  delete frames;
}
