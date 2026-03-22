import "dart:async";

import "package:burt_network/burt_network.dart";

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

/// Configuration for the subsystems program
class SubsystemsConfig {
  /// The port to host the socket on
  final int port;

  /// Whether or not to use the GPS
  final bool useGps;

  /// Whether or not to use the IMU
  final bool useImu;

  /// The default destination for the server
  final SocketInfo? destination;

  /// Const constructor for [SubsystemsConfig]
  const SubsystemsConfig({
    this.port = 8001,
    this.useGps = true,
    this.useImu = true,
    this.destination,
  });
}

/// Contains all the resources needed by the subsystems program.
class SubsystemsCollection extends Service {
  /// Whether the subsystems is fully initialized.
  bool isReady = false;

  /// The Serial service.
  final firmware = FirmwareManager();

  /// The UDP server.
  late final RoverSocket server;

  /// The GPS reader.
  final gps = GpsReader();

  /// The IMU reader.
  final imu = ImuReader();

  /// Extra services added on to the program, runtime specific
  final List<Service> extraServices = [];

  /// Internal configuration (the one used when init was first called)
  SubsystemsConfig? _config;

  /// Timer for sending the subsystems status
  Timer? dataSendTimer;

  @override
  Future<bool> init({
    SubsystemsConfig config = const SubsystemsConfig(),
  }) async {
    if (_config == null) {
      _config = config;
      server = RoverSocket(
        port: _config!.port,
        collection: this,
        device: Device.SUBSYSTEMS,
        destination: _config!.destination,
        keepDestination: _config!.destination != null,
      );
    }
    await server.init();
    logger.socket = server;
    var result = true;
    dataSendTimer = Timer.periodic(
      const Duration(milliseconds: 250),
      sendStatus,
    );
    try {
      result &= await firmware.init();
      if (_config!.useGps) result &= await gps.init();
      if (_config!.useImu) result &= await imu.init();
      for (final service in extraServices) {
        result &= await service.init();
      }
      if (result) {
        logger.info("Subsystems initialized");
      } else {
        logger.warning("The subsystems did not start properly");
      }
      isReady = true;
      return true; // The subsystems should keep running even when something goes wrong.
    } catch (error) {
      logger.critical(
        "Unexpected error when initializing Subsystems",
        body: error.toString(),
      );
      return false;
    }
  }

  @override
  Future<void> dispose() async {
    logger.info("Shutting down...");
    await onDisconnect();
    isReady = false;
    await firmware.dispose();
    await imu.dispose();
    await gps.dispose();
    for (final service in extraServices) {
      await service.dispose();
    }
    await server.dispose();
    dataSendTimer?.cancel();
    logger.socket = null;
    logger.info("Subsystems disposed");
  }

  @override
  Future<void> onDisconnect() async {
    await super.onDisconnect();
    for (final service in extraServices) {
      await service.onDisconnect();
    }
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
        connectedDevices: firmware.devices
            .where((e) => e.isReady)
            .map((firmware) => firmware.device),
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
