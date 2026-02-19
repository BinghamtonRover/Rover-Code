import "dart:io";

import "package:burt_network/burt_network.dart";
import "package:video/src/collection.dart";

void main() async {
  if (!await collection.init(
    config: VideoConfig(
      port: 8011,
      useLidar: false,
      destination: SocketInfo(
        address: InternetAddress("192.168.1.20"),
        port: 8002,
      ),
    ),
  )) {
    await collection.dispose();
  }
}
