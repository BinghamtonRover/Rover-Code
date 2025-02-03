#include <iostream>
// #include <windows.h> // For sleep fucntion on windows
// #include <unistd.h> // For sleep function on unix
#include <cassert>
#include <cstring>
#include <cmath>
#include <vector>

#include "lidar.h"
#define WIDTH 1000
#define HEIGHT 1000
#define PI 3.14159

// enum SickScanApiErrorCodes
// {
//     SICK_SCAN_API_SUCCESS = 0,          // function executed successfully
//     SICK_SCAN_API_ERROR = 1,            // general (unspecified) error
//     SICK_SCAN_API_NOT_LOADED = 2,       // sick_scan_xd library not loaded
//     SICK_SCAN_API_NOT_INITIALIZED = 3,  // API not initialized
//     SICK_SCAN_API_NOT_IMPLEMENTED = 4,  // function not implemented in sick_scan_xd library
//     SICK_SCAN_API_TIMEOUT = 5           // timeout during wait for response
// };

LidarHandle* globalHandle;
void updateLatestImage(SickScanApiHandle apiHandle, const SickScanPointCloudMsg* pointCloudMsg);
void updateLatestData(const SickScanPointCloudMsg* pointCloudMsg);
void make_matrix(const SickScanPointCloudMsg* msg);
void addCross(const SickScanPointCloudMsg* pixels);
void addHiddenArea();

FFI_PLUGIN_EXPORT LidarHandle* Lidar_create() {
    LidarHandle* handle = new LidarHandle;
    handle->isReady = false;
  handle->lock = 0;
  handle->api = SickScanApiCreate(0, nullptr);



  SickScanApiSetVerboseLevel(handle->api, 3); // 0=DEBUG, 1=INFO, 2=WARN, 3=ERROR, 4=FATAL or 5=QUIET
  char* args[] = {"lidar.dart", "lidar.launch", "hostname:=192.168.1.71"};
  // if(status = SickScanApiInitByCli(handle, 3, args) != SICK_SCAN_API_SUCCESS){
  //   dispose();
  //   return status;
  // }
  SickScanApiInitByCli(handle->api, 3, args);
  // if(status = SickScanApiRegisterCartesianPointCloudMsg(handle, updateLatestImage) != SICK_SCAN_API_SUCCESS){
  //   dispose();
  //   return status;
  // }
   SickScanApiRegisterCartesianPointCloudMsg(handle->api, updateLatestImage);
  /// allocate data
  handle->OneDArray = new double[270];
  memset(handle->OneDArray, -1, 270 * sizeof(double));

  /// allocate image
  handle->image.data = new uint8_t[3 * WIDTH * HEIGHT];
  handle->image.height = HEIGHT;
  handle->image.width = WIDTH;

  std::cout << "Getting status" << std::endl;

  handle->statusBuffer = new char[128];
  getStatus(handle);
  std::cout << "==============================" << std::endl;
  std::cout << "\n\n\n Init done with status: " << handle->statusCode << "\n\n\n" <<  std::endl;
  std::cout << "==============================" << std::endl;
  handle->lock = 1;
  globalHandle = handle;
  return handle;
}

FFI_PLUGIN_EXPORT void Lidar_delete(LidarHandle* handle) {
  SickScanApiDeregisterCartesianPointCloudMsg(handle->api, updateLatestImage);
  SickScanApiClose(handle->api);
  SickScanApiRelease(handle->api);
  delete handle->image.data;
  delete handle->OneDArray;
  delete handle->statusBuffer;
  delete handle;
  globalHandle = nullptr;
}

FFI_PLUGIN_EXPORT void deregisterCallback(LidarHandle* handle) {
  SickScanApiDeregisterCartesianPointCloudMsg(handle->api, updateLatestImage);
}

FFI_PLUGIN_EXPORT void registerCallback(LidarHandle* handle) {
   SickScanApiRegisterCartesianPointCloudMsg(handle->api, updateLatestImage);
}

void updateLatestImage(SickScanApiHandle apiHandle, const SickScanPointCloudMsg* pointCloudMsg) {
  // Change to if: assert(pointCloudMsg->height >= 0 && (int)pointCloudMsg->width >=0);
  if (globalHandle == nullptr) return;
  deregisterCallback(globalHandle);
  std::cout << "C++ callback" << std::endl;
  globalHandle->isReady = false;
  if(pointCloudMsg->height == 0 || pointCloudMsg->width == 0 || globalHandle->image.data == nullptr){
    return;
  }
  if(globalHandle->lock == 0){
    std::cout << "Image locked" << std::endl;
    return;
  }
  std::cout << "Unlocked" << std::endl;
  globalHandle->lock = 0;
  make_matrix(pointCloudMsg);
  addCross(pointCloudMsg);
  addHiddenArea();
  globalHandle->lock = 1;
  globalHandle->isReady = true;
}

void updateLatestData(const SickScanPointCloudMsg* pointCloudMsg) {
  if (globalHandle == nullptr) return;
  if(pointCloudMsg->height == 0 || pointCloudMsg->row_step == 0 || globalHandle->image.data == nullptr){
    return;
  }
  //std::cout << "Image height: " << (int) pointCloudMsg->height << ", Width: " << (int) pointCloudMsg->width << std::endl;
  uint32_t midx = globalHandle->image.width / 2;
  uint32_t midy = globalHandle->image.height / 2;

  //do pythagorean theorem with x and y
   // Get offsets for x, y, z, intensity values
    SickScanPointFieldMsg* msg_fields_buffer = (SickScanPointFieldMsg*)pointCloudMsg->fields.buffer;
    int field_offset_x = -1, field_offset_y = -1, field_offset_z = -1, field_offset_intensity = -1;
    for(int n = 0; n < pointCloudMsg->fields.size; n++)
    {
        if (strcmp(msg_fields_buffer[n].name, "x") == 0 && msg_fields_buffer[n].datatype == SICK_SCAN_POINTFIELD_DATATYPE_FLOAT32)
            field_offset_x = msg_fields_buffer[n].offset;
        else if (strcmp(msg_fields_buffer[n].name, "y") == 0 && msg_fields_buffer[n].datatype == SICK_SCAN_POINTFIELD_DATATYPE_FLOAT32)
            field_offset_y = msg_fields_buffer[n].offset;
        else if (strcmp(msg_fields_buffer[n].name, "z") == 0 && msg_fields_buffer[n].datatype == SICK_SCAN_POINTFIELD_DATATYPE_FLOAT32)
            field_offset_z = msg_fields_buffer[n].offset;
        else if (strcmp(msg_fields_buffer[n].name, "intensity") == 0 && msg_fields_buffer[n].datatype == SICK_SCAN_POINTFIELD_DATATYPE_FLOAT32)
            field_offset_intensity = msg_fields_buffer[n].offset;
    }
	  assert(field_offset_x >= 0 && field_offset_y >= 0 && field_offset_z >= 0);
	// Create an image with 250 pixel/meter, max. +/-2 meter
   for (int row_idx = 0; row_idx < (int)pointCloudMsg->height; row_idx++)
    {
        for (int col_idx = 0; col_idx < (int)pointCloudMsg->width; col_idx++)
        {
            // Get cartesian point coordinates
            int polar_point_offset = row_idx * pointCloudMsg->row_step + col_idx * pointCloudMsg->point_step;
            float point_x = *((float*)(pointCloudMsg->data.buffer + polar_point_offset + field_offset_x));
            float point_y = *((float*)(pointCloudMsg->data.buffer + polar_point_offset + field_offset_y));
            float point_z = *((float*)(pointCloudMsg->data.buffer + polar_point_offset + field_offset_z));
            float point_intensity = 0;
            if (field_offset_intensity >= 0) point_intensity = *((float*)(pointCloudMsg->data.buffer + polar_point_offset + field_offset_intensity));
        }
    }
    // std::cout << "\n";
    // for(int k = 0; k < 270; k++){
    //   std:: cout<< image->OneDArray[k] << " ";
    // }
}

void make_matrix(const SickScanPointCloudMsg* msg){
    uint32_t midx = globalHandle->image.width / 2;
    uint32_t midy = globalHandle->image.height / 2;
    double angle = 0;

   // Get offsets for x, y, z, intensity values
    SickScanPointFieldMsg* msg_fields_buffer = (SickScanPointFieldMsg*)msg->fields.buffer;
    int field_offset_x = -1, field_offset_y = -1, field_offset_z = -1, field_offset_intensity = -1;
    for(int n = 0; n < msg->fields.size; n++)
    {
        if (strcmp(msg_fields_buffer[n].name, "x") == 0 && msg_fields_buffer[n].datatype == SICK_SCAN_POINTFIELD_DATATYPE_FLOAT32)
            field_offset_x = msg_fields_buffer[n].offset;
        else if (strcmp(msg_fields_buffer[n].name, "y") == 0 && msg_fields_buffer[n].datatype == SICK_SCAN_POINTFIELD_DATATYPE_FLOAT32)
            field_offset_y = msg_fields_buffer[n].offset;
        else if (strcmp(msg_fields_buffer[n].name, "z") == 0 && msg_fields_buffer[n].datatype == SICK_SCAN_POINTFIELD_DATATYPE_FLOAT32)
            field_offset_z = msg_fields_buffer[n].offset;
        else if (strcmp(msg_fields_buffer[n].name, "intensity") == 0 && msg_fields_buffer[n].datatype == SICK_SCAN_POINTFIELD_DATATYPE_FLOAT32)
            field_offset_intensity = msg_fields_buffer[n].offset;
    }
	assert(field_offset_x >= 0 && field_offset_y >= 0 && field_offset_z >= 0);
	// Create an image with 250 pixel/meter, max. +/-2 meter
	int img_width = WIDTH, img_height = HEIGHT;
	//uint8_t* img_pixel = image->data;

  memset(globalHandle->image.data, 0, 3 * globalHandle->image.width * globalHandle->image.height);

	/// Plot all points in pointcloud
    for (int row_idx = 0; row_idx < (int)msg->height; row_idx++)
    {
        for (int col_idx = 0; col_idx < (int)msg->width; col_idx++)
        {
            // Get cartesian point coordinates
            int polar_point_offset = row_idx * msg->row_step + col_idx * msg->point_step;
            float point_x = *((float*)(msg->data.buffer + polar_point_offset + field_offset_x));
            float point_y = *((float*)(msg->data.buffer + polar_point_offset + field_offset_y));
            float point_z = *((float*)(msg->data.buffer + polar_point_offset + field_offset_z));
            float point_intensity = 0;
            if (field_offset_intensity >= 0)
                point_intensity = *((float*)(msg->data.buffer + polar_point_offset + field_offset_intensity));
			// Convert point coordinates in meter to image coordinates in pixel
			      int img_x = (int)(250.0f * (-point_y + 2.0f)); // img_x := -pointcloud.y
            int img_y = (int)(250.0f * (-point_x + 2.0f)); // img_y := -pointcloud.x
            if (img_x >= 0 && img_x < img_width && img_y >= 0 && img_y < img_height) // point within the image area
            {
              globalHandle->image.data[3 * img_y * img_width + 3 * img_x + 0] = 255; // R
              globalHandle->image.data[3 * img_y * img_width + 3 * img_x + 1] = 255; // G
              globalHandle->image.data[3 * img_y * img_width + 3 * img_x + 2] = 255; // B
              angle  = std::atan2(point_y,  point_x);
              angle = angle * 180 / PI;
             // std::cout << " angle:" << angle << "  point_x " << point_x << " point_y " << point_y << std::endl;

            }

            if(angle >=0 && angle <= 270){
              double distance = sqrt(pow(point_x,2) + pow(point_y,2));
              globalHandle->OneDArray[int(angle)] = distance;
              //std::cout << int(angle) << std::endl;
            }

		}
	}

  // for(int k = 0; k < 270; k++){
  //     std:: cout<< image->OneDArray[k] << " ";
  // }
  // std::cout << "\n";

  // std::cout << "Made it here2" << std::endl;
}

void addCross(const SickScanPointCloudMsg* pixels) {
    int thickness = 1;
    uint32_t midx = globalHandle->image.width / 2;
    uint32_t midy = globalHandle->image.height / 2;
    for (uint32_t x = midx - 7; x <= midx + 7; x++) {
      // draw horizontal
      for (uint32_t y = midy - thickness; y < midy + thickness; y++) {
        globalHandle->image.data[3 * y * globalHandle->image.width + 3 * x + 0] = 0; // B
        globalHandle->image.data[3 * y * globalHandle->image.width + 3 * x + 1] = 0; // G
        globalHandle->image.data[3 * y * globalHandle->image.width + 3 * x + 2] = 255; // R
      }
    }
    for (uint32_t y = midy - 7; y <= midy + 7; y++) {
      // draw vertical
      for (uint32_t x = midx - thickness; x < midx + thickness; x++) {
        globalHandle->image.data[3 * y * globalHandle->image.width + 3 * x + 0] = 0; // B
        globalHandle->image.data[3 * y * globalHandle->image.width + 3 * x + 1] = 0; // G
        globalHandle->image.data[3 * y * globalHandle->image.width + 3 * x + 2] = 255; // R
      }
    }
  }

/// Draws a triangle in the area behind lidar that doesn't include data
void addHiddenArea() {
    /// NEED IMAGE TO BE SQUARE FOR THIS TO WORK
    for (uint32_t y = globalHandle->image.height - 1; y > (int)(globalHandle->image.height / 2); y--) {
      for (uint32_t x = globalHandle->image.width - y; x < y; x++) {
        globalHandle->image.data[3 * y * globalHandle->image.width + 3 * x + 0] = 130; // R
        globalHandle->image.data[3 * y * globalHandle->image.width + 3 * x + 1] = 130; // G
        globalHandle->image.data[3 * y * globalHandle->image.width + 3 * x + 2] = 130; // B
      }
    }
}

FFI_PLUGIN_EXPORT void getStatus(LidarHandle* handle){
  SickScanApiGetStatus(handle->api, &handle->statusCode, handle->statusBuffer, 128);
  if(handle->statusCode != SICK_SCAN_API_SUCCESS){
    std::cout << "Status: " << handle->statusBuffer << std::endl;
  }
}
