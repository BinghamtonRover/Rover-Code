import "package:burt_network/logging.dart";
import "package:burt_network/generated.dart";

import "package:autonomy/simulator.dart";
import "package:autonomy/rover.dart";

void main() async {
  Logger.level = LogLevel.debug;
  final simulator = AutonomySimulator();
  simulator.drive = SensorlessDrive(collection: simulator, useGps: false, useImu: false);
  await simulator.init();
  await simulator.server.waitForConnection();

  final message = AutonomyData(
    destination: GpsCoordinates(latitude: 0, longitude: 0),
    state: AutonomyState.DRIVING,
    task: AutonomyTask.GPS_ONLY,
    obstacles: [],
    path: [
      for (double x = 0; x < 3; x++)
        for (double y = 0; y < 3; y++)
          GpsCoordinates(latitude: y, longitude: x),
    ],
  );
  simulator.server.sendMessage(message);

  // "Snakes" around a 3x3 meter box.    (0, 0), North
  await simulator.drive.goForward();  // (1, 0), North
  await simulator.drive.goForward();  // (2, 0), North
  await simulator.drive.turnRight();  // (2, 0), East
  await simulator.drive.goForward();  // (2, 1), East
  await simulator.drive.turnRight();  // (2, 1), South
  await simulator.drive.goForward();  // (1, 1), South
  await simulator.drive.goForward();  // (0, 1), South
  await simulator.drive.turnLeft();   // (0, 1), East
  await simulator.drive.goForward();  // (0, 2), East
  await simulator.drive.turnLeft();   // (0, 2), North
  await simulator.drive.goForward();  // (1, 2), North
  await simulator.drive.goForward();  // (2, 2), North
  await simulator.drive.turnLeft();   // (2, 2), West
  await simulator.drive.goForward();  // (2, 1), West
  await simulator.drive.goForward();  // (2, 0), West
  await simulator.drive.turnLeft();   // (2, 0), South
  await simulator.drive.goForward();  // (1, 0), South
  await simulator.drive.goForward();  // (0, 0), South
  await simulator.drive.turnLeft();   // (0, 0), East
  await simulator.drive.turnLeft();   // (0, 0), North

  final message2 = AutonomyData(
    state: AutonomyState.AT_DESTINATION,
    task: AutonomyTask.AUTONOMY_TASK_UNDEFINED,
    obstacles: [],
    path: [
      for (double x = 0; x < 3; x++)
        for (double y = 0; y < 3; y++)
          GpsCoordinates(latitude: y, longitude: x),
    ],
  );
  simulator.server.sendMessage(message2);
  simulator.server.sendMessage(message2);

  await simulator.dispose();
}
