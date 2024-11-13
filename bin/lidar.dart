import "package:lidar/lidar.dart";

void main() async {
  final collection = LidarCollection();
  await collection.init();
  collection.run();
}
