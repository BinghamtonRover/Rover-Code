export "src/rover/drive.dart";
export "src/rover/pathfinding.dart";
export "src/rover/orchestrator.dart";
export "src/rover/sensorless.dart";

import "package:autonomy/interfaces.dart";
import "package:burt_network/burt_network.dart";

import "src/rover/pathfinding.dart";
import "src/rover/drive.dart";
import "src/rover/gps.dart";
import "src/rover/imu.dart";
import "src/rover/orchestrator.dart";
import "src/rover/video.dart";
import "src/rover/detector.dart";

/// A collection of all the different services used by the autonomy program.
class RoverAutonomy extends AutonomyInterface {
	/// A server to communicate with the dashboard and receive data from the subsystems.
	// @override late final AutonomyServer server = AutonomyServer(collection: this);
  @override late final server = RoverSocket(port: 8003, device: Device.AUTONOMY, collection: this);
	/// A helper class to handle driving the rover.
	@override late DriveInterface drive = RoverDrive(collection: this);
  @override late GpsInterface gps = RoverGps(collection: this);
  @override late ImuInterface imu = RoverImu(collection: this);
  @override late final logger = BurtLogger(socket: server);
  @override late PathfindingInterface pathfinder = RoverPathfinder(collection: this);
  @override late DetectorInterface detector = RoverDetector(collection: this);
  @override late VideoInterface video = RoverVideo(collection: this);
  @override late OrchestratorInterface orchestrator = RoverOrchestrator(collection: this);

  @override
  Future<void> onDisconnect() async {
    await super.onDisconnect();
    await orchestrator.abort();
  }
}
