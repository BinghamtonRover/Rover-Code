import "package:autonomy/interfaces.dart";
import "package:burt_network/generated.dart";

mixin RoverMotors {
  AutonomyInterface get collection;
  
  /// Sets the max speed of the rover. 
	/// 
	/// [setSpeeds] takes the speeds of each side of wheels. These numbers are percentages of the
	/// max speed allowed by the rover, which we call the throttle. This function adjusts the 
	/// throttle, as a percentage of the rover's top speed. 
	void setThrottle(double throttle) {
		collection.logger.trace("Setting throttle to $throttle");
		collection.server.sendCommand(DriveCommand(throttle: throttle, setThrottle: true));
	}

	/// Sets the speeds of the left and right wheels, using differential steering. 
	/// 
	/// These values are percentages of the max speed allowed by the rover. See [setThrottle].
	void setSpeeds({required double left, required double right}) {
		collection.logger.trace("Setting speeds to $left and $right");
		collection.server.sendCommand(DriveCommand(left: left, setLeft: true));
		collection.server.sendCommand(DriveCommand(right: right, setRight: true));
	}
}
