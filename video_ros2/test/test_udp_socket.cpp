#include <arpa/inet.h>
#include <sys/socket.h>
#include <unistd.h>

#include <cstdint>
#include <cstring>
#include <string>
#include <thread>

#include "gtest/gtest.h"

#include "video_ros2/udp_socket.hpp"

namespace video_ros2
{
namespace
{

constexpr size_t kMaxPacketSize = 1024;

class UdpSocketTest : public ::testing::Test
{
protected:
  void SetUp() override
  {
    // Create a UDP socket bound to an ephemeral port on localhost.
    fd_ = ::socket(AF_INET, SOCK_DGRAM, 0);
    ASSERT_GE(fd_, 0);

    sockaddr_in addr{};
    addr.sin_family = AF_INET;
    addr.sin_port = 0;
    addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);

    ASSERT_EQ(::bind(fd_, reinterpret_cast<const sockaddr *>(&addr), sizeof(addr)), 0);

    socklen_t len = sizeof(addr);
    ASSERT_EQ(::getsockname(fd_, reinterpret_cast<sockaddr *>(&addr), &len), 0);
    port_ = ntohs(addr.sin_port);
  }

  void TearDown() override
  {
    if (fd_ >= 0) {
      ::close(fd_);
    }
  }

  int fd_ = -1;
  uint16_t port_ = 0;
};

TEST_F(UdpSocketTest, SendToLocalEcho)
{
  UdpSocket sender;
  ASSERT_TRUE(sender.setDestination("127.0.0.1", port_));

  const std::string message = "Hello, UDP!";
  ASSERT_TRUE(sender.send(message.data(), message.size()));

  char buffer[kMaxPacketSize] = {};
  sockaddr_in from_addr{};
  socklen_t from_len = sizeof(from_addr);
  ssize_t received = ::recvfrom(
    fd_, buffer, sizeof(buffer), 0,
    reinterpret_cast<sockaddr *>(&from_addr), &from_len);

  ASSERT_EQ(received, static_cast<ssize_t>(message.size()));
  EXPECT_EQ(std::string(buffer, received), message);
}

TEST_F(UdpSocketTest, SendStringOverload)
{
  UdpSocket sender;
  ASSERT_TRUE(sender.setDestination("127.0.0.1", port_));

  const std::string message = "String overload test";
  ASSERT_TRUE(sender.send(message));

  char buffer[kMaxPacketSize] = {};
  sockaddr_in from_addr{};
  socklen_t from_len = sizeof(from_addr);
  ssize_t received = ::recvfrom(
    fd_, buffer, sizeof(buffer), 0,
    reinterpret_cast<sockaddr *>(&from_addr), &from_len);

  ASSERT_EQ(received, static_cast<ssize_t>(message.size()));
  EXPECT_EQ(std::string(buffer, received), message);
}

TEST_F(UdpSocketTest, SendToArbitraryDestination)
{
  UdpSocket sender;
  const std::string message = "SendTo test";
  ASSERT_TRUE(sender.sendTo("127.0.0.1", port_, message.data(), message.size()));

  char buffer[kMaxPacketSize] = {};
  sockaddr_in from_addr{};
  socklen_t from_len = sizeof(from_addr);
  ssize_t received = ::recvfrom(
    fd_, buffer, sizeof(buffer), 0,
    reinterpret_cast<sockaddr *>(&from_addr), &from_len);

  ASSERT_EQ(received, static_cast<ssize_t>(message.size()));
  EXPECT_EQ(std::string(buffer, received), message);
}

TEST_F(UdpSocketTest, HasDestination)
{
  UdpSocket sender;
  EXPECT_FALSE(sender.hasDestination());
  ASSERT_TRUE(sender.setDestination("127.0.0.1", port_));
  EXPECT_TRUE(sender.hasDestination());
}

}  // namespace
}  // namespace video_ros2
