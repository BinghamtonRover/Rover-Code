#include <cstdlib>
#include <unistd.h>
#include <iostream>

#include "lidar.h"
#include "udp.hpp"

const int sleepDelay = 1;  // seconds
const int destinationPort = 8004;

int main() {
  // Open the UDP socket
  auto socket = UdpSocket(destinationPort);
  if (!socket.init()) {
    perror("Could not initialize UDP server");
  }
  std::cout << "Initialized UDP server" << std::endl;
  // Open the lidar
  auto lidar = new Lidar;
  init(lidar);
  sleep(15);  // init is actually async. TODO: better error-handling

  while (true) {
    // Check for errors and quit if there are any (the lidar has disconnected)
    updateStatus(lidar);
    if (lidar->statusCode != 0) {
      std::cout << "Error: Lidar status is "
        << lidar->statusCode << " ("
        << lidar->statusBuffer << ")" << std::endl;
      exit(1);
    }

    // Check for data and send them if there are any
    if (lidar->hasNewData) {
      auto angleData = lidar->angleData;
      auto buffer = reinterpret_cast<uint8_t*>(angleData);
      if (!socket.send(buffer, 271 * sizeof(double))) {
        perror("Could not send data over UDP");
      }
      auto coordinateData = lidar->coordinateData;
      buffer = reinterpret_cast<uint8_t*>(coordinateData);
      if (!socket.send(buffer, 542 * sizeof(double))) {
        perror("Could not send data over UDP");
      }
      lidar->hasNewData = false;
    }
    else{
      std::cout << "no data \n";
    }

    sleep(sleepDelay);
  }
}
