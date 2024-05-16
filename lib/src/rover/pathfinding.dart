import "package:a_star/a_star.dart";

import "package:autonomy/interfaces.dart";
import "package:burt_network/generated.dart";

class RoverPathfinder extends PathfindingInterface {
  RoverPathfinder({required super.collection});

  @override
  Future<bool> init() async => true;

  @override
  List<AutonomyAStarState>? getPath(GpsCoordinates destination) {
    if (isObstacle(destination)) return null;
    final state = AutonomyAStarState(
      position: collection.gps.coordinates,
      orientation: collection.imu.orientation,
      collection: collection,
      goal: destination,
      direction: DriveDirection.stop,
    );
    final result = aStar(state, verbose: false, limit: 10000);
    if (result == null) return null;
    final transitions = result.reconstructPath().toList();
    return transitions;
  }
}
