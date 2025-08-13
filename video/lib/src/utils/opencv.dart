import "dart:ffi";

import "package:dartcv4/dartcv.dart";
import "package:video/realsense.dart";

/// Useful methods to adjust settings of an OpenCV video device.
extension VideoCaptureUtils on VideoCapture {
  /// Sets the capture resolution of the device.
  void setResolution({required int width, required int height}) {
    set(3, width.toDouble());
    set(4, height.toDouble());
  }

  /// The capture width of the device, this is
  /// the width of the image taken, which may
  /// not always be the width the user set the
  /// resolution to
  int get width => get(3).toInt();

  /// The capture height of the device, this is
  /// the height of the image taken, which may
  /// not always be the height the user set the
  /// resolution to
  int get height => get(4).toInt();

  /// Gets the capture resolution of the device
  ({int width, int height}) get resolution => (width: width, height: height);

  /// The frames per second the device will record, independent of calls to [read].
  int get fps => get(5).toInt();
  set fps(int value) => set(5, value.toDouble());

  /// The zoom level of the camera.
  int get zoom => get(27).toInt();
  set zoom(int value) => set(27, value.toDouble());

  /// The focus of the camera.
  int get focus => get(28).toInt();
  set focus(int value) => set(28, value.toDouble());

  /// Pans the camera when zoomed in.
  int get pan => get(33).toInt();
  set pan(int value) => set(33, value.toDouble());

  /// Tilts the camera vertically when zoomed in.
  int get tilt => get(34).toInt();
  set tilt(int value) => set(34, value.toDouble());

  /// Rolls the camera when zoomed in.
  int get roll => get(35).toInt();
  set roll(int value) => set(35, value.toDouble());

  /// Determines whether autofocus is on or off
  bool get autofocus => get(39) == 1;
  set autofocus(bool value) => set(39, value ? 1 : 0);
}

/// Useful methods on OpenCV images.
extension MatrixUtils on Mat {
  static final _crosshairColor = Scalar.fromRgb(0, 255, 0);

  /// Encodes this image as a JPG with the given quality.
  VecUChar? encodeJpg({required int quality}) {
    final params = VecI32.fromList([IMWRITE_JPEG_QUALITY, quality]);
    final (success, frame) = imencodeVec(".jpg", this, params: params);
    return success ? frame : null;
  }

  /// Draws a crosshair on the image
  Future<void> drawCrosshair({Point? center, int thickness = 2}) async {
    center ??= Point(width ~/ 2, height ~/ 2);

    // Vertical segment
    await lineAsync(
      this,
      Point(center.x, center.y - 25),
      Point(center.x, center.y - 5),
      _crosshairColor,
      thickness: thickness,
    );
    await lineAsync(
      this,
      Point(center.x, center.y + 5),
      Point(center.x, center.y + 25),
      _crosshairColor,
      thickness: thickness,
    );
    // Horizontal segment
    await lineAsync(
      this,
      Point(center.x - 25, center.y),
      Point(center.x - 5, center.y),
      _crosshairColor,
      thickness: thickness,
    );
    await lineAsync(
      this,
      Point(center.x + 5, center.y),
      Point(center.x + 25, center.y),
      _crosshairColor,
      thickness: thickness,
    );
  }
}

/// Converts raw data in native memory to an OpenCV image.
extension Uint8ToMat on Pointer<Uint8> {
  /// Reads this 1-dimensional list as an OpenCV image.
  Mat toOpenCVMat(Resolution resolution, {int? length}) {
    length ??= resolution.width * resolution.height;
    return Mat.fromList(
      resolution.height,
      resolution.width,
      MatType.CV_8UC3,
      asTypedList(length),
    );
  }
}
