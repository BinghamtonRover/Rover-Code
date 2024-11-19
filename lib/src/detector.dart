import "dart:io";

import "package:burt_network/burt_network.dart";
import "package:cv/cv.dart";

final videoSocket = SocketInfo(address: InternetAddress.loopbackIPv4, port: 8002);

class ObjectDetector extends Service {
  @override
  Future<bool> init() async {
    collection.server.messages.onMessage<ImageAnalysisCommand>(
      name: ImageAnalysisCommand().messageName,
      constructor: ImageAnalysisCommand.fromBuffer,
      callback: _handleCommand,
    );
    // TODO: Open any resources needed by [analyzeFrame]
    return true;
  }

  void _handleCommand(ImageAnalysisCommand command) {
    final data = analyzeFrame(command.frame);
    collection.server.sendMessage(data, destination: videoSocket);
  }

  @override
  Future<void> dispose() async {
    // TODO: Clean up any resource you opened in [init]
  }

  ImageAnalysisData analyzeFrame(List<int> frame) {
    // TODO: Actually analyze this image
    return ImageAnalysisData();
  }
}
