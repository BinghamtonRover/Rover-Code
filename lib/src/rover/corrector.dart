import "dart:collection";

class ErrorCorrector {  // non-nullable
  final int maxSamples;
  final double maxDeviation;
  ErrorCorrector({required this.maxSamples, this.maxDeviation = double.infinity});
  
  double calibratedValue = 0;
  final Queue<double> recentSamples = DoubleLinkedQueue();
  
  void addValue(double value) {
    if (recentSamples.isEmpty) {
      recentSamples.add(value);
      calibratedValue = value;
      return;
    }
    final deviation = (calibratedValue - value).abs();
    if (deviation > maxDeviation) return;
    if (recentSamples.length == maxSamples) recentSamples.removeLast();
    recentSamples.addFirst(value);
    calibratedValue = recentSamples.weightedAverage();
  }
}

extension on Iterable<num> {
  double weightedAverage() {
    num sum = 0;
    var count = 0;
    for (final element in this) {
      sum += element; 
      count++;
    }
    return sum / count;
  }
}
