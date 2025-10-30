import "package:autonomy/src/state_machine/rover_state_machine.dart";

/// Abstracted version of a state
abstract class StateInterface {
  /// The controller for the state machine
  StateController get controller;

  /// Called when the state is initially entered
  void enter();

  /// Called when the state is updated from the controller
  void update();

  /// Called when the state is exited or removed from the stack
  void exit();
}

/// An implementation of [StateInterface] to be used for the rover
///
/// Stores an own internal [StateController]
class RoverState implements StateInterface {
  @override
  final StateController controller;

  /// Constructor for [RoverState] initializing its controller
  RoverState(this.controller);

  @override
  void enter() {}

  @override
  void update() {}

  @override
  void exit() {}
}
