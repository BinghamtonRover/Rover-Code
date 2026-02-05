import "package:autonomy/interfaces.dart";

class RoverDetector extends DetectorInterface {
  RoverDetector({required super.collection});

  @override
  bool isOnSlope() => false;

  @override
  bool findObstacles() => false;

  @override
//  bool canSeeAruco() => collection.video.data.arucoDetected == BoolState.YES;
	bool canSeeAruco() => collection.video.flag;

  @override
  Future<bool> init() async => true;

  @override
  Future<void> dispose() async { }
}
