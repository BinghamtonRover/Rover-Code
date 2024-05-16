import "package:test/test.dart";
import "package:burt_network/generated.dart";
import "package:burt_network/logging.dart";

import "package:autonomy/interfaces.dart";
import "package:autonomy/rover.dart";
import "package:autonomy/simulator.dart";

void main() {
  test("Simulator can be restarted", () async { 
    Logger.level = LogLevel.off;
    final simulator = AutonomySimulator();
    expect(simulator.isInitialized, isFalse);
    await simulator.init();
    expect(simulator.isInitialized, isTrue);
    await simulator.restart();
    expect(simulator.isInitialized, isTrue);
    await simulator.dispose();
    expect(simulator.isInitialized, isFalse);
  });
  
  test("Simulated drive test with simulated GPS", () async {
    Logger.level = LogLevel.off;
    final simulator = AutonomySimulator();
    var position = GpsCoordinates();
    final gps = simulator.gps;
    expect(gps.coordinates.isNear(position), isTrue);
    // Turning left takes you +90 degrees
    await simulator.drive.turnLeft();
    expect(simulator.imu.heading, 90);
    expect(gps.coordinates.isNear(position), isTrue);
    // Turning right takes you -90 degrees
    await simulator.drive.turnRight();
    expect(simulator.imu.heading, 0);
    expect(gps.coordinates.isNear(position), isTrue);
    // Going straight takes you 1 cell forward
    await simulator.drive.goForward();
    position += GpsUtils.north;
    expect(gps.coordinates.isNear(position), isTrue);
    expect(simulator.imu.heading, 0);
    // Going forward at 90 degrees
    await simulator.drive.turnLeft();
    await simulator.drive.goForward();
    position += GpsUtils.west;
    expect(gps.coordinates.isNear(position), isTrue);
    expect(simulator.imu.heading, 90);   
    // Going forward at 180 degrees
    await simulator.drive.turnLeft();
    await simulator.drive.goForward();
    position += GpsUtils.south;
    expect(gps.coordinates.isNear(position), isTrue);
    expect(simulator.imu.heading, 180);   
    // Going forward at 270 degrees
    await simulator.drive.turnLeft();
    await simulator.drive.goForward();
    position += GpsUtils.east;
    expect(gps.coordinates.isNear(position), isTrue);
    expect(simulator.imu.heading, 270);   
    // 4 lefts go back to north
    await simulator.drive.turnLeft();
    expect(simulator.imu.heading, 0);
    expect(gps.coordinates.isNear(position), isTrue);
    await simulator.dispose();
  });

  test("Following path gets to the end", () async { 
    Logger.level = LogLevel.off;
    final simulator = AutonomySimulator();
    simulator.pathfinder = RoverPathfinder(collection: simulator);
    final destination = (5, 5).toGps();
    final path = simulator.pathfinder.getPath(destination);
    expect(path, isNotNull); if (path == null) return;
    expect(simulator.gps.latitude, 0);
    expect(simulator.gps.longitude, 0);
    await simulator.drive.followPath(path);
    expect(simulator.gps.coordinates.isNear(destination), isTrue);
    await simulator.dispose();
  });

  test("Path avoids obstacles but reaches the goal", () async {
    Logger.level = LogLevel.off;
    final simulator = AutonomySimulator();
    simulator.pathfinder = RoverPathfinder(collection: simulator);
    final destination = GpsCoordinates(latitude: 5, longitude: 5);
    final obstacles = <GpsCoordinates>{
      (1, 0).toGps(),
      (1, 1).toGps(),
      (2, 0).toGps(),
      (2, 1).toGps(),
      (3, 3).toGps(),
    };
    for (final obstacle in obstacles) {
      simulator.pathfinder.recordObstacle(obstacle);
    }
    final path = simulator.pathfinder.getPath(destination);
    expect(path, isNotNull); if (path == null) return;
    expect(path, isNotEmpty);
    for (final step in path) {
      expect(obstacles.contains(step.position), false);
    }
    await simulator.drive.followPath(path);
    expect(simulator.gps.latitude, destination.latitude);
    expect(simulator.gps.longitude, destination.longitude);
    await simulator.dispose();
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

  test("Orchestrator works with simulated obstacles", () async {
    Logger.level = LogLevel.off;
    final simulator = AutonomySimulator();
    final obstacles = <SimulatedObstacle>[
      SimulatedObstacle(coordinates: (2, 0).toGps(), radius: 3),
      SimulatedObstacle(coordinates: (6, -1).toGps(), radius: 3),
      SimulatedObstacle(coordinates: (6, 1).toGps(), radius: 3),
    ];
    simulator.detector = DetectorSimulator(collection: simulator, obstacles: obstacles);
    simulator.pathfinder = RoverPathfinder(collection: simulator);
    simulator.orchestrator = RoverOrchestrator(collection: simulator);
    simulator.drive = DriveSimulator(collection: simulator);
    await simulator.init();
    expect(simulator.gps.latitude, 0);
    expect(simulator.gps.longitude, 0);
    expect(simulator.imu.heading, 0);
    final command = AutonomyCommand(destination: (7, 0).toGps(), task: AutonomyTask.GPS_ONLY);
    await simulator.orchestrator.onCommand(command);
    expect(simulator.gps.latitude, 7);
    expect(simulator.gps.longitude, 0);
  });
}
