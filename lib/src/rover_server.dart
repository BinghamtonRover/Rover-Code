import "dart:io";
import "package:meta/meta.dart";
import "package:burt_network/generated.dart";

import "rover_heartbeats.dart";
import "burt_protocol.dart";
import "rover_logger.dart";
import "socket_info.dart";

abstract class RoverServer extends BurtUdpProtocol with RoverHeartbeats, RoverLogger {
  RoverServer({
    required super.port, 
    required super.device,
    super.quiet,
  });
  
  @override
  void onWrapper(WrappedMessage wrapper, SocketInfo source) {
    if (wrapper.name == UpdateSetting().messageName) {
      final settings = UpdateSetting.fromBuffer(wrapper.data);
      updateSettings(settings);
    }
    super.onWrapper(wrapper, source);
  }

  @mustCallSuper
  void updateSettings(UpdateSetting settings) {
    sendMessage(settings);
    if (settings.status == RoverStatus.POWER_OFF) {
      logger.critical("Shutting down...");
      Process.run("sudo", ["shutdown", "now"]);
    } else if (settings.status == RoverStatus.RESTART) {
      restart();
    }
  }

  void restart();
}
