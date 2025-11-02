#include "pointcloud_ffi.h"

#include <cmath>
#include <iostream>
#include <vector>

#include "pcl/common/centroid.h"
#include "pcl/common/common.h"
#include "pcl/filters/extract_indices.h"
#include "pcl/filters/filter.h"
#include "pcl/filters/voxel_grid.h"
#include "pcl/point_cloud.h"
#include "pcl/point_types.h"
#include "pcl/search/kdtree.h"
#include "pcl/segmentation/extract_clusters.h"
#include "pcl/segmentation/sac_segmentation.h"

DetectedObstacles* DetectObstacles2D(float* cloud, int cloud_length, PointCloudDetectionStatus* status) {
    pcl::PointCloud<pcl::PointXYZ>::Ptr cloud_in(new pcl::PointCloud<pcl::PointXYZ>);
    cloud_in->points.resize(cloud_length);

    // Copy input data into the cloud
    for (int i = 0; i < cloud_length; i++) {
        cloud_in->points[i].x = cloud[i * 2 + 0];
        cloud_in->points[i].y = cloud[i * 2 + 1];
        cloud_in->points[i].z = 0;
    }

    pcl::PointCloud<pcl::PointXYZ>::Ptr cloud_clean(new pcl::PointCloud<pcl::PointXYZ>);

    for (const auto& point : cloud_in->points) {
        if (!std::isfinite(point.x) || !std::isfinite(point.y) || !std::isfinite(point.z)) {
            continue;
        }
        cloud_clean->points.push_back(point);
    }

    if (cloud_clean->points.size() == 0) {
        return nullptr;
    }

    // Euclidian clustering for obstacle detection
    std::vector<pcl::PointIndices> cluster_indices;
    pcl::search::KdTree<pcl::PointXYZ>::Ptr tree(new pcl::search::KdTree<pcl::PointXYZ>);
    pcl::EuclideanClusterExtraction<pcl::PointXYZ> euclidianCluster;
    euclidianCluster.setClusterTolerance(0.50); // 50 cm search radius for neighbors
    euclidianCluster.setMinClusterSize(5);     // Minimum 5 points to be considered an obstacle
    euclidianCluster.setMaxClusterSize(25000);
    euclidianCluster.setSearchMethod(tree);
    euclidianCluster.setInputCloud(cloud_clean);
    euclidianCluster.extract(cluster_indices);

    std::vector<Obstacle> obstacles;

    for (const auto& indices : cluster_indices) {
        pcl::PointCloud<pcl::PointXYZ>::Ptr cluster(new pcl::PointCloud<pcl::PointXYZ>);

        // Extract the cluster points
        for (int index : indices.indices) {
            cluster->points.push_back(cloud_clean->points[index]);
        }
        cluster->width = cluster->points.size();
        cluster->height = 1;
        cluster->is_dense = true;

        Eigen::Vector4f centroid;
        pcl::compute3DCentroid(*cluster, centroid);

        pcl::PointXYZ min_point, max_point;
        pcl::getMinMax3D(*cluster, min_point, max_point);

        Obstacle obstacle = {0};
        obstacle.x = centroid[0];
        obstacle.y = centroid[1];

        obstacle.width = std::abs(max_point.x - min_point.x);
        obstacle.length = std::abs(max_point.y - min_point.y);
        obstacle.height = 0;
        obstacles.push_back(obstacle);
    }

    DetectedObstacles* result = (DetectedObstacles*)malloc(sizeof(DetectedObstacles));
    memset(result, 0, sizeof(DetectedObstacles));
    result->obstacleCount = obstacles.size();
    if (result->obstacleCount > 0) {
        result->obstacles = (Obstacle*)malloc(result->obstacleCount * sizeof(Obstacle));
        memcpy(result->obstacles, obstacles.data(), result->obstacleCount * sizeof(Obstacle));
    } else {
        result->obstacles = nullptr;
    }

    if (status) *status = DETECTION_STATUS_OK;

    return result;
}

DetectedObstacles* DetectObstacles3D(float* cloud, int cloud_length, PointCloudDetectionStatus* status) {
    pcl::PointCloud<pcl::PointXYZ>::Ptr cloud_in(new pcl::PointCloud<pcl::PointXYZ>);
    cloud_in->points.resize(cloud_length);

    // Copy input data into the cloud
    for (int i = 0; i < cloud_length; i++) {
        cloud_in->points[i].x = cloud[i * 3 + 0];
        cloud_in->points[i].y = cloud[i * 3 + 1];
        cloud_in->points[i].z = cloud[i * 3 + 2];
    }

    pcl::PointCloud<pcl::PointXYZ>::Ptr cloud_clean(new pcl::PointCloud<pcl::PointXYZ>);
    pcl::PointCloud<pcl::PointXYZ>::Ptr cloud_filtered(new pcl::PointCloud<pcl::PointXYZ>);
    pcl::PointCloud<pcl::PointXYZ>::Ptr cloud_no_ground(new pcl::PointCloud<pcl::PointXYZ>);
    pcl::PointCloud<pcl::PointXYZ>::Ptr cloud_ground(new pcl::PointCloud<pcl::PointXYZ>);

    for (const auto& point : cloud_in->points) {
        if (!std::isfinite(point.x) || !std::isfinite(point.y) || !std::isfinite(point.z)) {
            continue;
        }
        cloud_clean->points.push_back(point);
    }

    // Downsample with Voxel grid
    pcl::VoxelGrid<pcl::PointXYZ> voxel_grid;
    voxel_grid.setInputCloud(cloud_clean);
    // 2.5 cm large leaf size
    voxel_grid.setLeafSize(0.05f, 0.05f, 0.05f);
    voxel_grid.filter(*cloud_filtered);

    if (cloud_filtered->points.empty()) {
        std::cerr << "PCL Error: Filtered cloud is empty." << std::endl;
        if (status) *status = FILTERED_CLOUD_EMPTY;
        return nullptr;
    }

    // RANSAC Ground Segmentation
    // Picks a bunch of random points, and tries to fit a ground plane onto
    // it, this is used to find a common plane which will be considered the ground
    pcl::ModelCoefficients::Ptr coefficients(new pcl::ModelCoefficients);
    pcl::PointIndices::Ptr inliers(new pcl::PointIndices);
    pcl::SACSegmentation<pcl::PointXYZ> seg;

    seg.setOptimizeCoefficients(true);
    seg.setModelType(pcl::SACMODEL_PLANE); // Look for a planar model
    seg.setMethodType(pcl::SAC_RANSAC);    // Use RANSAC
    seg.setMaxIterations(100);
    seg.setDistanceThreshold(0.02); // Points within 2cm of the plane are considered ground
    seg.setInputCloud(cloud_filtered);
    seg.segment(*inliers, *coefficients);

    if (inliers->indices.size() == 0) {
        std::cerr << "PCL Warning: Could not estimate a planar model (ground)." << std::endl;
        cloud_no_ground = cloud_filtered; // Treat the whole cloud as potential obstacles
        if (status) *status = PLANAR_ESTIMATION_FAILED;
    } else {
        std::cout << "PCL: Ground plane estimated with " << inliers->indices.size() << " points." << std::endl;

        // Extract the non-ground Points, which are where the obstacles will be searched
        pcl::ExtractIndices<pcl::PointXYZ> extract;
        extract.setInputCloud(cloud_filtered);
        extract.setIndices(inliers);
        extract.setNegative(true); // Extract the points not in the ground plane (the obstacles)
        extract.filter(*cloud_no_ground);
    }

    // Euclidian clustering for obstacle detection
    std::vector<pcl::PointIndices> cluster_indices;
    pcl::search::KdTree<pcl::PointXYZ>::Ptr tree(new pcl::search::KdTree<pcl::PointXYZ>);
    pcl::EuclideanClusterExtraction<pcl::PointXYZ> euclidianCluster;
    euclidianCluster.setClusterTolerance(0.50); // 50 cm search radius for neighbors
    euclidianCluster.setMinClusterSize(25);     // Minimum 25 points to be considered an obstacle
    euclidianCluster.setMaxClusterSize(25000);
    euclidianCluster.setSearchMethod(tree);
    euclidianCluster.setInputCloud(cloud_no_ground);
    euclidianCluster.extract(cluster_indices);

    std::vector<Obstacle> obstacles;

    for (const auto& indices : cluster_indices) {
        pcl::PointCloud<pcl::PointXYZ>::Ptr cluster(new pcl::PointCloud<pcl::PointXYZ>);

        // Extract the cluster points
        for (int index : indices.indices) {
            cluster->points.push_back(cloud_no_ground->points[index]);
        }
        cluster->width = cluster->points.size();
        cluster->height = 1;
        cluster->is_dense = true;

        Eigen::Vector4f centroid;
        pcl::compute3DCentroid(*cluster, centroid);

        pcl::PointXYZ min_point, max_point;
        pcl::getMinMax3D(*cluster, min_point, max_point);

        Obstacle obstacle = {0};
        obstacle.x = centroid[0];
        obstacle.y = centroid[1];
        obstacle.z = centroid[2];

        obstacle.width = std::abs(max_point.x - min_point.x);
        obstacle.length = std::abs(max_point.z - min_point.z);
        obstacle.height = std::abs(max_point.y - min_point.y);
        obstacles.push_back(obstacle);
    }

    DetectedObstacles* result = (DetectedObstacles*)malloc(sizeof(DetectedObstacles));
    memset(result, 0, sizeof(DetectedObstacles));
    result->obstacleCount = obstacles.size();
    if (result->obstacleCount > 0) {
        result->obstacles = (Obstacle*)malloc(result->obstacleCount * sizeof(Obstacle));
        memcpy(result->obstacles, obstacles.data(), result->obstacleCount * sizeof(Obstacle));
    } else {
        result->obstacles = nullptr;
    }

    if (status) *status = DETECTION_STATUS_OK;

    return result;
}
