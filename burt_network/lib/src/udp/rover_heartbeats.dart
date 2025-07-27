
import "package:burt_network/protobuf.dart";

import "burt_socket.dart";
import "socket_info.dart";

/// A mixin that automatically handles rover-side heartbeats.
mixin RoverHeartbeats on BurtSocket {
  /// The heartbeats received by the socket since the last call to [checkHeartbeats].
  final Set<SocketInfo> receivedHeartbeats = {};

  /// Whether this socket received a heartbeat since the last call to [checkHeartbeats].
  bool get didReceivedHeartbeat => receivedHeartbeats.isNotEmpty;

  @override
  bool get isConnected => destinations.isNotEmpty;

  @override
  Duration get heartbeatInterval => const Duration(seconds: 2);

  /// Handles incoming heartbeats.
  ///
  /// 1. If the heartbeat was meant for another device, log it and ignore it.
  /// 2. If it came from an existing client, respond to it with [sendHeartbeatResponse].
  /// 3. If the number of clients is less than [maxClients], call [onConnect] and respond with [sendHeartbeatResponse].
  @override
  void onHeartbeat(Heartbeat heartbeat, SocketInfo source) {
    // (1)
    if (heartbeat.receiver != device) {
      logger.warning(
        "Received a misaddressed heartbeat for ${heartbeat.receiver}",
      );
      return;
    }

    // (2)
    if (destinations.contains(source)) {
      sendHeartbeatResponse(source);
    } else if (destinations.length < maxClients) {
      // (3)
      onConnect(source);
      sendHeartbeatResponse(source);
    } else {
      logger.warning(
        "Too many clients connected on port $port, ignoring connection from ${source.address.address}:${source.port}",
      );
    }
  }

  /// Checks if a heartbeat has been received from any destination. If not,
  /// sends a [Disconnect] message to any destination who has not sent any heartbeats.
  /// 
  /// If no heartbeats have been received, calls [onDisconnect].
  ///
  /// This function runs every [heartbeatInterval].
  @override
  Future<void> checkHeartbeats() async {
    final wasConnected = isConnected;
    destinations.removeWhere((address) {
      if (!receivedHeartbeats.contains(address)) {
        logger.warning(
          "Heartbeat not received from ${address.address.address}:${address.port}, assuming client has disconnected",
        );
        sendMessage(Disconnect(sender: device), destination: address);
        return true;
      }
      return false;
    });

    if (receivedHeartbeats.isNotEmpty) {
      receivedHeartbeats.clear();
    } else if (wasConnected) {
      logger.warning(
        "No heartbeats received. Assuming the dashboard has disconnected",
      );
      await onDisconnect();
    }
  }

  /// Responds to an incoming heartbeat from [source].
  void sendHeartbeatResponse(SocketInfo source) {
    final response = Connect(sender: device, receiver: Device.DASHBOARD);
    sendMessage(response, destination: source);
    receivedHeartbeats.add(source);
  }
}
