import "package:autonomy/interfaces.dart";

class ImuSimulator extends ImuInterface with ValueReporter {
  final RandomError _error;

  ImuSimulator({required super.collection, double maxError = 0})
    : _error = RandomError(maxError);

  @override
  RoverPosition getMessage() => RoverPosition(orientation: raw);

  Rotation3d _orientation = Rotation3d();

  @override
  Rotation3d get raw => Rotation3d(
    pitch: _orientation.pitch + _error.value,
    roll: _orientation.roll + _error.value,
    yaw: _orientation.yaw + _error.value,
  );

  @override
  void update(Rotation3d newValue) => _orientation = newValue;

  @override
  Future<bool> init() async {
    hasValue = true;
    return super.init();
  }

  @override
  Future<void> dispose() async {
    _orientation = Rotation3d();
    await super.dispose();
  }
}
