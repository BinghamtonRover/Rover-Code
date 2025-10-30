import "package:autonomy/interfaces.dart";

class PathfindingSimulator extends PathfindingInterface {
  static int i = 0;

  PathfindingSimulator({required super.collection});

  @override
  Future<bool> init() async => true;

  @override
  List<AutonomyAStarState> getPath(
    GpsCoordinates destination, {
    bool verbose = false,
  }) => [
    AutonomyAStarState(
      depth: i++,
      goal: (lat: 2, long: 1).toGps(),
      position: (lat: 0, long: 0).toGps(),
      orientation: CardinalDirection.north,
      instruction: DriveDirection.right,
      collection: collection,
    ),
    AutonomyAStarState(
      depth: i++,
      goal: (lat: 2, long: 1).toGps(),
      position: (lat: 0, long: 0).toGps(),
      orientation: CardinalDirection.east,
      instruction: DriveDirection.forward,
      collection: collection,
    ),
    AutonomyAStarState(
      depth: i++,
      goal: (lat: 2, long: 1).toGps(),
      position: (lat: 0, long: 1).toGps(),
      orientation: CardinalDirection.east,
      instruction: DriveDirection.forward,
      collection: collection,
    ),
    AutonomyAStarState(
      depth: i++,
      goal: (lat: 2, long: 1).toGps(),
      position: (lat: 0, long: 2).toGps(),
      orientation: CardinalDirection.east,
      instruction: DriveDirection.left,
      collection: collection,
    ),
    AutonomyAStarState(
      depth: i++,
      goal: (lat: 2, long: 1).toGps(),
      position: (lat: 0, long: 2).toGps(),
      orientation: CardinalDirection.north,
      instruction: DriveDirection.forward,
      collection: collection,
    ),
    AutonomyAStarState(
      depth: i++,
      goal: (lat: 2, long: 1).toGps(),
      position: (lat: 1, long: 2).toGps(),
      orientation: CardinalDirection.north,
      instruction: DriveDirection.forward,
      collection: collection,
    ),
    AutonomyAStarState(
      depth: i++,
      goal: (lat: 2, long: 1).toGps(),
      position: (lat: 2, long: 2).toGps(),
      orientation: CardinalDirection.north,
      instruction: DriveDirection.left,
      collection: collection,
    ),
    AutonomyAStarState(
      depth: i++,
      goal: (lat: 2, long: 1).toGps(),
      position: (lat: 2, long: 2).toGps(),
      orientation: CardinalDirection.west,
      instruction: DriveDirection.forward,
      collection: collection,
    ),
    AutonomyAStarState(
      depth: i++,
      goal: (lat: 2, long: 1).toGps(),
      position: (lat: 2, long: 1).toGps(),
      orientation: CardinalDirection.west,
      instruction: DriveDirection.right,
      collection: collection,
    ),
    AutonomyAStarState(
      depth: i++,
      goal: (lat: 2, long: 1).toGps(),
      position: (lat: 2, long: 1).toGps(),
      orientation: CardinalDirection.north,
      instruction: DriveDirection.forward,
      collection: collection,
    ),
  ];
}
