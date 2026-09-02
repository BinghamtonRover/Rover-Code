#include "rclcpp/rclcpp.hpp"

#include "video_ros2/video_node.hpp"

int main(int argc, char ** argv)
{
  rclcpp::init(argc, argv);
  rclcpp::spin(std::make_shared<video_ros2::VideoNode>());
  rclcpp::shutdown();
  return 0;
}
