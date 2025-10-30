import "package:autonomy/src/state_machine/rover_state_machine.dart";

/// State to add a timeout to a state
///
/// The [child] of this state will be updated each time update is
/// called on this state, but when [timeout] amount of time elapses
/// after starting, the state will be popped.
class TimeoutDecorator extends RoverState {
  /// The child state the timeout will be applied to
  final RoverState child;

  /// The timeout duration
  final Duration timeout;

  /// The function to execute when the timeout is reached
  final StateCallback onTimeout;

  DateTime _startTime = DateTime(0);

  /// Constructor for [TimeoutDecorator]
  TimeoutDecorator({
    required this.child,
    required this.timeout,
    required this.onTimeout,
  }) : super(child.controller);

  @override
  void enter() {
    _startTime = DateTime.now();
    child.enter();
  }

  @override
  void update() {
    if (DateTime.now().difference(_startTime) > timeout) {
      return onTimeout(controller);
    }
    child.update();
  }

  @override
  void exit() {
    child.exit();
  }
}
