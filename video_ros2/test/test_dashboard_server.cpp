#include <arpa/inet.h>
#include <sys/socket.h>
#include <unistd.h>

#include <atomic>
#include <cstdint>
#include <cstring>
#include <string>
#include <thread>
#include <vector>

#include "gtest/gtest.h"
#include "rclcpp/rclcpp.hpp"

#include "subsystems_ros2/generated/core.pb.h"
#include "subsystems_ros2/generated/status.pb.h"
#include "subsystems_ros2/generated/video.pb.h"
#include "subsystems_ros2/generated/wrapper.pb.h"

#include "video_ros2/dashboard_server.hpp"

namespace video_ros2
{
namespace
{

/// A fake dashboard: a plain UDP socket that can send requests to the server
/// and collect everything the server sends back.
class FakeDashboard
{
public:
  FakeDashboard()
  {
    fd_ = ::socket(AF_INET, SOCK_DGRAM, 0);
    sockaddr_in address{};
    address.sin_family = AF_INET;
    address.sin_port = 0;
    address.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
    ::bind(fd_, reinterpret_cast<const sockaddr *>(&address), sizeof(address));
    socklen_t length = sizeof(address);
    ::getsockname(fd_, reinterpret_cast<sockaddr *>(&address), &length);
    port_ = ntohs(address.sin_port);
  }

  ~FakeDashboard()
  {
    if (fd_ >= 0) {
      ::close(fd_);
    }
  }

  uint16_t port() const {return port_;}

  /// Send a wrapped message to the server.
  void send(const WrappedMessage & message, uint16_t server_port)
  {
    const std::string data = message.SerializeAsString();
    sockaddr_in address{};
    address.sin_family = AF_INET;
    address.sin_port = htons(server_port);
    address.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
    ::sendto(
      fd_, data.data(), data.size(), 0,
      reinterpret_cast<const sockaddr *>(&address), sizeof(address));
  }

  /// Wait for one message from the server (up to timeout_ms).
  bool receive(WrappedMessage & message, int timeout_ms = 2000)
  {
    timeval timeout{};
    timeout.tv_sec = timeout_ms / 1000;
    timeout.tv_usec = (timeout_ms % 1000) * 1000;
    fd_set read_fds;
    FD_ZERO(&read_fds);
    FD_SET(fd_, &read_fds);
    if (::select(fd_ + 1, &read_fds, nullptr, nullptr, &timeout) <= 0) {
      return false;
    }
    std::vector<char> buffer(65535);
    ssize_t received = ::recv(fd_, buffer.data(), buffer.size(), 0);
    if (received <= 0) {
      return false;
    }
    return message.ParseFromArray(buffer.data(), static_cast<int>(received));
  }

private:
  int fd_ = -1;
  uint16_t port_ = 0;
};

WrappedMessage wrap(const google::protobuf::Message & message)
{
  WrappedMessage wrapper;
  wrapper.set_name(message.GetDescriptor()->full_name());
  wrapper.set_data(message.SerializeAsString());
  return wrapper;
}

class DashboardServerTest : public ::testing::Test
{
protected:
  void SetUp() override
  {
    // Port 0 lets the OS pick an ephemeral port, avoiding conflicts in CI.
    server_ = std::make_unique<DashboardServer>(0, 5, rclcpp::get_logger("dashboard_server_test"));
    ASSERT_TRUE(server_->start());
    ASSERT_NE(server_->port(), 0);
  }

  void TearDown() override
  {
    server_->stop();
    server_.reset();
  }

  /// Perform the dashboard handshake so the server registers the client.
  void connect(FakeDashboard & dashboard)
  {
    Connect heartbeat;
    heartbeat.set_sender(Device::DASHBOARD);
    heartbeat.set_receiver(Device::VIDEO);
    dashboard.send(wrap(heartbeat), server_->port());

    WrappedMessage response;
    ASSERT_TRUE(dashboard.receive(response));
    EXPECT_EQ(response.name(), "Connect");
  }

  std::unique_ptr<DashboardServer> server_;
};

TEST_F(DashboardServerTest, HandshakeRegistersClient)
{
  FakeDashboard dashboard;

  Connect heartbeat;
  heartbeat.set_sender(Device::DASHBOARD);
  heartbeat.set_receiver(Device::VIDEO);
  dashboard.send(wrap(heartbeat), server_->port());

  EXPECT_EQ(server_->connectedClients(), 0u);
  WrappedMessage response;
  ASSERT_TRUE(dashboard.receive(response));
  EXPECT_EQ(response.name(), "Connect");

  Connect parsed;
  ASSERT_TRUE(parsed.ParseFromString(response.data()));
  EXPECT_EQ(parsed.sender(), Device::VIDEO);
  EXPECT_EQ(parsed.receiver(), Device::DASHBOARD);

  // The heartbeat response registers the dashboard as a client.
  // (poll briefly; the registration happens on the server thread)
  for (int i = 0; i < 20 && server_->connectedClients() == 0; ++i) {
    std::this_thread::sleep_for(std::chrono::milliseconds(10));
  }
  EXPECT_EQ(server_->connectedClients(), 1u);
}

TEST_F(DashboardServerTest, MisaddressedHeartbeatIsIgnored)
{
  FakeDashboard dashboard;

  // A heartbeat addressed to the subsystems program must not register this
  // dashboard with the video server.
  Connect heartbeat;
  heartbeat.set_sender(Device::DASHBOARD);
  heartbeat.set_receiver(Device::SUBSYSTEMS);
  dashboard.send(wrap(heartbeat), server_->port());

  WrappedMessage response;
  EXPECT_FALSE(dashboard.receive(response, 300));
  EXPECT_EQ(server_->connectedClients(), 0u);
}

TEST_F(DashboardServerTest, UpdateSettingIsEchoed)
{
  FakeDashboard dashboard;
  connect(dashboard);

  UpdateSetting settings;
  settings.set_status(RoverStatus::MANUAL);
  dashboard.send(wrap(settings), server_->port());

  WrappedMessage echo;
  ASSERT_TRUE(dashboard.receive(echo));
  EXPECT_EQ(echo.name(), "UpdateSetting");

  UpdateSetting parsed;
  ASSERT_TRUE(parsed.ParseFromString(echo.data()));
  EXPECT_EQ(parsed.status(), RoverStatus::MANUAL);
}

TEST_F(DashboardServerTest, CommandsReachTheMessageCallback)
{
  std::atomic<int> callback_count{0};
  std::atomic<bool> got_camera{false};
  server_->setMessageCallback(
    [&](const WrappedMessage & message, const std::string & address, uint16_t port) {
      (void)address;
      (void)port;
      if (message.name() == "VideoCommand") {
        VideoCommand command;
        if (command.ParseFromString(message.data()) &&
          command.details().name() == CameraName::ROVER_FRONT)
        {
          got_camera.store(true);
        }
      }
      callback_count.fetch_add(1);
    });

  FakeDashboard dashboard;
  connect(dashboard);

  VideoCommand command;
  command.mutable_details()->set_name(CameraName::ROVER_FRONT);
  command.set_take_snapshot(true);
  dashboard.send(wrap(command), server_->port());

  // The echo of the command is sent back to the callback registrant by the
  // node, not the server, so the server itself only counts the command.
  for (int i = 0; i < 50 && callback_count.load() == 0; ++i) {
    std::this_thread::sleep_for(std::chrono::milliseconds(10));
  }
  EXPECT_EQ(callback_count.load(), 1);
  EXPECT_TRUE(got_camera.load());
}

TEST_F(DashboardServerTest, BroadcastReachesAllClients)
{
  FakeDashboard first;
  FakeDashboard second;
  connect(first);
  connect(second);

  for (int i = 0; i < 20 && server_->connectedClients() < 2u; ++i) {
    std::this_thread::sleep_for(std::chrono::milliseconds(10));
  }
  ASSERT_EQ(server_->connectedClients(), 2u);

  VideoData frame;
  frame.set_id("ROVER_FRONT");
  server_->broadcast(wrap(frame));

  for (FakeDashboard * dashboard : {&first, &second}) {
    WrappedMessage message;
    ASSERT_TRUE(dashboard->receive(message));
    EXPECT_EQ(message.name(), "VideoData");
    VideoData parsed;
    ASSERT_TRUE(parsed.ParseFromString(message.data()));
    EXPECT_EQ(parsed.id(), "ROVER_FRONT");
  }
}

TEST_F(DashboardServerTest, StopIsIdempotent)
{
  server_->stop();
  server_->stop();
  EXPECT_EQ(server_->port(), 0);
}

}  // namespace
}  // namespace video_ros2
