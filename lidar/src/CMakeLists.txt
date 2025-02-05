# Config for CMake
cmake_minimum_required(VERSION 3.10)

project(lidar_ffi VERSION 1.0 LANGUAGES CXX)

SET(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)
SET(ROS_VERSION 0)

add_subdirectory(sick_scan_xd)

# Include directories for sick_scan_xd
include_directories(${SICK_SCAN_XD_INCLUDE_DIR})

# Set the output type to a shared library (DLL)
add_library(lidar_ffi SHARED lidar.cpp)  # Add your own C++ files here

# Link the sick_scan_xd DLL to your project
if(WIN32)
    message("Building for windows")
    target_link_libraries(lidar_ffi ${sick_scan_xd_LIBRARIES})
    target_link_libraries(lidar_ffi "${CMAKE_SOURCE_DIR}/../build/sick_scan_xd/Debug/sick_scan_xd_shared_lib.lib")
else()
    message("Building for linux")
    target_link_libraries(lidar_ffi ${sick_scan_xd_LIBRARIES})
    target_link_libraries(lidar_ffi "${CMAKE_CURRENT_SOURCE_DIR}/../build/sick_scan_xd/libsick_scan_xd_lib.a")
endif()

# Specify the output directory for the generated DLL
set_target_properties(lidar_ffi PROPERTIES
    PUBLIC_HEADER lidar.h
    PUBLIC_HEADER sick_scan_api.h
    PUBLIC_HEADER sick_scan_xd.h
    OUTPUT_NAME "lidar_ffi"
)
