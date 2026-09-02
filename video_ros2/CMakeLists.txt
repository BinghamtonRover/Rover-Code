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
find_package(Boost REQUIRED COMPONENTS system thread)
find_package(OpenCV REQUIRED)
find_package(Threads REQUIRED)

# Find Protobuf C++ library. Allow user overrides; otherwise search common system paths.
if(NOT Protobuf_LIBRARIES OR NOT Protobuf_INCLUDE_DIRS)
  find_library(Protobuf_LIBRARIES
    NAMES protobuf protobufd libprotobuf.so.23
    PATHS /usr/lib/x86_64-linux-gnu /usr/lib /usr/local/lib
  )
  find_path(Protobuf_INCLUDE_DIRS
    google/protobuf/message.h
    PATHS /usr/include /usr/local/include /tmp/protobuf_dev/usr/include
  )
  if(NOT Protobuf_LIBRARIES OR NOT Protobuf_INCLUDE_DIRS)
    message(FATAL_ERROR "Could not find Protobuf C++ library. Install libprotobuf-dev or set Protobuf_LIBRARIES and Protobuf_INCLUDE_DIRS.")
  endif()
endif()

# Optional RealSense SDK
find_package(realsense2 QUIET)

# Optional libjpeg-turbo
find_package(PkgConfig QUIET)
if(PkgConfig_FOUND)
  pkg_check_modules(TURBOJPEG QUIET libturbojpeg)
endif()

# Optional OpenCV ArUco module (older OpenCV 4.x ships it in opencv2/aruco.hpp)
find_path(OPENCV_ARUCO_HEADER
  opencv2/aruco.hpp
  PATHS ${OpenCV_INCLUDE_DIRS}
)
if(OPENCV_ARUCO_HEADER)
  message(STATUS "OpenCV ArUco module found at ${OPENCV_ARUCO_HEADER}")
endif()

# Shared utility library. Reuses the generated protobufs linked through subsystems_ros2_utils.
add_library(${PROJECT_NAME}_utils SHARED
  src/camera.cpp
  src/opencv_camera.cpp
  src/realsense_camera.cpp
  src/virtual_camera.cpp
  src/jpeg_encoder.cpp
  src/aruco_detector.cpp
  src/udp_socket.cpp
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
if(realsense2_FOUND)
  target_compile_definitions(${PROJECT_NAME}_utils PRIVATE HAS_REALSENSE)
  target_link_libraries(${PROJECT_NAME}_utils realsense2::realsense2)
endif()
if(TURBOJPEG_FOUND)
  target_compile_definitions(${PROJECT_NAME}_utils PRIVATE HAS_TURBOJPEG)
  target_include_directories(${PROJECT_NAME}_utils PRIVATE ${TURBOJPEG_INCLUDE_DIRS})
  target_link_libraries(${PROJECT_NAME}_utils ${TURBOJPEG_LIBRARIES})
endif()
if(OPENCV_ARUCO_HEADER)
  target_compile_definitions(${PROJECT_NAME}_utils PRIVATE HAVE_OPENCV_ARUCO)
endif()

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
endif()

ament_package()
