import "dart:async";
import "dart:io";

import "package:autonomy/autonomy.dart";
import "package:autonomy/src/drive/drive_config.dart";
import "package:burt_network/burt_network.dart";
import "package:test/test.dart";

import "test_util.dart";

class MockSubsystems extends Service {
  final socket = RoverSocket(
    device: Device.AUTONOMY,
    port: 8001,
    destination: SocketInfo(address: InternetAddress.loopbackIPv4, port: 8003),
    quiet: true,
  );

  double throttle = 0;
  double left = 0;
  double right = 0;
  bool throttleFlag = false;
  bool enabled = false;

  @override
  Future<bool> init() async {
    await socket.init();
    socket.messages.onMessage(
      name: DriveCommand().messageName,
      constructor: DriveCommand.fromBuffer,
      callback: onDriveCommand,
    );
    return true;
  }

  void onDriveCommand(DriveCommand command) {
    if (!enabled) return;
    if (command.setLeft) left = command.left;
    if (command.setRight) right = command.right;
    if (command.setThrottle) {
      throttle = command.throttle;
      throttleFlag = throttle > 0;
    }
  }

  @override
  Future<void> dispose() async {
    left = 0;
    right = 0;
    throttle = 0;
    throttleFlag = false;
    enabled = false;
    await socket.dispose();
  }
}

class StopState extends RoverState {
  final AutonomyInterface collection;

  StopState(super.controller, {required this.collection});

  @override
  void update() {
    collection.drive.stop();
    controller.popState();
  }
}

void main() => group("[Network]", tags: ["network"], () {
  var subsystems = MockSubsystems();
  final rover = RoverAutonomy();
  rover.drive = RoverDrive(collection: rover, useGps: false, useImu: false);

  setUp(() async {
    Logger.level = LogLevel.off;
    await subsystems.dispose();
    subsystems = MockSubsystems();
    await subsystems.init();
    await rover.init();
  });

  tearDown(() async {
    await subsystems.dispose();
    await rover.dispose();
  });

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
    expect(rover.video.hasValue, isFalse);

    subsystems.socket.sendMessage(posGps);
    await Future<void>.delayed(networkDelay);
    expect(rover.hasValue, isFalse);
    expect(rover.gps.hasValue, isTrue);
    expect(rover.imu.hasValue, isFalse);
    expect(rover.video.hasValue, isFalse);

    subsystems.socket.sendMessage(posImu);
    await Future<void>.delayed(networkDelay);
    expect(rover.hasValue, isFalse);
    expect(rover.gps.hasValue, isTrue);
    expect(rover.imu.hasValue, isTrue);
    expect(rover.video.hasValue, isFalse);

    subsystems.socket.sendMessage(depth);
    await Future<void>.delayed(networkDelay);
    expect(rover.gps.hasValue, isTrue);
    expect(rover.imu.hasValue, isTrue);
    expect(rover.video.hasValue, isTrue);
    expect(rover.hasValue, isTrue);

    await Future<void>.delayed(const Duration(seconds: 1));
  });

  test("Rover can drive", retry: 10, () async {
    subsystems.enabled = true;
    final simulator = AutonomySimulator();
    simulator.gps = GpsSimulator(collection: simulator);
    simulator.imu = ImuSimulator(collection: simulator);
    simulator.drive = RoverDrive(
      collection: simulator,
      useGps: false,
      useImu: false,
      config: tankConfig,
    );
    await simulator.init();

    final oneMeter = origin.plus(x: 0, y: 1);
    simulator.gps.update(origin);
    expect(subsystems.throttle, 0);
    expect(subsystems.left, 0);
    expect(subsystems.right, 0);
    expect(simulator.gps.isNear(origin), isTrue);
    expect(simulator.gps.isNear(oneMeter), isFalse);

    expect(subsystems.throttleFlag, isFalse);
    final forwardFuture = Future<void>.delayed(
      simulator.drive.config.oneMeterDelay,
    );
    final forwardState = simulator.drive.driveForwardState(oneMeter);
    simulator.orchestrator.controller.pushState(forwardState);
    simulator.orchestrator.controller.update();
    simulator.orchestrator.controller.update();
    simulator.orchestrator.controller.update();

    await Future<void>.delayed(simulator.drive.config.oneMeterDelay * 0.5);

    expect(subsystems.throttleFlag, isTrue);
    expect(subsystems.throttle, isNot(0));
    expect(subsystems.left, isNot(0));
    expect(subsystems.right, isNot(0));
    expect(simulator.gps.isNear(origin), isTrue);
    expect(simulator.gps.isNear(oneMeter), isFalse);

    simulator.orchestrator.controller.update();
    simulator.orchestrator.controller.update();
    simulator.orchestrator.controller.update();

    await forwardFuture;

    simulator.orchestrator.controller.update();
    simulator.orchestrator.controller.update();
    simulator.orchestrator.controller.update();

    await Future<void>.delayed(Duration.zero);

    expect(subsystems.throttleFlag, isTrue);
    expect(subsystems.throttle, isNot(0));
    expect(subsystems.left, isNot(0));
    expect(subsystems.right, isNot(0));

    simulator.orchestrator.controller.pushState(
      StopState(simulator.orchestrator.controller, collection: simulator),
    );

    simulator.orchestrator.controller.update();
    simulator.orchestrator.controller.update();
    simulator.orchestrator.controller.update();

    // Future events need to pump for the call to drive.stop() to execute
    await Future<void>.delayed(Duration.zero);

    expect(subsystems.throttle, 0);
    expect(subsystems.left, 0);
    expect(subsystems.right, 0);

    expect(simulator.gps.isNear(origin, 0.5), isFalse);
    expect(simulator.gps.isNear(oneMeter), isTrue);

    subsystems.enabled = false;
    await subsystems.dispose();
    await simulator.dispose();
  });
});
