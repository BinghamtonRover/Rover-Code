import "dart:io";

/// JSON data as a map.
typedef Json = Map<String, dynamic>;

/// Information about a socket.
class SocketInfo {
  /// The IP address of this socket.
  InternetAddress address;
  /// The port that the socket is connected to.
  int port;
  
  /// A const constructor.
  SocketInfo({required this.address, required this.port}); 

  /// Use this constructor to pass in a raw String for the address.
  SocketInfo.raw(String host, this.port) : address = InternetAddress(host);

  /// Parses the socket data from a YAML map.
  SocketInfo.fromJson(Json yaml) : 
    address = InternetAddress(yaml["host"]),
    port = yaml["port"];

  /// This socket's configuration in JSON format.
  Json toJson() => {
    "host": address.address,
    "port": port,
  };

  /// A copy of this configuration, to avoid modifying the original.
  SocketInfo copy() => SocketInfo(address: address, port: port);

  @override
  String toString() => "${address.address}:$port";
}
