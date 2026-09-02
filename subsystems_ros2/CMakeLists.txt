cmake_minimum_required(VERSION 3.8)
project(subsystems_ros2)

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

option(ENABLE_SANITIZERS "Enable AddressSanitizer and LeakSanitizer" OFF)
if(ENABLE_SANITIZERS)
  add_compile_options(-fsanitize=address,leak -fno-omit-frame-pointer)
  add_link_options(-fsanitize=address,leak)
endif()

find_package(ament_cmake REQUIRED)
find_package(rclcpp REQUIRED)
find_package(std_msgs REQUIRED)
find_package(rosidl_default_generators REQUIRED)
find_package(Boost REQUIRED COMPONENTS system thread)
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

# Custom ROS2 message
rosidl_generate_interfaces(${PROJECT_NAME}
  "msg/WrappedProtobuf.msg"
)

# Include generated protobuf headers and source files
file(GLOB PROTO_SRCS "include/${PROJECT_NAME}/generated/*.pb.cc")
file(GLOB PROTO_HDRS "include/${PROJECT_NAME}/generated/*.pb.h")

include_directories(
  include
  ${Boost_INCLUDE_DIRS}
  ${Protobuf_INCLUDE_DIRS}
)

# Shared utility library
add_library(${PROJECT_NAME}_utils SHARED
  src/utils.cpp
  ${PROTO_SRCS}
)
target_include_directories(${PROJECT_NAME}_utils PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
  $<INSTALL_INTERFACE:include>
)
ament_target_dependencies(${PROJECT_NAME}_utils rclcpp std_msgs)
target_link_libraries(${PROJECT_NAME}_utils
  ${Boost_LIBRARIES}
  ${Protobuf_LIBRARIES}
  Threads::Threads
)
rosidl_get_typesupport_target(cpp_typesupport_target "${PROJECT_NAME}" "rosidl_typesupport_cpp")
if(cpp_typesupport_target)
  target_link_libraries(${PROJECT_NAME}_utils "${cpp_typesupport_target}")
endif()
install(TARGETS ${PROJECT_NAME}_utils
  EXPORT ${PROJECT_NAME}_utilsTargets
  DESTINATION lib
)

# Helper macro to build a node executable
macro(add_subsystems_node NODE_NAME)
  add_executable(${NODE_NAME} src/${NODE_NAME}.cpp)
  ament_target_dependencies(${NODE_NAME} rclcpp std_msgs)
  target_link_libraries(${NODE_NAME}
    ${PROJECT_NAME}_utils
    ${Boost_LIBRARIES}
    ${Protobuf_LIBRARIES}
    Threads::Threads
  )
  if(cpp_typesupport_target)
    target_link_libraries(${NODE_NAME} "${cpp_typesupport_target}")
  endif()
  install(TARGETS ${NODE_NAME}
    DESTINATION lib/${PROJECT_NAME}
  )
endmacro()

add_subsystems_node(udp_bridge)
add_subsystems_node(firmware_manager)
add_subsystems_node(gps_node)
add_subsystems_node(imu_node)
add_subsystems_node(subsystems_node)

install(DIRECTORY launch
  DESTINATION share/${PROJECT_NAME}
)

# Install generated protobuf headers so downstream packages can use them.
install(DIRECTORY include/${PROJECT_NAME}/generated
  DESTINATION include/${PROJECT_NAME}
)

# Export the utility library so other packages can link against it.
ament_export_targets(${PROJECT_NAME}_utilsTargets HAS_LIBRARY_TARGET)
ament_export_include_directories(include)
ament_export_libraries(${PROJECT_NAME}_utils)

# Unit tests
if(BUILD_TESTING)
  find_package(ament_cmake_gtest REQUIRED)
  ament_add_gtest(test_utils test/test_utils.cpp)
  if(TARGET test_utils)
    target_link_libraries(test_utils
      ${PROJECT_NAME}_utils
      ${Protobuf_LIBRARIES}
    )
  endif()
endif()

ament_package()
