export "src/simulator/detector.dart";
export "src/simulator/drive.dart";
export "src/simulator/gps.dart";
export "src/simulator/imu.dart";
export "src/simulator/realsense.dart";
export "src/simulator/server.dart";

import "package:autonomy/interfaces.dart";
import "package:autonomy/src/simulator/orchestrator.dart";
import "package:burt_network/logging.dart";

import "src/simulator/detector.dart";
import "src/simulator/drive.dart";
import "src/simulator/gps.dart";
import "src/simulator/imu.dart";
import "src/simulator/pathfinding.dart";
import "src/simulator/realsense.dart";
import "src/simulator/server.dart";

class AutonomySimulator extends AutonomyInterface {
  @override late final logger = BurtLogger(socket: server);
  @override late ServerInterface server = SimulatorServer(collection: this);
  @override late GpsInterface gps = GpsSimulator(collection: this);
  @override late ImuInterface imu = ImuSimulator(collection: this);
  @override late DriveInterface drive = DriveSimulator(collection: this);
  @override late PathfindingInterface pathfinder = PathfindingSimulator(collection: this);
  @override late DetectorInterface detector = DetectorSimulator(collection: this, obstacles: []);
  @override late RealSenseInterface realsense = RealSenseSimulator(collection: this);
  @override late OrchestratorInterface orchestrator = OrchestratorSimulator(collection: this);

  bool isInitialized = false;

  @override
  Future<bool> init() { isInitialized = true; return super.init(); }
  
  @override
  Future<void> dispose() { isInitialized = false; return super.dispose(); }
}
