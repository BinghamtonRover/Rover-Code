# Config for CMake
cmake_minimum_required(VERSION 3.10)

project(lidar_ffi VERSION 1.0 LANGUAGES CXX)

SET(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)
SET(ROS_VERSION 0)

set(BUILD_SICK_SCAN_XD_API_TEST 0)
add_subdirectory(sick_scan_xd)
include_directories("sick_scan_xd/include/sick_scan_xd_api")

<<<<<<< HEAD
# Set the output type to a shared library (DLL)
add_library(lidar_ffi SHARED lidar.cpp)  # Add your own C++ files here

# Include directories for sick_scan_xd
include_directories(${SICK_SCAN_XD_INCLUDE_DIR})

# Link the sick_scan_xd DLL to your project
if(WIN32)
    target_link_libraries(lidar_ffi "${CMAKE_SOURCE_DIR}/../build/sick_scan_xd/Debug/sick_scan_xd_shared_lib.lib")
else()
    #target_link_libraries(lidar_ffi ${sick_scan_xd_LIBRARIES})
    target_link_libraries(lidar_ffi "${CMAKE_CURRENT_SOURCE_DIR}/../build/sick_scan_xd/libsick_scan_xd_lib.a")
=======
if (NOT WIN32)
add_executable(lidar udp.cpp image.cpp lidar.cpp main.cpp)
target_link_libraries(lidar sick_scan_xd_lib)
>>>>>>> 649b2768441ae09ab1ec34d7683fee0bf1d5f2c6
endif()

add_library(lidar_ffi SHARED lidar.cpp image.cpp )
target_link_libraries(lidar_ffi sick_scan_xd_lib)
