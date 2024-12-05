import "package:burt_network/burt_network.dart";
import "package:test/test.dart";

import "package:autonomy/interfaces.dart";
import "package:autonomy/rover.dart";
import "package:autonomy/simulator.dart";

void main() => group("[Pathfinding]", tags: ["path"], () {
  setUp(() => Logger.level = LogLevel.off);
  tearDown(() => Logger.level = LogLevel.off);

  test("Simple path from (0, 0) to (5, 5) exists", () {
    final simulator = AutonomySimulator();
    final destination = (5, 5).toGps();
    simulator.logger.info("Each step is ${GpsUtils.north.latitude.toStringAsFixed(5)}");
    simulator.logger.info("Going to ${destination.prettyPrint()}");
    simulator.pathfinder = RoverPathfinder(collection: simulator);  
    final path = simulator.pathfinder.getPath(destination);
    expect(path, isNotNull);
  });

  test("Small paths are efficient", () {
    final oldError = GpsUtils.maxErrorMeters;
    GpsUtils.maxErrorMeters = 1;
    final simulator = AutonomySimulator();

    // Plan a path from (0, 0) to (5, 5)
    simulator.pathfinder = RoverPathfinder(collection: simulator);  
    final destination = (5, 5).toGps();
    simulator.logger.info("Going to ${destination.prettyPrint()}");
    final path = simulator.pathfinder.getPath(destination);
    expect(path, isNotNull); if (path == null) return;

    var turnCount = 0;
    for (final step in path) {
      if (step.direction == DriveDirection.left || step.direction == DriveDirection.right) {
        turnCount++;
      }
      simulator.logger.trace(step.toString());
    }

    // start + 5 forward + 1 turn + 5 right = 12 steps
    expect(turnCount, 1);
    expect(path.length, 11);
    
    GpsUtils.maxErrorMeters = oldError;
  });
  
  test("Following path gets to the end", () async { 
    final simulator = AutonomySimulator();
    final destination = (5, 5).toGps();
    simulator.pathfinder = RoverPathfinder(collection: simulator);
    final path = simulator.pathfinder.getPath(destination);
    
    expect(path, isNotNull); if (path == null) return;
    expect(simulator.gps.isNear(GpsCoordinates()), isTrue);

    await simulator.drive.followPath(path);
    expect(simulator.gps.isNear(destination), isTrue);

    await simulator.dispose();
  });

  test("Avoid obstacles but reach the goal", () async {
    // Logger.level = LogLevel.all;
    final simulator = AutonomySimulator();
    final destination = (5, 0).toGps();
    simulator.pathfinder = RoverPathfinder(collection: simulator);
    simulator.pathfinder.recordObstacle((1, 0).toGps());
    simulator.pathfinder.recordObstacle((2, 0).toGps());
    final path = simulator.pathfinder.getPath(destination);
    expect(path, isNotNull); if (path == null) return;
    expect(path, isNotEmpty);
    for (final step in path) {
      simulator.logger.trace(step.toString());
      expect(simulator.pathfinder.isObstacle(step.position), isFalse);
    }
    expect(path.length, 10, reason: "1 Stop + 5 detour + 4 forward = 10 steps total");
    await simulator.drive.followPath(path);
    expect(simulator.gps.isNear(destination), isTrue);
    await simulator.dispose();
  });

  test("Stress test", () async {
    final oldError = GpsUtils.maxErrorMeters;
    GpsUtils.maxErrorMeters = 1;
    final simulator = AutonomySimulator();
    simulator.pathfinder = RoverPathfinder(collection: simulator);
    simulator.logger.trace("Starting from ${simulator.gps.coordinates.prettyPrint()}");
    simulator.logger.trace("Each step is +/- ${GpsUtils.north.prettyPrint()}");
    final destination = (1000, 1000).toGps();
    simulator.logger.info("Going to ${destination.prettyPrint()}");
    final path = simulator.pathfinder.getPath(destination);
    expect(path, isNotNull);
    await simulator.dispose();
    GpsUtils.maxErrorMeters = oldError;
  });

  test("Impossible paths are reported", () async {
    final simulator = AutonomySimulator();
    simulator.pathfinder = RoverPathfinder(collection: simulator);
    final destination = (5, 5).toGps();
    final obstacles = {
      (1, -1).toGps(),  (1, 0).toGps(),  (1, 1).toGps(),
      (0, -1).toGps(),   /* Rover */     (0, 1).toGps(),
      (-1, -1).toGps(), (-1, 0).toGps(), (-1, 1).toGps(),
    };
    for (final obstacle in obstacles) {
      simulator.pathfinder.recordObstacle(obstacle);
    }
    final path = simulator.pathfinder.getPath(destination);
    expect(path, isNull);
    await simulator.dispose();
  });
});
