import "package:burt_network/burt_network.dart";

abstract class Lidar extends Service {
  Future<VideoData> readFrame();
}
