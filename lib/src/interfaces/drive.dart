import "package:autonomy/interfaces.dart";
import "package:burt_network/generated.dart";

enum DriveDirection {
  forward, 
  left,
  right,
  stop,
}

enum DriveOrientation {
  north(0),
  west(90),
  south(180),
  east(270);

  final int angle;
  const DriveOrientation(this.angle);

  static DriveOrientation? fromRaw(Orientation orientation) {
    // TODO: Make this more precise.
    for (final value in values) {
      if (orientation.isNear(value.angle.toDouble())) return value;
    }
    return null;
  }

  DriveOrientation turnLeft() => switch (this) {
    north => west,
    west => south,
    south => east,
    east => north,
  };

  DriveOrientation turnRight() => switch (this) {
    north => east,
    west => north,
    south => west,
    east => south,
  };
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
