import "package:burt_network/burt_network.dart";
import "package:autonomy/interfaces.dart";

import "corrector.dart";

class RoverGps extends GpsInterface {
  final _latitudeCorrector = ErrorCorrector(maxSamples: 1, maxDeviation: GpsInterface.gpsError * 10);
  final _longitudeCorrector = ErrorCorrector(maxSamples: 1, maxDeviation: GpsInterface.gpsError * 10);
  RoverGps({required super.collection});

  @override
  Future<bool> init() async {
    collection.server.messages.onMessage(
      name: RoverPosition().messageName,
      constructor: RoverPosition.fromBuffer,
      callback: (pos) {
        if (pos.hasGps()) update(pos.gps);
      },
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
    _latitudeCorrector.addValue(newValue.latitude);
    _longitudeCorrector.addValue(newValue.longitude);
    hasValue = true;
  }

  @override
 GpsCoordinates get coordinates => GpsCoordinates(
   latitude: _latitudeCorrector.calibratedValue,
   longitude: _longitudeCorrector.calibratedValue,
 );
}
