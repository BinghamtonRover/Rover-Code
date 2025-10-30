import "package:autonomy/interfaces.dart";

abstract class DetectorInterface extends Service {
  AutonomyInterface collection;
  DetectorInterface({required this.collection});

  bool findObstacles();
  bool isOnSlope();
}
