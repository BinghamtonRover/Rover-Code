import "package:autonomy/interfaces.dart";
import "package:burt_network/protobuf.dart";
import "dart:async";

class RoverOrchestrator extends OrchestratorInterface with ValueReporter {
  final List<GpsCoordinates> traversed = [];
  List<AutonomyAStarState>? currentPath;
  RoverOrchestrator({required super.collection});

  @override
  Future<void> dispose() async {
    currentPath = null;
    currentCommand = null;
    currentState = AutonomyState.AUTONOMY_STATE_UNDEFINED;
    traversed.clear();
    await super.dispose();
  }

  @override
  AutonomyData get statusMessage => AutonomyData(
    destination: currentCommand?.destination,
    state: currentState,
    obstacles: collection.pathfinder.obstacles,
    path: [
      for (final transition in currentPath ?? <AutonomyAStarState>[])
        transition.position,
      ...traversed,
    ],
    task: currentCommand?.task,
    crash: false,  // TODO: Investigate if this is used and how to use it better
  );

  @override
  Message getMessage() => statusMessage;

  @override
  Future<void> handleGpsTask(AutonomyCommand command) async {
    final destination = command.destination;
    collection.logger.info("Got GPS Task: Go to ${destination.prettyPrint()}");
    collection.logger.debug("Currently at ${collection.gps.coordinates.prettyPrint()}");
    collection.drive.setLedStrip(ProtoColor.RED);
    while (!collection.gps.coordinates.isNear(destination)) {
      // Calculate a path
      collection.logger.debug("Finding a path");
      currentState = AutonomyState.PATHING;
      await collection.drive.faceNorth();
      final path = collection.pathfinder.getPath(destination);
      currentPath = path;  // also use local variable path for promotion
      if (path == null) {
        final current = collection.gps.coordinates;
        collection.logger.error("Could not find a path", body: "No path found from ${current.prettyPrint()} to ${destination.prettyPrint()}");
        currentState = AutonomyState.NO_SOLUTION;
        currentCommand = null;
        return;
      }
      // Try to take that path
      final current = collection.gps.coordinates;
      collection.logger.info("Found a path from ${current.prettyPrint()} to ${destination.prettyPrint()}: ${path.length} steps");
      collection.logger.debug("Here is a summary of the path");
      for (final step in path) {
        collection.logger.debug(step.toString());
      }
      currentState = AutonomyState.DRIVING;
      var count = 0;
      for (final state in path) {
        collection.logger.debug(state.toString());
        await collection.drive.goDirection(state.direction);
        traversed.add(state.position);
        if (state.direction != DriveDirection.forward) continue;
        if (count++ == 5) break;
        final foundObstacle = collection.detector.findObstacles();
        if (foundObstacle) {
          collection.logger.debug("Found an obstacle. Recalculating path...");
          break;  // calculate a new path
        }
      }
    }
    collection.logger.info("Task complete");
    collection.drive.setLedStrip(ProtoColor.GREEN, blink: true);
    currentState = AutonomyState.AT_DESTINATION;
    currentCommand = null;
  }

  @override
  Future<void> handleArucoTask(AutonomyCommand command) async {
    collection.drive.setLedStrip(ProtoColor.RED);

    // Go to GPS coordinates
    // await handleGpsTask(command);
    collection.logger.info("Got ArUco Task");

    currentState = AutonomyState.SEARCHING;
    collection.logger.info("Searching for ArUco tag");
    final didSeeAruco = await collection.drive.spinForAruco();
    if (didSeeAruco) {
      collection.logger.info("Found aruco");
      currentState = AutonomyState.APPROACHING;
      await collection.drive.approachAruco();
      collection.drive.setLedStrip(ProtoColor.GREEN, blink: true);
      currentState = AutonomyState.AT_DESTINATION;
    }
  }

  @override
  Future<void> handleHammerTask(AutonomyCommand command) async {

  }

  @override
  Future<void> handleBottleTask(AutonomyCommand command) async {

  }
}
