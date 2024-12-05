import "package:test/test.dart";

import "package:autonomy/autonomy.dart";
import "package:burt_network/burt_network.dart";

void main() => group("[Simulator]", tags: ["simulator"], () {
  test("Simulator can be restarted", () async { 
    Logger.level = LogLevel.off;
    final simulator = AutonomySimulator();
    expect(simulator.isInitialized, isFalse);
    await simulator.init();
    expect(simulator.isInitialized, isTrue);
    await simulator.restart();
    expect(simulator.isInitialized, isTrue);
    await simulator.dispose();
    expect(simulator.isInitialized, isFalse);
  });
  
  test("Simulated drive test with simulated GPS", () async {
    Logger.level = LogLevel.off;
    final simulator = AutonomySimulator();
    var position = GpsCoordinates();
    final gps = simulator.gps;
    expect(gps.coordinates.isNear(position), isTrue);
    // Turning left takes you +90 degrees
    await simulator.drive.turnLeft();
    expect(simulator.imu.heading, 90);
    expect(gps.coordinates.isNear(position), isTrue);
    // Turning right takes you -90 degrees
    await simulator.drive.turnRight();
    expect(simulator.imu.heading, 0);
    expect(gps.coordinates.isNear(position), isTrue);
    // Going straight takes you 1 cell forward
    await simulator.drive.goForward();
    position += GpsUtils.north;
    expect(gps.coordinates.isNear(position), isTrue);
    expect(simulator.imu.heading, 0);
    // Going forward at 90 degrees
    await simulator.drive.turnLeft();
    await simulator.drive.goForward();
    position += GpsUtils.west;
    expect(gps.coordinates.isNear(position), isTrue);
    expect(simulator.imu.heading, 90);   
    // Going forward at 180 degrees
    await simulator.drive.turnLeft();
    await simulator.drive.goForward();
    position += GpsUtils.south;
    expect(gps.coordinates.isNear(position), isTrue);
    expect(simulator.imu.heading, 180);   
    // Going forward at 270 degrees
    await simulator.drive.turnLeft();
    await simulator.drive.goForward();
    position += GpsUtils.east;
    expect(gps.coordinates.isNear(position), isTrue);
    expect(simulator.imu.heading, 270);   
    // 4 lefts go back to north
    await simulator.drive.turnLeft();
    expect(simulator.imu.heading, 0);
    expect(gps.coordinates.isNear(position), isTrue);
    await simulator.dispose();
  });

  test("Already has values", () async {
    final simulator = AutonomySimulator();
    expect(simulator.hasValue, isFalse);
    await simulator.init();
    expect(simulator.hasValue, isTrue);
  });
});
