import "package:a_star/a_star.dart";

import "package:burt_network/generated.dart";
import "package:autonomy/interfaces.dart";

class AutonomyAStarState extends AStarState<AutonomyAStarState> {
  final DriveDirection direction;
  final DriveOrientation orientation;
  final GpsCoordinates position;
  final GpsCoordinates goal;
  final AutonomyInterface collection;

  AutonomyAStarState({
    required this.position, 
    required this.goal, 
    required this.collection,
    required this.direction,
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
    direction: DriveDirection.stop, 
    orientation: collection.imu.orientation!, 
    depth: 0,
  );

  @override
  String toString() => switch(direction) {
    DriveDirection.forward => "Go forward to ${position.prettyPrint()}",
    DriveDirection.left => "Turn left to face $direction",
    DriveDirection.right => "Turn right to face $direction",
    DriveDirection.stop => "Start/Stop at ${position.prettyPrint()}",
  };

  @override
  double heuristic() => position.manhattanDistance(goal);

  @override
  String hash() => "${position.prettyPrint()} ($orientation)";

  @override
  bool isGoal() => position.isNear(goal);

  AutonomyAStarState copyWith({required DriveDirection direction, required DriveOrientation orientation, required GpsCoordinates position}) => AutonomyAStarState(
    collection: collection,
    position: position,
    orientation: orientation, 
    direction: direction,
    goal: goal, 
    depth: direction == DriveDirection.forward ? depth + 1 : depth + 2,
  );

  @override
  Iterable<AutonomyAStarState> expand() => [
    copyWith(direction: DriveDirection.forward, orientation: orientation, position: position.goForward(orientation)),
    copyWith(direction: DriveDirection.left, orientation: orientation.turnLeft(), position: position),
    copyWith(direction: DriveDirection.right, orientation: orientation.turnRight(), position: position),    
  ].where((state) => !collection.pathfinder.isObstacle(state.position));
}
