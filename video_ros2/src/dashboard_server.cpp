#include "video_ros2/dashboard_server.hpp"

#include <arpa/inet.h>
#include <netdb.h>
#include <poll.h>
#include <sys/socket.h>
#include <unistd.h>

#include <cerrno>
#include <chrono>
#include <thread>

#include <cstring>
#include <utility>

#include "rclcpp/rclcpp.hpp"

#include "subsystems_ros2/generated/core.pb.h"
#include "subsystems_ros2/generated/status.pb.h"

namespace video_ros2
{

namespace
{

std::string endpointKey(const std::string & address, uint16_t port)
{
  return address + ":" + std::to_string(port);
}

/// Wrap a protobuf message the way the BURT protocol expects (name + payload).
/// Mirrors subsystems_ros2::wrapMessage, which is not exported in a header the
/// video package can include.
WrappedMessage wrapMessage(const google::protobuf::Message & message)
{
  WrappedMessage wrapper;
  wrapper.set_name(message.GetDescriptor()->full_name());
  wrapper.set_data(message.SerializeAsString());
  return wrapper;
}

}  // namespace

DashboardServer::DashboardServer(uint16_t port, int max_clients, rclcpp::Logger logger)
: logger_(logger), requested_port_(port), max_clients_(max_clients)
{
}

DashboardServer::~DashboardServer()
{
  stop();
}

uint16_t DashboardServer::port() const
{
  return bound_port_;
}

void DashboardServer::setMessageCallback(MessageCallback callback)
{
  message_callback_ = std::move(callback);
}

bool DashboardServer::start()
{
  if (running_.load()) {
    return true;
  }

  fd_ = ::socket(AF_INET, SOCK_DGRAM, 0);
  if (fd_ < 0) {
    RCLCPP_ERROR(logger_, "DashboardServer: could not create UDP socket: %s", strerror(errno));
    return false;
  }

  // Allow quick restarts of the node (e.g. when it is restarted remotely).
  int reuse = 1;
  ::setsockopt(fd_, SOL_SOCKET, SO_REUSEADDR, &reuse, sizeof(reuse));

  sockaddr_in address{};
  address.sin_family = AF_INET;
  address.sin_addr.s_addr = htonl(INADDR_ANY);
  address.sin_port = htons(requested_port_);
  if (::bind(fd_, reinterpret_cast<sockaddr *>(&address), sizeof(address)) < 0) {
    RCLCPP_ERROR(
      logger_, "DashboardServer: could not bind UDP port %u: %s",
      requested_port_, strerror(errno));
    ::close(fd_);
    fd_ = -1;
    return false;
  }

  socklen_t length = sizeof(address);
  if (::getsockname(fd_, reinterpret_cast<sockaddr *>(&address), &length) == 0) {
    bound_port_ = ntohs(address.sin_port);
  }

  clients_.clear();
  running_.store(true);
  thread_ = std::thread([this]() {receiveLoop();});

  RCLCPP_INFO(
    logger_, "DashboardServer: serving the dashboard protocol on UDP port %u",
    static_cast<unsigned>(bound_port_));
  return true;
}

void DashboardServer::stop()
{
  if (!running_.exchange(false)) {
    return;
  }
  if (thread_.joinable()) {
    thread_.join();
  }
  if (fd_ >= 0) {
    ::close(fd_);
    fd_ = -1;
  }
  bound_port_ = 0;
  {
    std::lock_guard<std::mutex> lock(clients_mutex_);
    clients_.clear();
  }
}

size_t DashboardServer::connectedClients() const
{
  std::lock_guard<std::mutex> lock(clients_mutex_);
  return clients_.size();
}

bool DashboardServer::sendRaw(
  const std::string & data, const std::string & address, uint16_t port)
{
  if (fd_ < 0) {
    return false;
  }

  // Resolve numerically first (the common case for a rover on a LAN).
  sockaddr_in destination{};
  destination.sin_family = AF_INET;
  destination.sin_port = htons(port);
  if (::inet_pton(AF_INET, address.c_str(), &destination.sin_addr) == 1) {
    return ::sendto(
             fd_, data.data(), data.size(), 0,
             reinterpret_cast<const sockaddr *>(&destination),
             sizeof(destination)) == static_cast<ssize_t>(data.size());
  }

  // Fall back to name resolution for hostnames.
  addrinfo hints{};
  hints.ai_family = AF_INET;
  hints.ai_socktype = SOCK_DGRAM;
  addrinfo * result = nullptr;
  if (::getaddrinfo(
      address.c_str(), std::to_string(port).c_str(), &hints, &result) == 0 && result)
  {
    const bool sent = ::sendto(
                        fd_, data.data(), data.size(), 0, result->ai_addr,
                        static_cast<socklen_t>(result->ai_addrlen)) ==
                      static_cast<ssize_t>(data.size());
    ::freeaddrinfo(result);
    return sent;
  }
  return false;
}

void DashboardServer::sendTo(
  const WrappedMessage & message, const std::string & address, uint16_t port)
{
  sendRaw(message.SerializeAsString(), address, port);
}

void DashboardServer::broadcast(const WrappedMessage & message)
{
  const std::string data = message.SerializeAsString();
  for (const ClientInfo & client : snapshotClients()) {
    sendRaw(data, client.address, client.port);
  }
}

std::vector<DashboardServer::ClientInfo> DashboardServer::snapshotClients() const
{
  std::vector<ClientInfo> snapshot;
  std::lock_guard<std::mutex> lock(clients_mutex_);
  snapshot.reserve(clients_.size());
  for (const auto & [key, entry] : clients_) {
    (void)key;
    snapshot.push_back(entry);
  }
  return snapshot;
}

void DashboardServer::receiveLoop()
{
  // Heartbeat pacing mirrors the Dart RoverSocket (every 2 seconds).
  auto last_maintenance = std::chrono::steady_clock::now();

  std::vector<uint8_t> buffer(65535);
  while (running_.load()) {
    // Wait for a packet (or the poll timeout) instead of busy-spinning: on a
    // Pi Zero 2 W a hot receive loop steals CPU from the JPEG encoder.
    pollfd fds{};
    fds.fd = fd_;
    fds.events = POLLIN;
    const int ready = ::poll(&fds, 1, 200);

    if (ready > 0) {
      sockaddr_in sender{};
      socklen_t sender_length = sizeof(sender);
      ssize_t received = ::recvfrom(
        fd_, buffer.data(), buffer.size(), MSG_DONTWAIT,
        reinterpret_cast<sockaddr *>(&sender), &sender_length);

      if (received > 0) {
        char address_buffer[INET_ADDRSTRLEN] = {0};
        ::inet_ntop(AF_INET, &sender.sin_addr, address_buffer, sizeof(address_buffer));
        handlePacket(
          buffer.data(), static_cast<size_t>(received), address_buffer,
          ntohs(sender.sin_port));
      }
    } else if (ready < 0 && errno != EINTR) {
      // Socket closed or erroring; stop if we are shutting down, otherwise
      // back off briefly so a persistent error cannot spin the CPU.
      if (!running_.load()) {
        break;
      }
      std::this_thread::sleep_for(std::chrono::milliseconds(100));
    }

    auto now = std::chrono::steady_clock::now();
    if (now - last_maintenance >= std::chrono::seconds(2)) {
      maintainClients();
      last_maintenance = now;
    }
  }
}

void DashboardServer::handlePacket(
  const uint8_t * data, size_t size, const std::string & address, uint16_t port)
{
  WrappedMessage wrapper;
  if (!wrapper.ParseFromArray(data, static_cast<int>(size))) {
    RCLCPP_WARN(logger_, "DashboardServer: received a malformed UDP packet");
    return;
  }

  const std::string key = endpointKey(address, port);

  if (wrapper.name() == Connect::descriptor()->full_name()) {
    Connect heartbeat;
    if (!heartbeat.ParseFromString(wrapper.data())) {
      return;
    }
    if (heartbeat.receiver() == Device::VIDEO) {
      {
        std::lock_guard<std::mutex> lock(clients_mutex_);
        ClientInfo & entry = clients_[key];
        entry.address = address;
        entry.port = port;
        entry.last_heartbeat = std::chrono::steady_clock::now();
      }
      Connect response;
      response.set_sender(Device::VIDEO);
      response.set_receiver(heartbeat.sender());
      sendTo(wrapMessage(response), address, port);
    } else {
      RCLCPP_WARN(
        logger_, "DashboardServer: misaddressed heartbeat for %s from %s",
        Device_Name(heartbeat.receiver()).c_str(), key.c_str());
    }
    return;
  }

  if (wrapper.name() == UpdateSetting::descriptor()->full_name()) {
    // Confirm receipt by echoing the setting back, like the Dart programs do.
    UpdateSetting settings;
    if (settings.ParseFromString(wrapper.data())) {
      sendTo(wrapMessage(settings), address, port);
    }
    return;
  }

  if (message_callback_) {
    message_callback_(wrapper, address, port);
  }
}

void DashboardServer::maintainClients()
{
  std::vector<std::pair<std::string, uint16_t>> stale;
  {
    std::lock_guard<std::mutex> lock(clients_mutex_);
    if (clients_.empty()) {
      return;
    }
    const auto now = std::chrono::steady_clock::now();
    for (auto it = clients_.begin(); it != clients_.end();) {
      if (now - it->second.last_heartbeat > std::chrono::seconds(10)) {
        stale.emplace_back(it->second.address, it->second.port);
        it = clients_.erase(it);
      } else {
        ++it;
      }
    }
  }

  // Heartbeats are only sent while at least one dashboard is listening, and
  // only to the dashboards themselves (mirrors the udp_bridge behavior).
  if (stale.empty()) {
    Connect heartbeat;
    heartbeat.set_sender(Device::VIDEO);
    heartbeat.set_receiver(Device::DASHBOARD);
    broadcast(wrapMessage(heartbeat));
  }
}

}  // namespace video_ros2
