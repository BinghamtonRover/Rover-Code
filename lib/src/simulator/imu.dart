import "package:burt_network/generated.dart";
import "package:autonomy/interfaces.dart";

class ImuSimulator extends ImuInterface with ValueReporter {  
  final RandomError _error;
  ImuSimulator({required super.collection, double maxError = 0}) : 
    _error = RandomError(maxError);
  
  @override
  RoverPosition getMessage() => RoverPosition(orientation: orientation);

  Orientation _orientation = Orientation();

  @override
  Orientation get orientation => Orientation(
    x: _orientation.x + _error.value,
    y: _orientation.y + _error.value,
    z: _orientation.z + _error.value,
  );

  @override
  void update(Orientation newValue) => _orientation = newValue.clampHeading();
}
