#include <iostream>
#include <windows.h> // For sleep fucntion on windows
// #include <unistd.h> // For sleep function on unix
#include <cassert>
#include "lidar.h"
#define WIDTH 1000
#define HEIGHT 1000

Image image;

SickScanApiHandle handle;

int mutex = 1;

FFI_PLUGIN_EXPORT void init() {
  image.data = (uint8_t*)calloc(3*WIDTH*HEIGHT, sizeof(uint8_t));
  image.pointCloudMsg = new SickScanPointCloudMsg;
  handle = SickScanApiCreate(0, nullptr);
  SickScanApiRegisterCartesianPointCloudMsg(handle, updateLatestImage);
  SickScanApiSetVerboseLevel(handle, 0); // 0 = DEBUG
  char* args[] = {"lidar.dart", "lidar.launch", "hostname:=169.254.166.55"};
  SickScanApiInitByCli(handle, 3, args);

  // ALLOCATE MEMORY FOR image.data 
  std::cout << "INITEDDDDD !!!" << std::endl;
}

FFI_PLUGIN_EXPORT void dispose() {
  SickScanApiDeregisterCartesianPointCloudMsg(handle, updateLatestImage);
  SickScanApiClose(handle);
  SickScanApiRelease(handle);
}

FFI_PLUGIN_EXPORT void updateLatestImage(SickScanApiHandle apiHandle, const SickScanPointCloudMsg* pointCloudMsg) {
  std::cout << "Image height: " << (int) pointCloudMsg->height << ", Width: " << (int) pointCloudMsg->width << std::endl;
  std::cout << pointCloudMsg << std::endl;
  // SickScanPointCloudMsg* msgptr = pointCloudMsg;
  // memcpy(msgptr, image.pointCloudMsg, 100);
  //if (image.height != 0) mutex = 0;  

  // Change to if: assert(pointCloudMsg->height >= 0 && (int)pointCloudMsg->width >=0);
  if(pointCloudMsg->height == 0 || pointCloudMsg->width ==0){
    return;
    // image.height = pointCloudMsg->height;
    // image.width = pointCloudMsg->width;
    // return;
  }
  if (image.data == nullptr) {
    // image.data = new uint8_t[image.height * image.width * 3];
  }
  std::cout << "Made it here1" << std::endl;
  image.height = 1000;
  image.width = 1000;
  
  make_matrix(pointCloudMsg);
  addCross(pointCloudMsg);
  addHiddenArea();
  //mutex = 1;
  std::cout << "Done updating upate" << std::endl;
}

FFI_PLUGIN_EXPORT void make_matrix(const SickScanPointCloudMsg* msg){
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
	int img_width = 250 * 4, img_height = 250 * 4;
	//uint8_t* img_pixel = image.data;
  

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
        //std::cout << 3 * img_y * img_width + 3 * img_x + 0 << std::endl;
				image.data[3 * img_y * img_width + 3 * img_x + 0] = 255; // R
				image.data[3 * img_y * img_width + 3 * img_x + 1] = 255; // G
				image.data[3 * img_y * img_width + 3 * img_x + 2] = 255; // B
			}
		}
	}
  std::cout << "Made it here2" << std::endl;
  //free(img_pixel);
  // addCross(imageData);
  // addHiddenArea();
}

FFI_PLUGIN_EXPORT void addCross(const SickScanPointCloudMsg* pixels) {
    int thickness = 1;
    int midx = image.width / 2;
    int midy = image.height / 2;
    for (int x = midx - 7; x <= midx + 7; x++) {
      // draw horizontal
      for (int y = midy - thickness; y < midy + thickness; y++) {
        image.data[3 * y * image.width + 3 * x + 0] = 0; // B
        image.data[3 * y * image.width + 3 * x + 1] = 0; // G
        image.data[3 * y * image.width + 3 * x + 2] = 255; // R
      }
    }
    for (int y = midy - 7; y <= midy + 7; y++) {
      // draw vertical
      for (int x = midx - thickness; x < midx + thickness; x++) {
        image.data[3 * y * image.width + 3 * x + 0] = 0; // B
        image.data[3 * y * image.width + 3 * x + 1] = 0; // G
        image.data[3 * y * image.width + 3 * x + 2] = 255; // R
      }
    }
  }

  /// Draws a triangle in the area behind lidar that doesn't include data
FFI_PLUGIN_EXPORT void addHiddenArea() {
    /// NEED IMAGE TO BE SQUARE FOR THIS TO WORK
    for (int y = image.height - 1; y > (int)(image.height / 2); y--) {
      for (int x = image.width - y; x < y; x++) {
        image.data[3 * y * image.width + 3 * x + 0] = 130; // R
        image.data[3 * y * image.width + 3 * x + 1] = 130; // G
        image.data[3 * y * image.width + 3 * x + 2] = 130; // B
      }
    }
}


FFI_PLUGIN_EXPORT Image getLatestImage() { 
  // while(mutex == 0){
  //   std::cout << "Mutex locked" << std::endl;
  //   Sleep(100);
  // }
  std::cout << "Latest Image: " << image.height << std::endl;
  return image;
}
