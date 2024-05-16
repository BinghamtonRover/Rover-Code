import "package:a_star/a_star.dart";

import "package:burt_network/generated.dart";
import "package:autonomy/interfaces.dart";

class AutonomyAStarState extends AStarState<AutonomyAStarState> {
  final DriveDirection direction;
  final GpsCoordinates position;
  final GpsCoordinates goal;
  final Orientation orientation;
  final AutonomyInterface collection;
  AutonomyAStarState({
    required this.position, 
    required this.goal, 
    required this.orientation,
    required this.collection,
    required this.direction,
  });

  @override
  String toString() => switch(direction) {
    DriveDirection.forward => "Go forward to ${position.prettyPrint()}",
    DriveDirection.left => "Turn left to face ${orientation.heading}",
    DriveDirection.right => "Turn right to face ${orientation.heading}",
    DriveDirection.stop => "Start/Stop at ${position.prettyPrint()}",
  };

  @override
  double heuristic() {
    var result = (position.latitude - goal.latitude).abs() + (position.longitude - goal.longitude).abs();
    if (goal.latitude > position.latitude) {
      result += switch (orientation.heading) {
        0 => 0,
        90 => 1, 
        270 => 1,
        180 => 2,
        _ => throw StateError("Unrecognized orientation: ${orientation.heading}"),
      };
    } else if (goal.latitude < position.latitude) {
      result += switch (orientation.heading) {
        0 => 2,
        90 => 1, 
        270 => 1,
        180 => 0,
        _ => throw StateError("Unrecognized orientation: ${orientation.heading}"),
      };
    }
    return result;
  }

  @override
  String hash() => "${position.latitude},${position.longitude}-${orientation.z}";

  @override
  bool isGoal() => position.isNear(goal);

  AutonomyAStarState copyWith(DriveDirection direction, {GpsCoordinates? position, Orientation? orientation}) => AutonomyAStarState(
    position: position ?? this.position, 
    orientation: orientation ?? this.orientation,
    collection: collection,
    direction: direction,
    goal: goal, 
  );

  @override
  Iterable<AutonomyAStarState> expand() => [
    copyWith(DriveDirection.left, orientation: orientation.turnLeft()),
    copyWith(DriveDirection.right, orientation: orientation.turnRight()),
    copyWith(DriveDirection.forward, position: position.goForward(orientation)),
  ].where((state) => !collection.pathfinder.isObstacle(state.position));
}
