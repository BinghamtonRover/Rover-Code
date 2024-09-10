import "dart:io";

import "package:burt_network/burt_network.dart";

extension ServerUtils on RoverSocket {
  static SocketInfo subsystemsDestination = SocketInfo(
    address: InternetAddress("192.168.1.20"),
    port: 8001,
  );

  void sendCommand(Message message) => sendMessage(message, destination: subsystemsDestination);

  Future<void> waitForConnection() async {
    logger.info("Waiting for connection...");
    while (!isConnected) {
      await Future<void>.delayed(const Duration(milliseconds: 100));
    }
    return;
  }

  void sendDone() {
    final message = AutonomyData(state: AutonomyState.AT_DESTINATION, task: AutonomyTask.AUTONOMY_TASK_UNDEFINED);
    sendMessage(message);
  }
}
