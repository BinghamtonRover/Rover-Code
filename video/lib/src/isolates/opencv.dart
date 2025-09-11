import "package:dartcv4/dartcv.dart" hide LogLevel;
import "package:burt_network/burt_network.dart";

import "package:video/utils.dart";
import "package:video/video.dart";

/// A [CameraIsolate] that reads cameras using `package:opencv_dart`.
class OpenCVCameraIsolate extends CameraIsolate {
  /// The native camera object from OpenCV.
  VideoCapture? camera;

  /// Creates a new manager for the given camera and default details.
  OpenCVCameraIsolate({required super.details});

  @override
  void initCamera() {
    camera = getCamera(name);
    camera!.set(CAP_PROP_FOURCC, VideoCapture.toCodec("MJPG"));
    camera?.setResolution(
      width: details.resolutionWidth,
      height: details.resolutionHeight,
    );
    frameProperties = FrameProperties.fromFrameDetails(
      captureWidth: camera!.width,
      captureHeight: camera!.height,
      details: details,
    );
    if (details.hasFps()) camera?.fps = details.fps;
    if (details.hasZoom()) camera?.zoom = details.zoom;
    if (details.hasFocus()) camera?.focus = details.focus;
    camera?.autofocus = details.autofocus;

    if (!camera!.isOpened) {
      sendLog(LogLevel.warning, "Camera $name is not connected");
      updateDetails(
        CameraDetails(status: CameraStatus.CAMERA_DISCONNECTED),
        save: false,
      );
      stop();
    }
  }

  @override
  void disposeCamera() {
    camera?.dispose();
    camera = null;
  }

  @override
  void updateDetails(CameraDetails newDetails, {bool save = true}) {
    super.updateDetails(newDetails, save: save);
    if (details.status != CameraStatus.CAMERA_ENABLED || camera == null) return;
    if ((details.hasResolutionWidth() &&
            details.resolutionWidth != camera!.width) ||
        details.hasResolutionHeight() &&
            details.resolutionHeight != camera!.height) {
      camera?.setResolution(
        width: details.resolutionWidth,
        height: details.resolutionHeight,
      );
    }
    if (details.hasZoom() && details.zoom != camera!.zoom) {
      camera!.zoom = details.zoom;
    }
    if (details.hasPan() && details.pan != camera!.pan) {
      camera!.pan = details.pan;
    }
    if (details.hasTilt() && details.tilt != camera!.tilt) {
      camera!.tilt = details.tilt;
    }
    if (details.hasFocus() && details.focus != camera!.focus) {
      camera!.focus = details.focus;
    }
    if (details.hasAutofocus() && details.autofocus != camera!.autofocus) {
      camera!.autofocus = details.autofocus;
    }
    if (frameProperties == null ||
        (newDetails.hasDiagonalFov() &&
            newDetails.diagonalFov != frameProperties!.diagonalFoV) ||
        frameProperties!.captureWidth != camera!.width ||
        frameProperties!.captureHeight != camera!.height) {
      frameProperties = FrameProperties.fromFrameDetails(
        captureWidth: camera!.width,
        captureHeight: camera!.height,
        details: details,
      );
    }
  }

  @override
  Future<void> sendFrames() async {
    if (camera == null) return;
    final (success, matrix) = camera!.read();
    if (!success || matrix.width <= 0 || matrix.height <= 0) return;

    final detectedMarkers = await arucoDetector.process(
      matrix,
      frameProperties!,
    );

    sendToParent(
      ObjectDetectionPayload(details: details, tags: detectedMarkers),
    );

    // await matrix.drawCrosshair(center: frameProperties!.center);

    if (details.resolutionWidth != matrix.width ||
        details.resolutionHeight != matrix.height) {
      details.mergeFromMessage(
        CameraDetails(
          resolutionWidth: matrix.width,
          resolutionHeight: matrix.height,
        ),
      );
      saveDetails();
    }

    var streamWidth = matrix.width;
    var streamHeight = matrix.height;
    if (details.hasStreamWidth() && details.streamWidth > 0) {
      streamWidth = details.streamWidth;
    }
    if (details.hasStreamHeight() && details.streamHeight > 0) {
      streamHeight = details.streamHeight;
    }
    // don't enlarge image
    if (streamWidth > matrix.width || streamHeight > matrix.height) {
      streamWidth = matrix.width;
      streamHeight = matrix.height;
    }
    if (details.streamWidth != streamWidth ||
        details.streamHeight != streamHeight) {
      updateDetails(
        CameraDetails(streamWidth: streamWidth, streamHeight: streamHeight),
      );
    }

    VecUChar? frame;
    // don't resize unless if the stream is different from the capture
    if (streamWidth < matrix.width || streamHeight < matrix.height) {
      try {
        // No idea why fx and fy are needed, but if they aren't present then
        // sometimes it will throw errors
        final resizedMatrix = resize(
          matrix,
          (streamWidth, streamHeight),
          fx: streamWidth / matrix.width,
          fy: streamHeight / matrix.height,
          interpolation: INTER_AREA,
        );
        frame = resizedMatrix.encodeJpg(quality: details.quality);
        resizedMatrix.dispose();
      } catch (e) {
        sendLog(
          LogLevel.error,
          "Error when resizing image for camera ${details.name.name}",
          body: e.toString(),
        );
        matrix.dispose();
        return;
      }
    } else {
      frame = matrix.encodeJpg(quality: details.quality);
    }
    matrix.dispose();

    if (frame == null) {
      // Error getting the frame
      sendLog(LogLevel.warning, "Camera $name didn't respond");
      updateDetails(
        CameraDetails(status: CameraStatus.CAMERA_NOT_RESPONDING),
        save: false,
      );
      return;
    }

    sendFrame(frame);
    fpsCount++;
  }

  @override
  Future<VecUChar?> getScreenshotJpeg() async {
    if (camera == null) {
      return null;
    }
    final originalWidth = camera!.get(CAP_PROP_FRAME_WIDTH).toInt();
    final originalHeight = camera!.get(CAP_PROP_FRAME_HEIGHT).toInt();

    camera!.dispose();
    camera = getCamera(name);

    camera!.set(CAP_PROP_FOURCC, VideoCapture.toCodec("MJPG"));
    camera!.setResolution(width: 10000, height: 10000);

    camera!.fps = 0;
    if (details.hasZoom()) camera!.zoom = details.zoom;
    if (details.hasFocus()) camera!.focus = details.focus;
    camera!.autofocus = details.autofocus;

    final captureStart = DateTime.timestamp();

    for (int i = 0; i < 3; i++) {
      await camera!.grabAsync();
      if (DateTime.timestamp().difference(captureStart) >
          const Duration(seconds: 3)) {
        break;
      }
    }

    final (success, matrix) = await camera!.readAsync();

    camera!.dispose();
    camera = getCamera(name);

    camera!.set(CAP_PROP_FOURCC, VideoCapture.toCodec("MJPG"));
    camera!.setResolution(width: originalWidth, height: originalHeight);
    camera!.fps = details.fps;
    if (details.hasZoom()) camera!.zoom = details.zoom;
    if (details.hasFocus()) camera!.focus = details.focus;
    camera!.autofocus = details.autofocus;

    if (!success) return null;

    final frame = matrix.encodeJpg(quality: 100);
    matrix.dispose();

    return frame;
  }
}
