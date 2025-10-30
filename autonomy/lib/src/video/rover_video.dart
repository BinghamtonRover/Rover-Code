import "dart:async";

import "package:autonomy/constants.dart";
import "package:autonomy/interfaces.dart";
import "package:collection/collection.dart";

class RoverVideo extends VideoInterface {
  final List<VideoData> _cachedResults = [];

  RoverVideo({required super.collection});

  @override
  void updateFrame(VideoData result) {
    hasValue = true;
    if (result.hasFrame() && result.frame.isNotEmpty) return;

    _cachedResults.removeWhere((e) => e.details.name == result.details.name);
    if (result.detectedObjects.isEmpty) return;

    _cachedResults.add(result);
  }

  @override
  DetectedObject? getArucoDetection(int id, {CameraName? desiredCamera}) {
    for (final result in _cachedResults.where(
      (e) => e.details.name == (desiredCamera ?? e.details.name),
    )) {
      for (final object in result.detectedObjects) {
        if (object.objectType == DetectedObjectType.ARUCO &&
            object.arucoTagId == id) {
          return object;
        }
      }
    }
    return null;
  }

  @override
  Future<DetectedObject?> waitForAruco(
    int id, {
    CameraName? desiredCamera,
    Duration timeout = Constants.arucoSearchTimeout,
  }) async {
    final completer = Completer<DetectedObject>();

    late final StreamSubscription<VideoData> resultSubscription;

    resultSubscription = collection.server.messages.onMessage(
      name: VideoData().messageName,
      constructor: VideoData.fromBuffer,
      callback: (result) async {
        if (result.hasFrame() && result.frame.isNotEmpty) return;
        if (result.details.name != (desiredCamera ?? result.details.name)) {
          return;
        }
        final object = result.detectedObjects.firstWhereOrNull(
          (e) => e.objectType == DetectedObjectType.ARUCO && e.arucoTagId == id,
        );
        if (object != null) {
          await resultSubscription.cancel();
          completer.complete(object);
        }
      },
    );

    try {
      return await completer.future.timeout(timeout);
    } on TimeoutException {
      await resultSubscription.cancel();
      return null;
    }
  }
}
