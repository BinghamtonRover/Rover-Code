import "dart:io";

import "package:burt_network/udp.dart";
import "package:subsystems/subsystems.dart";
import "package:burt_network/logging.dart";

void main() async {
  Logger.level = LogLevel.trace;
  if (!await collection.init(
    port: 8010,
    useGps: false,
    useImu: false,
    destination: SocketInfo(
      address: InternetAddress("192.168.1.20"),
      port: 8001,
    ),
  )) {
    await collection.dispose();
  }
}
