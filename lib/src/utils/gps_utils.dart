import "dart:math";

import "package:autonomy/constants.dart";
import "package:autonomy/interfaces.dart";
import "package:coordinate_converter/coordinate_converter.dart";

/// An alias for gps coordinates measured in meters
typedef GpsMeters = ({num lat, num long});

/// Utility math methods for GpsMeters
extension GpsMetersUtil on GpsMeters {
  /// Add 2 [GpsMeters] together
  GpsMeters operator +(GpsMeters other) =>
      (lat: lat + other.lat, long: long + other.long);

  /// Subtract 2 [GpsMeters] from each other
  GpsMeters operator -(GpsMeters other) =>
      (lat: lat - other.lat, long: long - other.long);
}

extension GpsUtils on GpsCoordinates {
  static UTMCoordinates eastMeters = UTMCoordinates(
    y: 0,
    x: Constants.moveLengthMeters,
    zoneNumber: 1,
  );
  static UTMCoordinates westMeters = UTMCoordinates(
    y: 0,
    x: -Constants.moveLengthMeters,
    zoneNumber: 1,
  );
  static UTMCoordinates northMeters = UTMCoordinates(
    y: Constants.moveLengthMeters,
    x: 0,
    zoneNumber: 1,
  );
  static UTMCoordinates southMeters = UTMCoordinates(
    y: -Constants.moveLengthMeters,
    x: 0,
    zoneNumber: 1,
  );
  static final UTMCoordinates northEastMeters = northMeters + eastMeters;
  static final UTMCoordinates northWestMeters = northMeters + westMeters;
  static final UTMCoordinates southEastMeters = southMeters + eastMeters;
  static final UTMCoordinates southWestMeters = southMeters + westMeters;

  /// Whether or not the coordinates is fused with the RTK algorithm
  bool get hasRTK =>
      rtkMode == RTKMode.RTK_FIXED || rtkMode == RTKMode.RTK_FLOAT;

  /// The distance to [other] using the haversine formula
  double distanceTo(GpsCoordinates other) {
    // Radius of the earth in meters
    const double earthRadius = 6371000;
    // Calculate the differences between the coordinates
    final deltaLat = (latitude - other.latitude) * pi / 180;
    final deltaLong = (longitude - other.longitude) * pi / 180;

    // Apply the Haversine formula
    final a =
        pow(sin(deltaLat / 2), 2) +
        cos(other.latitude * pi / 180) *
            cos(latitude * pi / 180) *
            pow(sin(deltaLong / 2), 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }

  double heuristicDistance(GpsCoordinates other) {
    var distance = 0.0;
    final delta = toUTM() - other.toUTM();
    final deltaLat = delta.y.abs();
    final deltaLong = delta.x.abs();

    final minimumDistance = min(deltaLat, deltaLong);
    if (minimumDistance >= Constants.moveLengthMeters) {
      distance += (minimumDistance ~/ Constants.moveLengthMeters) * sqrt2;
    }

    final translationDelta = (deltaLat - deltaLong).abs();

    if (translationDelta >= Constants.moveLengthMeters) {
      distance += translationDelta ~/ Constants.moveLengthMeters;
    }

    return distance;
  }

  double manhattanDistance(GpsCoordinates other) {
    final delta = toUTM() - other.toUTM();
    return delta.x.abs() + delta.y.abs();
  }

  double octileDistance(GpsCoordinates other) {
    final delta = toUTM() - other.toUTM();
    final dx = delta.x.abs() ~/ Constants.moveLengthMeters;
    final dy = delta.y.abs() ~/ Constants.moveLengthMeters;

    return max(dx, dy) + (sqrt2 - 1) * min(dx, dy);
  }

  bool isNear(GpsCoordinates other, [double? tolerance]) {
    tolerance ??= Constants.maxErrorMeters;

    return distanceTo(other) <= tolerance;
  }

  GpsCoordinates operator +(GpsCoordinates other) =>
      (toUTM() + other.toUTM()).toGps();

  GpsCoordinates operator -(GpsCoordinates other) =>
      (toUTM() - other.toUTM()).toGps();

  String prettyPrint() => toProto3Json().toString();

  GpsCoordinates goForward(CardinalDirection orientation) =>
      (toUTM() +
              switch (orientation) {
                CardinalDirection.north => GpsUtils.northMeters,
                CardinalDirection.south => GpsUtils.southMeters,
                CardinalDirection.west => GpsUtils.westMeters,
                CardinalDirection.east => GpsUtils.eastMeters,
                CardinalDirection.northEast => GpsUtils.northEastMeters,
                CardinalDirection.northWest => GpsUtils.northWestMeters,
                CardinalDirection.southEast => GpsUtils.southEastMeters,
                CardinalDirection.southWest => GpsUtils.southWestMeters,
              })
          .toGps();
}
