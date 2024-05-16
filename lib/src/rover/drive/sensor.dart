import "package:autonomy/interfaces.dart";
import "package:autonomy/src/rover/drive/motors.dart";

class SensorDrive extends DriveInterface with RoverMotors {
  static const double maxThrottle = 0.2;
  static const predicateDelay = Duration(milliseconds: 10);
  
  SensorDrive({required super.collection});

  @override
  Future<void> stop() async {
    setThrottle(0);
    setSpeeds(left: 0, right: 0);
  }

  Future<void> waitFor(bool Function() predicate) async {
    while (!predicate()) {
      await Future<void>.delayed(predicateDelay);
    }
  }

  @override
  Future<bool> init() async => true;

  @override
  Future<void> dispose() async { }

  @override
  Future<void> goForward() async {
    final orientation = collection.imu.orientation;
    final currentCoordinates = collection.gps.coordinates;
    final destination = currentCoordinates.goForward(orientation);
    
    setThrottle(maxThrottle);
    setSpeeds(left: 1, right: 1);
    await waitFor(() => collection.gps.coordinates.isPast(destination, orientation));
    await stop();
  }

  @override
  Future<void> turnLeft() async {
    final orientation = collection.imu.orientation;
    final destination = orientation.heading + 90;  // do NOT clamp!
    setThrottle(maxThrottle);
    setSpeeds(left: -1, right: 1);
    await waitFor(() => collection.imu.heading >= destination); 
    await stop();
  }

  @override
  Future<void> turnRight() async {
    // TODO: Allow corrective turns
    final orientation = collection.imu.orientation;
    final destination = orientation.heading - 90;  // do NOT clamp!
    setThrottle(maxThrottle);
    setSpeeds(left: -1, right: 1);
    await waitFor(() => collection.imu.heading <= destination); 
    await stop();
  }
}
