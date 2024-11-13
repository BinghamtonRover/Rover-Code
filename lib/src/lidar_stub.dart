import "dart:ffi";

import "package:burt_network/burt_network.dart";
import "generated/lidar_bindings.dart";

import "lidar.dart";

class LidarStub extends Lidar {
  final LidarBindings bindings;

  LidarStub() : bindings = LidarBindings(DynamicLibrary.open("dist/lidar_ffi.dll"));
    
  @override
  Future<bool> init() async {
    /// init will return bool
    /// return bindings.init();
    bindings.init();
    return true;
  }

  @override
  Future<void> dispose() async {
    bindings.dispose();
  }

  @override
  Future<VideoData> readFrame() async => VideoData(
    // TODO: Add CameraName.LIDAR
    details: CameraDetails(name: CameraName.AUTONOMY_DEPTH, status: CameraStatus.CAMERA_DISCONNECTED),
  );
}
