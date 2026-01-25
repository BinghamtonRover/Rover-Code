import "dart:math";

import "package:a_star/a_star.dart";
import "package:autonomy/constants.dart";

import "package:autonomy/interfaces.dart";

class AutonomyAStarState extends AStarState<AutonomyAStarState> {
  static double getCost(DriveDirection direction) {
    if (direction == DriveDirection.stop) {
      return 0;
    }
    if (direction == DriveDirection.forward) {
      return 1;
    } else if (direction == DriveDirection.quarterLeft ||
        direction == DriveDirection.quarterRight) {
      return sqrt2;
    } else {
      return 2 * sqrt2;
    }
  }

  final DriveDirection instruction;
  final GpsCoordinates position;
  final CardinalDirection orientation;
  final GpsCoordinates goal;
  final AutonomyInterface collection;

  GpsCoordinates get startPostition {
    if (instruction != DriveDirection.forward) {
      return position;
    }

    return position.goForward(orientation.turnRight().turnRight());
  }

  AutonomyAStarState({
    required this.position,
    required this.goal,
    required this.collection,
    required this.instruction,
    required this.orientation,
    required super.depth,
  });

  factory AutonomyAStarState.start({
    required AutonomyInterface collection,
    required GpsCoordinates goal,
  }) => AutonomyAStarState(
    position: collection.gps.coordinates,
    goal: goal,
    collection: collection,
    instruction: DriveDirection.stop,
    orientation: collection.imu.nearest,
    depth: 0,
  );

  AutonomyAStarState copyWith({
    required DriveDirection direction,
    required CardinalDirection orientation,
    required GpsCoordinates position,
  }) => AutonomyAStarState(
    collection: collection,
    position: position,
    orientation: orientation,
    instruction: direction,
    goal: goal,
    depth: depth + getCost(direction),
  );

  @override
  String toString() => switch (instruction) {
    DriveDirection.forward => "Go forward to ${position.prettyPrint()}",
    DriveDirection.left => "Turn left to face $instruction",
    DriveDirection.right => "Turn right to face $instruction",
    DriveDirection.stop => "Start/Stop at ${position.prettyPrint()}",
    DriveDirection.quarterLeft => "Turn 45 degrees left to face $instruction",
    DriveDirection.quarterRight => "Turn 45 degrees right to face $instruction",
  };

  @override
  double heuristic() => position.octileDistance(goal);

  @override
  String hash() => "${position.prettyPrint()} ($orientation) ($instruction)";

  @override
  bool isGoal() => position.isNear(
    goal,
    min(Constants.moveLengthMeters, Constants.maxErrorMeters),
  );

  /// Returns whether or not the rover will drive between or right next to an obstacle diagonally<br/>
  /// <br/>
  /// Example 1:<br/>
  /// 0 X<br/>
  /// X R<br/>
  /// Assuming the rover is facing 0 and trying to drive forward, will return false<br/>
  /// <br/>
  /// Example 2:<br/>
  /// 0 0<br/>
  /// X R<br/>
  /// Assuming the rover is facing 0 and trying to drive forward, will return false<br/>
  /// <br/>
  bool willDriveThroughObstacle(AutonomyAStarState state) {
    // Can't hit an obstacle while turning
    final isTurn = state.instruction != DriveDirection.forward;
    // Forward drive across the perpendicular axis
    final isPerpendicular = state.orientation.isPerpendicular;
    if (isTurn || isPerpendicular) {
      return false;
    }

    final orientation1 = state.orientation.turnQuarterLeft();
    final orientation2 = state.orientation.turnQuarterRight();

    // Since the state being passed has a position of moving after the
    // turn, we have to check the position of where it started (our current position)
    return collection.pathfinder.isObstacle(position.goForward(orientation1)) ||
        collection.pathfinder.isObstacle(position.goForward(orientation2));
  }

  bool isValidState(AutonomyAStarState state) =>
      !(state.instruction == DriveDirection.forward &&
          collection.pathfinder.isObstacle(state.position)) &&
      !willDriveThroughObstacle(state);

  Iterable<AutonomyAStarState> _allNeighbors() => [
    copyWith(
      direction: DriveDirection.forward,
      orientation: orientation,
      position: position.goForward(orientation),
    ),
    copyWith(
      direction: DriveDirection.left,
      orientation: orientation.turnLeft(),
      position: position,
    ),
    copyWith(
      direction: DriveDirection.right,
      orientation: orientation.turnRight(),
      position: position,
    ),
    copyWith(
      direction: DriveDirection.quarterLeft,
      orientation: orientation.turnQuarterLeft(),
      position: position,
    ),
    copyWith(
      direction: DriveDirection.quarterRight,
      orientation: orientation.turnQuarterRight(),
      position: position,
    ),
    copyWith(
      direction: DriveDirection.stop,
      orientation: orientation,
      position: position,
    ),
  ];

  @override
  Iterable<AutonomyAStarState> expand() => _allNeighbors().where(isValidState);
}
