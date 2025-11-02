# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.

# Config for CMake
cmake_minimum_required(VERSION 3.10)
project(realsense_ffi_library VERSION 0.0.1 LANGUAGES CXX)
# add_compile_options(-std=c++11 -fPIC -lusb-1.0 -lpthread )

# RealSense SDK config. These only build the stuff we need to reduce build time
# See https://dev.intelrealsense.com/docs/build-configuration
remove_definitions(-DUNICODE -D_UNICODE)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
SET(BUILD_EXAMPLES OFF CACHE BOOL "Some option" FORCE)
SET(BUILD_GRAPHICAL_EXAMPLES OFF CACHE BOOL "Some option" FORCE)
SET(BUILD_TOOLS OFF CACHE BOOL "Some option" FORCE)
SET(BUILD_WITH_OPENMP ON CACHE BOOL "Some option" FORCE)
SET(BUILD_SHARED_LIBS ON CACHE BOOL "Some option" FORCE)
SET(CMAKE_BUILD_TYPE Release)

SET(BUILD_EASY_LOGGINGPP OFF CACHE BOOL "Some option" FORCE)
SET(BUILD_WITH_TM2 OFF CACHE BOOL "Some option" FORCE)
SET(IMPORT_DEPTH_CAM_FW OFF CACHE BOOL "Some option" FORCE)

# Compile the RealSense SDK and register with CMake
add_subdirectory(librealsense)

# Config for realsense_ffi
include_directories(BEFORE SYSTEM "${CMAKE_SOURCE_DIR}/librealsense/include")
add_library(realsense_ffi SHARED "realsense_ffi.cpp" "realsense_internal.cpp")
set_target_properties(realsense_ffi PROPERTIES
  PUBLIC_HEADER realsense_ffi.h
  OUTPUT_NAME "realsense_ffi"
)

# Compile realsense_ffi
target_compile_definitions(realsense_ffi PUBLIC DART_SHARED_LIB)
target_link_libraries(realsense_ffi PUBLIC "realsense2")

# Compile and link point cloud ffi library
find_package(PCL REQUIRED)
add_library(pointcloud_ffi SHARED "pointcloud_ffi.cpp")
target_include_directories(pointcloud_ffi PUBLIC ${PCL_INCLUDE_DIRS})
set_target_properties(pointcloud_ffi PROPERTIES
  PUBLIC_HEADER pointcloud_ffi.h
  OUTPUT_NAME "pointcloud_ffi"
)
target_compile_definitions(pointcloud_ffi PUBLIC DART_SHARED_LIB)
target_link_libraries(pointcloud_ffi ${PCL_LIBRARIES})
