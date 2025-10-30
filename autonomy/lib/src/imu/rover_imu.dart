import "package:autonomy/interfaces.dart";

class RoverImu extends ImuInterface {
  final _xCorrector = ErrorCorrector.disabled();
  final _yCorrector = ErrorCorrector.disabled();
  final _zCorrector = ErrorCorrector.disabled();

  RoverImu({required super.collection});

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
    _zCorrector.clear();
  }

  @override
  void update(Orientation newValue) {
    // Do nothing, since this should only be internally updated
  }

  @override
  void forceUpdate(Orientation newValue) =>
      _internalUpdate(RoverPosition(orientation: newValue));

  void _internalUpdate(RoverPosition newValue) {
    if (!newValue.hasOrientation()) return;
    // Angles are always between -180 and +180
    if (newValue.orientation.x.abs() > 180 ||
        newValue.orientation.y.abs() > 180 ||
        newValue.orientation.z.abs() > 180) {
      return;
    }
    _xCorrector.addValue(newValue.orientation.x);
    _yCorrector.addValue(newValue.orientation.y);
    _zCorrector.addValue(newValue.orientation.z);
    hasValue = true;
  }

  @override
  Orientation get raw => Orientation(
    x: _xCorrector.calibratedValue.clampHalfAngle(),
    y: _yCorrector.calibratedValue.clampHalfAngle(),
    z: _zCorrector.calibratedValue.clampHalfAngle(),
  );
}
