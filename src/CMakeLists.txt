
# Config for CMake
cmake_minimum_required(VERSION 3.10)
project(lidar_ffi VERSION 1.0 LANGUAGES CXX)

SET(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)

SET(ROS_VERSION 0)

add_subdirectory(sick_scan_xd)

add_library(lidar_ffi SHARED lidar.cpp) 

include_directories(${sick_scan_xd_INCLUDE_DIR})

target_link_libraries(lidar_ffi ${sick_scan_xd_LIBRARIES})

set_target_properties(lidar_ffi PROPERTIES
    PUBLIC_HEADER lidar.h
    PUBLIC_HEADER sick_scan_xd.h
    OUTPUT_NAME "lidar_ffi"
)