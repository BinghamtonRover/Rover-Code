import "dart:async";
import "dart:io";

import "package:burt_network/burt_network.dart";
import "package:burt_network/logging.dart";
import "package:burt_network/protobuf.dart";
import "package:burt_network/service.dart";
import "package:video/video.dart";

class CommandForwarder extends Service {
  StreamSubscription<VideoCommand>? _commandSubscription;

  @override
  Future<bool> init() async {
    _commandSubscription = collection.videoServer.messages.onMessage(
      name: VideoCommand().messageName,
      constructor: VideoCommand.fromBuffer,
      callback: (data) {
        collection.videoServer.sendMessage(
          data,
          destination: SocketInfo(
            address: InternetAddress("192.168.1.60"),
            port: 8011,
          ),
        );
      },
    );

    return true;
  }

  @override
  Future<void> dispose() async {
    await _commandSubscription?.cancel();
    _commandSubscription = null;
  }
}

void main() async {
  Logger.level = LogLevel.all;
  collection.extraServices.add(CommandForwarder());
  await collection.init();
}
