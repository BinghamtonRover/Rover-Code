import "package:autonomy/interfaces.dart";
import "package:burt_network/generated.dart";

class OrchestratorSimulator extends OrchestratorInterface {
  OrchestratorSimulator({required super.collection});

  @override
  Future<bool> init() async => true;

  @override
  Future<void> dispose() async { }

  @override
  AutonomyData get statusMessage => AutonomyData();

  @override
  Future<void> handleGpsTask(AutonomyCommand command) async {

  }

  @override
  Future<void> handleArucoTask(AutonomyCommand command) async {

  }

  @override
  Future<void> handleHammerTask(AutonomyCommand command) async {

  }

  @override
  Future<void> handleBottleTask(AutonomyCommand command) async {

  }
}
