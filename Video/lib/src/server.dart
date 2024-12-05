import "dart:io";

import "package:burt_network/burt_network.dart";

import "collection.dart";

/// The socket to send autonomy data to.
final autonomySocket = SocketInfo(address: InternetAddress("192.168.1.30"), port: 8003);

/// Class for the video program to interact with the dashboard
class VideoServer extends RoverServer {
  /// Requires a port to communicate through
  VideoServer({required super.port}) : super(device: Device.VIDEO);

  @override
  void onMessage(WrappedMessage wrapper) {
    // ignore message if not a video message
    if (wrapper.name != VideoCommand().messageName) return;
    final command = VideoCommand.fromBuffer(wrapper.data);
    sendMessage(command);  // Echo the request
    if (command.details.name == CameraName.ROVER_FRONT) {
      // ROVER_FRONT is on the same camera as AUTONOMY_DEPTH
      command.details.name = CameraName.AUTONOMY_DEPTH;
    }
    collection.parent.send(data: command, id: command.details.name);
  }

  /// Sends the depth frame to [autonomySocket].
  void sendDepthFrame(VideoData frame) => 
    sendMessage(frame, destinationOverride: autonomySocket);

  @override
  Future<void> restart() => collection.restart();

  @override
  Future<void> onShutdown() => collection.dispose();
}
