import "package:autonomy/simulator.dart";
import "package:autonomy/rover.dart";
import "package:burt_network/burt_network.dart";

final chair = (lat: 2, long: 0).toGps();
final obstacles = <SimulatedObstacle>[
  SimulatedObstacle(coordinates: (lat: 6, long: -1).toGps(), radius: 3),
  SimulatedObstacle(coordinates: (lat: 6, long: 1).toGps(), radius: 3),
];
// Enter in the Dashboard: Destination = (lat=7, long=0);

void main() async {
  Logger.level = LogLevel.trace;
  final simulator = RoverAutonomy();
  simulator.detector = NetworkDetector(collection: simulator);
  simulator.pathfinder = RoverPathfinder(collection: simulator);
  simulator.orchestrator = RoverOrchestrator(collection: simulator);
  simulator.drive = RoverDrive(
    collection: simulator,
    useGps: false,
    useImu: false,
  );
  simulator.gps = GpsSimulator(collection: simulator);
  simulator.imu = ImuSimulator(collection: simulator);
  simulator.video = VideoSimulator(collection: simulator);

  await simulator.init();
  await simulator.imu.waitForValue();
  await simulator.server.waitForConnection();
}
