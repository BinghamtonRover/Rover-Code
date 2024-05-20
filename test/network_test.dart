import "dart:io";

import "package:autonomy/autonomy.dart";
import "package:burt_network/burt_network.dart";
import "package:test/test.dart";

class MockSubsystems extends RoverServer {
  double throttle = 0;
  double left = 0;
  double right = 0;

  bool enabled = false;

  bool throttleFlag = false;
  
  MockSubsystems({required super.port}) : 
    super(device: Device.SUBSYSTEMS, quiet: true);
  
  @override
  Future<void> init() async {
    destination = SocketInfo(address: InternetAddress.loopbackIPv4, port: 8003);
    await super.init();
  }
  
  @override
  void onMessage(WrappedMessage wrapper) {
    if (!enabled) return;
    if (wrapper.name != DriveCommand().messageName) return;
    final command = DriveCommand.fromBuffer(wrapper.data);
    if (command.setLeft) left = command.left;
    if (command.setRight) right = command.right;
    if (command.setThrottle) throttle = command.throttle;
    if (throttle > 0) throttleFlag = true;
  }

  @override
  Future<void> onShutdown() async {  }

  @override
  Future<void> restart() async {  }

  @override
  Future<void> dispose() async {
    left = 0;
    right = 0;
    throttle = 0;
    throttleFlag = false;
    await super.dispose();
  }
}

void main() => group("[Network]", tags: ["network"], () {
  final subsystems = MockSubsystems(port: 8001);
  final rover = RoverAutonomy();
  rover.drive = SensorlessDrive(collection: rover, useGps: false, useImu: false);

  Future<void> setup() async {
    Logger.level = LogLevel.off;
    await subsystems.init();
    await rover.init();
  }

  setUp(setup);
  tearDown(() async { await subsystems.dispose(); await rover.dispose(); });

  test("Rover waits for all data to arrive", () async {
    final gps = GpsCoordinates(latitude: 1, longitude: 2);
    final imu = Orientation(z: 60);
    final posGps = RoverPosition(gps: gps);
    final posImu = RoverPosition(orientation: imu);
    final depth = VideoData(frame: [1, 2, 3, 4, 5]);
    const networkDelay = Duration(milliseconds: 10);

    expect(rover.hasValue, isFalse);
    expect(rover.gps.hasValue, isFalse);
    expect(rover.imu.hasValue, isFalse);
    expect(rover.realsense.hasValue, isFalse);

    subsystems.sendMessage(posGps);
    await Future<void>.delayed(networkDelay);
    expect(rover.hasValue, isFalse);
    expect(rover.gps.hasValue, isTrue);
    expect(rover.imu.hasValue, isFalse);
    expect(rover.realsense.hasValue, isFalse);

    subsystems.sendMessage(posImu);
    await Future<void>.delayed(networkDelay);
    expect(rover.hasValue, isFalse);
    expect(rover.gps.hasValue, isTrue);
    expect(rover.imu.hasValue, isTrue);
    expect(rover.realsense.hasValue, isFalse);

    subsystems.sendMessage(depth);
    await Future<void>.delayed(networkDelay);
    expect(rover.gps.hasValue, isTrue);
    expect(rover.imu.hasValue, isTrue);
    expect(rover.realsense.hasValue, isTrue);
    expect(rover.hasValue, isTrue);
  });

  test("Rover can drive", () async {
    subsystems.enabled = true;
    ServerInterface.subsystemsDestination = SocketInfo(
      address: InternetAddress.loopbackIPv4,
      port: 8001,
    );
    final simulator = AutonomySimulator();
    simulator.gps = GpsSimulator(collection: simulator);
    simulator.imu = ImuSimulator(collection: simulator);
    simulator.drive = SensorlessDrive(collection: simulator, useGps: false, useImu: false);
    await simulator.init();

    await simulator.drive.faceNorth();
    expect(simulator.imu.orientation, DriveOrientation.north);
    
    final origin = GpsCoordinates(latitude: 0, longitude: 0);
    final oneMeter = (1, 0).toGps();
    expect(subsystems.throttle, 0);
    expect(subsystems.left, 0);
    expect(subsystems.right, 0);
    expect(simulator.gps.isNear(origin), isTrue);
    expect(simulator.gps.isNear(oneMeter), isFalse);

    const driveDelay = Duration(milliseconds: 10);
    expect(subsystems.throttleFlag, isFalse);
    await simulator.drive.goForward();
    await Future<void>.delayed(driveDelay);
    expect(subsystems.throttleFlag, isTrue);
    expect(subsystems.throttle, 0);
    expect(subsystems.left, 0);
    expect(subsystems.right, 0);
    expect(simulator.gps.isNear(origin), isFalse);
    expect(simulator.gps.isNear(oneMeter), isTrue);

    subsystems.enabled = false;
    await simulator.dispose();
  });
});
