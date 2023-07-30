import "package:burt_network/burt_network.dart";
import "collection.dart";

/// A helper class to send drive commands to the rover with a simpler API. 
class Drive {
	/// Initializes the rover's drive subsystems.
	void init() => setThrottle(0.3);
	/// Stops the rover from driving.
	void dispose() => setThrottle(0);

	/// Sets the max speed of the rover. 
	/// 
	/// [setSpeeds] takes the speeds of each side of wheels. These numbers are percentages of the
	/// max speed allowed by the rover, which we call the throttle. This function adjusts the 
	/// throttle, as a percentage of the rover's top speed. 
	void setThrottle(double throttle) {
		logger.verbose("Setting throttle to $throttle");
		final command = DriveCommand(throttle: throttle, setThrottle: true);
		collection.subsystems.sendMessage(command);
	}

	/// Sets the speeds of the left and right wheels, using differential steering. 
	/// 
	/// These values are percentages of the max speed allowed by the rover. See [setThrottle].
	void setSpeeds({required double left, required double right}) {
		logger.verbose("Setting speeds to $left and $right");
		final command = DriveCommand(left: left, right: right, setLeft: true, setRight: true);
		collection.subsystems.sendMessage(command);
	}

	/// Sets the angle of the front camera.
	void setCameraAngle({required double swivel, required double tilt}) {
		logger.verbose("Setting camera angles to $swivel (swivel) and $tilt (tilt)");
		final command = DriveCommand(frontSwivel: swivel, frontTilt: tilt);
		collection.subsystems.sendMessage(command);
	}
}
