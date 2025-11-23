import "dart:io";

import "package:burt_network/burt_network.dart";
import "src/firmware.dart";

/// Logger for the arm auxillary program
final logger = BurtLogger();

/// The socket destination for the subsystems program
final subsystemsSocket = SocketInfo(
  address: InternetAddress("192.168.1.20"),
  port: 8001,
);

/// The resouces needed to run the arm auxillary program
class ArmAuxillary extends Service {
  /// Whether the arm auxillary code is fully initialized.
  bool isReady = false;

  /// The Serial service.
  final firmware = FirmwareManager();

  /// The server for the arm auxillary program
  late final RoverSocket server = RoverSocket(
    // change to ARM_AUXILLARY once protobuf message is added
    device: Device.DEVICE_UNDEFINED,
    port: 8010,
    collection: this,
    destination: subsystemsSocket,
    keepDestination: true,
  );

  @override
  Future<bool> init() async {
    bool result = true;
    logger.socket = server;
    result &= await server.init();
    // TODO: initialize the rest of the arm auxillary's resources, such as
    // arm and EA board communication
    try {
      result &= await firmware.init();
      if (result) {
        logger.info("Arm Auxillary software initialized");
      } else {
        logger.warning("The arm auxillary software did not start properly");
      }
      isReady = true;

      // The arm auxillary software should keep running even when something goes wrong.
      return true;
    } catch (error) {
      logger.critical("Unexpected error when initializing Arm Auxillary", body: error.toString());
      return false;
    }
  }

  @override
  Future<void> dispose() async {
    logger.info("Arm Auxillary software shutting down...");
    isReady = false;
    await firmware.dispose();
    await server.dispose();
    logger.socket = null;
    logger.info("Subsystems disposed");
  }
}

/// The collection of all the arm auxillary's resources
final collection = ArmAuxillary();
