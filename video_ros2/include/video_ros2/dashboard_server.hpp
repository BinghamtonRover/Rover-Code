#ifndef VIDEO_ROS2_DASHBOARD_SERVER_HPP_
#define VIDEO_ROS2_DASHBOARD_SERVER_HPP_

#include <atomic>
#include <chrono>
#include <cstdint>
#include <functional>
#include <mutex>
#include <string>
#include <thread>
#include <unordered_map>
#include <utility>
#include <vector>

#include "rclcpp/logger.hpp"

#include "subsystems_ros2/generated/wrapper.pb.h"

namespace video_ros2
{

/// Standalone implementation of the BURT dashboard-facing video protocol.
///
/// When the video node runs on its own host (e.g. a Raspberry Pi Zero 2 W
/// dedicated to cameras) there is no udp_bridge on that host to impersonate
/// the video program on UDP port 8002. This class speaks the same wire
/// protocol directly, so the Dashboard works without any changes:
///
/// - answers dashboard `Connect` handshakes addressed to Device::VIDEO,
/// - periodically sends `Connect` heartbeats and prunes silent clients,
/// - echoes `UpdateSetting` messages back to the sender to confirm receipt,
/// - hands every other message (e.g. `VideoCommand`) to a registered callback,
/// - broadcasts `VideoData` frames/status to every connected dashboard.
///
/// Several Pi Zero 2 W boards can run this server at the same time, each
/// streaming a different set of cameras; a dashboard connects to each board's
/// port independently, so there is no central video streamer.
class DashboardServer
{
public:
  /// Callback for dashboard messages that are not part of the connection
  /// protocol (e.g. `VideoCommand`). Receives the wrapped message plus the
  /// sender's address/port so callers can reply to that specific client.
  using MessageCallback =
    std::function<void (const WrappedMessage &, const std::string &, uint16_t)>;

  /// @param port UDP port to listen on (0 lets the OS choose, useful in tests).
  /// @param max_clients Maximum number of simultaneous dashboard connections.
  /// @param logger Logger used for diagnostics.
  DashboardServer(uint16_t port, int max_clients, rclcpp::Logger logger);
  ~DashboardServer();

  DashboardServer(const DashboardServer &) = delete;
  DashboardServer & operator=(const DashboardServer &) = delete;

  /// Bind the socket and start the receive/heartbeat thread.
  /// Returns false (and logs) if the port could not be bound.
  bool start();

  /// Stop the receive thread and close the socket. Safe to call twice.
  void stop();

  /// The port the socket is actually bound to (differs from the requested
  /// port only when constructed with 0).
  uint16_t port() const;

  /// Number of dashboards currently considered connected.
  size_t connectedClients() const;

  /// Register the callback invoked for non-protocol dashboard messages.
  /// Must be called before start().
  void setMessageCallback(MessageCallback callback);

  /// Send a wrapped message to one specific client.
  void sendTo(const WrappedMessage & message, const std::string & address, uint16_t port);

  /// Send a wrapped message to every connected dashboard.
  void broadcast(const WrappedMessage & message);

private:
  /// Receive/heartbeat loop; runs on its own thread.
  void receiveLoop();

  /// Parse and dispatch one datagram.
  void handlePacket(
    const uint8_t * data, size_t size, const std::string & address,
    uint16_t port);

  /// Prune silent clients and send heartbeats to the remaining ones.
  void maintainClients();

  /// One connected dashboard client.
  struct ClientInfo
  {
    std::string address;
    uint16_t port = 0;
    std::chrono::steady_clock::time_point last_heartbeat;
  };

  /// Copy of the currently connected clients.
  std::vector<ClientInfo> snapshotClients() const;

  /// Send raw bytes to one destination. Non-fatal on failure.
  bool sendRaw(const std::string & data, const std::string & address, uint16_t port);

  rclcpp::Logger logger_;
  uint16_t requested_port_ = 8002;
  uint16_t bound_port_ = 0;
  int max_clients_ = 5;
  int fd_ = -1;

  std::atomic<bool> running_{false};
  std::thread thread_;
  MessageCallback message_callback_;

  mutable std::mutex clients_mutex_;
  // Keyed by "ip:port".
  std::unordered_map<std::string, ClientInfo> clients_;
};

}  // namespace video_ros2

#endif  // VIDEO_ROS2_DASHBOARD_SERVER_HPP_
