import "package:autonomy/autonomy.dart";
import "package:coordinate_converter/coordinate_converter.dart";

final GpsCoordinates origin = UTMCoordinates(
  x: 5,
  y: 5,
  zoneNumber: 31,
).toGps();

extension GpsTransformUtil on GpsCoordinates {
  GpsCoordinates plus({required double x, required double y}) =>
      (toUTM() + UTMCoordinates(x: x, y: y, zoneNumber: 31)).toGps();
}
