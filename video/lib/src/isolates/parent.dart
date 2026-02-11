import "dart:async";
import "dart:io";

import "package:typed_isolate/typed_isolate.dart";
import "package:burt_network/burt_network.dart";

import "package:video/video.dart";

/// The socket to send autonomy data to.
final autonomySocket = SocketInfo(
  address: InternetAddress("192.168.1.20"),
  port: 8003,
);

/// The socket to send frames that need to be analyzed to.
final cvSocket = SocketInfo(address: InternetAddress.loopbackIPv4, port: 8006);

/// A parent isolate that spawns [CameraIsolate]s to manage the cameras.
///
/// With one isolate per camera, each camera can read in parallel. This class sends [VideoCommand]s
/// from the dashboard to the appropriate [CameraIsolate], and receives [IsolatePayload]s which it uses
/// to read an image from native memory and send to the dashboard. By not sending the frame
/// from child isolate to the parent (just the pointer), we save a whole JPG image's worth of bytes
/// from every camera, every frame, every second. That could be up to 5 MB per second of savings.
class CameraManager extends Service {
  /// The parent isolate that spawns the camera isolates.
  final parent = IsolateParent<VideoCommand, IsolatePayload>();

  StreamSubscription<VideoCommand>? _commands;
  StreamSubscription<VideoData>? _vision;
  StreamSubscription<IsolatePayload>? _data;

  @override
  Future<bool> init() async {
    _commands = collection.videoServer.messages.onMessage<VideoCommand>(
      name: VideoCommand().messageName,
      constructor: VideoCommand.fromBuffer,
      callback: _handleCommand,
    );
    _vision = collection.videoServer.messages.onMessage<VideoData>(
      name: VideoData().messageName,
      constructor: VideoData.fromBuffer,
      callback: _handleVision,
    );
    parent.init();
    _data = parent.stream.listen(onData);

    for (final name in CameraName.values) {
      switch (name) {
        case CameraName.CAMERA_NAME_UNDEFINED:
        case CameraName.ROVER_FRONT:
          continue;
        case CameraName.AUTONOMY_DEPTH:
          final details = loadCameraDetails(getRealsenseDetails(name), name);
          final isolate = RealSenseIsolate(details: details);
          await parent.spawn(isolate);
        // All other cameras share the same logic, even future cameras
        default: // ignore: no_default_cases
          final details = loadCameraDetails(getDefaultDetails(name), name);
          final isolate = OpenCVCameraIsolate(details: details);
          await parent.spawn(isolate);
      }
    }
    return true;
  }

  @override
  Future<void> dispose() async {
    stopAll();

    // Wait a bit after sending the stop command so the messages are received properly
    await Future<void>.delayed(const Duration(milliseconds: 1500));

    await _commands?.cancel();
    await _vision?.cancel();
    // Dispose the parent isolate and kill all children before canceling
    // data subscription, just in case if one last native frame is received
    await parent.dispose();

    // Wait just a little bit to ensure any remaining messages get sent
    // otherwise, if a message contained native memory, it will never
    // be disposed
    await Future<void>.delayed(const Duration(milliseconds: 50));

    await _data?.cancel();
  }

  /// Handles data coming from the child isolates.
  ///
  /// - If a [FramePayload] comes, sends the frame and details to the Dashboard
  /// - If a [DepthFramePayload] comes, sends the depth data to autonomy
  /// - If a [LogPayload] comes, logs the message using [logger].
  void onData(IsolatePayload data) {
    switch (data) {
      case FramePayload(:final details, :final screenshotPath):
        final image = data.image?.toU8List();
        data.dispose();
        if (data.details.name == findObjectsInCameraFeed) {
          // Feeds from this camera get sent to the vision program.
          // The vision program will detect objects and send metadata to Autonomy.
          // The frames will be annotated and sent back here. See [_handleVision].
          collection.videoServer.sendMessage(
            VideoData(frame: image, details: details),
            destination: cvSocket,
          );
        } else {
          collection.videoServer.sendMessage(
            VideoData(
              frame: image,
              details: details,
              imagePath: screenshotPath,
            ),
          );
        }
      case DepthFramePayload():
        collection.videoServer.sendMessage(
          VideoData(frame: data.frame.depthFrame),
          destination: autonomySocket,
        );
        data.dispose();
      case LogPayload():
        switch (data.level) {
          // Turns out using deprecated members when you *have* to still results in a lint.
          // See https://github.com/dart-lang/linter/issues/4852 for why we ignore it.
          case LogLevel.all:
            logger.info(data.message, body: data.body);
          // ignore: deprecated_member_use
          case LogLevel.verbose:
            logger.trace(data.message, body: data.body);
          case LogLevel.trace:
            logger.trace(data.message, body: data.body);
          case LogLevel.debug:
            logger.debug(data.message, body: data.body);
          case LogLevel.info:
            logger.info(data.message, body: data.body);
          case LogLevel.warning:
            logger.warning(data.message, body: data.body);
          case LogLevel.error:
            logger.error(data.message, body: data.body);
          // ignore: deprecated_member_use
          case LogLevel.wtf:
            logger.info(data.message, body: data.body);
          case LogLevel.fatal:
            logger.critical(data.message, body: data.body);
          // ignore: deprecated_member_use
          case LogLevel.nothing:
            logger.info(data.message, body: data.body);
          case LogLevel.off:
            logger.info(data.message, body: data.body);
        }
      case ObjectDetectionPayload(:final details, :final tags):
        final visionResult = VideoData(
          details: details,
          detectedObjects: tags,
          version: Version(major: 1, minor: 2),
        );
        collection.videoServer.sendMessage(visionResult);
        collection.videoServer.sendMessage(
          visionResult,
          destination: autonomySocket,
        );
    }
  }

  /// Forwards the command to the appropriate camera.
  void _handleCommand(VideoCommand command) {
    collection.videoServer.sendMessage(command); // echo the request
    var cameraName = command.details.name;
    if (cameraName == CameraName.ROVER_FRONT) {
      cameraName = CameraName.AUTONOMY_DEPTH;
    }
    parent.sendToChild(data: command, id: cameraName);
  }

  void _handleVision(VideoData data) {
    // The vision program doesn't have proper integration with the Dashboard. We can either add
    // that, or send the annotated frames back to Video to then send back to the Dashboard.
    //
    // We chose this option because the Dashboard is already managing a lot of connections as it is,
    // we're extremely short on time, it leaves analysis as an implementation detail of Video, and
    // it doesn't add much latency (from 24 FPS on the camera to 23 FPS on the Dashboard).
    collection.videoServer.sendMessage(data);
  }

  /// Stops all the cameras managed by this class.
  void stopAll() {
    final command = VideoCommand(
      details: CameraDetails(status: CameraStatus.CAMERA_DISABLED),
    );
    for (final name in CameraName.values) {
      if (name == CameraName.CAMERA_NAME_UNDEFINED ||
          name == CameraName.ROVER_FRONT) {
        continue;
      }
      parent.sendToChild(data: command, id: name);
    }
  }
}
