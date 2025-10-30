import "dart:math";

import "package:autonomy/constants.dart";
import "package:autonomy/interfaces.dart";
import "package:autonomy/rover.dart";

/// State to manage the navigation of the rover
///
/// This state should be pushed after [PathingState], as it depends
/// on having a path already made for the rover to follow.
///
/// This state will manage following each individual step of the path as well
/// as performing necessary corrections and replanning.
///
/// When the path has to be replanned, this state will transition to [PathingState]
class NavigationState extends RoverState {
  /// The collection for the state
  final AutonomyInterface collection;

  /// The orchestrator for the state
  final RoverOrchestrator orchestrator;

  /// The final destination to navigate to
  final GpsCoordinates destination;

  /// Whether or not the state has performed pre-step correction
  bool hasCorrected = false;

  /// Whether or not the state has just completed following a path step
  bool hasFollowed = false;

  /// The index of the waypoint being followed
  int waypointIndex = 0;

  /// The current step of the path being followed
  AutonomyAStarState? get currentPathState {
    if (orchestrator.currentPath == null ||
        waypointIndex >= orchestrator.currentPath!.length) {
      return null;
    }
    return orchestrator.currentPath![waypointIndex];
  }

  /// Default constructor for [NavigationState]
  NavigationState(
    super.controller, {
    required this.collection,
    required this.orchestrator,
    required this.destination,
  });

  @override
  void enter() {
    waypointIndex = 0;
    hasCorrected = false;
    hasFollowed = false;

    orchestrator.currentState = AutonomyState.DRIVING;
  }

  /// Checks if the rover is oriented properly before driving the [state]
  ///
  /// This is assuming that the step's instruction is to drive forward.
  ///
  /// If the rover is not facing the proper direction, a new state will be pushed
  /// to re-correct the rover's orientation
  bool checkOrientation(AutonomyAStarState state) {
    Orientation targetOrientation;
    // if it has RTK, point towards the next coordinate
    if (collection.gps.coordinates.hasRTK) {
      final difference =
          state.position.toUTM() - collection.gps.coordinates.toUTM();

      final angle = atan2(difference.y, difference.x) * 180 / pi;

      targetOrientation = Orientation(z: angle);
    } else {
      targetOrientation = state.orientation.orientation;
    }

    if (!collection.imu.isNear(
      targetOrientation,
      Constants.driveRealignmentEpsilon,
    )) {
      collection.logger.info("Re-aligning IMU to correct orientation");
      controller.pushState(
        collection.drive.faceOrientationState(targetOrientation),
      );
      return true;
    }
    return false;
  }

  /// Checks if the rover is within a certain distance of [state]'s starting position
  ///
  /// If the rover is not within [Constants.replanErrorMeters] of the state's starting
  /// position, the path will be replanned
  bool checkPosition(AutonomyAStarState state) {
    final distanceError = collection.gps.coordinates.distanceTo(
      state.startPostition,
    );
    if (distanceError > Constants.replanErrorMeters) {
      collection.logger.info(
        "Replanning Path",
        body: "Rover is $distanceError meters off the path",
      );
      controller.transitionTo(
        PathingState(
          controller,
          collection: collection,
          orchestrator: orchestrator,
          destination: destination,
        ),
      );
      return true;
    }
    return false;
  }

  /// Check's the position and orientation of [state] before following it
  ///
  /// If the instruction of [state] is to move forward, it will check if the
  /// orientation is correct using [checkOrientation], otherwise, it will check
  /// the position using [checkPosition]
  bool checkCurrentPosition(AutonomyAStarState state) {
    if (state.instruction == DriveDirection.forward) {
      return checkOrientation(state);
    } else {
      return checkPosition(state);
    }
  }

  @override
  void update() {
    if (currentPathState == null) {
      controller.popState();
      return;
    }

    if (!hasCorrected) {
      hasCorrected = true;
      if (checkCurrentPosition(currentPathState!)) return;
    }

    if (!hasFollowed) {
      hasFollowed = true;
      collection.logger.debug(currentPathState!.toString());
      controller.pushState(collection.drive.driveStateState(currentPathState!));
      return;
    }

    orchestrator.traversed.add(currentPathState!.position);

    if (orchestrator.replanPath) {
      controller.transitionTo(
        PathingState(
          controller,
          collection: collection,
          orchestrator: orchestrator,
          destination: destination,
        ),
      );
      return;
    }

    if (waypointIndex >= orchestrator.currentPath!.length - 1 ||
        waypointIndex >= 5 ||
        orchestrator.findAndLockObstacles()) {
      controller.transitionTo(
        PathingState(
          controller,
          collection: collection,
          orchestrator: orchestrator,
          destination: destination,
        ),
      );
      return;
    }

    waypointIndex++;
    hasCorrected = false;
    hasFollowed = false;
  }

  @override
  void exit() {
    if (currentPathState != null) {
      orchestrator.traversed.add(currentPathState!.position);
    }
  }
}
