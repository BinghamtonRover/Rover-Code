import "package:autonomy/interfaces.dart";
import "package:autonomy/src/drive/drive_commands.dart";
import "package:autonomy/src/drive/drive_config.dart";

class SensorTurnState extends RoverState {
  final AutonomyInterface collection;
  final Orientation orientation;

  final RoverDriveCommands drive;

  DriveConfig get config => collection.drive.config;

  SensorTurnState(
    super.controller, {
    required this.collection,
    required this.orientation,
    required this.drive,
  });

  @override
  void update() {
    drive.setThrottle(config.turnThrottle);

    final current = collection.imu.heading;
    final target = orientation.heading;
    final error = (target - current).clampHalfAngle();
    if (error < 0) {
      drive.spinRight();
    } else {
      drive.spinLeft();
    }

    if (collection.imu.isNear(orientation)) {
      controller.popState();
    }
  }

  @override
  void exit() {
    drive.stopMotors();
  }
}
