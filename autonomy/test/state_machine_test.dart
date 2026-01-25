import "package:autonomy/src/state_machine/rover_state_machine.dart";
import "package:test/test.dart";

class TrackingState extends RoverState {
  int enterCount = 0;
  int updateCount = 0;
  int exitCount = 0;

  TrackingState(super.controller);

  @override
  void enter() => enterCount++;

  @override
  void update() => updateCount++;

  @override
  void exit() => exitCount++;
}

void main() => group("[State Machine]", tags: ["state_machine"], () {
  final controller = StateController();

  test("Pushing and popping", () {
    final state = TrackingState(controller);

    controller.pushState(state);

    expect(state.enterCount, 1);
    controller.update();
    expect(state.updateCount, 1);
    controller.popState();
    expect(state.exitCount, 1);
  });

  test("Pushing multiple", () {
    final state1 = TrackingState(controller);
    final state2 = TrackingState(controller);

    controller.pushState(state1);

    expect(state1.enterCount, 1);
    controller.update();
    expect(state1.updateCount, 1);

    controller.pushState(state2);

    expect(state1.exitCount, 0);

    expect(state2.enterCount, 1);
    controller.update();
    expect(state2.updateCount, 1);
    controller.popState();
    expect(state2.exitCount, 1);
    expect(state1.exitCount, 0);

    controller.popState();

    expect(state1.exitCount, 1);
  });

  test("Sequence", () {
    final state1 = TrackingState(controller);
    final state2 = TrackingState(controller);
    final sequence = SequenceState(controller, steps: [state1, state2]);

    controller.pushState(sequence);

    // State 1 gets pushed, state 2 remains idle
    expect(state1.enterCount, 1);
    expect(state2.enterCount, 0);

    controller.update();

    // State 1 gets updated
    expect(state1.updateCount, 1);
    expect(state2.updateCount, 0);

    controller.popState();

    // State 1 exits, state 2 doesn't enter until next update
    expect(state1.exitCount, 1);
    expect(state2.enterCount, 0);

    controller.update();

    // State 2 enters, doesn't update until next controller update
    expect(state1.updateCount, 1);
    expect(state2.enterCount, 1);
    expect(state2.updateCount, 0);

    controller.update();

    expect(state2.updateCount, 1);
  });

  test("Timeout", () async {
    const timeoutDuration = Duration(milliseconds: 10);

    var timedOut = false;

    final state1 = TrackingState(controller);
    final timeout = TimeoutDecorator(
      child: state1,
      timeout: timeoutDuration,
      onTimeout: (_) {
        timedOut = true;
      },
    );

    controller.pushState(timeout);
    controller.update();
    expect(timedOut, false);

    await Future<void>.delayed(timeoutDuration);

    // Doesn't time out until next update
    expect(timedOut, false);
    controller.update();
    expect(timedOut, true);
  });

  test("Delayed State", () async {
    const delayTime = Duration(milliseconds: 10);

    final state1 = TrackingState(controller);
    final state2 = TrackingState(controller);
    final sequence = SequenceState(
      controller,
      steps: [
        state1,
        DelayedState(controller, delayTime: delayTime),
        state2,
      ],
    );

    controller.pushState(sequence);

    expect(state1.enterCount, 1);
    expect(state2.enterCount, 0);

    controller.update();

    expect(state1.updateCount, 1);
    expect(state2.updateCount, 0);

    controller.popState();

    expect(state1.exitCount, 1);
    expect(state2.enterCount, 0);

    controller.update();

    expect(state1.updateCount, 1);
    expect(state2.enterCount, 0);
    expect(state2.updateCount, 0);

    controller.update();

    expect(state1.updateCount, 1);
    expect(state2.enterCount, 0);
    expect(state2.updateCount, 0);

    await Future<void>.delayed(delayTime);

    controller.update();

    expect(state1.updateCount, 1);
    expect(state2.enterCount, 0);
    expect(state2.updateCount, 0);

    controller.update();

    expect(state1.updateCount, 1);
    expect(state2.enterCount, 1);
    expect(state2.updateCount, 0);

    controller.update();

    expect(state2.updateCount, 1);
  });
});
