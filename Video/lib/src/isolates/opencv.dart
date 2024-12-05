import "dart:ffi";

import "package:opencv_ffi/opencv_ffi.dart";
import "package:burt_network/burt_network.dart";

import "package:video/video.dart";

/// An isolate that is spawned to manage one camera.
/// 
/// This class accepts [VideoCommand]s and calls [updateDetails] with the newly-received details.
/// When a frame is read, instead of sending the [VideoData], this class sends only the pointer
/// to the [OpenCVImage] via the [IsolatePayload] class, and the image is read by the parent isolate.
class OpenCVCameraIsolate extends CameraIsolate {
  /// The native camera object from OpenCV.
  late final Camera camera;
  /// Creates a new manager for the given camera and default details.
  OpenCVCameraIsolate({required super.details}); 

  @override
  void initCamera() {
    camera = getCamera(name);
    camera.setResolution(details.resolutionWidth, details.resolutionHeight);
    if (!camera.isOpened) {
      sendLog(LogLevel.warning, "Camera $name is not connected");
      updateDetails(CameraDetails(status: CameraStatus.CAMERA_DISCONNECTED));
    }
  }

  @override
  void disposeCamera() => camera.dispose();

  @override
  void updateDetails(CameraDetails newDetails, {bool restart = false}) {
    super.updateDetails(newDetails, restart: false);
    camera.setResolution(details.resolutionWidth, details.resolutionHeight);
    camera.zoom = details.zoom;
    camera.pan = details.pan;
    camera.tilt = details.tilt;
    camera.focus = details.focus;
    camera.autofocus = details.focus;
  }

  /// Reads a frame from the camera and sends it to the dashboard.
  /// 
  /// Checks for multiple errors along the way: 
  /// - If the camera does not respond, alerts the dashboard
  /// - If the frame is too large, reduces the quality (increases JPG compression)
  /// - If the quality is already low, alerts the dashboard
  @override
  void sendFrames() {
    final matrix = camera.getFrame();
    if (matrix == nullptr) return;
    // detectAndAnnotateFrames(matrix);
    final frame = encodeJpg(matrix, quality: details.quality);
    matrix.dispose();
    if (frame == null) {  // Error getting the frame
      sendLog(LogLevel.warning, "Camera $name didn't respond");
      updateDetails(CameraDetails(status: CameraStatus.CAMERA_NOT_RESPONDING));
      return;
    } 
    sendFrame(frame);
    fpsCount++;
  }
}
