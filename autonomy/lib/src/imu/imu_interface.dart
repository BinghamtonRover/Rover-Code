import "package:autonomy/interfaces.dart";
import "package:meta/meta.dart";

abstract class ImuInterface extends Service with Receiver {
  final AutonomyInterface collection;
  ImuInterface({required this.collection});

  double get heading => raw.yaw;
  Rotation3d get raw;

  CardinalDirection get nearest => CardinalDirection.nearest(raw);

  void update(Rotation3d newValue);

  @visibleForTesting
  void forceUpdate(Rotation3d newValue) {}

  bool isNear(Rotation3d orientation, [double? tolerance]) =>
      raw.isNear(orientation.heading, tolerance);

  @override
  Future<bool> init() async => true;
}
