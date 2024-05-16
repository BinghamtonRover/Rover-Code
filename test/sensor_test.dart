import "package:autonomy/src/rover/imu.dart";
import "package:burt_network/logging.dart";
import "package:test/test.dart";

import "package:burt_network/generated.dart";

import "package:autonomy/interfaces.dart";
import "package:autonomy/simulator.dart";
import "package:autonomy/src/rover/gps.dart";

// const gpsError = GpsUtils.gpsError;
const imuError = 5.0;
const gpsPrecision = 7;

void main() => group("Sensors: ", () {
  test("GPS handles error when stationary", () async {
    // Set up a simulated and real GPS, both starting at (0, 0)
    Logger.level = LogLevel.off;
    final simulator = AutonomySimulator();
    final realGps = RoverGps(collection: simulator);
    final simulatedGps = GpsSimulator(collection: simulator, maxError: GpsInterface.gpsError);
    final origin = GpsCoordinates();
    simulatedGps.update(origin);
    realGps.update(origin);
    expect(realGps.coordinates.isNear(origin), isTrue);

    // Feed many noisy signals to produce a cleaner signal.
    for (var step = 0; step < 10; step++) {
      realGps.update(simulatedGps.coordinates);
      simulator.logger.trace("New coordinate: ${realGps.coordinates.latitude.toStringAsFixed(gpsPrecision)} vs real position: ${origin.latitude.toStringAsFixed(gpsPrecision)}");
      expect(realGps.isNear(origin), isTrue);
    }

    simulator.logger.info("Final coordinates: ${realGps.coordinates.latitude}");

    // Ensure that *very* noisy readings don't affect anything.
    simulator.logger.debug("Adding 100, 100");
    simulator.gps.update(GpsCoordinates(latitude: 100, longitude: 100));
    expect(realGps.isNear(origin), isTrue);
  });

  test("IMU error when stationary", () async {
    Logger.level = LogLevel.off;
    final simulator = AutonomySimulator();
    final simulatedImu = ImuSimulator(collection: simulator, maxError: imuError);
    final realImu = RoverImu(collection: simulator);
    final north = OrientationUtils.north;
    simulatedImu.update(north);
    for (var i = 0; i < 5; i++) {
      final orientation = simulatedImu.orientation;
      realImu.update(orientation);
    }
    realImu.update(OrientationUtils.south);
    expect(realImu.orientation.isNear(OrientationUtils.north.heading), isTrue);
    await simulator.dispose();
  });

  test("GPS handles errors when moving", () async {
    // Set up a simulated and real GPS, both starting at (0, 0)
    Logger.level = LogLevel.off;
    final simulator = AutonomySimulator();
    final realGps = RoverGps(collection: simulator);
    final simulatedGps = GpsSimulator(collection: simulator, maxError: GpsInterface.gpsError);
    var realCoordinates = GpsCoordinates();
    simulatedGps.update(realCoordinates);
    realGps.update(realCoordinates);
    expect(realGps.coordinates.isNear(realCoordinates), isTrue);

    // For each step forward, use the noisy GPS to update the real GPS.
    for (var step = 0; step < 10; step++) {
      realCoordinates += GpsUtils.north;
      simulatedGps.update(realCoordinates);
      realGps.update(simulatedGps.coordinates);
      simulator.logger.trace("New coordinate: ${realGps.coordinates.latitude.toStringAsFixed(5)} vs real position: ${realCoordinates.latitude.toStringAsFixed(5)}");
      simulator.logger.trace("  Difference: ${(realGps.latitude - realCoordinates.latitude).abs().toStringAsFixed(5)} < ${GpsUtils.epsilonLatitude.toStringAsFixed(5)}");
      expect(realGps.isNear(realCoordinates), isTrue);
    }

    // Ensure that *very* noisy readings don't affect anything.
    simulator.logger.debug("Adding 100, 100");
    simulator.gps.update(GpsCoordinates(latitude: 100, longitude: 100));
    expect(realGps.isNear(realCoordinates), isTrue);
  });
});
