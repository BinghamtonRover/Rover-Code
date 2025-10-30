import "package:autonomy/autonomy.dart";

class SimulationDriveTurn extends RoverState {
  final SimulationMethod method;
  final AutonomyInterface collection;
  final Orientation goalOrientation;

  Duration get delay => collection.drive.config.turnDelay;

  DateTime _startTime = DateTime(0);
  Orientation _startOrientation = Orientation();

  SimulationDriveTurn(
    super.controller, {
    required this.collection,
    required this.method,
    required this.goalOrientation,
  });

  @override
  void enter() {
    _startTime = DateTime.now();
    _startOrientation = collection.imu.raw;
  }

  @override
  void update() {
    if (method == SimulationMethod.instant) {
      collection.imu.update(goalOrientation);
      controller.popState();
      return;
    }

    if (DateTime.now().difference(_startTime) >= delay) {
      collection.imu.update(goalOrientation);
      controller.popState();
      return;
    }

    if (method == SimulationMethod.intermediate) {
      final deltaOrientation = (goalOrientation.z - _startOrientation.z)
          .clampHalfAngle();
      final deltaTime = DateTime.now().difference(_startTime);
      final timeFraction =
          1.0 * deltaTime.inMicroseconds / delay.inMicroseconds;

      final intermediateRotation =
          _startOrientation.z + deltaOrientation * timeFraction;

      collection.imu.update(Orientation(z: intermediateRotation));
    }
  }
}
