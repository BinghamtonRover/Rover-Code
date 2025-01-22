#include <iostream>
#include <windows.h> // For sleep fucntion on windows
// #include <unistd.h> // For sleep function on unix
#include <cassert>
#include <cmath>
#include <vector>

#include "lidar.h"
#define WIDTH 1000
#define HEIGHT 1000
#define PI 3.14159

Image image;

SickScanApiHandle handle;
SickScanApiHandle handleData;

int mutex = 1;

FFI_PLUGIN_EXPORT void init() {
  handle = SickScanApiCreate(0, nullptr);
  SickScanApiRegisterCartesianPointCloudMsg(handle, updateLatestImage);

  SickScanApiSetVerboseLevel(handle, 0); // 0 = DEBUG
  char* args[] = {"lidar.dart", "lidar.launch", "hostname:=169.254.166.55"};
  SickScanApiInitByCli(handle, 3, args);
  //alloc data
  image.OneDArray = (double*)calloc(1*270, sizeof(double));
  for(int i =0; i < 270; i++){
    image.OneDArray[i] = -1;
  }
  //alloc image
  image.data = (uint8_t*)calloc(3*WIDTH*HEIGHT, sizeof(uint8_t));
  image.height = HEIGHT;
  image.width = WIDTH;
}

FFI_PLUGIN_EXPORT void dispose() {
  SickScanApiDeregisterCartesianPointCloudMsg(handle, updateLatestImage);

  SickScanApiClose(handle);
  SickScanApiRelease(handle);

}

FFI_PLUGIN_EXPORT void updateLatestData(const SickScanPointCloudMsg* pointCloudMsg) {
  if(pointCloudMsg->height == 0 || pointCloudMsg->row_step == 0 || image.data == nullptr){
    return;
  }
  uint64_t midx = image.width / 2;
  uint64_t midy = image.height / 2;

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
    std::cout << "\n";
    for(int k = 0; k < 270; k++){
      std:: cout<< image.OneDArray[k] << " ";
    }
}


FFI_PLUGIN_EXPORT void updateLatestImage(SickScanApiHandle apiHandle, const SickScanPointCloudMsg* pointCloudMsg) {
  // std::cout << "Image height: " << (int) pointCloudMsg->height << ", Width: " << (int) pointCloudMsg->width << std::endl;
  // std::cout << pointCloudMsg << std::endl;
  // SickScanPointCloudMsg* msgptr = pointCloudMsg;
  //if (image.height != 0) mutex = 0;
  //std::cout << "height" << pointCloudMsg->height << "width" << pointCloudMsg->width << "pointstep" << pointCloudMsg->point_step<< "rowstep" << pointCloudMsg->row_step << "data capacity" << pointCloudMsg->data.capacity << "data size" << pointCloudMsg->data.size << "data buffer" << pointCloudMsg->data.buffer << std::endl;

  // Change to if: assert(pointCloudMsg->height >= 0 && (int)pointCloudMsg->width >=0);
  if(pointCloudMsg->height == 0 || pointCloudMsg->width == 0 || image.data == nullptr){
    return;
  }

  // if(mutex == 0){
  //   std::cout << "Mutex locked" << std::endl;
  //   return;
  // }
  //mutex = 0;
  make_matrix(pointCloudMsg);
  addCross(pointCloudMsg);
  //updateLatestData(pointCloudMsg);
  addHiddenArea();
  //mutex = 1;
  // std::cout << "Done updating upate" << std::endl;
}

FFI_PLUGIN_EXPORT void make_matrix(const SickScanPointCloudMsg* msg){
    uint64_t midx = image.width / 2;
    uint64_t midy = image.height / 2;

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
	//uint8_t* img_pixel = image.data;

  memset(image.data, 0, 3 * image.width * image.height);


	// Plot all points in pointcloud
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
              image.data[3 * img_y * img_width + 3 * img_x + 0] = 255; // R
              image.data[3 * img_y * img_width + 3 * img_x + 1] = 255; // G
              image.data[3 * img_y * img_width + 3 * img_x + 2] = 255; // B
            }
            double angle  = std::atan2(point_y-midy, point_x-midx);
            angle = angle * 180 / PI;
            //std::cout << " Angle:" << angle << " ";
            if(point_x >= 0 && point_y >=0 && angle >=0 && angle <= 270){
              image.OneDArray[int(angle)] = angle;
            }

		}
	}

  // std::cout << "\n";
  // for(int k = 0; k < 270; k++){
  //     std:: cout<< image.OneDArray[k] << " ";
  // }
  // std::cout << "Made it here2" << std::endl;
}

FFI_PLUGIN_EXPORT void addCross(const SickScanPointCloudMsg* pixels) {
    int thickness = 1;
    uint64_t midx = image.width / 2;
    uint64_t midy = image.height / 2;
    for (uint64_t x = midx - 7; x <= midx + 7; x++) {
      // draw horizontal
      for (uint64_t y = midy - thickness; y < midy + thickness; y++) {
        image.data[3 * y * image.width + 3 * x + 0] = 0; // B
        image.data[3 * y * image.width + 3 * x + 1] = 0; // G
        image.data[3 * y * image.width + 3 * x + 2] = 255; // R
      }
    }
    for (uint64_t y = midy - 7; y <= midy + 7; y++) {
      // draw vertical
      for (uint64_t x = midx - thickness; x < midx + thickness; x++) {
        image.data[3 * y * image.width + 3 * x + 0] = 0; // B
        image.data[3 * y * image.width + 3 * x + 1] = 0; // G
        image.data[3 * y * image.width + 3 * x + 2] = 255; // R
      }
    }
  }

  /// Draws a triangle in the area behind lidar that doesn't include data
FFI_PLUGIN_EXPORT void addHiddenArea() {
    /// NEED IMAGE TO BE SQUARE FOR THIS TO WORK
    for (uint64_t y = image.height - 1; y > (int)(image.height / 2); y--) {
      for (uint64_t x = image.width - y; x < y; x++) {
        image.data[3 * y * image.width + 3 * x + 0] = 130; // R
        image.data[3 * y * image.width + 3 * x + 1] = 130; // G
        image.data[3 * y * image.width + 3 * x + 2] = 130; // B
      }
    }
}

FFI_PLUGIN_EXPORT void getLatestData() {

}

FFI_PLUGIN_EXPORT Image getLatestImage() {
  // while(mutex == 0){
  //   std::cout << "Mutex locked" << std::endl;
  //   Sleep(100);
  // }
  return image;
}
