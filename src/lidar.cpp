// #include <chrono>
#include <iostream>
// #include <thread>

// #include "lidar.h"

// Image* ReturnLatestImage(void* msg){
//     ReturnLatestImage * latestImage;
//     latestImage->buffer = msg->data;
//     latestImage->size = msg->height;
//     latestImage->capacity  = msg->width;

//     return latestImage;
// }
// static void exitOnError(const char* msg, int32_t error_code)
// {
//     printf("## ERROR sick_scan_xd_api_test: %s, error code %d\n", msg, error_code);
//     exit(EXIT_FAILURE);
// }

// static void apiTestCartesianPointCloudMsgCallback(SickScanApiHandle apiHandle, const SickScanPointCloudMsg* msg)
// {
//     printf("[Info]: apiTestCartesianPointCloudMsgCallback(apiHandle:%p): %dx%d pointcloud callback...\n", apiHandle, msg->width, msg->height);
// }

// int main(int argc, char** argv, const std::string& sick_scan_args, bool polling){
//   int32_t ret = SICK_SCAN_API_SUCCESS;
//   SickScanApiHandle apiHandle = 0;

//   if ((apiHandle = SickScanApiCreate(argc, argv)) == 0)
//     exitOnError("SickScanApiCreate failed", -1);

//   // Initialize a lidar and starts message receiving and processing
// #if __ROS_VERSION == 1
//   if ((ret = SickScanApiInitByLaunchfile(apiHandle, sick_scan_args.c_str())) != SICK_SCAN_API_SUCCESS)
//     exitOnError("SickScanApiInitByLaunchfile failed", ret);
// #else
//   if ((ret = SickScanApiInitByCli(apiHandle, argc, argv)) != SICK_SCAN_API_SUCCESS)
//     exitOnError("SickScanApiInitByCli failed", ret);
// #endif

// }

#include "lidar.h"
#include <cassert>


Image image;

SickScanApiHandle handle;

int mutex;

FFI_PLUGIN_EXPORT void init() {
  image.data = (uint8_t*)malloc(image.width*image.height*3*sizeof(uint8_t));
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
  // return;
  if(mutex == 0) return;
  mutex = 0;
  // Change to if: assert(pointCloudMsg->height >= 0 && (int)pointCloudMsg->width >=0);
  if((int)pointCloudMsg->height == 0 && (int)pointCloudMsg->width ==0){
    image.height = pointCloudMsg->height;
    image.width = pointCloudMsg->width;
    return;
  }
  image.height = pointCloudMsg->height;
  image.width = pointCloudMsg->width;
  if (image.data == nullptr) {
    image.data = new uint8_t[image.height * image.width * 3];
  }
  make_matrix(pointCloudMsg);
  addCross(pointCloudMsg);
  addHiddenArea();
  mutex = 1;
}

FFI_PLUGIN_EXPORT void make_matrix(const SickScanPointCloudMsg* imageData){
  SickScanPointFieldMsg* imageData_fields_buffer = (SickScanPointFieldMsg*)imageData->fields.buffer;
  int field_offset_x = -1, field_offset_y = -1;
  for(int n = 0; n < imageData->fields.size; n++)
    {
        if (strcmp(imageData_fields_buffer[n].name, "x") == 0 && imageData_fields_buffer[n].datatype == SICK_SCAN_POINTFIELD_DATATYPE_FLOAT32)
            field_offset_x = imageData_fields_buffer[n].offset;
        else if (strcmp(imageData_fields_buffer[n].name, "y") == 0 && imageData_fields_buffer[n].datatype == SICK_SCAN_POINTFIELD_DATATYPE_FLOAT32)
            field_offset_y = imageData_fields_buffer[n].offset;
    }
  assert(field_offset_x >= 0 && field_offset_y >= 0);
  int img_width = 250 * 4, img_height = 250 * 4;

  for(int row = 0; row < (int)imageData->height; row++){
    for(int col = 0; col < (int)imageData->width; col++){
    int polar_point_offset = row * imageData->row_step + col * imageData->point_step;
    float point_x = *((float*)(imageData->data.buffer + polar_point_offset + field_offset_x));
    float point_y = *((float*)(imageData->data.buffer + polar_point_offset + field_offset_y));
			// Convert point coordinates in meter to image coordinates in pixel
			int img_x = (int)(250.0f * (-point_y + 2.0f)); // img_x := -pointcloud.y
			int img_y = (int)(250.0f * (-point_x + 2.0f)); // img_y := -pointcloud.x
			if (img_x >= 0 && img_x < img_width && img_y >= 0 && img_y < img_height) // point within the image area
			{
        std::cout << "Before" << std::endl;
				image.data[3 * img_y * img_width + 3 * img_x + 0] = 255; // R
        std::cout << "After" << std::endl;

				image.data[3 * img_y * img_width + 3 * img_x + 1] = 255; // G
				image.data[3 * img_y * img_width + 3 * img_x + 2] = 255; // B
			}
  } 
  }
 
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
  return image;
}
