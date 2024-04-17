import "package:meta/meta.dart";

import "package:burt_network/generated.dart";
import "dart:async";

import "proto_socket.dart";
import "socket_info.dart";

/// A UDP socket that implements the BURT communication protocol.
/// 
/// The protocol ensures devices connect by sending a [Connect] message to initiate a handshake.
/// This process is repeated periodically to create "heartbeats" that indicate the status of the
/// connection. 
/// 
/// - Override [isConnected] to indicate when this socket has successfully connected.
/// - Override [checkHeartbeats] to tell the socket how to check for incoming heartbeats.
/// - Override [onHeartbeat] to be notified of an incoming heartbeat.
/// - Override [onMessage] to be notified of a non-heartbeat message.
abstract class BurtUdpProtocol extends ProtoSocket {
  /// A timer to call [checkHeartbeats] every [heartbeatInterval].
  Timer? heartbeatTimer;

  /// How often to check for heartbeats.
  Duration get heartbeatInterval;

  /// Creates a UDP socket that implements the BURT communication protocols.
  BurtUdpProtocol({
    required super.port, 
    required super.device, 
    super.quiet,
  });

  @override
  Future<void> init() async {
    await super.init();
    heartbeatTimer = Timer.periodic(heartbeatInterval, (_) => checkHeartbeats());
  }

  @override
  Future<void> dispose() async {
    heartbeatTimer?.cancel();
    await super.dispose();
  }
  
  @override
  @mustCallSuper
  void onWrapper(WrappedMessage wrapper, SocketInfo source) {
    if (wrapper.name == Connect().messageName) {
      final heartbeat = Connect.fromBuffer(wrapper.data);
      onHeartbeat(heartbeat, source);
    } else {
      onMessage(wrapper);
    }
  }

  /// Whether the socket is connected to the intended device(s).
  bool get isConnected;
  /// Checks for incoming heartbeats from the intended device(s).
  /// 
  /// For example, on the rover, this waits for new heartbeats, but on the Dashboard,
  /// it sends heartbeats to every connected device.
  void checkHeartbeats();
  /// Handles an incoming heartbeat from another device.
  void onHeartbeat(Connect heartbeat, SocketInfo source);
  /// Handles a non-heartbeat message, usually containing data or commands.
  void onMessage(WrappedMessage wrapper);
}
