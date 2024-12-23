import "dart:async";

import "package:autonomy/interfaces.dart";
import "package:burt_network/burt_network.dart";

class RoverVideo extends VideoInterface {
  RoverVideo({required super.collection});

  @override
  Future<bool> init() async {
    collection.server.messages.onMessage(
      name: VideoData().messageName,
      constructor: VideoData.fromBuffer,
      callback: updateFrame,
    );
    return true;
  }

  @override
  Future<void> dispose() async { }

  @override
  void updateFrame(VideoData newData) {
    data = newData;
    // if (data.arucoDetected == BoolState.YES) {
    //   flag = true;
    //   Timer(const Duration(seconds: 3), () => flag = false);
    //   collection.logger.info("Is ArUco detected: ${data.arucoDetected}");
    // }
    hasValue  = true;
  }
}
