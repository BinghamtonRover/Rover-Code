import "package:burt_network/burt_network.dart";

// Run this program using `dart run :logs` and connect the Dashboard.

// Create that socket and make a logger that uses it.
final server = RoverSocket(port: 8001, device: Device.SUBSYSTEMS);
final logger = BurtLogger(socket: server);

void main() async {
  // Initialize the socket and start sending messages
  await server.init();
  while (true) {
    logger.critical("This is a message");
    await Future<void>.delayed(const Duration(milliseconds: 250));
    logger.error("This is a message");
    await Future<void>.delayed(const Duration(milliseconds: 250));
    logger.warning("This is a message");
    await Future<void>.delayed(const Duration(milliseconds: 250));
    logger.info("This is a message");
    await Future<void>.delayed(const Duration(milliseconds: 250));
    logger.debug("This is a message");
    await Future<void>.delayed(const Duration(milliseconds: 250));
    logger.trace("This is a message");
  }
}
