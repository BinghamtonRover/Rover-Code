import "dart:async";

import "package:autonomy/constants.dart";
import "package:autonomy/interfaces.dart";

/// Handles obstacle detection data and ArUco data from video
abstract class VideoInterface extends Service with Receiver {
  final AutonomyInterface collection;
  StreamSubscription<VideoData>? _dataSubscription;

  VideoInterface({required this.collection});

  @override
  Future<bool> init() async {
    _dataSubscription = collection.server.messages.onMessage(
      name: VideoData().messageName,
      constructor: VideoData.fromBuffer,
      callback: updateFrame,
    );
    return true;
  }

  @override
  Future<void> dispose() async {
    await _dataSubscription?.cancel();
  }

  void updateFrame(VideoData result);

  DetectedObject? getArucoDetection(int id, {CameraName? desiredCamera}) =>
      null;

  Future<DetectedObject?> waitForAruco(
    int id, {
    CameraName? desiredCamera,
    Duration timeout = Constants.arucoSearchTimeout,
  }) => Future.value();
}
