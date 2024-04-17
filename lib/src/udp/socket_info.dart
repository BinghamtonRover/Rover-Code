import "dart:io";
import "package:meta/meta.dart";

/// JSON data as a map.
typedef Json = Map<String, dynamic>;

/// Information about a socket.
@immutable
class SocketInfo {
  /// The IP address of this socket.
  final InternetAddress address;
  /// The port that the socket is connected to.
  final int port;
  
  /// A const constructor.
  const SocketInfo({required this.address, required this.port}); 

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
  SocketInfo copyWith({InternetAddress? address, int? port}) => SocketInfo(
    address: address ?? this.address, 
    port: port ?? this.port,
  );

  @override
  String toString() => "${address.address}:$port";

  @override
  bool operator ==(Object other) => other is SocketInfo 
    && address == other.address 
    && port == other.port;

  @override
  int get hashCode => Object.hash(address, port);
}
