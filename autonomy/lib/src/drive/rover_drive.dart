import "package:autonomy/interfaces.dart";
import "package:autonomy/rover.dart";

import "sensor_drive.dart";
import "timed_drive.dart";
import "sim_drive.dart";

/// A helper class to send drive commands to the rover with a simpler API.
class RoverDrive extends DriveInterface {
  /// Whether or not it should use the GPS while driving forward
  final bool useGps;

  /// Whether or not it should use the IMU while turning
  final bool useImu;

  /// A [SensorDrive] used during movements that rely on sensors
  late final sensorDrive = SensorDrive(collection: collection, config: config);

  /// A [TimedDrive] used during movements that do not use sensors
  late final timedDrive = TimedDrive(collection: collection, config: config);

  /// A simulator used in conjunction with [timedDrive] to simulate the sensor
  /// readings of the drive when driving without sensors
  late final simDrive = DriveSimulator(collection: collection, config: config);

  /// Constructor for RoverDrive
  ///
  /// Takes in parameters for whether or not to use the GPS and imu
  /// These will determine when to use [sensorDrive] or [timedDrive]
  RoverDrive({
    required super.collection,
    this.useGps = true,
    this.useImu = true,
    super.config,
  });

  /// Initializes the rover's drive subsystems.
  @override
  Future<bool> init() async {
    if (!useImu && collection.imu is RoverImu) {
      collection.logger.critical(
        "Cannot use Rover IMU with simulated turning",
        body: "Set useImu to true, or use the simulated IMU",
      );
      return false;
    }
    if (!useGps && collection.imu is RoverGps) {
      collection.logger.critical(
        "Cannot use Rover GPS with simulated driving",
        body: "Set useGps to true, or use the simulated GPS",
      );
      return false;
    }

    var result = true;
    result &= await sensorDrive.init();
    result &= await timedDrive.init();
    result &= await simDrive.init();
    return result;
  }

  /// Stops the rover from driving.
  @override
  Future<void> dispose() async {
    await sensorDrive.dispose();
    await timedDrive.dispose();
    await simDrive.dispose();
  }

  @override
  Future<bool> stop() async {
    var result = true;
    result &= await sensorDrive.stop();
    result &= await timedDrive.stop();
    result &= await simDrive.stop();
    return result;
  }

  @override
  Future<bool> spinForAruco(int arucoId, {CameraName? desiredCamera}) =>
      sensorDrive.spinForAruco(arucoId, desiredCamera: desiredCamera);

  @override
  Future<void> approachAruco() => sensorDrive.approachAruco();

  @override
  Future<bool> faceOrientation(Orientation orientation) async {
    if (useImu) {
      return sensorDrive.faceOrientation(orientation);
    } else {
      return simDrive.faceOrientation(orientation);
    }
  }

  @override
  Future<bool> driveForward(GpsCoordinates position) async {
    if (useGps) {
      return sensorDrive.driveForward(position);
    } else {
      var result = true;
      result &= await timedDrive.driveForward(position);
      result &= await simDrive.driveForward(position);
      return result;
    }
  }

  @override
  StateInterface driveForwardState(GpsCoordinates coordinates) {
    if (useGps) {
      return sensorDrive.driveForwardState(coordinates);
    } else {
      return SequenceState(
        controller,
        steps: [
          timedDrive.driveForwardState(coordinates),
          simDrive.driveForwardState(coordinates),
        ],
      );
    }
  }

  @override
  StateInterface turnStateState(AutonomyAStarState state) {
    if (useImu) {
      return sensorDrive.turnStateState(state);
    } else {
      return SequenceState(
        controller,
        steps: [
          timedDrive.turnStateState(state),
          simDrive.turnStateState(state),
        ],
      );
    }
  }

  @override
  StateInterface faceOrientationState(Orientation orientation) {
    if (useImu) {
      return sensorDrive.faceOrientationState(orientation);
    } else {
      return simDrive.faceOrientationState(orientation);
    }
  }

  @override
  StateInterface spinForArucoState(int arucoId, {CameraName? desiredCamera}) {
    if (useImu) {
      return sensorDrive.spinForArucoState(
        arucoId,
        desiredCamera: desiredCamera,
      );
    } else {
      return simDrive.spinForArucoState(arucoId, desiredCamera: desiredCamera);
    }
  }
}
