import "package:autonomy/constants.dart";
import "package:autonomy/interfaces.dart";
import "package:autonomy/rover.dart";
import "package:autonomy/src/drive/drive_config.dart";

class ApproachVisibleObject extends RoverState {
  final AutonomyInterface collection;
  final List<DetectedObjectType> targetTypes;
  final CameraName? desiredCamera;
  final int? arucoId;

  DriveConfig get config => collection.drive.config;

  int _missingFrames = 0;

  ApproachVisibleObject(
    super.controller, {
    required this.collection,
    required List<DetectedObjectType> targetTypes,
    this.desiredCamera,
    this.arucoId,
  }) : targetTypes = targetTypes.isEmpty
           ? [DetectedObjectType.DETECTION_TYPE_UNDEFINED]
           : targetTypes;

  @override
  void update() {
    if (collection.drive is! RoverDrive) {
      controller.popState();
      return;
    }

    final drive = (collection.drive as RoverDrive).sensorDrive;

    DetectedObjectSnapshot? detection;
    for (final type in targetTypes) {
      detection = collection.video.getDetection(
        type,
        desiredCamera: desiredCamera,
        arucoId: arucoId,
      );
      if (detection != null) {
        break;
      }
    }

    if (detection == null) {
      _missingFrames += 1;
      drive.stopMotors();
      if (_missingFrames >= Constants.visionMissingFramesToArrive) {
        controller.popState();
      }
      return;
    }

    _missingFrames = 0;

    final object = detection.object;
    final xPositionError = object.hasXPosition() ? object.xPosition : null;
    final yawError = object.hasYaw() ? object.yaw : null;

    double? pixelError;
    if (yawError == null && object.hasCenterX()) {
      final width = detection.details.hasStreamWidth()
          ? detection.details.streamWidth
          : detection.details.resolutionWidth;
      if (width > 0) {
        pixelError = object.centerX - (width / 2.0);
      }
    }

    if (xPositionError == null && yawError == null && pixelError == null) {
      collection.logger.warning(
        "Detected object lacks centering data",
        body: "Cannot determine yaw or center for ${object.objectType}",
      );
      drive.stopMotors();
      return;
    }

    final isCentered = xPositionError != null
        ? xPositionError.abs() <= Constants.visionCenterXPositionEpsilon
        : (yawError != null
            ? yawError.abs() <= Constants.visionCenterYawEpsilon
            : pixelError!.abs() <= Constants.visionCenterPixelEpsilon);

    if (!isCentered) {
      drive.setThrottle(config.turnThrottle);
      final error = xPositionError ?? yawError ?? pixelError!;
      if (error > 0) {
        drive.spinRight();
      } else {
        drive.spinLeft();
      }
      return;
    }

    drive.setThrottle(config.forwardThrottle);
    drive.moveForward();
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
