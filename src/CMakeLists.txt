

# # add_library(sick_scan_xd SHARED IMPORTED)
# # set_target_properties(sick_scan_xd PROPERTIES IMPORTED_LOCATION lidar.dll)
# # Config for SICK_SCAN_XD_ffi_library
# add_library(lidar_ffi SHARED "lidar.cpp")
# set_target_properties(lidar_ffi PROPERTIES
#   PUBLIC_HEADER lidar.h
#   PUBLIC_HEADER sick_scan_xd.h
#   OUTPUT_NAME "lidar_ffi"
# )

# Compile lidar_ffi
# target_compile_definitions(lidar_ffi PUBLIC DART_SHARED_LIB)
#target_link_libraries(lidar_ffi sick_scan_xd_shared_lib)

# Config for CMake
cmake_minimum_required(VERSION 3.10)
project(lidar_ffi VERSION 1.0 LANGUAGES CXX)

SET(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)

SET(ROS_VERSION 0)

add_subdirectory(sick_scan_xd)

# Set the output type to a shared library (DLL)
add_library(lidar_ffi SHARED lidar.cpp)  # Add your own C++ files here

# Specify the path to the sick_scan_xd headers and DLL
message("${CMAKE_SOURCE_DIR}")
set(SICK_SCAN_XD_INCLUDE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/sick_scan_xd/include")
set(SICK_SCAN_XD_DLL_DIR "${CMAKE_CURRENT_SOURCE_DIR}/sick_scan_xd/build/Release")  # Where sick_scan_xd DLL is built

# Include directories for sick_scan_xd
include_directories(${SICK_SCAN_XD_INCLUDE_DIR})

# Link the sick_scan_xd DLL to your project
target_link_libraries(lidar_ffi "${CMAKE_SOURCE_DIR}/../build/sick_scan_xd/Debug/sick_scan_xd_shared_lib.lib")
#video\src\build\sick_scan_xd\Debug\sick_scan_xd_shared_lib.lib
#C:/Users/aidan/dev/MarsRover/SecondaryPi/video/src/lidar

# Specify the output directory for the generated DLL
set_target_properties(lidar_ffi PROPERTIES
    PUBLIC_HEADER lidar.h
    PUBLIC_HEADER sick_scan_xd.h
    OUTPUT_NAME "lidar_ffi"
)