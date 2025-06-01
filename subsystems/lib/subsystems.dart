import "dart:async";

import "package:burt_network/burt_network.dart";
import "package:subsystems/src/devices/can_bus.dart";

import "src/devices/gps.dart";
import "src/devices/imu.dart";
import "src/devices/firmware.dart";

export "src/devices/firmware.dart";
export "src/devices/imu.dart";
export "src/devices/gps.dart";

export "src/can/ffi.dart";
export "src/can/message.dart";
export "src/can/socket_ffi.dart";
export "src/can/socket_interface.dart";
export "src/can/socket_stub.dart";

/// Maps command names to [Device]s.
final commandToDevice = <String, Device>{
  ArmCommand().messageName: Device.ARM,
  GripperCommand().messageName: Device.GRIPPER,
  DriveCommand().messageName: Device.DRIVE,
  ScienceCommand().messageName: Device.SCIENCE,
  RelaysCommand().messageName: Device.RELAY,
};

/// Contains all the resources needed by the subsystems program.
class SubsystemsCollection extends Service {
  /// Whether the subsystems is fully initialized.
  bool isReady = false;

  /// The Serial service.
  final firmware = FirmwareManager();

  /// The UDP server.
  late final server = RoverSocket(port: 8001, collection: this, device: Device.SUBSYSTEMS);

  /// The GPS reader.
  final gps = GpsReader();

  /// The IMU reader.
  final imu = ImuReader();

  /// The CAN bus
  final can = CanBus();

  /// Timer for sending the subsystems status
  Timer? dataSendTimer;

  StreamSubscription<WrappedMessage>? _messageSubscription;

  @override
  Future<bool> init() async {
    await server.init();
    logger.socket = server;
    var result = true;
    dataSendTimer = Timer.periodic(
      const Duration(milliseconds: 250),
      sendStatus,
    );
    _messageSubscription = server.messages.listen((message) async {
      if (can.canSendWrapper(message)) {
        await can.sendWrapper(message);
      } else {
        firmware.sendToSerial(message);
      }
    });
    try {
      result &= await firmware.init();
      result &= await gps.init();
      result &= await imu.init();
      result &= await can.init();
      if (result) {
        logger.info("Subsystems initialized");
      } else {
        logger.warning("The subsystems did not start properly");
      }
      isReady = true;
      return true;  // The subsystems should keep running even when something goes wrong.
    } catch (error) {
      logger.critical("Unexpected error when initializing Subsystems", body: error.toString());
      return false;
    }
  }

  @override
  Future<void> dispose() async {
    logger.info("Shutting down...");
    await onDisconnect();
    await _messageSubscription?.cancel();
    isReady = false;
    await firmware.dispose();
    await imu.dispose();
    await gps.dispose();
    await can.dispose();
    await server.dispose();
    dataSendTimer?.cancel();
    logger.socket = null;
    logger.info("Subsystems disposed");
  }

  @override
  Future<void> onDisconnect() async {
    await super.onDisconnect();
    logger.info("Stopping all hardware");
    final stopDrive = DriveCommand(throttle: 0, setThrottle: true);
    final stopArm = ArmCommand(stop: true);
    final stopScience = ScienceCommand(stop: true);
    firmware.sendMessage(stopDrive);
    firmware.sendMessage(stopArm);
    firmware.sendMessage(stopScience);
  }
  
  /// Sends a [SubsystemsData] message over the network reporting the current status of subsystems
  void sendStatus([_]) {
    server.sendMessage(
      SubsystemsData(
        version: Version(major: 1, minor: 0),
        connectedDevices: <Device>{
          ...can.connectedDevices,
          ...firmware.devices
              .where((e) => e.isReady)
              .map((firmware) => firmware.device),
        },
        gpsConnected: gps.isConnected ? BoolState.YES : BoolState.NO,
        imuConnected: imu.isConnected ? BoolState.YES : BoolState.NO,
      ),
    );
  }
}

/// The collection of all the subsystem's resources.
final collection = SubsystemsCollection();

/// A logger that prints to the terminal and sends a UDP message.
final logger = BurtLogger();
