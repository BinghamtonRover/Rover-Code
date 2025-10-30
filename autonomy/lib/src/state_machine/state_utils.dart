import "package:autonomy/src/state_machine/rover_state_machine.dart";

/// State that can only be ran for [delayTime] amount of time
/// after entering before it automatically pops itself from the
/// state stack
///
/// This is commonly used in sequences to add a delay between actions.
/// This state has no functional logic to it.
class DelayedState extends RoverState {
  /// The amount of time to wait for before popping
  final Duration delayTime;

  DateTime _startTime = DateTime(0);

  /// Default constructor for [DelayedState], initializing the delay time
  DelayedState(super.controller, {required this.delayTime});

  @override
  void enter() {
    _startTime = DateTime.now();
  }

  @override
  void update() {
    if (DateTime.now().difference(_startTime) >= delayTime) {
      controller.popState();
    }
  }
}

/// A state with no internal logic that operates only on [StateCallback]s given by the user.
///
/// This state is to allow for simple states to be created inline rather than from a subclass.
class FunctionalState extends RoverState {
  /// [StateCallback] for when the state is entered
  final StateCallback? onEnter;

  /// [StateCallback] for when the state is updated
  final StateCallback? onUpdate;

  /// [StateCallback] for when the state is exited
  final StateCallback? onExit;

  /// Default constructor for [FunctionalState], initializing callbacks
  /// for entering, updating, and exiting
  FunctionalState(super.controller, {this.onEnter, this.onUpdate, this.onExit});

  @override
  void enter() => onEnter?.call(controller);

  @override
  void update() => onUpdate?.call(controller);

  @override
  void exit() => onExit?.call(controller);
}

/// A state which pushes multiple sub-states in order
///
/// This will push and execute the provided [steps] in order,
/// until all states have been entered and finished
class SequenceState extends RoverState {
  /// The list of states to execute in order
  final List<StateInterface> steps;

  int _stepIndex = 0;

  /// Default constructor for [SequenceState], initializing the steps
  SequenceState(super.controller, {required this.steps});

  @override
  void enter() {
    _stepIndex = 0;
    if (steps.isNotEmpty) {
      controller.pushState(steps[_stepIndex]);
    }
  }

  @override
  void update() {
    _stepIndex++;
    // There's another state left in the sequence, push it
    if (_stepIndex < steps.length) {
      controller.pushState(steps[_stepIndex]);
    } else {
      // sequence is done
      controller.popState();
    }
  }
}
