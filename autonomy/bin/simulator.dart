import "package:autonomy/autonomy.dart";
import "package:autonomy/src/drive/drive_config.dart";
import "package:burt_network/burt_network.dart";

void main() async {
  Logger.level = Level.debug;
  final simulator = AutonomySimulator();

  simulator.pathfinder = RoverPathfinder(collection: simulator);
  simulator.orchestrator = RoverOrchestrator(collection: simulator);
  simulator.drive = DriveSimulator(
    collection: simulator,
    method: SimulationMethod.intermediate,
    config: roverConfig.copyWith(
      oneMeterDelay: const Duration(milliseconds: 500),
      turnDelay: const Duration(milliseconds: 750),
      subsystemsAddress: "127.0.0.1",
    ),
  );
  simulator.detector = NetworkDetector(collection: simulator);

  await simulator.init();
}
