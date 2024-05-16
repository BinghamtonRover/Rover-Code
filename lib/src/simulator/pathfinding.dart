import "package:autonomy/interfaces.dart";
import "package:burt_network/generated.dart";

class PathfindingSimulator extends PathfindingInterface {
  PathfindingSimulator({required super.collection});

  @override
  Future<bool> init() async => true;

  @override
  List<AutonomyAStarState> getPath(GpsCoordinates destination) => [
    AutonomyAStarState(goal: (2, 1).toGps(), position: (0, 0).toGps(), orientation: OrientationUtils.north, direction: DriveDirection.right, collection: collection),
    AutonomyAStarState(goal: (2, 1).toGps(), position: (0, 0).toGps(), orientation: OrientationUtils.east, direction: DriveDirection.forward, collection: collection),
    AutonomyAStarState(goal: (2, 1).toGps(), position: (0, 1).toGps(), orientation: OrientationUtils.east, direction: DriveDirection.forward, collection: collection),
    AutonomyAStarState(goal: (2, 1).toGps(), position: (0, 2).toGps(), orientation: OrientationUtils.east, direction: DriveDirection.left, collection: collection),
    AutonomyAStarState(goal: (2, 1).toGps(), position: (0, 2).toGps(), orientation: OrientationUtils.north, direction: DriveDirection.forward, collection: collection),
    AutonomyAStarState(goal: (2, 1).toGps(), position: (1, 2).toGps(), orientation: OrientationUtils.north, direction: DriveDirection.forward, collection: collection),
    AutonomyAStarState(goal: (2, 1).toGps(), position: (2, 2).toGps(), orientation: OrientationUtils.north, direction: DriveDirection.left, collection: collection),
    AutonomyAStarState(goal: (2, 1).toGps(), position: (2, 2).toGps(), orientation: OrientationUtils.west, direction: DriveDirection.forward, collection: collection),
    AutonomyAStarState(goal: (2, 1).toGps(), position: (2, 1).toGps(), orientation: OrientationUtils.west, direction: DriveDirection.right, collection: collection),
    AutonomyAStarState(goal: (2, 1).toGps(), position: (2, 1).toGps(), orientation: OrientationUtils.north, direction: DriveDirection.forward, collection: collection),
  ];
}
