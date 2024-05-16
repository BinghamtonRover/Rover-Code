import "dart:io";

import "package:autonomy/interfaces.dart";
import "package:burt_network/burt_network.dart";
import "package:meta/meta.dart";

final subsystemsDestination = SocketInfo(
  address: InternetAddress("192.168.1.20"),
  port: 8001,
);

abstract class ServerInterface extends RoverServer implements Service {
  final AutonomyInterface collection;
  ServerInterface({required this.collection, super.quiet = false}) : super(device: Device.AUTONOMY, port: 8003);

  void sendCommand(Message message) => sendMessage(message, destinationOverride: subsystemsDestination);

  @override
  Future<void> restart() => collection.restart();

  @override
  Future<void> onShutdown() => collection.dispose();

  Future<void> waitForConnection() async {
    collection.logger.info("Waiting for connection...");
    while (!isConnected) {
      await Future<void>.delayed(const Duration(milliseconds: 100));
    }
    return;
  }

  @override
  @mustCallSuper
  void onMessage(WrappedMessage wrapper) {
    if (wrapper.name == AutonomyCommand().messageName) {
      sendWrapper(wrapper);  // acknowledge receipt to the dashboard
      final command = AutonomyCommand.fromBuffer(wrapper.data);
      if (command.abort) {
        collection.orchestrator.abort();
        return;
      }
      if (collection.orchestrator.currentCommand != null) {
        collection.logger.error("Already executing a command", body: "Abort first if you want to switch tasks");
        return;
      }
      collection.orchestrator.onCommand(command);
    }
  }

  @override
  Future<void> onDisconnect() async {
    await collection.orchestrator.abort();
    super.onDisconnect();
  }
}
