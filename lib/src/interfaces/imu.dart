import "package:autonomy/interfaces.dart";
import "package:burt_network/burt_network.dart";

abstract class ImuInterface extends Service with Receiver {
  final AutonomyInterface collection;
  ImuInterface({required this.collection});

  double get heading => raw.z;
  Orientation get raw;
  DriveOrientation? get orientation => DriveOrientation.fromRaw(raw);
  void update(Orientation newValue);
  bool isNear(double angle) => raw.isNear(angle);
}
