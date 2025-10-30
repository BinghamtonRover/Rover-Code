import "dart:math";

class RandomError {
  final double maxError;
  final _random = Random();

  RandomError(this.maxError);

  double get value {
    final sign = _random.nextBool() ? 1 : -1;
    final value = _random.nextDouble() * maxError;
    return sign * value;
  }
}
