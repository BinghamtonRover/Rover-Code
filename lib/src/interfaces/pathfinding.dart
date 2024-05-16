import "package:autonomy/interfaces.dart";
import "package:burt_network/generated.dart";

abstract class PathfindingInterface extends Service {
  final AutonomyInterface collection;
  PathfindingInterface({required this.collection});

  List<AutonomyAStarState>? getPath(GpsCoordinates destination);

  final Set<GpsCoordinates> obstacles = {};
  void recordObstacle(GpsCoordinates coordinates) => obstacles.add(coordinates);
  bool isObstacle(GpsCoordinates coordinates) => obstacles.contains(coordinates);

  @override
  Future<void> dispose() async {
    obstacles.clear();
  }
}
