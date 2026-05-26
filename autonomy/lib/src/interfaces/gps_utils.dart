
import "dart:math";

import "package:autonomy/interfaces.dart";
import "package:burt_network/protobuf.dart";

extension RecordToGps on (num, num) {
  GpsCoordinates toGps() => GpsCoordinates(latitude: $1.toDouble() * GpsUtils.latitudePerMeter, longitude: $2.toDouble() * GpsUtils.longitudePerMeter);
}

extension GpsUtils on GpsCoordinates {
  static double maxErrorMeters = 1;
  static double get epsilonLatitude => maxErrorMeters * latitudePerMeter;
  static double get epsilonLongitude => maxErrorMeters * longitudePerMeter;

  static GpsCoordinates get east =>
    GpsCoordinates(longitude: -1 / metersPerLongitude);
  static GpsCoordinates get west =>
    GpsCoordinates(longitude: 1 / metersPerLongitude);
  static GpsCoordinates get north =>
    GpsCoordinates(latitude: 1 * latitudePerMeter);
  static GpsCoordinates get south =>
    GpsCoordinates(latitude: -1 * latitudePerMeter);

  // Taken from https://stackoverflow.com/a/39540339/9392211
  // static const metersPerLatitude = 111.32 * 1000;  // 111.32 km
  static const metersPerLatitude = 1;
  static const radiansPerDegree = pi / 180;
  static double get metersPerLongitude => 1;
//    40075 * cos( GpsInterface.currentLatitude * radiansPerDegree ) / 360 * 1000;

  static double get latitudePerMeter => 1 / metersPerLatitude;
  static double get longitudePerMeter => 1 / metersPerLongitude;

  double distanceTo(GpsCoordinates other) => sqrt(
    pow(latitude - other.latitude, 2) +
    pow(longitude - other.longitude, 2),
  );

  double manhattanDistance(GpsCoordinates other) =>
    (latitude - other.latitude).abs() * metersPerLatitude +
    (longitude - other.longitude).abs() * metersPerLongitude;

  bool isNear(GpsCoordinates other) =>
    (latitude - other.latitude).abs() < epsilonLatitude &&
    (longitude - other.longitude).abs() < epsilonLongitude;

  GpsCoordinates operator +(GpsCoordinates other) => GpsCoordinates(
    latitude: latitude + other.latitude,
    longitude: longitude + other.longitude,
  );

//  String prettyPrint() => "(lat=${(latitude * GpsUtils.metersPerLatitude).toStringAsFixed(2)}, long=${(longitude * GpsUtils.metersPerLongitude).toStringAsFixed(2)})";
  String prettyPrint() => toProto3Json().toString();

  GpsCoordinates goForward(DriveOrientation orientation) => this + switch(orientation) {
    DriveOrientation.north => GpsUtils.north,
    DriveOrientation.south => GpsUtils.south,
    DriveOrientation.west => GpsUtils.west,
    DriveOrientation.east => GpsUtils.east,
  };
}
