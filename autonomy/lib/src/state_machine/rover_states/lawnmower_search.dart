import "package:autonomy/autonomy.dart";

/// A state that searches for an ArUco tag using a lawnmower pattern.
///
/// Generates a grid of waypoints centered on the rover's current position
/// and drives to each one in sequence, checking for the target after each leg.
/// Pops when the target is found or all waypoints are exhausted.
class LawnmowerSearch extends RoverState {
  final AutonomyInterface collection;
  final RoverOrchestrator orchestrator;
  final int arucoId;
  final CameraName? desiredCamera;

  LawnmowerSearch(
    super.controller, {
    required this.collection,
    required this.orchestrator,
    required this.arucoId,
    this.desiredCamera,
  });

  @override
  void enter() {
    final waypoints = orchestrator.generateLawnmowerWaypoints(
      collection.gps.coordinates,
    );

    final steps = <StateInterface>[];
    for (final waypoint in waypoints) {
      steps.add(
        _LawnmowerPathingState(
          controller,
          collection: collection,
          orchestrator: orchestrator,
          destination: waypoint,
        ),
      );
      steps.add(
        FunctionalState(
          controller,
          onEnter: (controller) {
            if (collection.video.getArucoDetection(
                  arucoId,
                  desiredCamera: desiredCamera,
                ) !=
                null) {
              controller.popUntil<LawnmowerSearch>();
              controller.popState();
              return;
            }
            controller.popState();
          },
        ),
      );
    }

    controller.transitionTo(SequenceState(controller, steps: steps));
  }
}

/// A pathing state that plans to its own [destination] rather than
/// [currentCommand.destination].
class _LawnmowerPathingState extends RoverState {
  final AutonomyInterface collection;
  final RoverOrchestrator orchestrator;
  final GpsCoordinates destination;

  _LawnmowerPathingState(
    super.controller, {
    required this.collection,
    required this.orchestrator,
    required this.destination,
  });

  @override
  void update() {
    final path = collection.pathfinder.getPath(destination);
    orchestrator.currentPath = path;

    if (path == null) {
      collection.logger.warning(
        "Lawnmower: no path to waypoint, skipping",
        body: destination.prettyPrint(),
      );
      controller.popState();
      return;
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
