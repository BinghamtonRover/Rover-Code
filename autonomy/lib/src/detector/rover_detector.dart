import "dart:async";
import "dart:math";

import "package:autonomy/interfaces.dart";
import "package:coordinate_converter/coordinate_converter.dart";

class RoverDetector extends DetectorInterface {
  StreamSubscription<LidarPointCloud>? _subscription;

  LidarPointCloud cloudCache = LidarPointCloud();

  Set<GpsCoordinates> queuedObstacles = {};
  Set<GpsCoordinates> temporaryObstacles = {};

  RoverDetector({required super.collection});

  void _handleLidarCloud(LidarPointCloud cloud) {
    if (cloud.cartesian.isNotEmpty) {
      cloudCache.cartesian.clear();
      cloudCache.cartesian.addAll(cloud.cartesian);
    }
    if (cloud.polar.isNotEmpty) {
      cloudCache.polar.clear();
      cloudCache.polar.addAll(cloud.polar);
    }

    _queueObstacles();
  }

  void _queueObstacles() {
    final cartesian = cloudCache.cartesian;
    final polar = cloudCache.polar;

    if (cartesian.isEmpty || polar.isEmpty) {
      return;
    }

    queuedObstacles.clear();

    for (final point in cartesian) {
      final angle = atan2(point.y, point.x) * 180 / pi;
      final magnitude = sqrt(pow(point.x, 2) + pow(point.y, 2));

      if (angle >= pi / 2) {
        continue;
      }

      if (magnitude <= 0.1) {
        continue;
      }

      final matchingPolar = polar.where(
        (e) =>
            (e.angle - angle.roundToDouble()).abs() <= 1 &&
            (e.angle - angle.roundToDouble()).abs() != 0,
      );

      // no polar coordinates are near the cartesian coordinate
      if (matchingPolar.isEmpty) {
        continue;
      }

      // nearby polar coordinates do not match the cartesian distance, likely a false speck
      if (!matchingPolar.any((e) => (e.distance - magnitude).abs() < 0.1)) {
        continue;
      }

      final imuAngleRad = collection.imu.heading * pi / 180 + pi / 2;

      final roverToPoint = UTMCoordinates(
        x: point.x * cos(imuAngleRad) - point.y * sin(imuAngleRad),
        y: point.y * cos(imuAngleRad) + point.x * sin(imuAngleRad),
        zoneNumber: 1,
      );

      queuedObstacles.add(
        (collection.gps.coordinates.toUTM() + roverToPoint).toGps(),
      );
    }

    cloudCache.cartesian.clear();
    cloudCache.polar.clear();
  }

  @override
  bool isOnSlope() => false;

  @override
  bool findObstacles() {
    if (queuedObstacles.isEmpty) return false;

    final roverUtm = collection.gps.coordinates.toUTM();

    final toRemove = temporaryObstacles.where((coordinates) {
      final delta = coordinates.toUTM() - roverUtm;
      final roverToPoint = (atan2(delta.y, delta.x) - pi / 2) * 180 / pi;
      final relativeAngle = (collection.imu.heading + roverToPoint)
          .clampHalfAngle();

      return relativeAngle > -135 && relativeAngle < 135;
    }).toList();
    collection.pathfinder.obstacles.removeAll(toRemove);
    temporaryObstacles.removeAll(toRemove);

    for (final obstacle in queuedObstacles) {
      collection.pathfinder.recordObstacle(obstacle);
    }

    temporaryObstacles.addAll(queuedObstacles);

    queuedObstacles.clear();

    return true;
  }

  @override
  Future<bool> init() async {
    _subscription = collection.server.messages.onMessage(
      name: LidarPointCloud().messageName,
      constructor: LidarPointCloud.fromBuffer,
      callback: _handleLidarCloud,
    );
    return true;
  }

  @override
  Future<void> dispose() async {
    await _subscription?.cancel();
  }
}
