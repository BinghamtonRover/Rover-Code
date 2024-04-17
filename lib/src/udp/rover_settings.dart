import "dart:io";

import "package:meta/meta.dart";
import "package:burt_network/generated.dart";

import "socket_info.dart";
import "burt_protocol.dart";

/// A mixin that handles [UpdateSetting] commands.
mixin RoverSettings on BurtUdpProtocol {
  @override
  void onWrapper(WrappedMessage wrapper, SocketInfo source) {
    if (wrapper.name == UpdateSetting().messageName) {
      final settings = UpdateSetting.fromBuffer(wrapper.data);
      updateSettings(settings);
    } else {
      super.onWrapper(wrapper, source);
    }
  }

  /// Handles an [UpdateSetting] command and updates the appropriate setting.
  /// 
  /// Also sends a handshake response to indicate the message was received.
  @mustCallSuper
  Future<void> updateSettings(UpdateSetting settings) async {
    sendMessage(settings);
    if (settings.status == RoverStatus.POWER_OFF) {
      logger.critical("Shutting down...");
      try {
        await onShutdown().timeout(const Duration(seconds: 5));
      } catch (error) {
        logger.critical("Error when shutting down: $error");
      }
      if (!Platform.isLinux) exit(0);
      await Process.run("sudo", ["shutdown", "now"]);
    } else if (settings.status == RoverStatus.RESTART) {
      await restart();
    }
  }

  /// Restarts this program, usually by disposing and re-initializing the collection.
  Future<void> restart();
  
  /// Shuts down the program by disposing the collection.
  /// 
  /// This gives any other parts of the rover a chance to shut down as well. For example,
  /// if the Subsystems program shuts down, the drive firmware would continue out of control.
  /// Overriding this function gives it the chance to stop the firmware first.
  Future<void> onShutdown();
}
