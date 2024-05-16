import "service.dart";

abstract class DetectorInterface extends Service {
  bool findObstacles();
  bool canSeeAruco();
  bool isOnSlope();
}
