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
  simulator.drive = SensorlessDrive(collection: simulator, useImu: false, useGps: false);
  await simulator.init();
  // await simulator.waitForValue();
	await simulator.drive.faceNorth();
  await simulator.server.waitForConnection();
}
