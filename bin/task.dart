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
  Logger.level = LogLevel.all;
  final simulator = AutonomySimulator();
  final detector = DetectorSimulator(collection: simulator, obstacles: obstacles);
  simulator.detector = detector;
  simulator.pathfinder = RoverPathfinder(collection: simulator);
  simulator.orchestrator = RoverOrchestrator(collection: simulator);
  simulator.drive = DriveSimulator(collection: simulator, shouldDelay: true);
  await simulator.init();
  await simulator.server.waitForConnection();
}
