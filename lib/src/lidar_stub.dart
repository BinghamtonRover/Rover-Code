import "dart:ffi";

import "package:burt_network/burt_network.dart";
import "package:lidar/lidar.dart";
import "generated/lidar_bindings.dart";
import "package:opencv_ffi/opencv_ffi.dart";

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
  Future<VideoData> readFrame() async {
    final image = bindings.getLatestImage();
    return VideoData(
      // TODO: Add CameraName.LIDAR
      frame: image.data.asTypedList(3 * image.height * image.width),
      details: CameraDetails(name: CameraName.AUTONOMY_DEPTH, status: CameraStatus.CAMERA_DISCONNECTED),
    );
  }
  

  // void sendFrame() {
  //   final image = bindings.getLatestImage();
  //   // final mat = getMatrix(image.height, image.width, image.data.asTypedList(3 * image.height * image.width));
  //   // final jpg = encodeJpg(mat);
  //   collection.server.sendMessage(VideoData(frame: image.data.asTypedList(3 * image.height * image.width)));
  // }
  // final mat = getMatrix(imgHeight, imgWidth, pixels);
  // final jpeg = encodeJpg(mat);
}
