import "dart:async";

/// An alternative to [Timer.periodic] that ensures its callback is only being run once.
///
/// Using [Timer.periodic] can cause your function to run in parallel with itself. For example:
///
/// ```dart
/// void main() => Timer.periodic(Duration(seconds: 1), twoSecondDelay);
///
/// void twoSecondDelay(_) async {
///   final id = Random().nextInt(100);
///   print("Starting task $id");
///   await Future.delayed(Duration(seconds: 2));
///   print("Finished tick $id");
/// }
/// ```
///
/// Running the above code will cause `twoSecondDelay` to be started before the previous call has
/// even finished. If your function uses a handle to a blocking resource, then the second call will
/// crash or stall while the first one is still running. This class ensures that each call to
/// [function] finishes running before the next one begins, while still making sure that they
/// are called approximately every [interval].
class PeriodicTimer {
  /// The interval at which to run [function].
  final Duration interval;

  /// The function to run. Can be synchronous or asynchronous.
  final FutureOr<void> Function(PeriodicTimer timer) function;

  /// A timer that runs the next [_tick] at exactly the right time.
  Timer? timer;

  /// Whether this timer is currently running.
  bool isRunning = true;

  /// Creates a periodic timer and starts the next tick asynchronously.
  PeriodicTimer(this.interval, this.function) {
    Timer.run(_tick);
  }

  /// Calls [function] once and ensures it is called again exactly after [interval].
  ///
  /// This function calls [function] and measures how long it takes to run. Afterwards,
  /// it waits a delay so that the delay plus the elapsed time equals [interval].
  Future<void> _tick() async {
    final startTime = DateTime.timestamp();
    await function(this);
    final delay = interval - DateTime.timestamp().difference(startTime);
    if (!isRunning) return;
    timer = Timer(delay, _tick);
  }

  /// Cancels the timer.
  void cancel() {
    isRunning = false;
    timer?.cancel();
  }

  /// Restarts the timer and begins the next tick asynchronously.
  void restart() {
    isRunning = true;
    Timer.run(_tick);
  }
}
