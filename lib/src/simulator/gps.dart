import "package:burt_network/generated.dart";
import "package:autonomy/interfaces.dart";

class GpsSimulator extends GpsInterface with ValueReporter {
  final RandomError _error;
  GpsSimulator({required super.collection, double maxError = 0}) : 
    _error = RandomError(maxError);
  
  @override
  RoverPosition getMessage() => RoverPosition(gps: coordinates);

  GpsCoordinates _coordinates = GpsCoordinates();

  @override
  GpsCoordinates get coordinates => GpsCoordinates(
    latitude: _coordinates.latitude + _error.value,
    longitude: _coordinates.longitude + _error.value,
  );

  @override
  void update(GpsCoordinates newValue) => _coordinates = newValue;
}
