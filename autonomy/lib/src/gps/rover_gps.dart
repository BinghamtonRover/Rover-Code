import "package:autonomy/interfaces.dart";

class RoverGps extends GpsInterface {
  final _latitudeCorrector = ErrorCorrector.disabled();
  final _longitudeCorrector = ErrorCorrector.disabled();

  RoverGps({required super.collection});

  @override
  Future<bool> init() async {
    collection.server.messages.onMessage(
      name: RoverPosition().messageName,
      constructor: RoverPosition.fromBuffer,
      callback: _internalUpdate,
    );
    return super.init();
  }

  @override
  Future<void> dispose() async {
    _latitudeCorrector.clear();
    _longitudeCorrector.clear();
  }

  @override
  void update(GpsCoordinates newValue) {
    // Do nothing, since this should only be internally updated
  }

  @override
  void forceUpdate(GpsCoordinates newValue) =>
      _internalUpdate(RoverPosition(gps: newValue));

  void _internalUpdate(RoverPosition newValue) {
    if (!newValue.hasGps()) return;
    final position = newValue.gps;
    _latitudeCorrector.addValue(position.latitude);
    _longitudeCorrector.addValue(position.longitude);
    hasValue = true;
  }

  @override
  GpsCoordinates get coordinates => GpsCoordinates(
    latitude: _latitudeCorrector.calibratedValue,
    longitude: _longitudeCorrector.calibratedValue,
  );
}
