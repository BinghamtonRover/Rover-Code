import "package:test/test.dart";

import "package:burt_network/generated.dart";
import "package:burt_network/logging.dart";

import "package:autonomy/interfaces.dart";
import "package:autonomy/rover.dart";
import "package:autonomy/simulator.dart";

void main() {
  test("Rover can be restarted", () async { 
    Logger.level = LogLevel.off;
    final rover = RoverAutonomy();
    await rover.init();
    await rover.restart();
    await rover.dispose();
  });

  test("Real pathfinding is coherent", () async { 
    Logger.level = LogLevel.off;
    final simulator = AutonomySimulator();
    simulator.pathfinder = RoverPathfinder(collection: simulator);
    await testPath(simulator);
    simulator.gps.update((0, 0).toGps());
    simulator.imu.update(Orientation());
    await testPath2(simulator);
    await simulator.dispose();
  });

  
  test("Orchestrator gracefully fails for invalid destinations", () async {
    Logger.level = LogLevel.off;  // this test can log critical messages
    final simulator = AutonomySimulator();
    simulator.pathfinder = RoverPathfinder(collection: simulator);
    simulator.orchestrator = RoverOrchestrator(collection: simulator);
    simulator.pathfinder.recordObstacle((2, 0).toGps());
    // Test blocked command: 
    final command = AutonomyCommand(destination: (2, 0).toGps(), task: AutonomyTask.GPS_ONLY);
    expect(simulator.gps.latitude, 0);
    expect(simulator.gps.longitude, 0);
    expect(simulator.imu.heading, 0);
    await simulator.orchestrator.onCommand(command);
    expect(simulator.gps.latitude, 0);
    expect(simulator.gps.longitude, 0);
    expect(simulator.imu.heading, 0);
    final status2 = simulator.orchestrator.statusMessage;
    expect(status2.crash, isFalse);
    expect(status2.state, AutonomyState.NO_SOLUTION);
    expect(status2.task, AutonomyTask.AUTONOMY_TASK_UNDEFINED);
    expect(status2.destination, GpsCoordinates());
    await simulator.dispose();
  });

  
  test("Orchestrator works for GPS task", () async {
    Logger.level = LogLevel.off;  // this test can log critical messages
    final simulator = AutonomySimulator();
    simulator.pathfinder = RoverPathfinder(collection: simulator);
    simulator.orchestrator = RoverOrchestrator(collection: simulator);
    simulator.pathfinder.obstacles.addAll([
      (2, 0).toGps(),
      (4, -1).toGps(),
      (4, 1).toGps(),
    ]);
    await simulator.init();
    // Test normal command: 
    final command1 = AutonomyCommand(destination: (4, 0).toGps(), task: AutonomyTask.GPS_ONLY);
    expect(simulator.gps.latitude, 0);
    expect(simulator.gps.longitude, 0);
    expect(simulator.imu.heading, 0);
    await simulator.orchestrator.onCommand(command1);
    expect(simulator.gps.latitude, 4);
    expect(simulator.gps.longitude, 0);
    expect(simulator.imu.heading, 0);
    final status1 = simulator.orchestrator.statusMessage;
    expect(status1.crash, isFalse);
    expect(status1.task, AutonomyTask.AUTONOMY_TASK_UNDEFINED);
    expect(status1.destination, GpsCoordinates());
    expect(status1.obstacles, [
      (2, 0).toGps(),
      (4, -1).toGps(),
      (4, 1).toGps(),
    ]);
    expect(status1.state, AutonomyState.AT_DESTINATION);
    await simulator.dispose();
  });

  test("Stress test pathfinding", () async {
    Logger.level = LogLevel.off;
    final simulator = AutonomySimulator();
    simulator.pathfinder = RoverPathfinder(collection: simulator);
    final destination = (1000, 1000).toGps();
    final path = simulator.pathfinder.getPath(destination);
    expect(path, isNotNull);
    await simulator.dispose();
  });
}

Future<void> testPath(AutonomyInterface simulator) async {
  final destination = GpsCoordinates(latitude: 5, longitude: 5);
  final result = simulator.pathfinder.getPath(destination);
  expect(simulator.gps.latitude, 0);
  expect(simulator.gps.longitude, 0);
  expect(simulator.imu.heading, 0);
  expect(result, isNotNull); if (result == null) return;
  expect(result, isNotEmpty);
  for (final transition in result) {
    simulator.logger.trace("  From: ${simulator.gps.coordinates.prettyPrint()} facing ${simulator.imu.heading}");
    simulator.logger.debug("  $transition");
    await simulator.drive.goDirection(transition.direction);
    expect(simulator.gps.latitude, transition.position.latitude);
    expect(simulator.gps.longitude, transition.position.longitude);
    simulator.logger.trace("New orientation: ${simulator.imu.heading}");
    simulator.logger.trace("Expected orientation: ${transition.orientation.heading}");
    expect(simulator.imu.heading, transition.orientation.heading);
  }
}

Future<void> testPath2(AutonomyInterface simulator) async {
  final destination = GpsCoordinates(latitude: 4, longitude: 0);
  simulator.pathfinder.recordObstacle((2, 0).toGps());
  simulator.pathfinder.recordObstacle((4, -1).toGps());
  simulator.pathfinder.recordObstacle((4, 1).toGps());
  final result = simulator.pathfinder.getPath(destination);
  expect(simulator.gps.latitude, 0);
  expect(simulator.gps.longitude, 0);
  expect(simulator.imu.heading, 0);
  expect(result, isNotNull); if (result == null) return;
  expect(result, isNotEmpty);
  for (final transition in result) {
    simulator.logger.debug(transition.toString());
    simulator.logger.trace("  From: ${simulator.gps.coordinates.prettyPrint()}");
    await simulator.drive.goDirection(transition.direction);
    expect(simulator.gps.latitude, transition.position.latitude);
    expect(simulator.gps.longitude, transition.position.longitude);
    expect(simulator.imu.heading, transition.orientation.heading);
    simulator.logger.trace("  To: ${simulator.gps.coordinates.prettyPrint()}");
  }
}
