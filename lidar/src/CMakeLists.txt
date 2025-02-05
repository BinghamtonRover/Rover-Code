# Config for CMake
cmake_minimum_required(VERSION 3.10)

project(lidar_ffi VERSION 1.0 LANGUAGES CXX)

SET(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)
SET(ROS_VERSION 0)

set(BUILD_SICK_SCAN_XD_API_TEST 0)
add_subdirectory(sick_scan_xd)
include_directories("sick_scan_xd/include/sick_scan_xd_api")

add_executable(lidar udp.cpp image.cpp lidar.cpp main.cpp)
target_link_libraries(lidar sick_scan_xd_lib)

add_library(lidar_ffi SHARED lidar.cpp image.cpp )
target_link_libraries(lidar_ffi sick_scan_xd_lib)
