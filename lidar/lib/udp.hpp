#include <netinet/in.h>

class UdpSocket {
  private:
    int socketHandle;
    int destPort;
    sockaddr_in address;

  public:
    UdpSocket(int destPort);
    ~UdpSocket();

    bool init();
    bool send(const uint8_t* data, size_t size);
};
