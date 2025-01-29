import "package:lidar/lidar.dart";

void main() async {
  final collection = LidarCollection();
  final ready = await collection.init();
  if(!ready) {
    print("Failed to initialize Lidar");
    await collection.dispose();
    print("Disposed Lidar");
    return;
  }
  collection.run();
}
