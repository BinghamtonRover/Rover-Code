import "dart:typed_data";

import "package:burt_network/burt_network.dart";
import "package:autonomy/interfaces.dart";

/// A server to handle incoming [AutonomyCommand]s and send [AutonomyData]s.
class AutonomyServer extends ServerInterface {
  /// Creates an autonomy server at the given port.
  AutonomyServer({required super.collection});

  @override
  void onMessage(WrappedMessage wrapper) {
    if (wrapper.name == RoverPosition().messageName) {
      final message = RoverPosition.fromBuffer(wrapper.data);
      if (message.hasGps()) collection.gps.update(message.gps);
      if (message.hasOrientation()) collection.imu.update(message.orientation);
    } else if (wrapper.name == VideoData().messageName) {
      final message = VideoData.fromBuffer(wrapper.data);
      if (!message.hasFrame()) return;
      final buffer = Uint16List.fromList(message.frame);
      collection.realsense.updateFrame(buffer);
    }
    super.onMessage(wrapper);
  }

  @override
  Future<bool> init() async {
    await super.init();
    collection.logger.info("Initialized server");
    return true;
  }
}
