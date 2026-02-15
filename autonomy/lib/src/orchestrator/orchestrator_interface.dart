import "dart:async";

import "package:autonomy/interfaces.dart";
import "package:meta/meta.dart";

abstract class OrchestratorInterface extends Service {
  final AutonomyInterface collection;

  AutonomyCommand? currentCommand;
  AutonomyState currentState = AutonomyState.AUTONOMY_STATE_UNDEFINED;
  PeriodicTimer? executionTimer;

  StateController controller = StateController();

  OrchestratorInterface({required this.collection});

  Future<void> onCommand(AutonomyCommand command) async {
    collection.server.sendMessage(command);
    if (command.abort) return abort();
    if (currentCommand != null) {
      collection.logger.error(
        "Already executing a command",
        body: "Abort first if you want to switch tasks",
      );
      return;
    }

    if (!collection.hasValue) {
      // We don't wait here because this was explicitly requested by the operator.
      // Users expect immediate feedback, so we give an error instead of freezing.
      collection.logger.error("Sensors haven't gotten any readings yet!");
      currentState = AutonomyState.NO_SOLUTION;
      return;
    }

    // await collection.drive.resolveOrientation();
    currentCommand = command;
    switch (command.task) {
      case AutonomyTask.BETWEEN_GATES:
        break; // TODO
      case AutonomyTask.AUTONOMY_TASK_UNDEFINED:
        break;
      case AutonomyTask.GPS_ONLY:
        handleGpsTask(command);
      case AutonomyTask.VISUAL_MARKER:
        handleArucoTask(command);
      case AutonomyTask.HAMMER_TARGET:
        handleHammerTask(command);
      case AutonomyTask.ROCK_HAMMER_TARGET:
        handleHammerTask(command);
      case AutonomyTask.BOTTLE_TARGET:
        handleBottleTask(command);
    }
  }

  @override
  Future<bool> init() async {
    collection.server.messages.onMessage(
      name: AutonomyCommand().messageName,
      constructor: AutonomyCommand.fromBuffer,
      callback: onCommand,
    );
    return true;
  }

  @mustCallSuper
  void onCommandEnd() {
    currentCommand = null;
    executionTimer?.cancel();
    executionTimer = null;
    controller.clearStates();
    collection.drive.stop();
  }

  @mustCallSuper
  Future<void> abort() async {
    collection.logger.warning("Aborting task!");
    onCommandEnd();
    currentState = AutonomyState.ABORTING;
    // await collection.dispose();
    // await collection.init();
    // exit(1);
  }

  void handleGpsTask(AutonomyCommand command);
  void handleArucoTask(AutonomyCommand command);
  void handleHammerTask(AutonomyCommand command);
  void handleBottleTask(AutonomyCommand command);

  AutonomyData get statusMessage;
}
