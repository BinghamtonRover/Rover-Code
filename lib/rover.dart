export "src/rover/drive.dart";
export "src/rover/pathfinding.dart";
export "src/rover/orchestrator.dart";
export "src/rover/sensorless.dart";

import "package:autonomy/interfaces.dart";
import "package:autonomy/simulator.dart";
import "package:burt_network/logging.dart";

import "src/rover/pathfinding.dart";
import "src/rover/server.dart";
import "src/rover/drive.dart";
import "src/rover/gps.dart";
import "src/rover/imu.dart";
import "src/rover/orchestrator.dart";
import "src/rover/realsense.dart";

/// A collection of all the different services used by the autonomy program.
class RoverAutonomy extends AutonomyInterface {
	/// A server to communicate with the dashboard and receive data from the subsystems.
	@override late final AutonomyServer server = AutonomyServer(collection: this);
	/// A helper class to handle driving the rover.
	@override late DriveInterface drive = RoverDrive(collection: this);
  @override late GpsInterface gps = RoverGps(collection: this);
  @override late ImuInterface imu = RoverImu(collection: this);
  @override late final logger = BurtLogger(socket: server);
  @override late final pathfinder = RoverPathfinder(collection: this);
  @override late final detector = DetectorSimulator(collection: this, obstacles: []);
  @override late final realsense = RoverRealsense(collection: this);
  @override late final orchestrator = RoverOrchestrator(collection: this); 
}
