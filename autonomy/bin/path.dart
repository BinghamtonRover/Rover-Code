import "package:autonomy/interfaces.dart";
import "package:autonomy/rover.dart";
import "package:autonomy/simulator.dart";
import "package:coordinate_converter/coordinate_converter.dart";

void main() {
  final destination = UTMCoordinates(
    x: 5 + 1000,
    y: 5 + 1000,
    zoneNumber: 31,
  ).toGps();
  final simulator = AutonomySimulator();
  simulator.pathfinder = RoverPathfinder(collection: simulator);
  simulator.gps.update(UTMCoordinates(x: 5, y: 5, zoneNumber: 31).toGps());
  final path = simulator.pathfinder.getPath(destination);
  if (path == null) {
    simulator.logger.critical(
      "Could not find path to ${destination.prettyPrint()}",
    );
    return;
  }
  if (path.isEmpty) {
    simulator.logger.critical("Path was empty");
    return;
  }
  var turnCount = 0;
  for (final step in path) {
    if (step.instruction.isTurn) {
      turnCount++;
    }
  }
  simulator.logger.info(
    "Got a path with ${path.length} steps and $turnCount turn(s)",
  );
}
