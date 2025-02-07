
import "package:burt_network/protobuf.dart";

import "burt_socket.dart";
import "socket_info.dart";

/// A mixin that automatically handles rover-side heartbeats.
mixin RoverHeartbeats on BurtSocket {
  /// Whether this socket received a heartbeat since the last call to [checkHeartbeats].
  bool didReceivedHeartbeat = false;

  @override
  bool get isConnected => destination != null;

  @override
  Duration get heartbeatInterval => const Duration(seconds: 2);

  /// Handles incoming heartbeats.
  ///
  /// 1. If the heartbeat was meant for another device, log it and ignore it.
  /// 2. If it came from our dashboard, respond to it with [sendHeartbeatResponse].
  /// 3. If it came from another dashboard, log it and ignore it.
  /// 4. If we are not connected to any dashboard, call [onConnect] and respond to it.
  @override
  void onHeartbeat(Heartbeat heartbeat, SocketInfo source) {
    if (heartbeat.receiver != device) {  // (1)
      logger.warning("Received a misaddressed heartbeat for ${heartbeat.receiver}");
    } else if (isConnected) {
      if (destination == source) {  // (2)
        sendHeartbeatResponse();
      } else {  // (3)
        logger.warning("Port $port is connected to $destination but received a heartbeat from $source");
      }
    } else {  // (4)
      onConnect(source);
      sendHeartbeatResponse();
    }
  }

  /// Checks if a heartbeat has been received. If not, calls [onDisconnect].
  ///
  /// This function runs every [heartbeatInterval].
  @override
  Future<void> checkHeartbeats() async {
    if (didReceivedHeartbeat) {
      didReceivedHeartbeat = false;
    } else if (isConnected) {
      logger.warning("Heartbeat not received. Assuming the dashboard has disconnected");
      await onDisconnect();
    }
  }

  /// Responds to an incoming heartbeat.
  void sendHeartbeatResponse() {
    final response = Connect(sender: device, receiver: Device.DASHBOARD);
    sendMessage(response);
    didReceivedHeartbeat = true;
  }
}
