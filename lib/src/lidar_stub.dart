import "package:burt_network/burt_network.dart";

import "lidar.dart";

class LidarStub extends Lidar {
  @override
  Future<bool> init() async => true;

  @override
  Future<void> dispose() async { }

  @override
  Future<VideoData> readFrame() async => VideoData(
    // TODO: Add CameraName.LIDAR
    details: CameraDetails(name: CameraName.AUTONOMY_DEPTH, status: CameraStatus.CAMERA_DISCONNECTED),
  );
}
