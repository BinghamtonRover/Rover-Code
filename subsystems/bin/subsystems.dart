import "dart:async";
import "dart:io";

import "package:burt_network/burt_network.dart";
import "package:subsystems/subsystems.dart";

/// Extra service to forward science data and commands to/from the auxillary board
class ScienceForwardService extends Service {
  StreamSubscription<ScienceCommand>? _commandSubscription;
  StreamSubscription<ScienceData>? _dataSubscription;

  @override
  Future<bool> init() async {
    _commandSubscription = collection.server.messages.onMessage(
      name: ScienceCommand().messageName,
      constructor: ScienceCommand.fromBuffer,
      callback: (command) => collection.server.sendMessage(
        command,
        destination: SocketInfo(
          address: InternetAddress("192.168.1.60"),
          port: 8010,
        ),
      ),
    );
    _dataSubscription = collection.server.messages.onMessage(
      name: ScienceData().messageName,
      constructor: (data) {
        try {
          return ScienceData.fromBuffer(data);
        } catch (_) {
          return ScienceData();
        }
      },
      callback: (data) => collection.server.sendMessage(data),
    );
    return true;
  }

  @override
  Future<void> dispose() async {
    await _commandSubscription?.cancel();
    await _dataSubscription?.cancel();
    _commandSubscription = null;
    _dataSubscription = null;
  }
}

void main() async {
  Logger.level = LogLevel.trace;
  collection.extraServices.add(ScienceForwardService());
  if (!await collection.init()) await collection.dispose();
}
