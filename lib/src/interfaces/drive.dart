import "package:autonomy/interfaces.dart";

enum DriveDirection {
  forward, 
  left,
  right,
  stop,
}

abstract class DriveInterface extends Service {
  AutonomyInterface collection;
  DriveInterface({required this.collection});

  Future<void> goDirection(DriveDirection direction) async => switch (direction) {
    DriveDirection.forward => await goForward(),
    DriveDirection.left => await turnLeft(),
    DriveDirection.right => await turnRight(),
    DriveDirection.stop => await stop(),
  };
  
  Future<void> goForward();
  Future<void> turnLeft();
  Future<void> turnRight();
  Future<void> stop();

  Future<void> followPath(List<AutonomyAStarState> path) async {
    for (final state in path) {
      await goDirection(state.direction);
    }
  }
}
