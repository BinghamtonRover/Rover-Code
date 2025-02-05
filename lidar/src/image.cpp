#include <cmath>
#include <cstring>

#include "image.h"

const double pi = 3.141592653589293;

typedef struct CartesianFieldOffsets {
  int x;
  int y;
  int z;
  int intensity;
} CartesianFieldOffsets;

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

void make_matrix(Image imageStruct, double* angleData, const SickScanPointCloudMsg* message){
  // Initialize some variables
  double angle = 0;
  auto offsets = getOffsets(message);
  auto image = imageStruct.data;
  memset(image, 0, 3 * imageStruct.width * imageStruct.height);

	/// Plot all points in pointcloud
  for (int row = 0; row < message->height; row++) {
    for (int col = 0; col < message->width; col++) {
      // Get cartesian point coordinates
      int point = row * message->row_step + col * message->point_step;
      float x = readFloat(message, point, offsets.x);
      float y = readFloat(message, point, offsets.y);
      // TODO: Can/should we use intensity?
      // float intensity = readFloat(message, point, offsets.intensity);

			// Convert point coordinates in meter to image coordinates in pixel
      int xPixel = 250.0 * (-y + 2.0);
      int yPixel = 250.0 * (-x + 2.0);
      if (xPixel >= 0 && xPixel < imageStruct.width && yPixel >= 0 && yPixel < imageStruct.height) {
        image[3 * yPixel * imageStruct.width + 3 * xPixel + 0] = 255; // R
        image[3 * yPixel * imageStruct.width + 3 * xPixel + 1] = 255; // G
        image[3 * yPixel * imageStruct.width + 3 * xPixel + 2] = 255; // B
        angle  = std::atan2(y,  x);
        angle = angle * 180 / pi;
      }

      // Record the angle data for this point (TODO: Move this logic to the polar callback)
      if (angle >=0 && angle <= 270){
        auto distance = sqrt(pow(x, 2) + pow(y, 2));
        angleData[static_cast<int>(angle)] = distance;
      }
		}
	}
}

void addCross(Image imageStruct, const SickScanPointCloudMsg* pixels) {
  int thickness = 1;
  auto image = imageStruct.data;
  int midx = imageStruct.width / 2;
  int midy = imageStruct.height / 2;
  // draw horizontal
  for (int x = midx - 7; x <= midx + 7; x++) {
    for (int y = midy - thickness; y < midy + thickness; y++) {
      image[3 * y * imageStruct.width + 3 * x + 0] = 0; // B
      image[3 * y * imageStruct.width + 3 * x + 1] = 0; // G
      image[3 * y * imageStruct.width + 3 * x + 2] = 255; // R
    }
  }
  for (int y = midy - 7; y <= midy + 7; y++) {
    for (int x = midx - thickness; x < midx + thickness; x++) {
      image[3 * y * imageStruct.width + 3 * x + 0] = 0; // B
      image[3 * y * imageStruct.width + 3 * x + 1] = 0; // G
      image[3 * y * imageStruct.width + 3 * x + 2] = 255; // R
    }
  }
}

/// Draws a triangle in the area behind lidar that doesn't include data.
///
/// Assumes the image is a square.
void addHiddenArea(Image imageStruct) {
  auto image = imageStruct.data;
  for (int y = imageStruct.height - 1; y > imageStruct.height / 2; y--) {
    for (int x = imageStruct.width - y; x < y; x++) {
      image[3 * y * imageStruct.width + 3 * x + 0] = 130; // R
      image[3 * y * imageStruct.width + 3 * x + 1] = 130; // G
      image[3 * y * imageStruct.width + 3 * x + 2] = 130; // B
    }
  }
}
