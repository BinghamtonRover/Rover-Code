import "package:a_star/a_star.dart";

import "package:autonomy/interfaces.dart";

class RoverPathfinder extends PathfindingInterface {
  RoverPathfinder({required super.collection});

  @override
  Future<bool> init() async => true;

  List<AutonomyAStarState> optimizePath(Iterable<AutonomyAStarState> original) {
    final newPath = <AutonomyAStarState>[];
    AutonomyAStarState? previous;
    for (final step in original) {
      if (previous != null &&
          step.instruction.isQuarterTurn &&
          previous.instruction.isQuarterTurn &&
          step.instruction == previous.instruction) {
        newPath.last = AutonomyAStarState(
          position: previous.position,
          goal: previous.goal,
          collection: collection,
          instruction: step.instruction == DriveDirection.quarterLeft
              ? DriveDirection.left
              : DriveDirection.right,
          orientation: step.orientation,
          depth: step.depth,
        );
      } else {
        newPath.add(step);
      }
      previous = newPath.last;
    }

    return newPath;
  }

  @override
  List<AutonomyAStarState>? getPath(
    GpsCoordinates destination, {
    bool verbose = false,
  }) {
    if (isObstacle(destination)) return null;
    final state = AutonomyAStarState.start(
      collection: collection,
      goal: destination,
    );
    final result = aStar(state, verbose: verbose, limit: 50000);
    if (result == null) return null;
    final transitions = result.reconstructPath();
    final optimized = optimizePath(transitions);
    return optimized;
  }
}
