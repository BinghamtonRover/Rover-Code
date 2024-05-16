import "package:burt_network/generated.dart";
import "package:autonomy/interfaces.dart";

import "corrector.dart";

class RoverImu extends ImuInterface {
  final _zCorrector = ErrorCorrector(maxDeviation: OrientationUtils.epsilon);
  RoverImu({required super.collection});

  @override
  Future<bool> init() async => true;

  @override
  Future<void> dispose() async { }

  @override
  void update(Orientation newValue) => _zCorrector.addValue(newValue.clampHeading().heading);

  @override
  Orientation get orientation => Orientation(
    x: 0, 
    y: 0,
    z: _zCorrector.calibratedValue,
  );
}
