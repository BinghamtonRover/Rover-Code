import "package:autonomy/interfaces.dart";
import "package:burt_network/generated.dart";

/// Handles obstacle detection data and ArUco data from video
abstract class VideoInterface extends Service with Receiver {
bool flag = false;

  final AutonomyInterface collection;
  VideoInterface({required this.collection});

  VideoData data = VideoData();

  void updateFrame(VideoData newData);

  double get arucoSize => data.arucoSize;
  double get arucoPosition => data.arucoPosition;
}
