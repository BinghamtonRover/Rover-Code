import "package:autonomy/constants.dart";
import "package:autonomy/interfaces.dart";
import "package:autonomy/src/drive/drive_commands.dart";
import "package:autonomy/src/drive/drive_config.dart";
import "package:autonomy/src/orchestrator/rover_orchestrator.dart";

class SensorForwardState extends RoverState {
  final AutonomyInterface collection;
  final GpsCoordinates position;

  final RoverDriveCommands drive;

  DriveConfig get config => collection.drive.config;

  SensorForwardState(
    super.controller, {
    required this.collection,
    required this.position,
    required this.drive,
  });

  @override
  void update() {
    drive.setThrottle(config.forwardThrottle);
    drive.moveForward();

    if (collection.pathfinder.isObstacle(collection.gps.coordinates)) {
      if (collection.orchestrator is RoverOrchestrator) {
        (collection.orchestrator as RoverOrchestrator).triggerPathReplan();
      }
      controller.popState();
    }

    if (collection.gps.isNear(position, Constants.intermediateStepTolerance)) {
      controller.popState();
    }
  }
}
