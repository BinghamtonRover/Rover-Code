import "package:burt_network/burt_network.dart";

import "src/detector.dart";

class CvCollection extends Service {
  final server = RoverSocket(port: 8006, device: Device.VIDEO);
  final detector = ObjectDetector();

  @override
  Future<bool> init() async => await server.init()
    && await detector.init();

  @override
  Future<void> dispose() async {
    await server.dispose();
    await detector.dispose();
  }
}

final collection = CvCollection();
final logger = BurtLogger(socket: collection.server);
