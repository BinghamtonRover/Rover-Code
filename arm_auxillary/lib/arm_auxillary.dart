import "dart:io";

import "package:burt_network/burt_network.dart";

/// Logger for the arm auxillary program
final logger = BurtLogger();

/// The socket destination for the subsystems program
final subsystemsSocket = SocketInfo(
  address: InternetAddress("192.168.1.20"),
  port: 8001,
);

/// The resouces needed to run the arm auxillary program
class ArmAuxillary extends Service {
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
    return result;
  }

  @override
  Future<void> dispose() async {
    // TODO: implement dispose
  }
}

/// The collection of all the arm auxillary's resources
final collection = ArmAuxillary();
