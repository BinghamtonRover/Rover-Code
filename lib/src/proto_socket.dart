import "dart:io";

import "package:burt_network/generated.dart";

import "socket_info.dart";
import "udp_socket.dart";

abstract class ProtoSocket extends UdpSocket {
  final Device device;
  
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

  void sendMessage(Message message, {SocketInfo? destinationOverride}) => 
    sendWrapper(message.wrap(), destinationOverride: destinationOverride);

  void onWrapper(WrappedMessage wrapper, SocketInfo source);
}
