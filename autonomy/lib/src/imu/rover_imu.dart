import "package:autonomy/interfaces.dart";

class RoverImu extends ImuInterface {
  final _xCorrector = ErrorCorrector.disabled();
  final _yCorrector = ErrorCorrector.disabled();
  final _zCorrector = ErrorCorrector.disabled();

  RoverImu({required super.collection});

  @override
  Future<bool> init() async {
    collection.server.messages.listenFor(
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
  void update(Rotation3d newValue) {
    // Do nothing, since this should only be internally updated
  }

  @override
  void forceUpdate(Rotation3d newValue) =>
      _internalUpdate(RoverPosition(orientation: newValue));

  void _internalUpdate(RoverPosition newValue) {
    if (!newValue.hasOrientation()) return;
    // Angles are always between -180 and +180
    if (newValue.orientation.pitch.abs() > 180 ||
        newValue.orientation.roll.abs() > 180 ||
        newValue.orientation.yaw.abs() > 180) {
      return;
    }
    _xCorrector.addValue(newValue.orientation.pitch);
    _yCorrector.addValue(newValue.orientation.roll);
    _zCorrector.addValue(newValue.orientation.yaw);
    hasValue = true;
  }

  @override
  Rotation3d get raw => Rotation3d(
    pitch: _xCorrector.calibratedValue.clampHalfAngle(),
    roll: _yCorrector.calibratedValue.clampHalfAngle(),
    yaw: _zCorrector.calibratedValue.clampHalfAngle(),
  );
}
