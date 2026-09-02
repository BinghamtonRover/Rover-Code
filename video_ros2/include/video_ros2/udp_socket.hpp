#ifndef VIDEO_ROS2_UDP_SOCKET_HPP_
#define VIDEO_ROS2_UDP_SOCKET_HPP_

#include <cstdint>
#include <memory>
#include <string>

namespace video_ros2
{

/// Minimal UDP sender that caches a resolved destination address.
class UdpSocket
{
public:
  UdpSocket();
  ~UdpSocket();

  /// Set the destination endpoint. Returns true on success.
  bool setDestination(const std::string & host, uint16_t port);

  /// Send a datagram to the configured destination. Returns true on success.
  bool send(const void * data, size_t size);

  /// Convenience overload for std::string / std::vector<uint8_t>.
  bool send(const std::string & data);

  /// Send to an arbitrary host/port without changing the cached destination.
  bool sendTo(const std::string & host, uint16_t port, const void * data, size_t size);

  /// Returns true if a valid destination has been configured.
  bool hasDestination() const;

private:
  class Impl;
  std::unique_ptr<Impl> impl_;
};

}  // namespace video_ros2

#endif  // VIDEO_ROS2_UDP_SOCKET_HPP_
