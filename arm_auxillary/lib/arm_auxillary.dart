import "dart:io";

import "package:burt_network/burt_network.dart";

import "src/firmware.dart";
import "src/arm_camera_manager.dart";

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
  late final firmware = FirmwareManager(
    getServer: () => server,
    logger: logger,
  );

  /// The camera manager for arm cameras.
  final cameras = ArmCameraManager();

  /// The server for the arm auxillary program
  late final RoverSocket server = RoverSocket(
    device: Device.ARM,
    port: 8010,
    collection: this,
    destination: subsystemsSocket,
    keepDestination: true,
  );

  @override
  Future<bool> init() async {
    var result = true;
    logger.socket = server;
    result &= await server.init();
    // TODO(arm): Initialize the rest of the arm auxillary's resources, such as
    // TODO(arm): arm and EA board communication
    try {
      result &= await firmware.init();
      result &= await cameras.init();
      cameras.setServer(server);
      if (result) {
        logger.info("Arm Auxillary software initialized");
      } else {
        logger.warning("The arm auxillary software did not start properly");
      }
      isReady = true;

      // The arm auxillary software should keep running even when something goes wrong.
      return true;
    } catch (error) {
      logger.critical(
        "Unexpected error when initializing Arm Auxillary",
        body: error.toString(),
      );
      return false;
    }
  }

  @override
  Future<void> dispose() async {
    logger.info("Arm Auxillary software shutting down...");
    isReady = false;
    await cameras.dispose();
    await firmware.dispose();
    await server.dispose();
    logger.socket = null;
    logger.info("Subsystems disposed");
  }
}

/// The collection of all the arm auxillary's resources
final collection = ArmAuxillary();
