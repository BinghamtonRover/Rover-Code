cmake_minimum_required(VERSION 3.8)
project(autonomy_ros2)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

find_package(ament_cmake REQUIRED)
find_package(rclcpp REQUIRED)
find_package(subsystems_ros2 REQUIRED)
find_package(Boost REQUIRED COMPONENTS system thread)
find_package(Threads REQUIRED)

# Reuse the protobuf toolchain and generated messages exported by subsystems_ros2.
find_library(Protobuf_LIBRARIES NAMES protobuf REQUIRED)
find_path(Protobuf_INCLUDE_DIRS google/protobuf/message.h REQUIRED)

add_executable(autonomy_node src/autonomy_node.cpp)
ament_target_dependencies(autonomy_node rclcpp subsystems_ros2)
target_include_directories(autonomy_node PRIVATE
  ${CMAKE_CURRENT_SOURCE_DIR}/include
  ${CMAKE_CURRENT_SOURCE_DIR}/../subsystems_ros2/include
  ${Protobuf_INCLUDE_DIRS}
)
target_link_libraries(autonomy_node
  subsystems_ros2::subsystems_ros2_utils
  ${Protobuf_LIBRARIES}
  Threads::Threads
)

install(TARGETS autonomy_node
  DESTINATION lib/${PROJECT_NAME}
)

install(DIRECTORY launch
  DESTINATION share/${PROJECT_NAME}
)

ament_package()
