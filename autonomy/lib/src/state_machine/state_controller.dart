import "package:autonomy/src/state_machine/rover_state_machine.dart";
import "package:meta/meta.dart";

/// Class to control a Stack based State Machine, handling state pushes,
/// pops, and transitions
///
/// The class maintains a stack of [StateInterface], where the most recent
/// state, or the one at the top of the stack, is the one being updated.
///
/// When a new state is pushed, it will be added to the top of the state
/// stack, and becomes the new state being updated. This means that any
/// states underneath will no longer be updated.
///
/// When a state is popped, it is removed from the top of the stack, and will be exited.
class StateController {
  @visibleForTesting
  List<StateInterface> get stack => _stateStack;

  final List<StateInterface> _stateStack = [];

  /// Pushes a new state to the top of the stack, and enters it
  void pushState(StateInterface state) {
    _stateStack.add(state);
    state.enter();
  }

  /// Pops and exits the latest state from the top of the stack and replaces it with [state]
  void transitionTo(StateInterface state) {
    _stateStack.removeLast().exit();
    _stateStack.add(state);
    state.enter();
  }

  /// Clears all states from the stack
  void clearStates() {
    final originalLength = _stateStack.length;
    for (var i = 0; i < originalLength; i++) {
      popState();
    }
  }

  /// Pops the latest state from the top of the stack
  void popState() {
    if (_stateStack.isEmpty) {
      return;
    }
    _stateStack.removeLast().exit();
  }

  /// Pops all states the come before a state of type [T], not including [T]
  void popUntil<T>() {
    final index = _stateStack.lastIndexWhere((element) => element is T);

    if (index == -1) {
      return;
    }

    final amountToRemove = _stateStack.length - index - 1;
    for (var i = 0; i < amountToRemove; i++) {
      popState();
    }
  }

  /// Updates the state controller, calling the update
  /// method on the last element of the state stack
  void update() {
    if (_stateStack.isNotEmpty) {
      _stateStack.last.update();
    }
  }

  /// Whether or not there are any states in the stack
  bool hasState() => _stateStack.isNotEmpty;

  /// Whether or not there is a substate, or more than one state, in the stack
  bool hasSubstate() => _stateStack.length > 1;
}
