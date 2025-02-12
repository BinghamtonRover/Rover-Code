#include "udp.hpp"
  #include <errno.h>
  #include <iostream>

#ifdef __linux__ 
  #include <netinet/in.h>
  #include <string.h>
  #include <sys/socket.h>
  #include <sys/types.h>
  #include <unistd.h>
#elif _WIN32
  #include <windows.h>
#else
#endif



UdpSocket::UdpSocket(int destPort) : destPort(destPort) { }

UdpSocket::~UdpSocket() {
  close(socketHandle);
}

bool UdpSocket::init() {
  socketHandle = socket(AF_INET, SOCK_DGRAM, 0);
  memset(&address, 0, sizeof(sockaddr_in));
  address.sin_family = AF_INET;
  address.sin_port = htons(destPort);
  address.sin_addr.s_addr = INADDR_ANY;
  return socketHandle != -1;
}

bool UdpSocket::send(const uint8_t* data, size_t size) {
  auto addressPtr = (const struct sockaddr*) &address;
  return sendto(socketHandle, data, size, MSG_CONFIRM, addressPtr, sizeof(address)) != -1;
}
