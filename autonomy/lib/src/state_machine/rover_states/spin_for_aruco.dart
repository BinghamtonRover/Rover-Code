import "package:autonomy/autonomy.dart";
import "package:autonomy/src/drive/drive_commands.dart";
import "package:autonomy/src/drive/drive_config.dart";

class SpinForAruco extends RoverState {
  final AutonomyInterface collection;
  final RoverDriveCommands drive;

  DriveConfig get config => collection.drive.config;

  final int arucoId;
  final CameraName? desiredCamera;

  double _startOrientation = 0;
  bool _rotated180 = false;

  SpinForAruco(
    super.controller, {
    required this.drive,
    required this.arucoId,
    required this.collection,
    this.desiredCamera,
  });

  @override
  void enter() {
    _startOrientation = collection.imu.heading;
    _rotated180 = false;
  }

  @override
  void update() {
    drive.setThrottle(config.turnThrottle);

    if (collection.video.getArucoDetection(
          arucoId,
          desiredCamera: desiredCamera,
        ) !=
        null) {
      controller.popState();
      return;
    }

    drive.spinLeft();

    if ((collection.imu.heading - _startOrientation).clampHalfAngle().abs() >
        175) {
      _rotated180 = true;
    }

    if (_rotated180 &&
        collection.imu.isNear(Orientation(z: _startOrientation))) {
      controller.popState();
      return;
    }
  }

  @override
  void exit() {
    drive.stop();
  }
}
