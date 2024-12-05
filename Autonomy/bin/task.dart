import "package:autonomy/interfaces.dart";
import "package:autonomy/simulator.dart";
import "package:autonomy/rover.dart";
import "package:burt_network/logging.dart";

final chair = (2, 0).toGps();
final obstacles = <SimulatedObstacle>[
  SimulatedObstacle(coordinates: (2, 0).toGps(), radius: 3),
  SimulatedObstacle(coordinates: (6, -1).toGps(), radius: 3),
  SimulatedObstacle(coordinates: (6, 1).toGps(), radius: 3),
];
// Enter in the Dashboard: Destination = (lat=7, long=0);

void main() async {
  Logger.level = LogLevel.debug;
  final simulator = RoverAutonomy();
  simulator.detector = DetectorSimulator(collection: simulator, obstacles: obstacles);
  simulator.pathfinder = RoverPathfinder(collection: simulator);
  simulator.orchestrator = RoverOrchestrator(collection: simulator);
  simulator.drive = RoverDrive(collection: simulator, useImu: true, useGps: false);
  simulator.gps = GpsSimulator(collection: simulator);
//  simulator.drive = DriveSimulator(collection: simulator);
  await simulator.init();
  await simulator.imu.waitForValue();
//	await simulator.drive.faceNorth();
  await simulator.server.waitForConnection();
	print("Ready");

}
