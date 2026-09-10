#include <algorithm>
#include <array>
#include <chrono>
#include <cmath>
#include <cstdint>
#include <functional>
#include <memory>
#include <mutex>
#include <queue>
#include <string>
#include <unordered_map>
#include <vector>

#include "rclcpp/rclcpp.hpp"
#include "subsystems_ros2/msg/wrapped_protobuf.hpp"
#include "subsystems_ros2/utils.hpp"
#include "subsystems_ros2/generated/autonomy.pb.h"
#include "subsystems_ros2/generated/drive.pb.h"
#include "subsystems_ros2/generated/gps.pb.h"
#include "subsystems_ros2/generated/lidar.pb.h"
#include "subsystems_ros2/generated/wrapper.pb.h"

namespace autonomy_ros2
{

using WrappedProtobuf = subsystems_ros2::msg::WrappedProtobuf;

constexpr double EARTH_RADIUS_METERS = 6378137.0;
constexpr double OBSTACLE_RADIUS_METERS = 0.75;
constexpr double GOAL_TOLERANCE_METERS = 1.5;
constexpr double PATH_RESOLUTION_METERS = 0.5;
constexpr double CURVE_LOOKAHEAD_METERS = 1.5;
constexpr double TRACK_WIDTH_METERS = 0.85;
constexpr int WHEELS_PER_SIDE = 3;
constexpr double MIN_FORWARD_SIDE_SPEED = 0.12;
constexpr double MAX_THROTTLE = 0.20;
constexpr double MAX_STEERING = 0.75;

struct Point
{
  double x = 0.0;
  double y = 0.0;
};

struct GridPoint
{
  int x;
  int y;
  bool operator==(const GridPoint & other) const { return x == other.x && y == other.y; }
};

struct GridHash
{
  std::size_t operator()(const GridPoint & point) const
  {
    return std::hash<int>()(point.x) ^ (std::hash<int>()(point.y) << 1);
  }
};

struct PathPoint
{
  Point point;
  double heading = 0.0;
};

// The DriveCommand protocol exposes one speed for each side. The firmware distributes
// each side speed to its front, middle, and rear wheel, which is the appropriate
// differential/skid-steer interface for a six-wheel rocker-bogie chassis.
struct SixWheelSideSpeeds
{
  double left;
  double right;
};

static_assert(WHEELS_PER_SIDE == 3, "Rocker-bogie drive expects front, middle, and rear wheels per side");

Point operator+(const Point & left, const Point & right) { return {left.x + right.x, left.y + right.y}; }
Point operator-(const Point & left, const Point & right) { return {left.x - right.x, left.y - right.y}; }
Point operator*(const Point & point, double scalar) { return {point.x * scalar, point.y * scalar}; }
double norm(const Point & point) { return std::hypot(point.x, point.y); }
double distance(const Point & left, const Point & right) { return norm(left - right); }
Point unit(const Point & point)
{
  const double length = norm(point);
  return length > 1e-9 ? point * (1.0 / length) : Point{};
}
double wrapAngle(double angle)
{
  while (angle > M_PI) angle -= 2.0 * M_PI;
  while (angle < -M_PI) angle += 2.0 * M_PI;
  return angle;
}

class CurvedPathPlanner
{
public:
  void setObstacles(const std::vector<Point> & obstacles) { obstacles_ = obstacles; }

  std::vector<PathPoint> plan(const Point & start, double start_heading, const Point & goal) const
  {
    const auto grid_path = planGrid(start, goal);
    if (grid_path.empty()) return {};

    std::vector<Point> anchors{start};
    for (const auto & point : grid_path) {
      if (distance(anchors.back(), point) > 0.2) anchors.push_back(point);
    }
    if (distance(anchors.back(), goal) > 0.2) anchors.push_back(goal);
    if (anchors.size() < 2) anchors.push_back(goal);

    std::vector<PathPoint> result;
    double previous_heading = start_heading;
    for (size_t index = 0; index + 1 < anchors.size(); ++index) {
      const Point & from = anchors[index];
      const Point & to = anchors[index + 1];
      const Point incoming = index == 0 ? Point{std::cos(start_heading), std::sin(start_heading)} :
        unit(from - anchors[index - 1]);
      const Point outgoing = index + 2 >= anchors.size() ? unit(to - from) :
        unit(anchors[index + 2] - from);
      const double chord = distance(from, to);
      const double tangent_length = std::clamp(chord * 0.45, 0.25, 1.5);
      const Point p1 = from + incoming * tangent_length;
      const Point p2 = to - outgoing * tangent_length;
      const int samples = std::max(2, static_cast<int>(std::ceil(chord / PATH_RESOLUTION_METERS)));

      for (int sample = 0; sample < samples; ++sample) {
        const double t = static_cast<double>(sample) / samples;
        const double inverse = 1.0 - t;
        const Point point = from * (inverse * inverse * inverse) +
          p1 * (3.0 * inverse * inverse * t) +
          p2 * (3.0 * inverse * t * t) +
          to * (t * t * t);
        const Point derivative = (p1 - from) * (3.0 * inverse * inverse) +
          (p2 - p1) * (6.0 * inverse * t) + (to - p2) * (3.0 * t * t);
        const double heading = norm(derivative) > 1e-6 ? std::atan2(derivative.y, derivative.x) : previous_heading;
        if (result.empty() || distance(result.back().point, point) >= 0.2) {
          result.push_back({point, heading});
          previous_heading = heading;
        }
      }
    }
    result.push_back({goal, std::atan2(goal.y - anchors[anchors.size() - 2].y, goal.x - anchors[anchors.size() - 2].x)});
    return result;
  }

private:
  bool blocked(const Point & point) const
  {
    for (const auto & obstacle : obstacles_) {
      if (distance(point, obstacle) <= OBSTACLE_RADIUS_METERS) return true;
    }
    return false;
  }

  std::vector<Point> planGrid(const Point & start, const Point & goal) const
  {
    const GridPoint origin{static_cast<int>(std::floor(start.x)), static_cast<int>(std::floor(start.y))};
    const GridPoint target{static_cast<int>(std::floor(goal.x)), static_cast<int>(std::floor(goal.y))};
    if (origin == target) return {goal};

    struct Entry
    {
      double priority;
      GridPoint point;
    };
    auto compare = [](const Entry & left, const Entry & right) { return left.priority > right.priority; };
    std::priority_queue<Entry, std::vector<Entry>, decltype(compare)> open(compare);
    std::unordered_map<GridPoint, GridPoint, GridHash> came_from;
    std::unordered_map<GridPoint, double, GridHash> cost;
    open.push({0.0, origin});
    cost[origin] = 0.0;
    const std::array<GridPoint, 8> directions{{
      {1, 0}, {-1, 0}, {0, 1}, {0, -1}, {1, 1}, {1, -1}, {-1, 1}, {-1, -1}}};

    int expansions = 0;
    while (!open.empty() && expansions++ < 20000) {
      const GridPoint current = open.top().point;
      open.pop();
      if (current == target) break;
      for (const auto & direction : directions) {
        const GridPoint next{current.x + direction.x, current.y + direction.y};
        const Point next_point{next.x + 0.5, next.y + 0.5};
        if (blocked(next_point)) continue;
        if (direction.x != 0 && direction.y != 0 &&
            (blocked({current.x + direction.x + 0.5, current.y + 0.5}) ||
             blocked({current.x + 0.5, current.y + direction.y + 0.5}))) continue;
        const double step = direction.x != 0 && direction.y != 0 ? 1.41421356237 : 1.0;
        const double next_cost = cost[current] + step;
        if (cost.find(next) == cost.end() || next_cost < cost[next]) {
          cost[next] = next_cost;
          came_from[next] = current;
          open.push({next_cost + std::hypot(target.x - next.x, target.y - next.y), next});
        }
      }
    }

    if (came_from.find(target) == came_from.end()) return {};
    std::vector<Point> reverse;
    for (GridPoint current = target; !(current == origin); current = came_from[current]) {
      reverse.push_back({current.x + 0.5, current.y + 0.5});
    }
    std::reverse(reverse.begin(), reverse.end());
    reverse.back() = goal;
    return reverse;
  }

  std::vector<Point> obstacles_;
};

class AutonomyNode : public rclcpp::Node
{
public:
  AutonomyNode()
  : Node("autonomy_node")
  {
    this->declare_parameter<double>("throttle", MAX_THROTTLE);
    this->declare_parameter<bool>("allow_hardware_drive", true);
    this->declare_parameter<bool>("simulation_mode", false);
    this->declare_parameter<double>("simulation_latitude", 42.0987);
    this->declare_parameter<double>("simulation_longitude", -75.9657);
    throttle_ = this->get_parameter("throttle").as_double();
    allow_hardware_drive_ = this->get_parameter("allow_hardware_drive").as_bool();
    simulation_mode_ = this->get_parameter("simulation_mode").as_bool();
    if (simulation_mode_) {
      gps_ = {
        this->get_parameter("simulation_longitude").as_double(),
        this->get_parameter("simulation_latitude").as_double()};
      origin_ = gps_;
      origin_set_ = true;
      gps_valid_ = true;
      imu_valid_ = true;
      heading_ = M_PI / 2.0;
    }

    drive_pub_ = this->create_publisher<WrappedProtobuf>("/burt/outgoing", 100);
    gps_sim_pub_ = this->create_publisher<WrappedProtobuf>("/burt/gps_position", 100);
    imu_sim_pub_ = this->create_publisher<WrappedProtobuf>("/burt/imu_position", 100);
    command_pub_ = this->create_publisher<WrappedProtobuf>("/burt/incoming", 100);
    autonomy_pub_ = this->create_publisher<WrappedProtobuf>("/burt/autonomy_outgoing", 100);
    command_sub_ = this->create_subscription<WrappedProtobuf>(
      "/burt/autonomy_incoming", 100,
      std::bind(&AutonomyNode::onCommand, this, std::placeholders::_1));
    gps_sub_ = this->create_subscription<WrappedProtobuf>(
      "/burt/gps_position", 100, std::bind(&AutonomyNode::onGps, this, std::placeholders::_1));
    imu_sub_ = this->create_subscription<WrappedProtobuf>(
      "/burt/imu_position", 100, std::bind(&AutonomyNode::onImu, this, std::placeholders::_1));
    sensor_sub_ = this->create_subscription<WrappedProtobuf>(
      "/burt/outgoing", 100, std::bind(&AutonomyNode::onSensorData, this, std::placeholders::_1));
    timer_ = this->create_wall_timer(std::chrono::milliseconds(250), std::bind(&AutonomyNode::tick, this));

    RCLCPP_INFO(this->get_logger(), "Autonomy ROS2 node ready; Dashboard compatibility is provided by udp_bridge on port 8003");
    if (simulation_mode_) {
      RCLCPP_INFO(this->get_logger(), "Simulation mode enabled: synthetic GPS/IMU active and hardware drive output disabled");
      publishSimulationSensors();
    }
  }

  ~AutonomyNode() { publishDrive(0.0, 0.0, 0.0); }

private:
  void onCommand(const WrappedProtobuf::SharedPtr message)
  {
    if (message->name != AutonomyCommand::descriptor()->full_name()) return;
    AutonomyCommand command;
    if (!command.ParseFromArray(message->data.data(), static_cast<int>(message->data.size()))) return;
    std::lock_guard<std::mutex> lock(command_mutex_);
    pending_commands_.push(command);
  }

  void onGps(const WrappedProtobuf::SharedPtr message)
  {
    if (message->name != RoverPosition::descriptor()->full_name()) return;
    RoverPosition position;
    if (!position.ParseFromArray(message->data.data(), static_cast<int>(message->data.size())) || !position.has_gps()) return;
    std::lock_guard<std::mutex> lock(sensor_mutex_);
    gps_ = {position.gps().longitude(), position.gps().latitude()};
    gps_valid_ = true;
    if (!origin_set_) {
      origin_ = gps_;
      origin_set_ = true;
    }
  }

  void onImu(const WrappedProtobuf::SharedPtr message)
  {
    if (message->name != RoverPosition::descriptor()->full_name()) return;
    RoverPosition position;
    if (!position.ParseFromArray(message->data.data(), static_cast<int>(message->data.size())) || !position.has_orientation()) return;
    std::lock_guard<std::mutex> lock(sensor_mutex_);
    // BURT yaw is zero at north; local ENU path headings are zero at east.
    heading_ = M_PI / 2.0 - position.orientation().yaw() * M_PI / 180.0;
    imu_valid_ = true;
  }

  void onSensorData(const WrappedProtobuf::SharedPtr message)
  {
    if (message->name != LidarPointCloud::descriptor()->full_name()) return;
    LidarPointCloud cloud;
    if (!cloud.ParseFromArray(message->data.data(), static_cast<int>(message->data.size()))) return;
    std::lock_guard<std::mutex> lock(sensor_mutex_);
    lidar_obstacles_.clear();
    for (const auto & point : cloud.cartesian()) {
      const double range = std::hypot(point.x(), point.y());
      if (range >= 0.2 && range <= 20.0) lidar_obstacles_.push_back({point.x(), point.y()});
    }
  }

  void tick()
  {
    if (simulation_mode_) publishSimulationSensors();
    AutonomyCommand command;
    bool has_command = false;
    {
      std::lock_guard<std::mutex> lock(command_mutex_);
      if (!pending_commands_.empty()) {
        command = pending_commands_.front();
        pending_commands_.pop();
        has_command = true;
      }
    }
    if (has_command) startCommand(command);
    if (!active_) return;

    Point current;
    double heading;
    {
      std::lock_guard<std::mutex> lock(sensor_mutex_);
      current = gpsToLocal(gps_);
      heading = heading_;
    }
    if (!gps_valid_ || !imu_valid_ || path_.empty()) return;
    if (distance(current, goal_) <= GOAL_TOLERANCE_METERS) {
      active_ = false;
      publishDrive(0.0, 0.0, 0.0);
      publishStatus(AT_DESTINATION);
      return;
    }

    while (path_index_ + 1 < path_.size() && distance(current, path_[path_index_ + 1].point) < CURVE_LOOKAHEAD_METERS) ++path_index_;
    const auto & target = path_[std::min(path_index_ + 1, path_.size() - 1)];
    const double heading_error = wrapAngle(target.heading - heading);
    const double target_distance = std::max(CURVE_LOOKAHEAD_METERS, distance(current, target.point));
    const double curvature = 2.0 * std::sin(heading_error) / target_distance;
    const double steering = std::clamp(curvature * TRACK_WIDTH_METERS / 2.0, -MAX_STEERING, MAX_STEERING);
    const SixWheelSideSpeeds side_speeds = sixWheelSideSpeeds(steering);
    // Both sides remain forward-moving: a rocker-bogie turn is a skid-steer arc,
    // never an in-place pivot that would fight the six-wheel ground contact.
    publishDrive(throttle_, side_speeds.left, side_speeds.right);
    simulateMotion(steering);
    publishSimulationSensors();
    publishStatus(DRIVING);
  }

  void startCommand(const AutonomyCommand & command)
  {
    // Echo commands on the autonomy channel for the Dashboard acknowledgement flow.
    publishAutonomy(command);
    if (command.abort()) {
      active_ = false;
      path_.clear();
      publishDrive(0.0, 0.0, 0.0);
      publishStatus(ABORTING);
      return;
    }
    if (command.task() == AUTONOMY_TASK_UNDEFINED || command.task() == BETWEEN_GATES) {
      publishStatus(NO_SOLUTION);
      return;
    }
    if (!gps_valid_ || !imu_valid_ || !command.has_destination()) {
      publishStatus(NO_SOLUTION);
      return;
    }

    Point current;
    double heading;
    std::vector<Point> obstacles;
    {
      std::lock_guard<std::mutex> lock(sensor_mutex_);
      current = gpsToLocal(gps_);
      heading = heading_;
      const Point forward{std::cos(heading), std::sin(heading)};
      const Point left{-std::sin(heading), std::cos(heading)};
      for (const auto & lidar : lidar_obstacles_) obstacles.push_back(current + forward * lidar.x + left * lidar.y);
    }
    const Point destination_gps{command.destination().longitude(), command.destination().latitude()};
    const Point destination = gpsToLocal(destination_gps);
    planner_.setObstacles(obstacles);
    path_ = planner_.plan(current, heading, destination);
    path_index_ = 0;
    goal_ = destination;
    task_ = command.task();
    active_ = !path_.empty();
    if (active_) publishStatus(PATHING); else publishStatus(NO_SOLUTION);
  }

  Point gpsToLocal(const Point & gps) const
  {
    const double latitude_scale = M_PI * EARTH_RADIUS_METERS / 180.0;
    return {(gps.x - origin_.x) * latitude_scale * std::cos(origin_.y * M_PI / 180.0),
      (gps.y - origin_.y) * latitude_scale};
  }

  Point localToGps(const Point & local) const
  {
    const double latitude_scale = M_PI * EARTH_RADIUS_METERS / 180.0;
    return {origin_.x + local.x / (latitude_scale * std::cos(origin_.y * M_PI / 180.0)),
      origin_.y + local.y / latitude_scale};
  }

  SixWheelSideSpeeds sixWheelSideSpeeds(double steering) const
  {
    const double bounded_steering = std::clamp(steering, -MAX_STEERING, MAX_STEERING);
    const double slow_side = std::max(MIN_FORWARD_SIDE_SPEED, 1.0 - std::abs(bounded_steering));
    const double fast_side = 1.0;
    return bounded_steering >= 0.0 ?
      SixWheelSideSpeeds{slow_side, fast_side} : SixWheelSideSpeeds{fast_side, slow_side};
  }

  void simulateMotion(double steering)
  {
    if (!simulation_mode_) return;
    std::lock_guard<std::mutex> lock(sensor_mutex_);
    constexpr double simulation_period = 0.25;
    const double speed = std::max(0.1, throttle_ / MAX_THROTTLE * 0.75);
    const double curvature = steering * 2.0 / TRACK_WIDTH_METERS;
    heading_ = wrapAngle(heading_ + speed * curvature * simulation_period);
    Point position = gpsToLocal(gps_);
    position = position + Point{
      std::cos(heading_) * speed * simulation_period,
      std::sin(heading_) * speed * simulation_period};
    gps_ = localToGps(position);
  }

  void publishSimulationSensors()
  {
    if (!simulation_mode_ || !origin_set_) return;
    std::lock_guard<std::mutex> lock(sensor_mutex_);
    RoverPosition gps_position;
    gps_position.mutable_gps()->set_latitude(gps_.y);
    gps_position.mutable_gps()->set_longitude(gps_.x);
    gps_position.mutable_gps()->set_rtk_mode(RTK_FIXED);
    gps_position.mutable_version()->set_major(1);
    gps_position.mutable_version()->set_minor(0);
    WrappedProtobuf gps_message;
    gps_message.name = RoverPosition::descriptor()->full_name();
    const std::string gps_data = gps_position.SerializeAsString();
    gps_message.data.assign(gps_data.begin(), gps_data.end());
    gps_sim_pub_->publish(gps_message);

    RoverPosition imu_position;
    imu_position.mutable_orientation()->set_yaw((M_PI / 2.0 - heading_) * 180.0 / M_PI);
    imu_position.mutable_version()->set_major(1);
    imu_position.mutable_version()->set_minor(0);
    WrappedProtobuf imu_message;
    imu_message.name = RoverPosition::descriptor()->full_name();
    const std::string imu_data = imu_position.SerializeAsString();
    imu_message.data.assign(imu_data.begin(), imu_data.end());
    imu_sim_pub_->publish(imu_message);

    // Hardware telemetry is consumed by the Dashboard from the shared data stream. Keep GPS and
    // orientation together here; publishing an IMU-only RoverPosition would reset GPS to (0, 0)
    // in the Dashboard's protobuf merge model.
    RoverPosition combined_position = gps_position;
    *combined_position.mutable_orientation() = imu_position.orientation();
    *combined_position.mutable_version() = imu_position.version();
    const auto combined_wrapper = subsystems_ros2::wrapMessage(combined_position);
    WrappedProtobuf combined_message;
    combined_message.name = combined_wrapper.name();
    combined_message.data.assign(combined_wrapper.data().begin(), combined_wrapper.data().end());
    drive_pub_->publish(combined_message);
  }
  void publishDrive(double throttle, double left, double right)
  {
    if (!allow_hardware_drive_) return;
    DriveCommand command;
    command.set_throttle(static_cast<float>(throttle));
    command.set_left(static_cast<float>(left));
    // DriveCommand.left/right are side-wide values. The firmware applies each
    // value to all three wheels on that side: front, middle, and rear.
    // The protocol uses the opposite sign for the physical right motor group.
    command.set_right(static_cast<float>(-right));
    command.set_set_throttle(true);
    command.set_set_left(true);
    command.set_set_right(true);
    publishRos(command);
  }

  void publishRos(const google::protobuf::Message & message)
  {
    const auto wrapper = subsystems_ros2::wrapMessage(message);
    WrappedProtobuf output;
    output.name = wrapper.name();
    output.data.assign(wrapper.data().begin(), wrapper.data().end());
    drive_pub_->publish(output);
  }

  void publishAutonomy(const google::protobuf::Message & message)
  {
    const auto wrapper = subsystems_ros2::wrapMessage(message);
    WrappedProtobuf output;
    output.name = wrapper.name();
    output.data.assign(wrapper.data().begin(), wrapper.data().end());
    autonomy_pub_->publish(output);
  }

  void publishStatus(AutonomyState state)
  {
    AutonomyData status;
    status.set_state(state);
    status.set_task(task_);
    status.mutable_version()->set_major(1);
    status.mutable_version()->set_minor(0);
    if (origin_set_) {
      const Point destination = localToGps(goal_);
      status.mutable_destination()->set_latitude(destination.y);
      status.mutable_destination()->set_longitude(destination.x);
      for (const auto & point : path_) {
        const Point gps = localToGps(point.point);
        auto * path_point = status.add_path();
        path_point->set_latitude(gps.y);
        path_point->set_longitude(gps.x);
      }
    }
    publishAutonomy(status);
  }

  std::mutex command_mutex_;
  std::queue<AutonomyCommand> pending_commands_;
  std::mutex sensor_mutex_;
  Point gps_{};
  Point origin_{};
  Point goal_{};
  bool gps_valid_ = false;
  bool imu_valid_ = false;
  bool origin_set_ = false;
  double heading_ = 0.0;
  std::vector<Point> lidar_obstacles_;
  std::vector<PathPoint> path_;
  size_t path_index_ = 0;
  AutonomyTask task_ = AUTONOMY_TASK_UNDEFINED;
  bool active_ = false;
  bool allow_hardware_drive_ = true;
  bool simulation_mode_ = false;
  double throttle_ = MAX_THROTTLE;
  CurvedPathPlanner planner_;
  rclcpp::Publisher<WrappedProtobuf>::SharedPtr drive_pub_;
  rclcpp::Publisher<WrappedProtobuf>::SharedPtr gps_sim_pub_;
  rclcpp::Publisher<WrappedProtobuf>::SharedPtr imu_sim_pub_;
  rclcpp::Publisher<WrappedProtobuf>::SharedPtr command_pub_;
  rclcpp::Publisher<WrappedProtobuf>::SharedPtr autonomy_pub_;
  rclcpp::Subscription<WrappedProtobuf>::SharedPtr command_sub_;
  rclcpp::Subscription<WrappedProtobuf>::SharedPtr gps_sub_;
  rclcpp::Subscription<WrappedProtobuf>::SharedPtr imu_sub_;
  rclcpp::Subscription<WrappedProtobuf>::SharedPtr sensor_sub_;
  rclcpp::TimerBase::SharedPtr timer_;
};

}  // namespace autonomy_ros2

int main(int argc, char ** argv)
{
  rclcpp::init(argc, argv);
  rclcpp::spin(std::make_shared<autonomy_ros2::AutonomyNode>());
  rclcpp::shutdown();
  return 0;
}
