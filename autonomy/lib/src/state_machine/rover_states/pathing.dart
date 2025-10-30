import "package:autonomy/autonomy.dart";

/// State for when the rover is finding a path
///
/// When ran the state will attempt to plan a path to its given [destination],
/// if successful, it will transition to [NavigationState], if unsuccessful,
/// it will be popped from the stack.
class PathingState extends RoverState {
  /// The autonomy collection for the state
  final AutonomyInterface collection;

  /// The orchestrator for the state
  final RoverOrchestrator orchestrator;

  /// The destination to plan a path to
  final GpsCoordinates destination;

  /// Default constructor for [PathingState]
  PathingState(
    super.controller, {
    required this.collection,
    required this.orchestrator,
    required this.destination,
  });

  @override
  void enter() {
    orchestrator.replanPath = false;
    orchestrator.currentState = AutonomyState.PATHING;
    orchestrator.findAndLockObstacles();
  }

  @override
  void update() {
    final current = collection.gps.coordinates;
    orchestrator.currentPath = collection.pathfinder.getPath(
      orchestrator.currentCommand!.destination,
    );
    if (orchestrator.currentPath == null) {
      collection.logger.error(
        "Could not find a path",
        body:
            "No path found from ${current.prettyPrint()} to ${destination.prettyPrint()}",
      );
      collection.drive.stop();
      controller.popState();
    } else {
      collection.logger.debug(
        "Found a path from ${current.prettyPrint()} to ${destination.prettyPrint()}: ${orchestrator.currentPath!.length} steps",
      );
      collection.logger.debug("Here is a summary of the path");
      for (final step in orchestrator.currentPath!) {
        collection.logger.debug(step.toString());
      }
      controller.transitionTo(
        NavigationState(
          controller,
          collection: collection,
          orchestrator: orchestrator,
          destination: destination,
        ),
      );
    }
  }
}
