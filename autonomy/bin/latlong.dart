// ignore_for_file: avoid_print

import "package:autonomy/constants.dart";
import "package:autonomy/interfaces.dart";

const binghamtonLatitude = 42.0877327;
const utahLatitude = 38.406683;

void printInfo(String name, double latitude) {
  final metersPerLongitude = GpsToMeters.metersPerLongitude(latitude);
  print("At $name:");
  print(
    "  There are ${metersPerLongitude.toStringAsFixed(2)} meters per 1 degree of longitude",
  );
  print(
    "  Our max error in longitude would be ${(Constants.maxErrorMeters / metersPerLongitude).toStringAsFixed(20)} degrees",
  );
  final isWithinRange =
      Constants.gpsError <= Constants.maxErrorMeters / metersPerLongitude;
  print(
    "  Our GPS has ${Constants.gpsError} degrees of error, so this would ${isWithinRange ? 'work' : 'not work'}",
  );
}

void main() {
  print(
    "There are always ${GpsToMeters.metersPerLatitude} meters in 1 degree of latitude",
  );
  print(
    "  So our max error in latitude is always ${(Constants.maxErrorMeters / GpsToMeters.metersPerLatitude).toStringAsFixed(20)} degrees",
  );
  printInfo("the equator", 0);
  printInfo("Binghamton", binghamtonLatitude);
  printInfo("Utah", utahLatitude);
}
