#ifndef _POINTCLOUD_FFI_H
#define _POINTCLOUD_FFI_H

#if _WIN32
#define FFI_PLUGIN_EXPORT __declspec(dllexport)
#else
#define FFI_PLUGIN_EXPORT
#endif

#ifdef __cplusplus
extern "C" {
#endif

typedef enum {
    DETECTION_STATUS_OK,
    FILTERED_CLOUD_EMPTY,
    PLANAR_ESTIMATION_FAILED,
} PointCloudDetectionStatus;

typedef struct {
    float x;
    float y;
    float z;
    float width;
    float length;
    float height;
} Obstacle;

typedef struct DetectedObstacles {
    Obstacle* obstacles;
    int obstacleCount;
} DetectedObstacles;

#ifdef __cplusplus
}
#endif

FFI_PLUGIN_EXPORT DetectedObstacles* DetectObstacles2D(PointCloudDetectionStatus* status, float* cloud, int cloud_length);

FFI_PLUGIN_EXPORT DetectedObstacles* DetectObstacles3D(PointCloudDetectionStatus* status, float* cloud, int cloud_length);

#endif // _POINTCLOUD_FFI_H