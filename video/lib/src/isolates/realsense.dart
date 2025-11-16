import "dart:ffi";

import "package:burt_network/burt_network.dart";
import "package:dartcv4/dartcv.dart" hide LogLevel;
import "package:protobuf/protobuf.dart" show GeneratedMessageGenericExtensions;
import "package:video/utils.dart";
import "package:video/video.dart";

extension on CameraDetails {
  bool interferesWithAutonomy(CameraDetails current) {
    if (hasResolutionWidth() && resolutionWidth != current.resolutionWidth) {
      return true;
    }
    if (hasResolutionHeight() && resolutionHeight != current.resolutionHeight) {
      return true;
    }
    if (hasFps() && fps != current.fps) {
      return true;
    }
    return false;
  }
}

/// An isolate to read RGB, depth, and colorized frames from the RealSense.
///
/// While using the RealSense SDK for depth streaming, OpenCV cannot access the standard RGB frames,
/// so it is necessary for this isolate to grab the RGB frames as well.
///
/// Since the RealSense is being used for autonomy, certain settings that could interfere with the
/// autonomy program are not allowed to be changed, even for the RGB camera.
class RealSenseIsolate extends CameraIsolate {
  /// The native RealSense object. MUST be `late` so it isn't initialized on the parent isolate.
  late final RealSenseInterface camera = RealSenseInterface.forPlatform();

  /// Creates an isolate to read from the RealSense camera.
  RealSenseIsolate({required super.details});

  @override
  void onData(VideoCommand data) {
    if (data.details.status == CameraStatus.CAMERA_DISABLED) {
      stop();
    } else if (data.details.interferesWithAutonomy(details)) {
      sendLog(LogLevel.error, "That would break autonomy");
    } else {
      super.onData(data);
    }
  }

  @override
  void initCamera() {
    if (!camera.init()) {
      final details = CameraDetails(status: CameraStatus.CAMERA_DISCONNECTED);
      updateDetails(details, save: false);
      return sendLog(LogLevel.warning, "Could not open RealSense");
    }
    sendLog(LogLevel.debug, "RealSense connected");
    final name = camera.getName();
    sendLog(LogLevel.trace, "RealSense model: $name");
    if (!camera.startStream()) {
      final details = CameraDetails(status: CameraStatus.CAMERA_NOT_RESPONDING);
      updateDetails(details, save: false);
      return sendLog(LogLevel.warning, "Could not start RealSense");
    }
    frameProperties = FrameProperties.fromFrameDetails(
      captureWidth: camera.rgbResolution.width,
      captureHeight: camera.rgbResolution.height,
      details: details,
    );
    sendLog(LogLevel.debug, "Started streaming from RealSense");
  }

  @override
  void disposeCamera() {
    camera.stopStream();
    camera.dispose();
  }

  @override
  Future<void> sendFrames() async {
    // Get frames from RealSense
    final frames = camera.getFrames();
    if (frames == nullptr) return;

    sendColorizedFrame(frames);
    await sendRgbFrame(frames);

    fpsCount++;
    // send(DepthFramePayload(frames.address));  // For autonomy
    frames.dispose();
  }

  /// Sends the colorized RealSense depth frame
  void sendColorizedFrame(Pointer<NativeFrames> rawFrames) {
    final rawColorized = rawFrames.ref.colorized_data;
    if (rawColorized == nullptr) return;

    final colorizedImage = rawColorized.toOpenCVMat(
      camera.depthResolution,
      length: rawFrames.ref.colorized_length,
    );
    final colorizedJpg = colorizedImage.encodeJpg(quality: details.quality);

    if (colorizedJpg == null) {
      sendLog(LogLevel.debug, "Could not encode colorized frame");
    } else {
      sendFrame(colorizedJpg);
    }

    colorizedImage.dispose();
  }

  @override
  Future<VecUChar?> getScreenshotJpeg() async {
    // Get frames from RealSense
    final frames = camera.getFrames();
    if (frames == nullptr) return null;

    // Compress colorized frame
    final Pointer<Uint8> rawColorized = frames.ref.colorized_data;
    if (rawColorized == nullptr) return null;
    final colorizedMatrix = rawColorized.toOpenCVMat(
      camera.depthResolution,
      length: frames.ref.colorized_length,
    );
    final colorizedJpg = colorizedMatrix.encodeJpg(quality: details.quality);

    colorizedMatrix.dispose();
    frames.dispose();

    return colorizedJpg;
  }

  /// Sends the RealSense's RGB frame and optionally detects ArUco tags.
  Future<void> sendRgbFrame(Pointer<NativeFrames> rawFrames) async {
    final rawRGB = rawFrames.ref.rgb_data;
    if (rawRGB == nullptr) return;
    final rgbMatrix = rawRGB.toOpenCVMat(
      camera.rgbResolution,
      length: rawFrames.ref.rgb_length,
    );
    final detectedMarkers = await arucoDetector.process(
      rgbMatrix,
      frameProperties!,
    );
    sendToParent(
      ObjectDetectionPayload(
        details: details.deepCopy()..name = CameraName.ROVER_FRONT,
        tags: detectedMarkers,
      ),
    );

    if (details.resolutionWidth != rgbMatrix.width ||
        details.resolutionHeight != rgbMatrix.height) {
      details.mergeFromMessage(
        CameraDetails(
          resolutionWidth: rgbMatrix.width,
          resolutionHeight: rgbMatrix.height,
        ),
      );
      saveDetails();
    }

    var streamWidth = rgbMatrix.width;
    var streamHeight = rgbMatrix.height;
    if (details.hasStreamWidth() && details.streamWidth > 0) {
      streamWidth = details.streamWidth;
    }
    if (details.hasStreamHeight() && details.streamHeight > 0) {
      streamHeight = details.streamHeight;
    }
    // don't enlarge image
    if (streamWidth > rgbMatrix.width || streamHeight > rgbMatrix.height) {
      streamWidth = rgbMatrix.width;
      streamHeight = rgbMatrix.height;
    }
    if (details.streamWidth != streamWidth ||
        details.streamHeight != streamHeight) {
      updateDetails(
        CameraDetails(streamWidth: streamWidth, streamHeight: streamHeight),
      );
    }

    VecUChar? frame;
    if (streamWidth < rgbMatrix.width || streamHeight < rgbMatrix.height) {
      try {
        // No idea why fx and fy are needed, but if they aren't present then
        // sometimes it will throw errors
        final resizedMatrix = resize(
          rgbMatrix,
          (streamWidth, streamHeight),
          fx: streamWidth / rgbMatrix.width,
          fy: streamHeight / rgbMatrix.height,
          interpolation: INTER_AREA,
        );
        frame = resizedMatrix.encodeJpg(quality: details.quality);
        resizedMatrix.dispose();
      } catch (e) {
        sendLog(
          LogLevel.error,
          "Error when resizing RGB frame",
          body: e.toString(),
        );
        rgbMatrix.dispose();
        return;
      }
    } else {
      frame = rgbMatrix.encodeJpg(quality: details.quality);
    }
    rgbMatrix.dispose();

    // Compress the RGB frame into a JPG
    if (frame == null) {
      sendLog(LogLevel.debug, "Could not encode RGB frame");
    } else {
      final newDetails = details.deepCopy()..name = CameraName.ROVER_FRONT;
      sendFrame(frame, detailsOverride: newDetails);
    }
  }
}
