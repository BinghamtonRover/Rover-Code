import "package:burt_network/generated.dart";
import "package:autonomy/interfaces.dart";

abstract class GpsInterface extends Service with Receiver {
  static const gpsError = 0.00003;
  static double currentLatitude = 0;

  final AutonomyInterface collection;
  GpsInterface({required this.collection});

  double get longitude => coordinates.longitude;
  double get latitude => coordinates.latitude;

  void update(GpsCoordinates newValue);
  GpsCoordinates get coordinates;

  bool isNear(GpsCoordinates other) => coordinates.isNear(other);

  @override
  Future<void> waitForValue() async {
    await super.waitForValue();
    currentLatitude = coordinates.latitude;
  }

  @override
  Future<bool> init() async => true;
}
