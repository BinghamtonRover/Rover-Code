import "package:meta/meta.dart";

import "package:burt_network/generated.dart";
import "dart:async";

import "proto_socket.dart";
import "socket_info.dart";

abstract class BurtUdpProtocol extends ProtoSocket {
  /// A timer to call [checkHeartbeats] every [heartbeatInterval].
  Timer? heartbeatTimer;

  /// How often to check for heartbeats.
  Duration get heartbeatInterval;

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

  bool get isConnected;
  void checkHeartbeats();
  void onHeartbeat(Connect heartbeat, SocketInfo source);
  void onMessage(WrappedMessage wrapper);
}
