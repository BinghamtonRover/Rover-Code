import "dart:math";

import "package:burt_network/burt_network.dart";

class SwingingIterator implements Iterator<double> {
  final double min;
  final double max;
  final double increment;
  SwingingIterator(this.min, this.max, this.increment) : current = min;

  bool forward = true;
  @override double current;

  @override
  bool moveNext() {
    if (current >= max && forward) forward = false;
    if (current <= min && !forward) forward = true;
    if (forward) {
      current += increment;
    } else {
      current -= increment;
    }
    return true;
  }
}

Future<void> main() async {
  final server = RoverSocket(port: 8001, device: Device.SUBSYSTEMS);
  await server.init();
  final throttle = SwingingIterator(0, 1, 0.01);
  final voltage = SwingingIterator(24, 30, 0.1);
  final current = SwingingIterator(0, 30, 0.1);
  final motor = SwingingIterator(0, pi, 0.01);
  final motor2 = SwingingIterator(0, 2*pi, 0.05);
  final roll = SwingingIterator(-45, 45, 1);
  final pitch = SwingingIterator(-45, 45, 1);
  final yaw = SwingingIterator(-45, 45, 1);
  final color = SwingingIterator(0, 1, 0.01);
  final gps = SwingingIterator(-1, 1, 0.01);
  while (true) {
    throttle.moveNext();
    voltage.moveNext();
    current.moveNext();
    motor.moveNext();
    motor2.moveNext();
    roll.moveNext();
    pitch.moveNext();
    yaw.moveNext();
    color.moveNext();
    gps.moveNext();
    final data = DriveData(
      left: 1,
      setLeft: true,
      right: -1,
      setRight: true,
      throttle: throttle.current,
      setThrottle: true,
      batteryVoltage: voltage.current,
      batteryCurrent: current.current,
      version: Version(major: 1),
      color: color.current < 0.25 ? ProtoColor.UNLIT
        : color.current < 0.5 ? ProtoColor.BLUE
        : color.current < 0.75 ? ProtoColor.RED
        : ProtoColor.GREEN,
    );
    server.sendMessage(data);
    final data2 = ArmData(
      base: MotorData(angle: motor2.current),
      shoulder: MotorData(angle: motor.current),
      elbow: MotorData(angle: motor.current),
      version: Version(major: 1),
    );
    server.sendMessage(data2);
    final data3 = GripperData(lift: MotorData(angle: pi + -1 * 2 * motor.current), version: Version(major: 1));
    server.sendMessage(data3);
    final data4 = RoverPosition(
      orientation: Orientation(
        x: roll.current,
        y: pitch.current,
        z: yaw.current,
      ),
      gps: GpsCoordinates(
        latitude: gps.current,
        longitude: gps.current,
      ),
      version: Version(major: 1),
    );
    server.sendMessage(data4);
    await Future<void>.delayed(const Duration(milliseconds: 10));
  }
}
