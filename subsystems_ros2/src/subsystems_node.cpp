#include <memory>
#include <string>
#include <unordered_set>

#include "rclcpp/rclcpp.hpp"
#include "subsystems_ros2/msg/wrapped_protobuf.hpp"
#include "subsystems_ros2/utils.hpp"
#include "subsystems_ros2/generated/arm.pb.h"
#include "subsystems_ros2/generated/drive.pb.h"
#include "subsystems_ros2/generated/gps.pb.h"
#include "subsystems_ros2/generated/relays.pb.h"
#include "subsystems_ros2/generated/science.pb.h"
#include "subsystems_ros2/generated/subsystems.pb.h"
#include "subsystems_ros2/generated/version.pb.h"
#include "subsystems_ros2/generated/wrapper.pb.h"

namespace subsystems_ros2
{

class SubsystemsNode : public rclcpp::Node
{
public:
  SubsystemsNode()
  : Node("subsystems_node")
  {
    this->declare_parameter<double>("status_period", 0.25);
    double status_period = this->get_parameter("status_period").as_double();

    outgoing_pub_ = this->create_publisher<WrappedProtobuf>("/burt/outgoing", 100);
    incoming_sub_ = this->create_subscription<WrappedProtobuf>(
      "/burt/incoming", 100,
      std::bind(&SubsystemsNode::onIncoming, this, std::placeholders::_1));
    outgoing_sub_ = this->create_subscription<WrappedProtobuf>(
      "/burt/outgoing", 100,
      std::bind(&SubsystemsNode::onOutgoing, this, std::placeholders::_1));
    gps_position_sub_ = this->create_subscription<WrappedProtobuf>(
      "/burt/gps_position", 100,
      std::bind(&SubsystemsNode::onGpsPosition, this, std::placeholders::_1));
    imu_position_sub_ = this->create_subscription<WrappedProtobuf>(
      "/burt/imu_position", 100,
      std::bind(&SubsystemsNode::onImuPosition, this, std::placeholders::_1));

    last_gps_time_ = this->now();
    last_imu_time_ = this->now();

    status_timer_ = this->create_wall_timer(
      std::chrono::milliseconds(static_cast<int>(status_period * 1000)),
      std::bind(&SubsystemsNode::sendStatus, this));
  }

  ~SubsystemsNode()
  {
    onDisconnect();
  }

private:
  using WrappedProtobuf = subsystems_ros2::msg::WrappedProtobuf;

  void onIncoming(const WrappedProtobuf::SharedPtr msg)
  {
    // SubsystemsCommand is handled by the IMU node for zero_imu.
    (void)msg;
  }

  void onOutgoing(const WrappedProtobuf::SharedPtr msg)
  {
    if (msg->name == ArmData::descriptor()->full_name()) {
      connected_devices_.insert(static_cast<int>(ARM));
    } else if (msg->name == DriveData::descriptor()->full_name()) {
      connected_devices_.insert(static_cast<int>(DRIVE));
    } else if (msg->name == ScienceData::descriptor()->full_name()) {
      connected_devices_.insert(static_cast<int>(SCIENCE));
    } else if (msg->name == RelaysData::descriptor()->full_name()) {
      connected_devices_.insert(static_cast<int>(RELAY));
    }
  }

  void onGpsPosition(const WrappedProtobuf::SharedPtr msg)
  {
    (void)msg;
    gps_connected_ = true;
    last_gps_time_ = this->now();
  }

  void onImuPosition(const WrappedProtobuf::SharedPtr msg)
  {
    (void)msg;
    imu_connected_ = true;
    last_imu_time_ = this->now();
  }

  void sendStatus()
  {
    auto now = this->now();
    if ((now - last_gps_time_).seconds() > 2.0) gps_connected_ = false;
    if ((now - last_imu_time_).seconds() > 2.0) imu_connected_ = false;

    SubsystemsData status;
    status.mutable_version()->set_major(1);
    status.mutable_version()->set_minor(0);
    status.set_gps_connected(gps_connected_ ? BoolState::YES : BoolState::NO);
    status.set_imu_connected(imu_connected_ ? BoolState::YES : BoolState::NO);
    for (int device : connected_devices_) {
      status.add_connected_devices(static_cast<Device>(device));
    }

    WrappedMessage wrapper = wrapMessage(status);
    WrappedProtobuf msg;
    msg.name = wrapper.name();
    msg.data.assign(wrapper.data().begin(), wrapper.data().end());
    outgoing_pub_->publish(msg);
  }

  void onDisconnect()
  {
    RCLCPP_INFO(this->get_logger(), "Stopping all hardware");
    DriveCommand stop_drive;
    stop_drive.set_throttle(0);
    stop_drive.set_set_throttle(true);
    ArmCommand stop_arm;
    stop_arm.set_stop(true);
    ScienceCommand stop_science;
    stop_science.set_stop(true);

    publishMessage(stop_drive);
    publishMessage(stop_arm);
    publishMessage(stop_science);
  }

  template <typename T>
  void publishMessage(const T & message)
  {
    WrappedMessage wrapper = wrapMessage(message);
    WrappedProtobuf msg;
    msg.name = wrapper.name();
    msg.data.assign(wrapper.data().begin(), wrapper.data().end());
    outgoing_pub_->publish(msg);
  }

  rclcpp::Publisher<WrappedProtobuf>::SharedPtr outgoing_pub_;
  rclcpp::Subscription<WrappedProtobuf>::SharedPtr incoming_sub_;
  rclcpp::Subscription<WrappedProtobuf>::SharedPtr outgoing_sub_;
  rclcpp::Subscription<WrappedProtobuf>::SharedPtr gps_position_sub_;
  rclcpp::Subscription<WrappedProtobuf>::SharedPtr imu_position_sub_;
  rclcpp::TimerBase::SharedPtr status_timer_;

  bool gps_connected_ = false;
  bool imu_connected_ = false;
  std::unordered_set<int> connected_devices_;
  rclcpp::Time last_gps_time_;
  rclcpp::Time last_imu_time_;
};

}  // namespace subsystems_ros2

int main(int argc, char ** argv)
{
  rclcpp::init(argc, argv);
  rclcpp::spin(std::make_shared<subsystems_ros2::SubsystemsNode>());
  rclcpp::shutdown();
  return 0;
}
