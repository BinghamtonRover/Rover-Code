import "dart:ffi";
import "package:ffi/ffi.dart";

import "package:video/video.dart";

/// An FFI implementation of [RealSenseInterface] using [librealsense](https://github.com/IntelRealSense/librealsense).
class RealSenseFFI extends RealSenseInterface {
  /// The native FFI device.
  final device = realsenseLib.RealSense_create();
  @override
  late double scale;
  @override
  Resolution depthResolution = (height: 0, width: 0);
  @override
  Resolution rgbResolution = (height: 0, width: 0);

  @override
  bool init() {
    final status = realsenseLib.RealSense_init(device);
    return status == BurtRsStatus.BurtRsStatus_ok;
  }

  @override
  String getName() =>
      realsenseLib.RealSense_getDeviceName(device).toDartString();

  @override
  bool startStream() {
    final status = realsenseLib.RealSense_startStream(device);
    if (status != BurtRsStatus.BurtRsStatus_ok) {
      return false;
    }
    final config = realsenseLib.RealSense_getDeviceConfig(device);
    depthResolution = (height: config.depth_height, width: config.depth_width);
    rgbResolution = (height: config.rgb_height, width: config.rgb_width);
    scale = config.scale;
    return true;
  }

  @override
  void stopStream() => realsenseLib.RealSense_stopStream(device);

  @override
  Future<void> dispose() async {
    realsenseLib.RealSense_free(device);
  }

  @override
  Pointer<NativeFrames> getFrames() =>
      realsenseLib.RealSense_getDepthFrame(device);
}
