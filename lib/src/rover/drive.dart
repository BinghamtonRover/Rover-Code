import "package:burt_network/burt_network.dart";
import "package:autonomy/interfaces.dart";

import "drive/timed.dart";
import "drive/sensor.dart";

/// A helper class to send drive commands to the rover with a simpler API. 
class RoverDrive extends DriveInterface {
  final bool useGps;
  final bool useImu;
  
  final SensorDrive sensorDrive;
  final TimedDrive timedDrive;
  
  // TODO: Calibrate these
  RoverDrive({required super.collection, this.useGps = true, this.useImu = true}) : 
    sensorDrive = SensorDrive(collection: collection),
    timedDrive = TimedDrive(collection: collection);

	/// Initializes the rover's drive subsystems.
	@override 
  Future<bool> init() async => true;

	/// Stops the rover from driving.
	@override 
  Future<void> dispose() => stop();

	/// Sets the angle of the front camera.
	void setCameraAngle({required double swivel, required double tilt}) {
		collection.logger.trace("Setting camera angles to $swivel (swivel) and $tilt (tilt)");
		final command = DriveCommand(frontSwivel: swivel, frontTilt: tilt);
		collection.server.sendCommand(command);
	}

  @override 
  Future<void> stop() async {
    await timedDrive.stop();
  }

  @override
  Future<void> faceNorth() => useImu ? sensorDrive.faceNorth() : timedDrive.faceNorth();

  @override 
  Future<void> goForward() => useGps ? sensorDrive.goForward() : timedDrive.goForward();

  @override
  Future<void> turnLeft() => useImu ? sensorDrive.turnLeft() : timedDrive.turnLeft();

  @override
  Future<void> turnRight() => useImu ? sensorDrive.turnRight() : timedDrive.turnRight();
}
