import "package:autonomy/src/rover/imu.dart";
import "package:burt_network/logging.dart";
import "package:test/test.dart";

import "package:burt_network/generated.dart";

import "package:autonomy/interfaces.dart";
import "package:autonomy/simulator.dart";
import "package:autonomy/src/rover/gps.dart";

const imuError = 2.5;
const gpsPrecision = 7;

void main() => group("[Sensors]", tags: ["sensors"], () {
  setUp(() => Logger.level = LogLevel.off);
  tearDown(() => Logger.level = LogLevel.off);

  test("GpsUtils.isNear", () {
    final origin = (0, 0).toGps();
    expect(GpsCoordinates(latitude: 0, longitude: 0), origin);
    expect(origin.isNear(origin), isTrue);

    final a = (5, 5).toGps();
    final a2 = (5, 5).toGps();
    final b = (5, 6.5).toGps();

    expect(a.isNear(a), isTrue);
    expect(a.isNear(a2), isTrue);
    expect(a.isNear(b), isFalse);

    final c = GpsCoordinates(latitude: 0, longitude: 0);
    final d = GpsCoordinates(latitude: 45.123, longitude: 72.123);
    final e = GpsCoordinates(latitude: 12.123, longitude: 24.123);

    expect(c.isNear(d), isFalse);
    expect(c.isNear(e), isFalse);
    expect(d.isNear(e), isFalse);

    final f = (12, 12).toGps();
    final g = (12.2, 12.2).toGps();
    expect(f.isNear(g), isTrue);
  });

  test("GPS noise when stationary", () async {
    // Set up a simulated and real GPS, both starting at (0, 0)
    final oldError = GpsUtils.maxErrorMeters;
    GpsUtils.maxErrorMeters = 3;
    Logger.level = LogLevel.off;
    
    final simulator = AutonomySimulator();
    final realGps = RoverGps(collection: simulator);
    final simulatedGps = GpsSimulator(collection: simulator, maxError: GpsInterface.gpsError);
    final origin = GpsCoordinates();
    simulatedGps.update(origin);
    realGps.update(origin);
    expect(realGps.isNear(origin), isTrue);

    // Feed many noisy signals to produce a cleaner signal.
    var count = 0;
    for (var step = 0; step < 1000; step++) {
      realGps.update(simulatedGps.coordinates);
      simulator.logger.trace("New coordinate: ${realGps.coordinates.latitude.toStringAsFixed(gpsPrecision)} vs real position: ${origin.latitude.toStringAsFixed(gpsPrecision)}");
      if (step < 10) continue;
      if (realGps.isNear(origin)) count++;
    }

    final percentage = count / 1000;
    simulator.logger.info("Final coordinates: ${realGps.coordinates.latitude}");
    expect(percentage, greaterThan(0.75), reason: "GPS should be accurate >75% of the time: $percentage");

    // Ensure that *very* noisy readings don't affect anything.
    simulator.logger.debug("Adding 100, 100");
    simulator.gps.update(GpsCoordinates(latitude: 100, longitude: 100));
    expect(realGps.isNear(origin), isTrue);

    await simulator.dispose();
    GpsUtils.maxErrorMeters = oldError;
  });

  test("IMU noise when stationary", () async {
    Logger.level = LogLevel.off;
    final simulator = AutonomySimulator();
    final simulatedImu = ImuSimulator(collection: simulator, maxError: imuError);
    final realImu = RoverImu(collection: simulator);
    final north = OrientationUtils.north;
    simulatedImu.update(north);
    
    var count = 0;
    for (var i = 0; i < 1000; i++) {
      final newData = simulatedImu.raw;
      realImu.update(newData);
      simulator.logger.trace("Got new value: ${newData.heading}");
      simulator.logger.trace("  New heading: ${realImu.heading}");
      simulator.logger.trace("  Real position: ${north.heading}");
      if (i < 10) continue;
      simulator.logger.trace("  Values are similar: ${realImu.isNear(north.heading)}");
      if (realImu.isNear(north.heading)) count++;
    }

    final percentage = count / 1000;
    simulator.logger.info("Final orientation: ${realImu.heading}");
    expect(percentage, greaterThan(0.75), reason: "IMU should be accurate >75% of the time: $percentage");

    
    realImu.update(OrientationUtils.south);
    expect(realImu.isNear(OrientationUtils.north.heading), isTrue);
    await simulator.dispose();
  });

  test("GPS noise when moving", () async {
    // Set up a simulated and real GPS, both starting at (0, 0)
    final oldError = GpsUtils.maxErrorMeters;
    GpsUtils.maxErrorMeters = 3;
    final simulator = AutonomySimulator();
    final realGps = RoverGps(collection: simulator);
    final simulatedGps = GpsSimulator(collection: simulator, maxError: GpsInterface.gpsError);
    var realCoordinates = GpsCoordinates();
    simulatedGps.update(realCoordinates);
    realGps.update(realCoordinates);
    expect(realGps.coordinates.isNear(realCoordinates), isTrue);

    // For each step forward, use the noisy GPS to update the real GPS.
    var count = 0;
    for (var step = 0; step < 1000; step++) {
      realCoordinates += GpsUtils.north;
      simulatedGps.update(realCoordinates);
      realGps.update(simulatedGps.coordinates);
      simulator.logger.trace("New coordinate: ${realGps.coordinates.latitude.toStringAsFixed(5)} vs real position: ${realCoordinates.latitude.toStringAsFixed(5)}");
      simulator.logger.trace("  Difference: ${(realGps.latitude - realCoordinates.latitude).abs().toStringAsFixed(5)} < ${GpsUtils.epsilonLatitude.toStringAsFixed(5)}");
      if (step < 10) continue;
      if (realGps.isNear(realCoordinates)) count++;
    }

    final percentage = count / 1000;
    simulator.logger.info("Final coordinates: ${realGps.coordinates.prettyPrint()} vs actual: ${realCoordinates.prettyPrint()}");
    expect(percentage, greaterThan(0.75), reason: "GPS should be accurate >75% of the time: $percentage");

    // Ensure that *very* noisy readings don't affect anything.
    simulator.logger.debug("Adding 100, 100");
    simulator.gps.update(GpsCoordinates(latitude: 100, longitude: 100));
    expect(realGps.isNear(realCoordinates), isTrue);
    GpsUtils.maxErrorMeters = oldError;
  });

  test("IMU noise when moving", () async {
    Logger.level = LogLevel.off;
    final simulator = AutonomySimulator();
    final simulatedImu = ImuSimulator(collection: simulator, maxError: imuError);
    final realImu = RoverImu(collection: simulator);
    final orientation = OrientationUtils.north;
    simulatedImu.update(orientation);
    
    var count = 0;
    for (var i = 0; i < 350; i++) {
      orientation.z += 1;
      simulatedImu.update(orientation);
      final newData = simulatedImu.raw;
      realImu.update(newData);
      simulator.logger.trace("Got new value: ${newData.heading}");
      simulator.logger.trace("  New heading: ${realImu.heading}");
      simulator.logger.trace("  Real position: ${orientation.heading}");
      if (i < 10) continue;
      simulator.logger.trace("  Values are similar: ${realImu.isNear(orientation.heading)}");
      if (realImu.isNear(orientation.heading)) count++;
    }

    final percentage = count / 350;
    expect(percentage, greaterThan(0.75), reason: "IMU should be accurate >75% of the time: $percentage");

    final badData = Orientation(z: 10);
    simulator.logger.info("Final orientation: ${realImu.heading}");
    simulator.logger.info("Bad orientation: ${badData.heading}");
    realImu.update(badData);
    simulator.logger.info("Unaffected orientation: ${realImu.heading}");
    expect(realImu.isNear(orientation.heading), isTrue);
    await simulator.dispose();
  });

  test("GPS latitude is set properly", () async {
    final simulator = AutonomySimulator();
    const utahLatitude = 38.406683;
    final utah = GpsCoordinates(latitude: utahLatitude);

    simulator.gps.update(utah);
    expect(simulator.hasValue, isFalse);
    expect(GpsInterface.currentLatitude, 0);
    
    await simulator.init();
    await simulator.waitForValue();
    expect(simulator.hasValue, isTrue);
    expect(GpsInterface.currentLatitude, utahLatitude);

    await simulator.dispose();
    GpsInterface.currentLatitude = 0;
  });

  test("GPS can start in a real location", () async {
    final simulator = AutonomySimulator();
    final ocean = GpsCoordinates(latitude: 0, longitude: 0);
    final newYork = GpsCoordinates(latitude: 45, longitude: 72);
    simulator.gps = RoverGps(collection: simulator);

    await simulator.init();
    expect(simulator.gps.coordinates, ocean);
    expect(simulator.gps.isNear(newYork), isFalse);
    expect(ocean.isNear(newYork), isFalse);

    simulator.gps.update(newYork);
    expect(simulator.gps.isNear(ocean), isFalse);
    expect(simulator.gps.isNear(newYork), isTrue);

    await simulator.dispose();
  });

  test("IMU can handle values on the edge", () async {
    Logger.level = LogLevel.off;
    final simulator = AutonomySimulator();
    final simulatedImu = ImuSimulator(collection: simulator, maxError: imuError);
    final realImu = RoverImu(collection: simulator);
    final orientation = Orientation(z: 360);
    simulatedImu.update(orientation);
    
    var count = 0;
    for (var i = 0; i < 1000; i++) {
      final newData = simulatedImu.raw;
      realImu.update(newData);
      simulator.logger.trace("Got new value: ${newData.heading}");
      simulator.logger.trace("  New heading: ${realImu.heading}");
      simulator.logger.trace("  Real position: ${orientation.heading}");
      if (i < 10) continue;
      simulator.logger.trace("  Values are similar: ${realImu.isNear(orientation.heading)}");
      if (realImu.isNear(orientation.heading)) count++;
    }

    final percentage = count / 1000;
    expect(percentage, greaterThan(0.75), reason: "IMU should be accurate >75% of the time: $percentage");

    final badData = Orientation(z: 10);
    simulator.logger.info("Final orientation: ${realImu.heading}");
    simulator.logger.info("Bad orientation: ${badData.heading}");
    realImu.update(badData);
    simulator.logger.info("Unaffected orientation: ${realImu.heading}");
    expect(realImu.isNear(orientation.heading), isTrue);
    await simulator.dispose();
  });
});
