import "dart:ffi";

import "package:video/video.dart";

/// A stub implementation for platforms or devices without the RealSense SDK.
class RealSenseStub extends RealSenseInterface {
  @override
  bool init() => false;

  @override
  void dispose() {}

  @override
  bool startStream() => true;
  @override
  void stopStream() {}

  @override
  Resolution get depthResolution => (height: 0, width: 0);
  @override
  Resolution get rgbResolution => (height: 0, width: 0);
  @override
  double get scale => 0;

  @override
  String getName() => "Virtual RealSense";
  @override
  Pointer<NativeFrames> getFrames() => nullptr;
}
