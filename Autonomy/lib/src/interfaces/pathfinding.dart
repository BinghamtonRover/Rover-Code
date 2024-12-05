import "package:autonomy/interfaces.dart";
import "package:burt_network/generated.dart";

abstract class PathfindingInterface extends Service {
  final AutonomyInterface collection;
  PathfindingInterface({required this.collection});

  List<AutonomyAStarState>? getPath(GpsCoordinates destination, {bool verbose = false});

  Set<GpsCoordinates> obstacles = {};
  void recordObstacle(GpsCoordinates coordinates) => obstacles.add(coordinates);
  bool isObstacle(GpsCoordinates coordinates) => obstacles.any((obstacle) => obstacle.isNear(coordinates));

  @override
  Future<void> dispose() async {
    obstacles.clear();
  }
}
