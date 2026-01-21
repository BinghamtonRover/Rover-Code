import "package:autonomy/interfaces.dart";

/// Utility methods for a [DriveInterface] to send motor commands directly to the Subsystems program
mixin RoverDriveCommands on DriveInterface {
  /// Sets the max speed of the rover.
  ///
  /// [_setSpeeds] takes the speeds of each side of wheels. These numbers are percentages of the
  /// max speed allowed by the rover, which we call the throttle. This function adjusts the
  /// throttle, as a percentage of the rover's top speed.
  void setThrottle(double throttle) {
    collection.logger.trace("Setting throttle to $throttle");
    sendCommand(DriveCommand(setThrottle: true, throttle: throttle));
  }

  /// Sets the speeds of the left and right wheels, using differential steering.
  ///
  /// These values are percentages of the max speed allowed by the rover. See [setThrottle].
  void _setSpeeds({required double left, required double right}) {
    right *= -1;
    collection.logger.trace("Setting speeds to $left and $right");
    sendCommand(
      DriveCommand(setLeft: true, setRight: true, left: left, right: right),
    );
  }

  /// Stops the motors, setting the throttle and speeds to 0
  void stopMotors() {
    setThrottle(0);
    _setSpeeds(left: 0, right: 0);
  }

  /// Sets the speeds of the wheels to spin the rover left
  void spinLeft() => _setSpeeds(left: -1, right: 1);

  /// Sets the speeds of the wheels to spin the rover right
  void spinRight() => _setSpeeds(left: 1, right: -1);

  /// Sets the speeds of the wheels to move the rover in a straight line
  void moveForward() => _setSpeeds(left: 1, right: 1);

  /// Sets the angle of the front camera.
  void setCameraAngle({required double swivel, required double tilt}) {
    collection.logger.trace(
      "Setting camera angles to $swivel (swivel) and $tilt (tilt)",
    );
    final command = DriveCommand(frontSwivel: swivel, frontTilt: tilt);
    sendCommand(command);
  }
}
