import "package:a_star/a_star.dart";

import "package:autonomy/interfaces.dart";
import "package:burt_network/burt_network.dart";
import "package:burt_network/protobuf.dart";

class RoverPathfinder extends PathfindingInterface {
  RoverPathfinder({required super.collection});

  @override
  Future<bool> init() async => true;

  @override
  List<AutonomyAStarState>? getPath(GpsCoordinates destination, {bool verbose = false}) {
    if (isObstacle(destination)) return null;
    final state = AutonomyAStarState.start(collection: collection, goal: destination);
    final result = aStar(state, verbose: verbose, limit: 50000);
    if (result == null) return null;
    final transitions = result.reconstructPath().toList();
    return transitions;
  }
}
