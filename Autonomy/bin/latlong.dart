// ignore_for_file: avoid_print

import "package:autonomy/interfaces.dart";

const binghamtonLatitude = 42.0877327;
const utahLatitude = 38.406683;

void printInfo(String name, double latitude) {
  GpsInterface.currentLatitude = latitude;
  print("At $name:");
  print("  There are ${GpsUtils.metersPerLongitude.toStringAsFixed(2)} meters per 1 degree of longitude");
  print("  Our max error in longitude would be ${GpsUtils.epsilonLongitude} degrees");
  final isWithinRange = GpsInterface.gpsError <= GpsUtils.epsilonLongitude;
  print("  Our GPS has ${GpsInterface.gpsError} degrees of error, so this would ${isWithinRange ? 'work' : 'not work'}");
}

void main() {
  print("There are always ${GpsUtils.metersPerLatitude} meters in 1 degree of latitude");
  print("  So our max error in latitude is always ${GpsUtils.epsilonLatitude} degrees");
  printInfo("the equator", 0);
  printInfo("Binghamton", binghamtonLatitude);
  printInfo("Utah", utahLatitude);
}
