import "dart:math";

import "package:burt_network/generated.dart";
import "package:autonomy/interfaces.dart";

extension RecordToGps on (num, num) {
  GpsCoordinates toGps() => GpsCoordinates(latitude: $1.toDouble() * GpsUtils.latitudePerMeter, longitude: $2.toDouble() * GpsUtils.longitudePerMeter);
}

extension GpsUtils on GpsCoordinates {
  static const maxErrorMeters = 3;
  static double get epsilonLatitude => maxErrorMeters / metersPerLatitude; 
  static double get epsilonLongitude => maxErrorMeters / metersPerLongitude; 

  static GpsCoordinates get east => 
    GpsCoordinates(longitude: 1 / metersPerLongitude);
  static GpsCoordinates get west => 
    GpsCoordinates(longitude: -1 / metersPerLongitude);
  static GpsCoordinates get north => 
    GpsCoordinates(latitude: 1 / metersPerLatitude);
  static GpsCoordinates get south => 
    GpsCoordinates(latitude: 1 / metersPerLatitude);

  // Taken from https://stackoverflow.com/a/39540339/9392211
  static const metersPerLatitude = 111.32 * 1000;  // 111.32 km
  static const radiansPerDegree = pi / 180;
  static double get metersPerLongitude => 
    40075 * cos( GpsInterface.currentLatitude * radiansPerDegree ) / 360 * 1000;
  
  static double get latitudePerMeter => 1 / metersPerLatitude;
  static double get longitudePerMeter => 1 / metersPerLongitude;
  
  double distanceTo(GpsCoordinates other) => sqrt(
    pow(latitude - other.latitude, 2) +
    pow(longitude - other.longitude, 2),
  );

  double manhattanDistance(GpsCoordinates other) => 
    (latitude - other.latitude).abs() + 
    (longitude - other.longitude).abs();

  bool isNear(GpsCoordinates other) => 
    (latitude - other.latitude).abs() < epsilonLatitude &&
    (longitude - other.longitude).abs() < epsilonLongitude;

  GpsCoordinates operator +(GpsCoordinates other) => GpsCoordinates(
    latitude: latitude + other.latitude,
    longitude: longitude + other.longitude,
  );

  String prettyPrint() => "(lat=$latitude, long=$longitude)";

  GpsCoordinates goForward(Orientation orientation) => this + switch(orientation.z) {
    0 => north,
    90 => west,
    180 => south,
    270 => east,
    _ => throw ArgumentError("Unrecognized orientation: $orientation"),
  };

  bool isPast(GpsCoordinates other, Orientation orientation) => switch (orientation.z) {
    0 => latitude >= other.latitude,
    90 => longitude >= other.longitude,
    180 => latitude <= other.latitude,
    270 => longitude <= other.longitude,
    _ => throw ArgumentError("Unrecognized orientation: $orientation"),
  };
}

abstract class GpsInterface extends Service {
  static const gpsError = 0.00003;
  static double currentLatitude = 0;

  final AutonomyInterface collection;
  GpsInterface({required this.collection});
  
  double get longitude => coordinates.longitude;
  double get latitude => coordinates.latitude;

  void update(GpsCoordinates newValue);
  GpsCoordinates get coordinates;

  bool isNear(GpsCoordinates coordinates) => 
    coordinates.isNear(coordinates);
}
