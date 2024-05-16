import "package:autonomy/interfaces.dart";

import "motors.dart";

class TimedDrive extends DriveInterface with RoverMotors {
  static const maxThrottle = 0.2;
  static const turnThrottle = 0.1;
  static const oneMeterDelay = Duration(seconds: 1);
  static const turnDelay = Duration(seconds: 1);

  TimedDrive({required super.collection});

  @override
  Future<bool> init() async => true;

  @override
  Future<void> dispose() async { }

  @override 
  Future<void> stop() async {
    setThrottle(0);
    setSpeeds(left: 0, right: 0);
  }

  @override 
  Future<void> goForward() async {
    setThrottle(maxThrottle);
    setSpeeds(left: 1, right: 1);
    await Future<void>.delayed(oneMeterDelay);
    await stop();
  }

  @override
  Future<void> turnLeft() async {
    setThrottle(turnThrottle);
    setSpeeds(left: -1, right: 1);
    await Future<void>.delayed(turnDelay);
    await stop();
  }

  @override
  Future<void> turnRight() async {
    setThrottle(turnThrottle);
    setSpeeds(left: 1, right: -1);
    await Future<void>.delayed(turnDelay);
    await stop();
  }
}
