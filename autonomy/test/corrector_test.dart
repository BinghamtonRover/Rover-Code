import "package:autonomy/autonomy.dart";
import "package:test/test.dart";

void main() => group("[Corrector]", tags: ["corrector"], () {
  test("Sample Average", () {
    final random = RandomError(5);
    final corrector = ErrorCorrector(maxSamples: 10);

    corrector.addValue(0);

    var count = 0;
    for (var i = 0; i < 1000; i++) {
      corrector.addValue(random.value);

      if (corrector.calibratedValue.abs() < 1.25) count++;
    }
    final percentage = count / 1000;
    expect(percentage, greaterThan(0.75));
  });

  test("Rejects Outliers", () {
    final corrector = ErrorCorrector(maxSamples: 10, maxDeviation: 5);

    corrector.addValue(100);
    corrector.addValue(-50);
    corrector.addValue(20);

    expect(corrector.calibratedValue, 100);
  });
});
