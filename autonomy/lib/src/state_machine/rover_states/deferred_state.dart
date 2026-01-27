import "package:autonomy/autonomy.dart";

class DeferredState extends RoverState {
  final StateInterface Function(StateController controller) supplier;

  DeferredState(super.controller, this.supplier);

  @override
  void enter() {
    controller.transitionTo(supplier(controller));
  }
}
