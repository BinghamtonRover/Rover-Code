cmake_minimum_required(VERSION 3.8)
project(video_ros2)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

find_package(ament_cmake REQUIRED)
find_package(rclcpp REQUIRED)
find_package(std_msgs REQUIRED)
find_package(sensor_msgs REQUIRED)
find_package(subsystems_ros2 REQUIRED)
# Boost is optional: no source file includes Boost headers, but it is linked
# when present for backwards compatibility (e.g. Ubuntu CI). On the Raspberry
# Pi the dependency is skipped entirely.
find_package(Boost QUIET COMPONENTS system thread)
find_package(OpenCV REQUIRED)
find_package(Threads REQUIRED)

# Find Protobuf C++ library. Allow user overrides; otherwise search common
# system paths. The multiarch library path is resolved via the GNU install
# dirs so this also works on arm64/aarch64 (Raspberry Pi OS, Ubuntu arm64).
if(NOT Protobuf_LIBRARIES OR NOT Protobuf_INCLUDE_DIRS)
  include(GNUInstallDirs)
  get_filename_component(_multiarch_libdir
    "${CMAKE_INSTALL_FULL_LIBDIR}/../lib/${CMAKE_LIBRARY_ARCHITECTURE}"
    ABSOLUTE)
  find_library(Protobuf_LIBRARIES
    NAMES protobuf protobufd
    PATHS
      ${CMAKE_INSTALL_FULL_LIBDIR}
      ${_multiarch_libdir}
      /usr/lib
      /usr/local/lib
  )
  find_path(Protobuf_INCLUDE_DIRS
    google/protobuf/message.h
    PATHS /usr/include /usr/local/include
  )
  if(NOT Protobuf_LIBRARIES OR NOT Protobuf_INCLUDE_DIRS)
    message(FATAL_ERROR "Could not find Protobuf C++ library. Install libprotobuf-dev or set Protobuf_LIBRARIES and Protobuf_INCLUDE_DIRS.")
  endif()
endif()

# Optional RealSense SDK. Disabled by default; use -DVIDEO_ROS2_ENABLE_REALSENSE=ON
# to opt in. The Pi Zero 2 W build turns this off explicitly (the librealsense
# pipeline is far too heavy for it, and the SDK is not available for armv8 in
# Raspberry Pi OS Bullseye anyway).
option(VIDEO_ROS2_ENABLE_REALSENSE "Enable Intel RealSense camera support" OFF)
if(VIDEO_ROS2_ENABLE_REALSENSE)
  find_package(realsense2 REQUIRED)
else()
  set(realsense2_FOUND FALSE)
endif()

# Optional libjpeg-turbo
find_package(PkgConfig QUIET)
if(PkgConfig_FOUND)
  pkg_check_modules(TURBOJPEG QUIET libturbojpeg)
  # Optional GStreamer (appsrc) support for CSI cameras via libcamera. The
  # Raspberry Pi camera connector does not expose a V4L2 /dev/video device by
  # default on Raspberry Pi OS Bullseye/Bullseye+; frames are only reachable
  # through the libcamera/GStreamer stack.
  pkg_check_modules(GSTREAMER QUIET
    gstreamer-1.0 gstreamer-app-1.0 gstreamer-video-1.0)
endif()

if(GSTREAMER_FOUND)
  message(STATUS "GStreamer found - CSI/libcamera camera support enabled")
else()
  message(STATUS "GStreamer not found - CSI/libcamera camera support disabled")
endif()

# Optional OpenCV ArUco module (older OpenCV 4.x ships it in opencv2/aruco.hpp)
find_path(OPENCV_ARUCO_HEADER
  opencv2/aruco.hpp
  PATHS ${OpenCV_INCLUDE_DIRS}
)
if(OPENCV_ARUCO_HEADER)
  message(STATUS "OpenCV ArUco module found at ${OPENCV_ARUCO_HEADER}")
endif()

# Helper: apply the optional-feature compile definitions to a target.
# HAS_REALSENSE must also reach main.cpp because VideoNode unconditionally
# references RealSenseCamera::make().
function(video_ros2_apply_features TARGET)
  if(realsense2_FOUND)
    target_compile_definitions(${TARGET} PRIVATE HAS_REALSENSE)
    target_link_libraries(${TARGET} realsense2::realsense2)
  endif()
  if(TURBOJPEG_FOUND)
    target_compile_definitions(${TARGET} PRIVATE HAS_TURBOJPEG)
    target_include_directories(${TARGET} PRIVATE ${TURBOJPEG_INCLUDE_DIRS})
    target_link_libraries(${TARGET} ${TURBOJPEG_LIBRARIES})
  endif()
  if(GSTREAMER_FOUND)
    target_compile_definitions(${TARGET} PRIVATE HAS_GSTREAMER)
    target_include_directories(${TARGET} SYSTEM PRIVATE ${GSTREAMER_INCLUDE_DIRS})
    target_link_libraries(${TARGET} ${GSTREAMER_LIBRARIES})
  endif()
  if(OPENCV_ARUCO_HEADER)
    target_compile_definitions(${TARGET} PRIVATE HAVE_OPENCV_ARUCO)
  endif()
endfunction()

# Shared utility library. Reuses the generated protobufs linked through subsystems_ros2_utils.
add_library(${PROJECT_NAME}_utils SHARED
  src/camera.cpp
  src/opencv_camera.cpp
  src/gstreamer_camera.cpp
  src/realsense_camera.cpp
  src/virtual_camera.cpp
  src/jpeg_encoder.cpp
  src/aruco_detector.cpp
  src/udp_socket.cpp
  src/dashboard_server.cpp
  src/video_node.cpp
)
target_include_directories(${PROJECT_NAME}_utils PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
  $<INSTALL_INTERFACE:include>
  ${OpenCV_INCLUDE_DIRS}
  ${Protobuf_INCLUDE_DIRS}
)
ament_target_dependencies(${PROJECT_NAME}_utils rclcpp std_msgs sensor_msgs subsystems_ros2)
target_link_libraries(${PROJECT_NAME}_utils
  subsystems_ros2::subsystems_ros2_utils
  ${OpenCV_LIBS}
  ${Protobuf_LIBRARIES}
  Threads::Threads
)
video_ros2_apply_features(${PROJECT_NAME}_utils)

# Main executable
add_executable(video_node src/main.cpp)
ament_target_dependencies(video_node rclcpp std_msgs sensor_msgs subsystems_ros2)
target_include_directories(video_node PRIVATE
  ${CMAKE_CURRENT_SOURCE_DIR}/include
  ${OpenCV_INCLUDE_DIRS}
  ${Protobuf_INCLUDE_DIRS}
)
target_link_libraries(video_node
  ${PROJECT_NAME}_utils
  subsystems_ros2::subsystems_ros2_utils
  ${OpenCV_LIBS}
  ${Protobuf_LIBRARIES}
  Threads::Threads
)
video_ros2_apply_features(video_node)

install(TARGETS video_node
  DESTINATION lib/${PROJECT_NAME}
)

# Install the shared utility library next to the executable so the RPATH works.
install(TARGETS ${PROJECT_NAME}_utils
  DESTINATION lib/${PROJECT_NAME}
)

install(DIRECTORY launch
  DESTINATION share/${PROJECT_NAME}
)

# Ensure the executable can find the shared library at runtime.
set_target_properties(video_node PROPERTIES
  INSTALL_RPATH "$ORIGIN"
)

# Unit / performance tests
if(BUILD_TESTING)
  find_package(ament_cmake_gtest REQUIRED)

  ament_add_gtest(test_performance test/test_performance.cpp)
  if(TARGET test_performance)
    target_include_directories(test_performance PRIVATE
      ${CMAKE_CURRENT_SOURCE_DIR}/include
      ${OpenCV_INCLUDE_DIRS}
      ${Protobuf_INCLUDE_DIRS}
    )
    target_link_libraries(test_performance
      ${PROJECT_NAME}_utils
      ${OpenCV_LIBS}
      ${Protobuf_LIBRARIES}
    )
    video_ros2_apply_features(test_performance)
  endif()

  ament_add_gtest(test_udp_socket test/test_udp_socket.cpp)
  if(TARGET test_udp_socket)
    target_include_directories(test_udp_socket PRIVATE
      ${CMAKE_CURRENT_SOURCE_DIR}/include
    )
    target_link_libraries(test_udp_socket
      ${PROJECT_NAME}_utils
    )
  endif()

  ament_add_gtest(test_dashboard_server test/test_dashboard_server.cpp)
  if(TARGET test_dashboard_server)
    target_include_directories(test_dashboard_server PRIVATE
      ${CMAKE_CURRENT_SOURCE_DIR}/include
      ${Protobuf_INCLUDE_DIRS}
    )
    target_link_libraries(test_dashboard_server
      ${PROJECT_NAME}_utils
      ${Protobuf_LIBRARIES}
    )
    video_ros2_apply_features(test_dashboard_server)
  endif()
endif()

ament_package()
