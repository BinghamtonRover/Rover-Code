import "package:autonomy/autonomy.dart";

class NetworkDetector extends DetectorInterface {
  final List<GpsCoordinates> _newObstacles = [];
  bool _hasNewObstacles = false;

  NetworkDetector({required super.collection});

  @override
  Future<void> dispose() async {}

  @override
  bool findObstacles() {
    for (final obstacle in _newObstacles) {
      collection.pathfinder.recordObstacle(obstacle);
    }
    final newObstacles = _hasNewObstacles;
    _hasNewObstacles = false;

    _newObstacles.clear();

    return newObstacles;
  }

  @override
  Future<bool> init() async {
    collection.server.messages.listenFor(
      name: AutonomyData().messageName,
      constructor: AutonomyData.fromBuffer,
      callback: _onDataReceived,
    );
    return true;
  }

  void _onDataReceived(AutonomyData data) {
    if (data.obstacles.isNotEmpty) {
      _newObstacles.addAll(data.obstacles);
      _hasNewObstacles = true;
    }
  }

  @override
  bool isOnSlope() => false;
}
