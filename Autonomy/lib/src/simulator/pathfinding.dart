import "package:autonomy/interfaces.dart";
import "package:burt_network/generated.dart";

class PathfindingSimulator extends PathfindingInterface {  
  static int i = 0;
  
  PathfindingSimulator({required super.collection});

  @override
  Future<bool> init() async => true;

  @override
  List<AutonomyAStarState> getPath(GpsCoordinates destination, {bool verbose = false}) => [
    AutonomyAStarState(depth: i++, goal: (2, 1).toGps(), position: (0, 0).toGps(), orientation: DriveOrientation.north, direction: DriveDirection.right, collection: collection),
    AutonomyAStarState(depth: i++, goal: (2, 1).toGps(), position: (0, 0).toGps(), orientation: DriveOrientation.east, direction: DriveDirection.forward, collection: collection),
    AutonomyAStarState(depth: i++, goal: (2, 1).toGps(), position: (0, 1).toGps(), orientation: DriveOrientation.east, direction: DriveDirection.forward, collection: collection),
    AutonomyAStarState(depth: i++, goal: (2, 1).toGps(), position: (0, 2).toGps(), orientation: DriveOrientation.east, direction: DriveDirection.left, collection: collection),
    AutonomyAStarState(depth: i++, goal: (2, 1).toGps(), position: (0, 2).toGps(), orientation: DriveOrientation.north, direction: DriveDirection.forward, collection: collection),
    AutonomyAStarState(depth: i++, goal: (2, 1).toGps(), position: (1, 2).toGps(), orientation: DriveOrientation.north, direction: DriveDirection.forward, collection: collection),
    AutonomyAStarState(depth: i++, goal: (2, 1).toGps(), position: (2, 2).toGps(), orientation: DriveOrientation.north, direction: DriveDirection.left, collection: collection),
    AutonomyAStarState(depth: i++, goal: (2, 1).toGps(), position: (2, 2).toGps(), orientation: DriveOrientation.west, direction: DriveDirection.forward, collection: collection),
    AutonomyAStarState(depth: i++, goal: (2, 1).toGps(), position: (2, 1).toGps(), orientation: DriveOrientation.west, direction: DriveDirection.right, collection: collection),
    AutonomyAStarState(depth: i++, goal: (2, 1).toGps(), position: (2, 1).toGps(), orientation: DriveOrientation.north, direction: DriveDirection.forward, collection: collection),
  ];
}
