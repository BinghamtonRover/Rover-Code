import "dart:async";
import "dart:io";

import "package:typed_isolate/typed_isolate.dart";
import "package:burt_network/burt_network.dart";

import "package:video/video.dart";

/// Socket destination for the main video program on the Jetson
final videoSocket = SocketInfo(
  address: InternetAddress("192.168.1.30"),
  port: 8004, // Video program port
);

/// Manages arm cameras and streams video data to the main video program.
class ArmCameraManager extends Service {
  /// The parent isolate that spawns the arm camera isolates.
  final parent = IsolateParent<VideoCommand, IsolatePayload>();

  /// Stream subscriptions for cleanup
  StreamSubscription<VideoCommand>? _commands;
  StreamSubscription<IsolatePayload>? _data;

  /// Reference to the server for sending messages
  RoverSocket? _server;

  @override
  Future<bool> init() async {
    logger.info("Initializing arm camera manager");
    
    parent.init();
    _data = parent.stream.listen(onData);
    
    await _spawnArmCameras();
    
    logger.info("Arm camera manager initialized");
    return true;
  }

  @override
  Future<void> dispose() async {
    logger.info("Disposing arm camera manager");
    
    stopAll();
    
    // Wait a bit after sending the stop command so the messages are received properly
    await Future<void>.delayed(const Duration(milliseconds: 750));

    await _commands?.cancel();
    // Dispose the parent isolate and kill all children before canceling
    // data subscription, just in case if one last native frame is received
    await parent.dispose();

    // Wait just a little bit to ensure any remaining messages get sent
    // otherwise, if a message contained native memory, it will never
    // be disposed
    await Future<void>.delayed(const Duration(milliseconds: 50));

    await _data?.cancel();
    
    logger.info("Arm camera manager disposed");
  }

  /// Sets the server reference for message handling
  void setServer(RoverSocket server) {
    _server = server;
    
    // Set up command subscription now that server is available
    _commands = server.messages.onMessage<VideoCommand>(
      name: VideoCommand().messageName,
      constructor: VideoCommand.fromBuffer,
      callback: _handleCommand,
    );

    logger.info("Arm camera manager connected to server");
  }

  /// Spawns camera isolates for detected arm cameras
  Future<void> _spawnArmCameras() async {
    logger.info("Detecting arm cameras...");
    
    final armCameraNames = <CameraName>[
      CameraName.ARM_LEFT,
      CameraName.ARM_RIGHT,
      CameraName.GAP_CAM,
    ];
    
    for (final cameraName in armCameraNames) {
      try {
        final details = _createArmCameraDetails(cameraName);
        final isolate = OpenCVCameraIsolate(details: details);
        await parent.spawn(isolate);
        
        logger.info("Spawned camera isolate for $cameraName");
      } catch (error) {
        logger.error("Failed to spawn camera isolate for $cameraName", body: error.toString());
      }
    }
  }

  /// Creates camera details for arm cameras
  CameraDetails _createArmCameraDetails(CameraName name) => CameraDetails(
      name: name,
      resolutionWidth: 640,
      resolutionHeight: 480,
      fps: 15,
      quality: 80,
      status: CameraStatus.CAMERA_LOADING,
    );

  /// Handles data coming from the arm camera isolates
  void onData(IsolatePayload data) {
    switch (data) {
      case FramePayload(:final details, :final screenshotPath):
        final image = data.image?.toU8List();
        data.dispose();
        
        if (_server != null && image != null) {
          _server!.sendMessage(
            VideoData(
              frame: image,
              details: details,
              imagePath: screenshotPath,
            ),
            destination: videoSocket,
          );
        }
        
      case LogPayload():
        switch (data.level) {
          case LogLevel.all:
            logger.info("Camera isolate: ${data.message}", body: data.body);
          // ignore: deprecated_member_use
          case LogLevel.verbose:
            logger.trace("Camera isolate: ${data.message}", body: data.body);
          case LogLevel.trace:
            logger.trace("Camera isolate: ${data.message}", body: data.body);
          case LogLevel.debug:
            logger.debug("Camera isolate: ${data.message}", body: data.body);
          case LogLevel.info:
            logger.info("Camera isolate: ${data.message}", body: data.body);
          case LogLevel.warning:
            logger.warning("Camera isolate: ${data.message}", body: data.body);
          case LogLevel.error:
            logger.error("Camera isolate: ${data.message}", body: data.body);
          case LogLevel.fatal:
            logger.critical("Camera isolate: ${data.message}", body: data.body);
          case LogLevel.off:
            logger.info("Camera isolate: ${data.message}", body: data.body);
          // ignore: deprecated_member_use
          case LogLevel.wtf:
            logger.critical("Camera isolate: ${data.message}", body: data.body);
          // ignore: deprecated_member_use
          case LogLevel.nothing:
            break;
        }
        
      case ObjectDetectionPayload(:final details, :final tags):
        if (_server != null) {
          final visionResult = VideoData(
            details: details,
            detectedObjects: tags,
            version: Version(major: 1, minor: 2),
          );
          _server!.sendMessage(visionResult, destination: videoSocket);
        }
        
      default:
        logger.warning("Unknown payload type from camera isolate");
    }
  }

  /// Handles commands from the video program
  void _handleCommand(VideoCommand command) {
    logger.debug("Received camera command for ${command.details.name}");
    
    // Route command to correct camera isolate
    parent.sendToChild(data: command, id: command.details.name);
  }

  /// Stops all arm cameras
  void stopAll() {
    final stopCommand = VideoCommand(
      details: CameraDetails(status: CameraStatus.CAMERA_DISABLED),
    );
    
    // Send stop command to all arm camera isolates
    final armCameraNames = [
      CameraName.ARM_LEFT,
      CameraName.ARM_RIGHT,
      CameraName.GAP_CAM,
    ];
    
    for (final name in armCameraNames) {
      parent.sendToChild(data: stopCommand, id: name);
    }
    
    logger.info("Stopping all arm cameras");
  }
}