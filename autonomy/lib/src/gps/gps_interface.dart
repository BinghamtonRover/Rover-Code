import "package:autonomy/interfaces.dart";
import "package:meta/meta.dart";

abstract class GpsInterface extends Service with Receiver {
  final AutonomyInterface collection;

  GpsCoordinates get coordinates;

  double get longitude => coordinates.longitude;
  double get latitude => coordinates.latitude;

  GpsInterface({required this.collection});

  void update(GpsCoordinates newValue);

  @visibleForTesting
  void forceUpdate(GpsCoordinates newValue) {}

  bool isNear(GpsCoordinates other, [double? tolerance]) =>
      coordinates.isNear(other, tolerance);

  @override
  Future<bool> init() async => true;
}
