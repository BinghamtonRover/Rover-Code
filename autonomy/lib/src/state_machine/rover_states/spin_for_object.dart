import "package:autonomy/interfaces.dart";
import "package:autonomy/rover.dart";
import "package:autonomy/src/drive/drive_config.dart";

class SpinForObject extends RoverState {
  final AutonomyInterface collection;
  final List<DetectedObjectType> targetTypes;
  final CameraName? desiredCamera;

  DriveConfig get config => collection.drive.config;

  double _startOrientation = 0;
  bool _rotated180 = false;

  SpinForObject(
    super.controller, {
    required this.collection,
    required this.targetTypes,
    this.desiredCamera,
  });

  @override
  void enter() {
    _startOrientation = collection.imu.heading;
    _rotated180 = false;
  }

  @override
  void update() {
    if (collection.drive is! RoverDrive) {
      controller.popState();
      return;
    }

    final drive = (collection.drive as RoverDrive).sensorDrive;
    drive.setThrottle(config.turnThrottle);

    for (final type in targetTypes) {
      final detection = collection.video.getDetection(
        type,
        desiredCamera: desiredCamera,
      );
      if (detection != null) {
        controller.popState();
        return;
      }
    }

    drive.spinLeft();

    if ((collection.imu.heading - _startOrientation).clampHalfAngle().abs() >
        175) {
      _rotated180 = true;
    }

    if (_rotated180 &&
        collection.imu.isNear(Orientation(z: _startOrientation))) {
      controller.popState();
    }
  }

  @override
  void exit() {
    if (collection.drive is! RoverDrive) {
      return;
    }
    final drive = (collection.drive as RoverDrive).sensorDrive;
    drive.stopMotors();
  }
}
