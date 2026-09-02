#ifndef SUBSYSTEMS_ROS2_UTILS_HPP_
#define SUBSYSTEMS_ROS2_UTILS_HPP_

#include <memory>
#include <string>
#include <vector>
#include <google/protobuf/message.h>
#include "subsystems_ros2/generated/gps.pb.h"
#include "subsystems_ros2/generated/wrapper.pb.h"

namespace subsystems_ros2
{

constexpr int DEFAULT_PORT = 8001;
constexpr const char * GPS_PORT = "/dev/rover_gps";
constexpr const char * IMU_PORT = "/dev/rover_imu";

inline WrappedMessage wrapMessage(const google::protobuf::Message & message)
{
  WrappedMessage wrapper;
  wrapper.set_name(message.GetDescriptor()->full_name());
  wrapper.set_data(message.SerializeAsString());
  return wrapper;
}

// Convert an NMEA coordinate (DDMM.MMMM) to decimal degrees.
double nmeaToDecimal(double nmea_value);

// Parse an NMEA sentence and return GpsCoordinates, or nullptr if unsupported/invalid.
std::unique_ptr<GpsCoordinates> parseNmea(const std::string & sentence);

// Parse a null-terminated, 4-byte-padded OSC string starting at offset.
std::string parseOscString(const std::string & data, size_t & offset);

// Append a null-terminated, 4-byte-padded OSC string to a buffer.
void writeOscString(std::vector<uint8_t> & buffer, const std::string & str);

// Build a simple OSC message containing only string arguments.
std::vector<uint8_t> buildOscMessage(const std::string & address, const std::vector<std::string> & args);

}  // namespace subsystems_ros2

#endif  // SUBSYSTEMS_ROS2_UTILS_HPP_
