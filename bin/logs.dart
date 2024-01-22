import "package:burt_network/burt_network.dart";
import "package:burt_network/logging.dart";

// 1. Define a new socket on port 8001 that doesn't do anything
class LogsServer extends RoverServer {
  LogsServer() : super(port: 8001, device: Device.SUBSYSTEMS);

  @override
  void onMessage(_) { }

  @override
  void restart() { }
}

// 2. Create that socket and make a logger that uses it.
final server = LogsServer();
final logger = BurtLogger(socket: server);

void main() async {
  // 3. Initialize the socket and start sending messages
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
