import "dart:io";
import "package:lidar/lidar.dart";

void main() async {
  ProcessSignal.sigint.watch().listen((signal) {
    print("CTRL+C pressed");
    exit(0);
  });
     //socket.close();
  final collection = LidarCollection();
  final ready = await collection.init();
  if(!ready) {
    print("Failed to initialize Lidar");
    await collection.dispose();
    print("Disposed Lidar");
    return;
  }
  await collection.run();
  await collection.dispose();
}
