import "dart:ffi";
import "dart:io";

import "package:video/video.dart";

import "realsense_ffi.dart";
import "realsense_stub.dart";

/// The resolution of an image.
typedef Resolution = ({int width, int height});

/// An interface for reading the RealSense camera.
abstract class RealSenseInterface {
  /// A const constructor.
  const RealSenseInterface();

  /// Decides which implementation to use depending on platform.
  factory RealSenseInterface.forPlatform() =>
      Platform.isLinux ? RealSenseFFI() : RealSenseStub();

  /// Initializes the RealSense. Returns whether the initialization was successful.
  bool init();

  /// Releases the RealSense. Calling [init] again should re-open the device.
  void dispose();

  /// Starts the RealSense stream and waits for a valid frame.
  bool startStream();

  /// Stops the stream but keeps the device alive.
  void stopStream();

  /// The resolution of the depth frames.
  Resolution get depthResolution;

  /// The resolution of the RGB frames.
  Resolution get rgbResolution;

  /// The depth scale -- each pixel in the depth frame is an integer multiple of this, in meters.
  double get scale;

  /// Gets the name and model of the camera.
  String getName();

  /// Gets the currently available frames. May return [nullptr].
  Pointer<NativeFrames> getFrames();

  /// Gets the distance (in meters) at the RGB image coordinates (x, y) in the depth frame
  double getDistance(Pointer<NativeFrames> frame, int x, int y) {
    if (frame.ref.aligned_depth_data == nullptr) {
      return 0;
    }

    final index = y * rgbResolution.width + x;
    if (index >= frame.ref.aligned_depth_length) {
      return 0;
    }

    return frame.ref.aligned_depth_data[index] * scale;
  }
}
