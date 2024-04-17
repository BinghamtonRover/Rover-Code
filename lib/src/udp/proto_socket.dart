import "dart:io";

import "package:burt_network/generated.dart";

import "socket_info.dart";
import "udp_socket.dart";

/// A [UdpSocket] that speaks in Protobuf [Message]s, not bytes 
abstract class ProtoSocket extends UdpSocket {
  /// The rover device this socket represents. 
  final Device device;
  
  /// Creates a new UDP socket that uses Protobuf.
  ProtoSocket({
    required this.device,
    required super.port,
    super.quiet,
  });
  
  @override
  void onData(Datagram packet) {
    final wrapper = WrappedMessage.fromBuffer(packet.data);
    final source = SocketInfo(address: packet.address, port: packet.port);
    onWrapper(wrapper, source);
  }

  /// Sends an already-wrapped [WrappedMessage] to the [destination], or the given [destinationOverride].
  /// 
  /// Use this function instead of [sendMessage] if you need to manually wrap a message yourself.
  void sendWrapper(WrappedMessage wrapper, {SocketInfo? destinationOverride}) =>
    sendData(wrapper.writeToBuffer(), destinationOverride: destinationOverride);

  /// Wraps a message and sends it with [sendWrapper].
  void sendMessage(Message message, {SocketInfo? destinationOverride}) => 
    sendWrapper(message.wrap(), destinationOverride: destinationOverride);

  /// A callback for when messages are received.
  void onWrapper(WrappedMessage wrapper, SocketInfo source);
}
