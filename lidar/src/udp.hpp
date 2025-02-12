#ifdef __linux__ 
  #include <netinet/in.h>
#elif _WIN32
  #include <winsock2.h>
#else
#endif


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
