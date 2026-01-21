import "package:autonomy/interfaces.dart";

class GpsSimulator extends GpsInterface with ValueReporter {
  final RandomError _error;
  GpsSimulator({required super.collection, double maxError = 0})
    : _error = RandomError(maxError);

  @override
  RoverPosition getMessage() => RoverPosition(gps: coordinates);

  final GpsCoordinates _coordinates = GpsCoordinates();

  @override
  GpsCoordinates get coordinates => GpsCoordinates(
    latitude: _coordinates.latitude + _error.value,
    longitude: _coordinates.longitude + _error.value,
  );

  @override
  void update(GpsCoordinates newValue) =>
      _coordinates.mergeFromMessage(newValue);

  @override
  Future<bool> init() async {
    hasValue = true;
    return super.init();
  }
}
