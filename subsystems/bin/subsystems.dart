import "dart:async";
import "dart:io";

import "package:burt_network/burt_network.dart";
import "package:subsystems/subsystems.dart";

/// Extra service to forward science data and commands to/from the auxillary board
class AuxillaryForwarder extends Service {
  StreamSubscription<WrappedMessage>? _commandSubscription;
  StreamSubscription<WrappedMessage>? _dataSubscription;

  @override
  Future<bool> init() async {
    _commandSubscription = collection.server.messages
        .where(
          (e) =>
              e.name == ArmCommand().messageName ||
              e.name == ScienceCommand().messageName,
        )
        .listen(
          (wrapper) => collection.server.sendWrapper(
            wrapper,
            destination: SocketInfo(
              address: InternetAddress("192.168.1.60"),
              port: 8010,
            ),
          ),
        );
    _dataSubscription = collection.server.messages
        .where(
          (e) =>
              e.name == ArmData().messageName ||
              e.name == ScienceData().messageName,
        )
        .listen(collection.server.sendWrapper);
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
  collection.extraServices.add(AuxillaryForwarder());
  if (!await collection.init()) await collection.dispose();
}
