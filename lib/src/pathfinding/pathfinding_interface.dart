import "package:autonomy/constants.dart";
import "package:autonomy/interfaces.dart";

abstract class PathfindingInterface extends Service {
  final AutonomyInterface collection;
  PathfindingInterface({required this.collection});

  List<AutonomyAStarState>? getPath(
    GpsCoordinates destination, {
    bool verbose = false,
  });

  Set<GpsCoordinates> obstacles = {};
  final Set<GpsCoordinates> _lockedObstacles = {};

  Set<GpsCoordinates> get lockedObstacles => _lockedObstacles;

  void recordObstacle(GpsCoordinates coordinates) => obstacles.add(coordinates);

  void lockObstacle(GpsCoordinates coordinates) {
    _lockedObstacles.add(coordinates);
    obstacles.remove(coordinates);
  }

  bool isObstacle(GpsCoordinates coordinates) =>
      obstacles.any(
        (obstacle) =>
            obstacle.isNear(coordinates, Constants.obstacleAvoidanceRadius),
      ) ||
      _lockedObstacles.any(
        (obstacle) =>
            obstacle.isNear(coordinates, Constants.obstacleAvoidanceRadius),
      );

  @override
  Future<void> dispose() async {
    obstacles.clear();
  }
}
