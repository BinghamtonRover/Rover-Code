import "package:subsystems/subsystems.dart";
import "package:burt_network/logging.dart";

const speed = [0, 0, 0x9, 0xc4];

void main() async {
  final can = CanSocket.forPlatform();
  Logger.level = LogLevel.info;
  if (!await can.init()) logger.critical("Could not initialize CAN");
  while (true) {
    can.sendMessage(id: 0x304, data: speed);
    await Future<void>.delayed(const Duration(milliseconds: 500));
  }
}
