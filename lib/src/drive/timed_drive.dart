import "dart:math";

import "package:autonomy/interfaces.dart";
import "package:autonomy/src/drive/drive_config.dart";

import "drive_commands.dart";

class _TimedOperationState extends RoverState {
  DateTime _startTime = DateTime(0);

  final Duration time;
  final void Function() operation;
  final void Function()? onDone;

  _TimedOperationState(
    super.controller, {
    required this.time,
    required this.operation,
    this.onDone,
  });

  @override
  void enter() {
    _startTime = DateTime.now();
  }

  @override
  void update() {
    if (DateTime.now().difference(_startTime) >= time) {
      controller.popState();
      return;
    }
    operation();
  }

  @override
  void exit() => onDone?.call();
}

/// An implementation of [DriveInterface] that drives for a specified amount of time without using sensors
///
/// The time to drive/turn for is defined by [DriveConfig.oneMeterDelay] and [DriveConfig.turnDelay]
///
/// This should only be used if the rover is not using sensors for autonomous driving
class TimedDrive extends DriveInterface with RoverDriveCommands {
  TimedDrive({required super.collection, super.config});

  @override
  StateInterface faceOrientationState(Orientation orientation) {
    throw UnsupportedError(
      "Cannot face any arbitrary direction using TimedDrive",
    );
  }

  @override
  StateInterface driveForwardState(GpsCoordinates coordinates) =>
      _TimedOperationState(
        controller,
        time:
            config.oneMeterDelay *
            (collection.imu.nearest.isPerpendicular ? 1 : sqrt2),
        operation: () {
          setThrottle(config.forwardThrottle);
          moveForward();
        },
      );

  @override
  StateInterface turnStateState(AutonomyAStarState state) =>
      switch (state.instruction) {
        DriveDirection.forward => throw UnimplementedError(),

        DriveDirection.left => _TimedOperationState(
          controller,
          time: config.turnDelay,
          operation: () {
            setThrottle(config.turnThrottle);
            spinLeft();
          },
          onDone: stopMotors,
        ),

        DriveDirection.right => _TimedOperationState(
          controller,
          time: config.turnDelay,
          operation: () {
            setThrottle(config.turnThrottle);
            spinRight();
          },
          onDone: stopMotors,
        ),

        DriveDirection.quarterLeft => _TimedOperationState(
          controller,
          time: config.turnDelay * 0.5,
          operation: () {
            setThrottle(config.turnThrottle);
            spinLeft();
          },
          onDone: stopMotors,
        ),

        DriveDirection.quarterRight => _TimedOperationState(
          controller,
          time: config.turnDelay * 0.5,
          operation: () {
            setThrottle(config.turnThrottle);
            spinRight();
          },
          onDone: stopMotors,
        ),

        DriveDirection.stop => throw UnimplementedError(),
      };

  @override
  Future<bool> init() async => true;

  @override
  Future<void> dispose() async {}

  @override
  Future<bool> driveForward(GpsCoordinates position) async {
    await goForward(collection.imu.nearest.isPerpendicular ? 1 : sqrt2);
    return true;
  }

  @override
  Future<bool> turnState(AutonomyAStarState state) async {
    switch (state.instruction) {
      case DriveDirection.left:
        await turnLeft();
      case DriveDirection.right:
        await turnRight();
      case DriveDirection.quarterLeft:
        await turnQuarterLeft();
      case DriveDirection.quarterRight:
        await turnQuarterRight();
      case DriveDirection.forward || DriveDirection.stop:
        break;
    }
    return true;
  }

  @override
  Future<bool> stop() async {
    stopMotors();
    return true;
  }

  /// Moves forward for the amount of time it will take to drive the specified [distance]
  ///
  /// This will set the speeds to move forward, and wait for the amount of
  /// time specified by the [DriveConfig.oneMeterDelay]
  Future<bool> goForward([double distance = 1]) async {
    collection.logger.info("Driving forward $distance meters");
    setThrottle(config.forwardThrottle);
    moveForward();
    await Future<void>.delayed(config.oneMeterDelay * distance);
    await stop();
    return true;
  }

  /// Turns left for the amount of time it will take to spin left 90 degrees
  ///
  /// This will set the speeds to turn left, and wait for the amount of
  /// time specified by the [DriveConfig.turnDelay]
  Future<void> turnLeft() async {
    setThrottle(config.turnThrottle);
    spinLeft();
    await Future<void>.delayed(config.turnDelay);
    await stop();
  }

  /// Turns right for the amount of time it will take to spin right 90 degrees
  ///
  /// This will set the speeds to turn right, and wait for the amount of
  /// time defined by the [DriveConfig.turnDelay]
  Future<void> turnRight() async {
    setThrottle(config.turnThrottle);
    spinRight();
    await Future<void>.delayed(config.turnDelay);
    await stop();
  }

  /// Turns left for the amount of time it will take to spin left 45 degrees
  ///
  /// This will set the speeds to turn left, and wait for the amount of
  /// time defined by the [DriveConfig.turnDelay] / 2
  Future<void> turnQuarterLeft() async {
    setThrottle(config.turnThrottle);
    spinLeft();
    await Future<void>.delayed(config.turnDelay * 0.5);
    await stop();
  }

  /// Turns right for the amount of time it will take to spin right 45 degrees
  ///
  /// This will set the speeds to turn right, and wait for the amount of
  /// time defined by the [DriveConfig.turnDelay] / 2
  Future<void> turnQuarterRight() async {
    setThrottle(config.turnThrottle);
    spinRight();
    await Future<void>.delayed(config.turnDelay * 0.5);
    await stop();
  }

  @override
  Future<bool> faceOrientation(Orientation orientation) =>
      throw UnsupportedError(
        "Cannot face any arbitrary direction using TimedDrive",
      );
}
