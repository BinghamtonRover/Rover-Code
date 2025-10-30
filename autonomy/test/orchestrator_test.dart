import "dart:async";

import "package:autonomy/src/drive/drive_config.dart";
import "package:test/test.dart";
import "package:autonomy/autonomy.dart";
import "package:burt_network/burt_network.dart";

void main() => group("[Orchestrator]", skip: true, tags: ["orchestrator"], () {
  setUp(() => Logger.level = LogLevel.info);
  tearDown(() => Logger.level = LogLevel.off);

  test("Fails for invalid destinations", () async {
    Logger.level = LogLevel.off; // this test can log critical messages
    final simulator = AutonomySimulator();
    await simulator.init();
    simulator.pathfinder = RoverPathfinder(collection: simulator);
    simulator.orchestrator = RoverOrchestrator(collection: simulator);
    simulator.pathfinder.recordObstacle((lat: 2, long: 0).toGps());
    // Test blocked command:
    final command = AutonomyCommand(
      destination: (lat: 2, long: 0).toGps(),
      task: AutonomyTask.GPS_ONLY,
    );
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

  test("Works for GPS task", () async {
    Logger.level = LogLevel.off; // this test can log critical messages
    final simulator = AutonomySimulator();
    simulator.pathfinder = RoverPathfinder(collection: simulator);
    simulator.orchestrator = RoverOrchestrator(collection: simulator);
    simulator.pathfinder.obstacles.addAll([
      (lat: 2, long: 0).toGps(),
      (lat: 4, long: -1).toGps(),
      (lat: 4, long: 1).toGps(),
    ]);
    await simulator.init();
    // Test normal command:
    final destination = (lat: 4, long: 0).toGps();
    final command = AutonomyCommand(
      destination: destination,
      task: AutonomyTask.GPS_ONLY,
    );
    expect(simulator.gps.latitude, 0);
    expect(simulator.gps.longitude, 0);
    expect(simulator.imu.heading, 0);
    await simulator.orchestrator.onCommand(command);
    expect(simulator.gps.isNear(destination), isTrue);
    expect(simulator.imu.heading, 0);
    final status1 = simulator.orchestrator.statusMessage;
    expect(status1.crash, isFalse);
    expect(status1.task, AutonomyTask.AUTONOMY_TASK_UNDEFINED);
    expect(status1.destination, GpsCoordinates());
    expect(status1.obstacles, [
      (lat: 2, long: 0).toGps(),
      (lat: 4, long: -1).toGps(),
      (lat: 4, long: 1).toGps(),
    ]);
    expect(status1.state, AutonomyState.AT_DESTINATION);
    await simulator.dispose();
  });

  test("Simulated obstacles", () async {
    Logger.level = LogLevel.off;
    final simulator = AutonomySimulator();
    final obstacles = <SimulatedObstacle>[
      SimulatedObstacle(coordinates: (lat: 2, long: 0).toGps(), radius: 1),
      SimulatedObstacle(coordinates: (lat: 6, long: -1).toGps(), radius: 1),
      SimulatedObstacle(coordinates: (lat: 6, long: 1).toGps(), radius: 1),
    ];
    simulator.detector = DetectorSimulator(
      collection: simulator,
      obstacles: obstacles,
    );
    simulator.pathfinder = RoverPathfinder(collection: simulator);
    simulator.orchestrator = RoverOrchestrator(collection: simulator);
    simulator.drive = DriveSimulator(collection: simulator);
    await simulator.init();
    final origin = GpsCoordinates();
    final destination = (lat: 0, long: 7).toGps();
    expect(simulator.gps.isNear(origin), isTrue);
    expect(simulator.imu.heading, 0);
    final command = AutonomyCommand(
      destination: destination,
      task: AutonomyTask.GPS_ONLY,
    );
    await simulator.orchestrator.onCommand(command);
    expect(simulator.gps.isNear(destination), isTrue);
    await simulator.dispose();
  });

  test("Rejects commands until latitude has been determined", () async {
    final simulator = AutonomySimulator();
    final start = (lat: 5, long: 0).toGps();
    final destination = (lat: 5, long: 5).toGps();
    final command = AutonomyCommand(
      destination: destination,
      task: AutonomyTask.GPS_ONLY,
    );
    simulator.orchestrator = RoverOrchestrator(collection: simulator);
    simulator.pathfinder = RoverPathfinder(collection: simulator);
    simulator.gps = RoverGps(collection: simulator);
    simulator.drive = RoverDrive(
      collection: simulator,
      useImu: false,
      config: tankConfig,
    );
    await simulator.init();

    expect(simulator.gps.hasValue, isFalse);

    await simulator.orchestrator.onCommand(command);
    expect(simulator.gps.hasValue, isFalse);
    expect(
      simulator.orchestrator.statusMessage.state,
      AutonomyState.NO_SOLUTION,
    );

    simulator.gps.forceUpdate(start);
    await simulator.init();
    await simulator.waitForValue();
    expect(simulator.hasValue, isTrue);
    unawaited(simulator.orchestrator.onCommand(command));
    await Future<void>.delayed(Duration.zero);
    expect(simulator.orchestrator.currentCommand, isNotNull);
    expect(simulator.orchestrator.currentState, AutonomyState.DRIVING);

    await simulator.dispose();
  });
});
