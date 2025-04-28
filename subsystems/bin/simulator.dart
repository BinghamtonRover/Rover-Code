import "dart:async";
import "dart:math";

import "package:burt_network/burt_network.dart";

class EaseIterator implements Iterator<double> {
  Duration totalTime;
  double start = 0;
  double goal;
  Stopwatch stopwatch = Stopwatch();

  EaseIterator(this.totalTime, this.start) : current = start, goal = start;

  @override
  double current = 0;

  bool get isMoving => current != goal;

  MotorDirection get direction {
    if (current < goal) {
      return MotorDirection.UP;
    } else if (current > goal) {
      return MotorDirection.DOWN;
    }
    return MotorDirection.NOT_MOVING;
  }

  double get durationSeconds => totalTime.inMicroseconds / 1e6;

  double bezierBlend(double time) =>
      pow(time / durationSeconds, 2) * (3.0 - 2.0 * (time / durationSeconds));

  void setGoal(double goal) {
    if (goal == this.goal) {
      return;
    }
    start = current;
    this.goal = goal;
    stopwatch.stop();
    stopwatch.reset();
    stopwatch.start();
  }

  @override
  bool moveNext() {
    if (stopwatch.isRunning) {
      final delta = goal - start;
      current =
          start + bezierBlend(stopwatch.elapsed.inMilliseconds / 1000) * delta;

      if (stopwatch.elapsed >= totalTime) {
        stopwatch.stop();
        current = goal;
      }
    }
    return true;
  }
}

Future<void> main() async {
  final server = RoverSocket(port: 8001, device: Device.SUBSYSTEMS);
  final logger = BurtLogger(socket: server);
  await server.init();
  final driveCommand = DriveCommand();
  final armCommand = ArmCommand();
  final gripperCommand = GripperCommand();

  // Might experiment later with this
  const roll = 0.0;
  const pitch = 0.0;
  const yaw = 0.0;

  bool isBlinking() => driveCommand.blink == BoolState.ON;

  var blinkColor = ProtoColor.UNLIT;
  var ledOn = true;

  Timer.periodic(const Duration(milliseconds: 1000), (_) {
    // logger.info("Testing Logs");
  });

  Timer.periodic(const Duration(milliseconds: 250), (_) {
    if (!driveCommand.hasBlink() || driveCommand.blink != BoolState.ON) {
      return;
    }
    ledOn = !ledOn;
    if (ledOn) {
      blinkColor = driveCommand.color;
    } else {
      blinkColor = ProtoColor.UNLIT;
    }
  });

  const ikMoveDuration = Duration(milliseconds: 1500);
  const manualMoveDuration = Duration(milliseconds: 10);

  final shoulder = EaseIterator(ikMoveDuration, 0);
  final elbow = EaseIterator(ikMoveDuration, 0);
  final wrist = EaseIterator(ikMoveDuration, 0);
  final swivel = EaseIterator(ikMoveDuration, 0);

  server.messages.onMessage(
    name: DriveCommand().messageName,
    constructor: DriveCommand.fromBuffer,
    callback: (command) {
      driveCommand.mergeFromMessage(command);
      if (command.setLeft) {
        driveCommand.left = command.left;
      }
      if (command.setRight) {
        driveCommand.right = command.right;
      }
      if (command.setThrottle) {
        driveCommand.throttle = command.throttle;
      }
    },
  );

  server.messages.onMessage(
    name: ArmCommand().messageName,
    constructor: ArmCommand.fromBuffer,
    callback: (command) {
      armCommand.mergeFromMessage(command);
      if (command.stop) {
        shoulder.setGoal(shoulder.current);
        swivel.setGoal(swivel.current);
        elbow.setGoal(elbow.current);
        return;
      }
      if (command.hasShoulder()) {
        if (command.shoulder.hasAngle()) {
          shoulder.totalTime = ikMoveDuration;
          shoulder.setGoal(command.shoulder.angle);
        } else if (command.shoulder.hasMoveRadians()) {
          shoulder.totalTime = manualMoveDuration;
          shoulder.setGoal(shoulder.goal + command.shoulder.moveRadians);
        }
      }
      if (command.hasElbow()) {
        if (command.elbow.hasAngle()) {
          elbow.totalTime = ikMoveDuration;
          elbow.setGoal(command.elbow.angle);
        } else if (command.elbow.hasMoveRadians()) {
          elbow.totalTime = manualMoveDuration;
          elbow.setGoal(elbow.goal + command.elbow.moveRadians);
        }
      }
      if (command.hasSwivel()) {
        if (command.swivel.hasAngle()) {
          swivel.totalTime = ikMoveDuration;
          swivel.setGoal(command.swivel.angle);
        } else if (command.swivel.hasMoveRadians()) {
          swivel.totalTime = manualMoveDuration;
          swivel.setGoal(swivel.goal + command.swivel.moveRadians);
        }
      }
    },
  );
  server.messages.onMessage(
    name: GripperCommand().messageName,
    constructor: GripperCommand.fromBuffer,
    callback: (command) {
      gripperCommand.mergeFromMessage(command);
      if (command.stop) {
        wrist.setGoal(wrist.current);
        return;
      }
      if (command.hasLift()) {
        if (command.lift.hasAngle()) {
          wrist.totalTime = ikMoveDuration;
          wrist.setGoal(command.lift.angle);
        } else if (command.lift.hasMoveRadians()) {
          wrist.totalTime = manualMoveDuration;
          wrist.setGoal(wrist.goal + command.lift.moveRadians);
        }
      }

      if (command.hasLaserState()) {
        Future<void>.delayed(
          const Duration(milliseconds: 500),
          () => server.sendMessage(GripperData(laserState: command.laserState)),
        );
      }
    },
  );

  Timer.periodic(const Duration(milliseconds: 10), (_) {
    shoulder.moveNext();
    elbow.moveNext();
    wrist.moveNext();
    swivel.moveNext();
  });

  const Duration messageDelay = const Duration(microseconds: 10);

  Timer.periodic(const Duration(milliseconds: 10), (_) async {
    final data = DriveData(
      left: driveCommand.left * driveCommand.throttle,
      setLeft: true,
      right: driveCommand.right * driveCommand.throttle,
      setRight: true,
      throttle: driveCommand.throttle,
      setThrottle: true,
      batteryVoltage: 30,
      batteryCurrent: 30,
      frontLeft: driveCommand.left * driveCommand.throttle * 40000,
      middleLeft: driveCommand.left * driveCommand.throttle * 40000,
      backLeft: driveCommand.left * driveCommand.throttle * 40000,
      frontRight: driveCommand.right * driveCommand.throttle * 40000,
      middleRight: driveCommand.right * driveCommand.throttle * 40000,
      backRight: driveCommand.right * driveCommand.throttle * 40000,
      version: driveCommand.version,
      color: !isBlinking() ? driveCommand.color : blinkColor,
    );
    final data2 = ArmData(
      base: MotorData(
        currentAngle: swivel.current,
        isMoving: swivel.isMoving ? BoolState.YES : BoolState.NO,
        direction: swivel.direction,
      ),
      shoulder: MotorData(
        currentAngle: shoulder.current,
        isMoving: shoulder.isMoving ? BoolState.YES : BoolState.NO,
        direction: shoulder.direction,
      ),
      elbow: MotorData(
        currentAngle: elbow.current,
        isMoving: elbow.isMoving ? BoolState.YES : BoolState.NO,
        direction: elbow.direction,
      ),
      version: armCommand.version,
    );
    final data3 = GripperData(
      lift: MotorData(
        currentAngle: wrist.current,
        isMoving: wrist.isMoving ? BoolState.YES : BoolState.NO,
        direction: wrist.direction,
      ),
      version: gripperCommand.version,
    );
    final data4 = RoverPosition(
      orientation: Orientation(x: roll, y: pitch, z: yaw),
      gps: GpsCoordinates(latitude: 0, longitude: 0),
      version: Version(major: 1),
    );
    final data5 = SubsystemsData(
      gpsConnected: BoolState.NO,
      imuConnected: BoolState.YES,
      connectedDevices: [
        Device.ARM,
        Device.GRIPPER,
        Device.SCIENCE,
        Device.DRIVE,
        Device.RELAY,
      ],
    );
    server.sendMessage(data);
    await Future<void>.delayed(messageDelay);
    server.sendMessage(data2);
    await Future<void>.delayed(messageDelay);
    server.sendMessage(data3);
    await Future<void>.delayed(messageDelay);
    server.sendMessage(data4);
    await Future<void>.delayed(messageDelay);
    server.sendMessage(data5);
  });
}
