import "dart:math";

import "package:autonomy/constants.dart";
import "package:burt_network/burt_network.dart";
import "package:coordinate_converter/coordinate_converter.dart";
import "package:test/test.dart";

import "package:autonomy/interfaces.dart";
import "package:autonomy/rover.dart";
import "package:autonomy/simulator.dart";

import "test_util.dart";

void main() => group("[Pathfinding]", tags: ["path"], () {
  setUp(() => Logger.level = LogLevel.off);
  tearDown(() => Logger.level = LogLevel.off);

  test("Simple path from (0, 0) to (5, 5) exists", () {
    final simulator = AutonomySimulator();
    final destination = origin.plus(x: 5, y: 5);
    simulator.logger.info(
      "Each step is ${GpsUtils.northMeters.toGps().latitude.toStringAsFixed(5)}",
    );
    simulator.logger.info("Going to ${destination.prettyPrint()}");
    simulator.pathfinder = RoverPathfinder(collection: simulator);
    simulator.gps.update(origin);
    final path = simulator.pathfinder.getPath(destination);
    expect(path, isNotNull);
  });

  test("Small paths are efficient", () {
    final simulator = AutonomySimulator();

    // Plan a path from (0, 0) to (5, 5)
    simulator.pathfinder = RoverPathfinder(collection: simulator);
    final destination = origin.plus(x: 5, y: 5);
    simulator.logger.info("Going to ${destination.prettyPrint()}");
    simulator.gps.update(origin);
    final path = simulator.pathfinder.getPath(destination);
    expect(path, isNotNull);

    if (path == null) return;

    var turnCount = 0;
    for (final step in path) {
      if (step.instruction.isTurn) {
        turnCount++;
      }
      simulator.logger.trace(step.toString());
    }

    // start + 5 forward + 1 turn + 5 right = 12 steps
    // start + quarter turn left + 7 forward = 8 steps
    expect(turnCount, 1);
    expect(path.length, 7);
  });

  test("Avoid obstacles but reach the goal", () async {
    // Logger.level = LogLevel.all;
    final simulator = AutonomySimulator();
    final destination = origin.plus(x: 0, y: 5);
    simulator.pathfinder = RoverPathfinder(collection: simulator);
    simulator.pathfinder.recordObstacle(origin.plus(x: 0, y: 1));
    simulator.pathfinder.recordObstacle(origin.plus(x: 0, y: 2));
    simulator.gps.update(origin);
    final path = simulator.pathfinder.getPath(destination);
    expect(path, isNotNull);
    if (path == null) {
      return;
    }
    expect(path, isNotEmpty);
    for (final step in path) {
      simulator.logger.trace(step.toString());
      expect(simulator.pathfinder.isObstacle(step.position), isFalse);
    }
    expect(
      path.length,
      9,
      reason:
          "1 turn + 1 forward + 1 turn + 5 forward + 1 stop = 9 steps total",
    );
    expect(
      path.last.position.distanceTo(destination),
      lessThan(Constants.maxErrorMeters),
    );
  });

  test("Stress test", () async {
    final simulator = AutonomySimulator();
    simulator.pathfinder = RoverPathfinder(collection: simulator);
    simulator.logger.trace(
      "Starting from ${simulator.gps.coordinates.prettyPrint()}",
    );
    final destination = origin.plus(x: 1000, y: 1000);
    simulator.logger.info("Going to ${destination.prettyPrint()}");
    simulator.gps.update(origin);
    final path = simulator.pathfinder.getPath(destination);
    expect(path, isNotNull);
    await simulator.dispose();
  });

  test("Impossible paths are reported", () async {
    final simulator = AutonomySimulator();
    simulator.pathfinder = RoverPathfinder(collection: simulator);
    final destination = UTMCoordinates(x: 10, y: 10, zoneNumber: 31).toGps();
    final obstacles = {
      // dart format off
      origin.plus(x: -1, y: 1), origin.plus(x: 0, y: 1), origin.plus(x: 1, y: 1),
      origin.plus(x: -1, y: 0),       /* Rover */        origin.plus(x: 1, y: 0),
      origin.plus(x: -1, y: -1), origin.plus(x: 0, y: -1), origin.plus(x: 1, y: -1),
      // dart format on
    };
    for (final obstacle in obstacles) {
      simulator.pathfinder.recordObstacle(obstacle);
    }
    simulator.gps.update(origin);
    final path = simulator.pathfinder.getPath(destination);
    expect(path, isNull);
    await simulator.dispose();
  });

  group("diagonal turns", () {
    test("path chooses to move diagonally", () async {
      final simulator = AutonomySimulator();
      simulator.pathfinder = RoverPathfinder(collection: simulator);
      final destination = origin.plus(x: 5, y: 5);
      simulator.gps.update(origin);
      final path = simulator.pathfinder.getPath(destination);
      expect(path, isNotNull);
      expect(
        path!
            .where((state) => state.instruction == DriveDirection.forward)
            .length,
        5,
      );
      expect(path[1].instruction, DriveDirection.quarterRight);
      await simulator.dispose();
    });

    test("doesn't drive through an obstacle", () async {
      final simulator = AutonomySimulator();
      simulator.pathfinder = RoverPathfinder(collection: simulator);
      final destination = UTMCoordinates(x: 10, y: 10, zoneNumber: 31).toGps();
      final obstacles = {
        // dart format off
        origin.plus(x: 0, y: 1), /* Destination */
            /* Rover */         origin.plus(x: 1, y: 0),
        // dart format on
      };
      for (final obstacle in obstacles) {
        simulator.pathfinder.recordObstacle(obstacle);
      }
      simulator.gps.update(origin);
      final path = simulator.pathfinder.getPath(destination);
      expect(path, isNotNull);
      expect(
        path!
            .where((state) => state.instruction == DriveDirection.forward)
            .length,
        greaterThan(2),
      );
      await simulator.dispose();
    });

    test("doesn't drive through an obstacle", () async {
      final simulator = AutonomySimulator();
      simulator.pathfinder = RoverPathfinder(collection: simulator);
      final destination = UTMCoordinates(x: 10, y: 10, zoneNumber: 31).toGps();
      final obstacles = {
        origin /* Destination */,
        /* Rover */
      };
      for (final obstacle in obstacles) {
        simulator.pathfinder.recordObstacle(obstacle);
      }
      simulator.gps.update(origin);
      final path = simulator.pathfinder.getPath(destination);
      expect(path, isNotNull);
      expect(
        path!
            .where((state) => state.instruction == DriveDirection.forward)
            .length,
        greaterThan(1),
      );
      await simulator.dispose();
    });
  });

  group("optimizer", () {
    test("replaces equal and duplicate quarter turns", () async {
      final simulator = AutonomySimulator();
      final pathfinder = RoverPathfinder(collection: simulator);
      simulator.pathfinder = pathfinder;

      final originalPath = [
        AutonomyAStarState(
          position: UTMCoordinates(x: 0, y: 0, zoneNumber: 31).toGps(),
          goal: UTMCoordinates(x: 0, y: 0, zoneNumber: 31).toGps(),
          collection: simulator,
          instruction: DriveDirection.quarterLeft,
          orientation: CardinalDirection.northEast,
          depth: sqrt2,
        ),
        AutonomyAStarState(
          position: UTMCoordinates(x: 0, y: 0, zoneNumber: 31).toGps(),
          goal: UTMCoordinates(x: 0, y: 0, zoneNumber: 31).toGps(),
          collection: simulator,
          instruction: DriveDirection.quarterLeft,
          orientation: CardinalDirection.east,
          depth: sqrt2,
        ),
      ];
      final optimizedPath = pathfinder.optimizePath(originalPath);
      expect(optimizedPath.length, 1);
      expect(optimizedPath.first.instruction, DriveDirection.left);
      expect(optimizedPath.first.orientation, CardinalDirection.east);
      await simulator.dispose();
    });

    test("does not replace non-equal turns", () async {
      final simulator = AutonomySimulator();
      final pathfinder = RoverPathfinder(collection: simulator);
      simulator.pathfinder = pathfinder;

      final originalPath = [
        AutonomyAStarState(
          position: UTMCoordinates(x: 0, y: 0, zoneNumber: 31).toGps(),
          goal: UTMCoordinates(x: 0, y: 0, zoneNumber: 31).toGps(),
          collection: simulator,
          instruction: DriveDirection.quarterLeft,
          orientation: CardinalDirection.northEast,
          depth: sqrt2,
        ),
        AutonomyAStarState(
          position: UTMCoordinates(x: 0, y: 0, zoneNumber: 31).toGps(),
          goal: UTMCoordinates(x: 0, y: 0, zoneNumber: 31).toGps(),
          collection: simulator,
          instruction: DriveDirection.quarterRight,
          orientation: CardinalDirection.north,
          depth: sqrt2,
        ),
      ];
      final optimizedPath = pathfinder.optimizePath(originalPath);
      expect(optimizedPath.length, 2);
      expect(optimizedPath.first.instruction, DriveDirection.quarterLeft);
      expect(optimizedPath.first.orientation, CardinalDirection.northEast);
      await simulator.dispose();
    });
  });
});
