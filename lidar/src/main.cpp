#include <cstdlib>
#ifdef __linux__ 
  #include <unistd.h>
#elif _WIN32
  #include <windows.h>
#else
#endif


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
  // Open the lidar
  auto lidar = new Lidar;
  init(lidar);
#if __linux__
  sleep(5);  // init is actually async. TODO: better error-handling
#elseif(WIN32)
  Sleep(5000);
#endif

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
      auto data = lidar->angleData;
      auto buffer = reinterpret_cast<uint8_t*>(data);
      if (!socket.send(buffer, 270 * sizeof(double))) {
        perror("Could not send data over UDP");
      }
    }

#if __linux__
    sleep(sleepDelay);  // init is actually async. TODO: better error-handling
#elseif(WIN32)
    Sleep(sleepDelay);
#endif
  }
}
