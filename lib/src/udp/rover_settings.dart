import "dart:io";

import "package:burt_network/protobuf.dart";

import "burt_socket.dart";

/// A mixin that handles [UpdateSetting] commands.
mixin RoverSettings on BurtSocket {
  /// Whether this code is being run in a test environment.
  static bool isTest = false;

  /// Handles an [UpdateSetting] command and updates the appropriate setting.
  ///
  /// Also sends a handshake response to indicate the message was received.
  @override
  Future<void> onSettings(UpdateSetting settings) async {
    sendMessage(settings);
    if (settings.status == RoverStatus.POWER_OFF) {
      logger.critical("Shutting down...");
      try {
        await collection?.dispose().timeout(const Duration(seconds: 5));
      } catch (error) {
        logger.critical("Error when shutting down: $error");
      }
      if (!Platform.isLinux || isTest) return;
      await Process.run("sudo", ["shutdown", "now"]);
    } else if (settings.status == RoverStatus.RESTART) {
      await restart();
    }
  }

  /// Restarts this program, usually by disposing and re-initializing the collection.
  Future<void> restart() async {
    await collection?.dispose();
    await collection?.init();
  }
}
