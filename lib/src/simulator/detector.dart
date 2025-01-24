import "package:autonomy/interfaces.dart";
import "package:burt_network/protobuf.dart";

class SimulatedObstacle {
  final GpsCoordinates coordinates;
  final int radius;
  SimulatedObstacle({required this.coordinates, required this.radius});

  bool isNear(GpsCoordinates other) =>
    coordinates.distanceTo(other) <= radius;
}

class DetectorSimulator extends DetectorInterface {
  static const arucoPosition = (10, 10);
  static const slopedLatitude = -5;

  final List<SimulatedObstacle> obstacles;
  final Set<GpsCoordinates> found = {};

  DetectorSimulator({required super.collection, required this.obstacles});

  @override
  Future<bool> init() async => true;

  @override
  Future<void> dispose() async => obstacles.clear();

  @override
  bool findObstacles() {
    final coordinates = collection.gps.coordinates;
    var result = false;
    for (final obstacle in obstacles) {
      if (!obstacle.isNear(coordinates) || found.contains(obstacle.coordinates)) continue;
      result = true;
      found.add(obstacle.coordinates);
      collection.pathfinder.recordObstacle(obstacle.coordinates);
    }
    return result;
  }

  @override
  bool canSeeAruco() => false;  // if can see [arucoPosition]

  @override
  bool isOnSlope() => false;  // if on [slopedLatitude]
}
