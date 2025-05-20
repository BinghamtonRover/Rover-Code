import "dart:io";

import "package:burt_network/protobuf.dart";

import "burt_socket.dart";

/// A mixin that handles [UpdateSetting] commands.
mixin RoverSettings on BurtSocket {
  /// Whether this code is being run in a test environment.
  static bool isTest = false;

  /// Whether or not the socket's service is currently restarting
  ///
  /// If multiple restart commands come in too quickly,
  /// it could cause errors within the service, this ensures
  /// that only one restart happens at a time
  bool _isRestarting = false;

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
    if (_isRestarting) return;
    _isRestarting = true;
    await collection?.dispose();
    await collection?.init();
    _isRestarting = false;
  }
}
