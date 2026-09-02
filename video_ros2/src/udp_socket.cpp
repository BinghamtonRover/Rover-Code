#include "video_ros2/udp_socket.hpp"

#include <arpa/inet.h>
#include <netdb.h>
#include <sys/socket.h>
#include <unistd.h>

#include <cstring>
#include <memory>
#include <string>

namespace video_ros2
{

class UdpSocket::Impl
{
public:
  Impl()
  : fd_(::socket(AF_INET, SOCK_DGRAM, 0))
  {
  }

  ~Impl()
  {
    if (fd_ >= 0) {
      ::close(fd_);
    }
  }

  bool setDestination(const std::string & host, uint16_t port)
  {
    addrinfo hints{};
    hints.ai_family = AF_INET;
    hints.ai_socktype = SOCK_DGRAM;

    addrinfo * result = nullptr;
    int err = ::getaddrinfo(host.c_str(), std::to_string(port).c_str(), &hints, &result);
    if (err != 0 || result == nullptr) {
      return false;
    }

    std::memcpy(&addr_, result->ai_addr, result->ai_addrlen);
    addr_len_ = result->ai_addrlen;
    has_destination_ = true;
    freeaddrinfo(result);
    return true;
  }

  bool send(const void * data, size_t size)
  {
    if (fd_ < 0 || !has_destination_) {
      return false;
    }
    ssize_t sent = ::sendto(
      fd_, static_cast<const char *>(data), size, 0,
      reinterpret_cast<const sockaddr *>(&addr_), addr_len_);
    return sent == static_cast<ssize_t>(size);
  }

  bool sendTo(const std::string & host, uint16_t port, const void * data, size_t size)
  {
    if (fd_ < 0) {
      return false;
    }
    addrinfo hints{};
    hints.ai_family = AF_INET;
    hints.ai_socktype = SOCK_DGRAM;

    addrinfo * result = nullptr;
    int err = ::getaddrinfo(host.c_str(), std::to_string(port).c_str(), &hints, &result);
    if (err != 0 || result == nullptr) {
      return false;
    }
    ssize_t sent = ::sendto(
      fd_, static_cast<const char *>(data), size, 0,
      result->ai_addr, result->ai_addrlen);
    freeaddrinfo(result);
    return sent == static_cast<ssize_t>(size);
  }

  bool hasDestination() const { return has_destination_; }

  int fd_ = -1;
  sockaddr_in addr_{};
  socklen_t addr_len_ = 0;
  bool has_destination_ = false;
};

UdpSocket::UdpSocket()
: impl_(std::make_unique<Impl>())
{
}

UdpSocket::~UdpSocket() = default;

bool UdpSocket::setDestination(const std::string & host, uint16_t port)
{
  return impl_->setDestination(host, port);
}

bool UdpSocket::send(const void * data, size_t size)
{
  return impl_->send(data, size);
}

bool UdpSocket::send(const std::string & data)
{
  return send(data.data(), data.size());
}

bool UdpSocket::sendTo(const std::string & host, uint16_t port, const void * data, size_t size)
{
  return impl_->sendTo(host, port, data, size);
}

bool UdpSocket::hasDestination() const
{
  return impl_->hasDestination();
}

}  // namespace video_ros2
