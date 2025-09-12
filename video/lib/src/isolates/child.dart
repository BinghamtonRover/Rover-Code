import "dart:async";
import "dart:convert";
import "dart:io";

import "package:burt_network/burt_network.dart";
import "package:dartcv4/dartcv.dart" hide LogLevel;
import "package:typed_isolate/typed_isolate.dart";
import "package:video/video.dart";

/// The maximum size of a UDP packet, in bytes (minus a few to be safe).
const maxPacketLength = 60000;

/// A child isolate that manages a single camera and streams frames from it.
///
/// This class can represent any combination of hardware and software, such as regular USB cameras
/// driven by OpenCV or a depth camera read with the RealSense SDK. To use, override [initCamera]
/// and [disposeCamera], then override [sendFrames] to retrieve and send images. Override
/// [updateDetails] to be notified when the current [CameraDetails] have changed, but the common
/// cases such as stopping and starting the camera will be handled for you.
///
/// You may use [sendStatus], [sendLog], or [sendFrame] to send data to the Dashboard. Do not try
/// to communicate directly as only the parent isolate can access the network.
///
/// This class manages a few camera-independent details, such as:
/// - periodically sending the camera's current status to the Dashboard
/// - periodically logging how many frames were successfully read
/// - periodically calling [sendFrames] to read the camera
/// - calling [updateDetails] when a new [VideoCommand] arrives.
abstract class CameraIsolate
    extends IsolateChild<IsolatePayload, VideoCommand> {
  // Jetson has 6 cores, Pi has 4
  static final String _linuxUserHomeFolder = Platform.numberOfProcessors == 6
      ? "/home/rover"
      : "/home/pi";

  /// The root directory of the shared network folder
  static final String baseDirectory = Platform.isLinux
      ? "$_linuxUserHomeFolder/shared"
      : Directory.current.path;

  /// Holds the current details of the camera.
  final CameraDetails details;

  /// The Aruco detector for detecting markers in an RGB video image
  late final RoverArucoDetector arucoDetector = RoverArucoDetector(
    config: defaultArucoConfig,
  );

  /// Frame properties used for target tracking calculations
  FrameProperties? frameProperties;

  /// A constructor with initial details.
  CameraIsolate({required this.details}) : super(id: details.name);

  /// A timer to periodically send the camera status to the dashboard.
  Timer? statusTimer;

  /// A timer to read from the camera at an FPS given by [details].
  Timer? frameTimer;

  /// A timer to log out the [fpsCount] every 5 seconds using [sendLog].
  Timer? fpsTimer;

  /// Records how many FPS this camera is actually running at.
  int fpsCount = 0;

  /// Whether the camera is currently reading a frame.
  bool isReadingFrame = false;

  /// The name of this camera (where it is on the rover).
  CameraName get name => details.name;

  /// Sends the current status to the dashboard.
  void sendStatus([_]) => sendToParent(FramePayload(details: details));

  /// Logs a message by sending a [LogPayload] to the parent isolate.
  ///
  /// Note: it is important to _not_ log this message directly in _this_ isolate, as it will
  /// not be configurable by the parent isolate and will not be sent to the Dashboard.
  void sendLog(LogLevel level, String message, {String? body}) =>
      sendToParent(LogPayload(level: level, message: message, body: body));

  @override
  Future<void> onSpawn() async {
    sendLog(LogLevel.debug, "Initializing camera: $name");
    statusTimer = Timer.periodic(const Duration(seconds: 5), sendStatus);
    start();
  }

  /// Disposes of this camera and all other resources.
  ///
  /// After running this, the camera should need to be opened again.
  void dispose() {
    stop();
    statusTimer?.cancel();
  }

  @override
  void onData(VideoCommand data) => handleCommand(data);

  /// Handles the incoming [VideoCommand]
  Future<void> handleCommand(VideoCommand command) async {
    if (command.takeSnapshot) {
      return takeSnapshot();
    } else {
      updateDetails(command.details);
    }
  }

  /// Takes a high quality onboard image and saves it to a shared folder
  ///
  /// This calls the [getScreenshotJpeg] obtain a high quality image,
  /// and saves it to [baseDirectory]/shared
  ///
  /// This is highly blocking, and should only be called when a command is received
  Future<void> takeSnapshot() async {
    if (isReadingFrame) {
      sendLog(
        Level.warning,
        "Ignoring Screenshot Request",
        body: "Request was received while reading frame",
      );
      return;
    }
    try {
      isReadingFrame = true;
      final jpegData = await getScreenshotJpeg();
      isReadingFrame = false;
      if (jpegData != null) {
        final screenshotDirectory = "/screenshots/${name.name}";
        final cameraDirectory = Directory(baseDirectory + screenshotDirectory);

        await cameraDirectory.create(recursive: true);
        final files = cameraDirectory.listSync();
        final number = files.length;
        await File(
          "${cameraDirectory.path}/screenshot_$number.jpg",
        ).writeAsBytes(jpegData.toU8List());
        sendLog(Level.info, "Saved Screenshot");
        sendToParent(
          FramePayload(
            details: details,
            screenshotPath: "$screenshotDirectory/screenshot_$number.jpg",
          ),
        );
      } else {
        sendLog(Level.error, "Failed to take screenshot, jpeg data is null");
      }
    } catch (e) {
      sendLog(Level.error, "Error while taking screenshot", body: e.toString());
      isReadingFrame = false;
    }
  }

  /// Updates the camera's [details], which will take effect on the next [sendFrame] call.
  void updateDetails(CameraDetails newDetails, {bool save = true}) {
    final shouldRestart =
        (newDetails.hasFps() && newDetails.fps != details.fps) ||
        (newDetails.hasResolutionHeight() &&
            newDetails.resolutionHeight != details.resolutionHeight) ||
        (newDetails.hasResolutionWidth() &&
            newDetails.resolutionWidth != details.resolutionWidth) ||
        newDetails.status == CameraStatus.CAMERA_DISABLED;
    details.mergeFromMessage(newDetails);
    if (shouldRestart) {
      stop();
      if (details.status == CameraStatus.CAMERA_ENABLED) start();
    }
    if (save) {
      saveDetails();
    }
  }

  /// Saves the camera details to a json file in the shared network folder
  void saveDetails() {
    logger.debug("Saving camera details for ${name.name}");
    final directory = Directory("$baseDirectory/camera_details");
    final configFile = File("${directory.path}/${name.name}.json");
    try {
      if (!configFile.existsSync()) {
        configFile.createSync(recursive: true);
      }
      configFile.writeAsStringSync(jsonEncode(details.toProto3Json()));
    } catch (e) {
      logger.error(
        "Failed to save details to ${configFile.path}",
        body: e.toString(),
      );
    }
  }

  /// Initializes the camera and starts streaming.
  void initCamera();

  /// Closes and releases the camera.
  ///
  /// This is separate from [dispose] so the isolate can keep reporting its status.
  void disposeCamera();

  /// Reads a frame from the camera and sends it to the dashboard.
  ///
  /// When overriding this function, be sure to check for errors, such as:
  /// - If the camera does not respond, alert the dashboard
  /// - If the frame is too large, reduces the quality (increases JPG compression)
  /// - If the quality is already low, alert the dashboard
  Future<void> sendFrames();

  /// Reads a frame and returns the data in jpeg format
  ///
  /// The image this returns is intended to be taken at maximum quality
  /// and get saved as a screenshot
  ///
  /// Most likely, this image will be too big to send over the network
  Future<VecUChar?> getScreenshotJpeg();

  /// Sends an individual frame to the dashboard.
  ///
  /// This function also checks if the frame is too big to send, and if so,
  /// lowers the JPG quality by 1%. If the quality reaches 25% (visually noticeable),
  /// an error is logged instead.
  void sendFrame(VecUChar image, {CameraDetails? detailsOverride}) {
    final details = detailsOverride ?? this.details;
    // Frame can be sent
    if (image.length < maxPacketLength) {
      // Since we're sending the image's pointer address over an isolate, we don't
      // want the image to be automatically released from memory since it will cause
      // a segfault, we detach it from the finalizer and will release the memory manually
      // from the parent isolate
      VecUChar.finalizer.detach(image);
      sendToParent(FramePayload(details: details, address: image.ptr.address));
    } else if (details.quality > 25) {
      // Frame too large, lower quality
      sendLog(
        LogLevel.debug,
        "Lowering quality for $name from ${details.quality}",
      );
      details.quality -= 1; // maybe next frame can send
    } else {
      // Frame too large, quality cannot be lowered
      sendLog(
        LogLevel.warning,
        "Frame from camera $name are too large (${image.length})",
      );
      updateDetails(
        CameraDetails(status: CameraStatus.FRAME_TOO_LARGE),
        save: false,
      );
    }
  }

  /// Starts the camera and timers.
  void start() {
    if (details.status != CameraStatus.CAMERA_ENABLED) return;
    sendLog(LogLevel.debug, "Starting camera $name. Status=${details.status}");
    final interval = details.fps == 0
        ? Duration.zero
        : Duration(milliseconds: 1000 ~/ details.fps);
    frameTimer = Timer.periodic(interval, _frameCallback);
    fpsTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      sendLog(LogLevel.trace, "Camera $name sent ${fpsCount ~/ 5} frames");
      fpsCount = 0;
    });
    initCamera();
  }

  Future<void> _frameCallback(Timer timer) async {
    if (isReadingFrame) return;
    isReadingFrame = true;
    await sendFrames();
    isReadingFrame = false;
  }

  /// Cancels all timers and stops reading the camera.
  void stop() {
    sendLog(LogLevel.debug, "Stopping camera $name");
    frameTimer?.cancel();
    fpsTimer?.cancel();
    disposeCamera();
  }
}
