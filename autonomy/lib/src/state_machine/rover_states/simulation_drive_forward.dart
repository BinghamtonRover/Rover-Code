import "package:autonomy/autonomy.dart";
import "package:coordinate_converter/coordinate_converter.dart";

class SimulationDriveForward extends RoverState {
  final SimulationMethod method;
  final AutonomyInterface collection;
  final GpsCoordinates destination;

  Duration get delay => collection.drive.config.oneMeterDelay;

  DateTime _startTime = DateTime(0);
  GpsCoordinates _startCoordinates = GpsCoordinates();

  SimulationDriveForward(
    super.controller, {
    required this.collection,
    required this.method,
    required this.destination,
  });

  @override
  void enter() {
    _startTime = DateTime.now();
    _startCoordinates = collection.gps.coordinates;
  }

  @override
  void update() {
    if (method == SimulationMethod.instant) {
      collection.gps.update(destination);
      controller.popState();
      return;
    }

    if (DateTime.now().difference(_startTime) >= delay) {
      collection.gps.update(destination);
      controller.popState();
      return;
    }

    if (method == SimulationMethod.intermediate) {
      final deltaCoordinates = destination.toUTM() - _startCoordinates.toUTM();
      final deltaTime = DateTime.now().difference(_startTime);
      final timeFraction =
          1.0 * deltaTime.inMicroseconds / delay.inMicroseconds;

      final intermediateCoordinates =
          _startCoordinates.toUTM() +
          UTMCoordinates(
            x: deltaCoordinates.x * timeFraction,
            y: deltaCoordinates.y * timeFraction,
            zoneNumber: 1,
          );

      collection.gps.update(intermediateCoordinates.toGps());
    }
  }
}
