import "dart:async";
import "dart:io";

import "package:burt_network/burt_network.dart";
import "package:video/video.dart";

class CommandForwarder extends Service {
  StreamSubscription<VideoCommand>? _commandSubscription;

  @override
  Future<bool> init() async {
    _commandSubscription = collection.videoServer.messages.listenFor(
      name: VideoCommand().messageName,
      constructor: VideoCommand.fromBuffer,
      callback: (data) {
        // echo the command back to the dashboard
        collection.videoServer.sendMessage(data);
        // forward to auxillary program
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
  await collection.init(
    config: VideoConfig(
      supportedCameras: CameraName.values.toSet().difference({
        CameraName.BOTTOM_LEFT,
        CameraName.BOTTOM_RIGHT,
      }).toList(),
    ),
  );
}
