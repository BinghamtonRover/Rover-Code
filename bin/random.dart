// ignore_for_file: avoid_print

import "package:autonomy/interfaces.dart";
import "package:autonomy/src/rover/corrector.dart";

const maxError = GpsInterface.gpsError;
const maxSamples = 10;
final epsilon = GpsUtils.epsilonLatitude;  // we need to be accurate within 1 meter
const n = 1000;
bool verbose = false;

bool test() {
  final error = RandomError(maxError);
  final corrector = ErrorCorrector(maxSamples: maxSamples);
  for (var i = 0; i < 100; i++) {
    final value = error.value;
    corrector.addValue(value);
    if (verbose) {
      final calibrated = corrector.calibratedValue;
      print("Current value: $value, Corrected value: $calibrated");    
      print("  Difference: ${calibrated.toStringAsFixed(7)} < ${epsilon.toStringAsFixed(7)}");
    }
  }
  return corrector.calibratedValue.abs() <= epsilon;
}

void main(List<String> args) {
  if (args.contains("-v") || args.contains("--verbose")) verbose = true;
  var count = 0;
  for (var i = 0; i < n; i++) {
    if (test()) count++;
  }
  final percentage = (count / n * 100).toStringAsFixed(2);
  print("Average performance: %$percentage");
}
