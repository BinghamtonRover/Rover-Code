import "package:autonomy/interfaces.dart";

/// Enum to represent the method to use for drive simulation
enum SimulationMethod {
  /// Will instantly simulate moving to a location with no delay
  instant,

  /// Will wait a period of time before updating
  constantDelay,

  /// Will continuously update with intermediate states during its
  /// delay, as if the rover was actually moving
  intermediate,
}

/// An implementation of [DriveInterface] that will not move the rover,
/// and only update its sensor readings based on the desired values
///
/// This assumes that the implementations for sensors are not expected to be updated from the rover,
/// otherwise, this can cause the rover to not follow its path properly
class DriveSimulator extends DriveInterface {
  /// The amount of time to wait before updating the virtual sensor readings
  static const delay = Duration(milliseconds: 500);

  /// The method to use for the drive simulation
  final SimulationMethod method;

  /// Whether or not to wait before updating virtual sensor readings,
  /// this can be useful when simulating the individual steps of a path
  bool get shouldDelay => method != SimulationMethod.instant;

  /// Constructor for DriveSimulator, initializing the default fields, and whether or not it should delay
  DriveSimulator({
    required super.collection,
    this.method = SimulationMethod.instant,
    super.config,
  });

  @override
  StateInterface driveForwardState(GpsCoordinates coordinates) =>
      SimulationDriveForward(
        controller,
        collection: collection,
        method: method,
        destination: coordinates,
      );

  @override
  StateInterface faceOrientationState(Orientation orientation) =>
      SimulationDriveTurn(
        controller,
        collection: collection,
        method: method,
        goalOrientation: orientation,
      );

  @override
  StateInterface spinForArucoState(int arucoId, {CameraName? desiredCamera}) =>
      FunctionalState(
        controller,
        onEnter: (controller) => controller.popState(),
      );

  @override
  Future<bool> init() async => true;

  @override
  Future<void> dispose() async {}

  @override
  Future<bool> driveForward(GpsCoordinates position) async {
    if (shouldDelay) await Future<void>.delayed(delay);
    collection.gps.update(position);
    return true;
  }

  @override
  Future<bool> faceOrientation(Orientation orientation) async {
    if (shouldDelay) {
      await Future<void>.delayed(const Duration(milliseconds: 500));
    }
    collection.imu.update(orientation);
    return true;
  }

  @override
  Future<bool> spinForAruco(int arucoId, {CameraName? desiredCamera}) async =>
      true;

  @override
  Future<bool> stop() async {
    collection.logger.debug("Stopping");
    return true;
  }
}
