import "dart:async";

import "package:burt_network/burt_network.dart";
import "package:video/src/lidar.dart";

import "package:video/video.dart";

/// Configuration class for the video program
class VideoConfig {
  /// The port to host the server on
  final int port;

  /// Whether or not to enable the lidar
  final bool useLidar;

  /// The explicit destination for the rover's server
  final SocketInfo? destination;

  /// Const constructor for VideoConfig
  const VideoConfig({this.port = 8002, this.useLidar = true, this.destination});
}

/// Class to contain all video devices
class VideoCollection extends Service {
  /// The [RoverSocket] to send messages through
  late final RoverSocket videoServer;

  /// Main parent isolate
  final cameras = CameraManager();

  /// The lidar manager
  final lidar = LidarManager();

  /// Extra services added on to the program, runtime specific
  final List<Service> extraServices = [];

  VideoConfig? _config;

  /// Function to initialize cameras
  @override
  Future<bool> init({VideoConfig config = const VideoConfig()}) async {
    if (_config == null) {
      _config = config;

      videoServer = RoverSocket(
        port: _config!.port,
        device: Device.VIDEO,
        collection: this,
        destination: _config!.destination,
        keepDestination: _config!.destination != null,
      );
    }
    logger.socket = videoServer;
    await videoServer.init();
    logger
      ..trace("Running in trace mode")
      ..debug("Running in debug mode");
    await cameras.init();
    if (_config!.useLidar) {
      await lidar.init();
    }
    for (final service in extraServices) {
      await service.init();
    }
    logger.info("Video program initialized");
    return true;
  }

  /// Stops all cameras and disconnects from the hardware.
  @override
  Future<void> dispose() async {
    await cameras.dispose();
    if (_config!.useLidar) {
      await lidar.dispose();
    }
    for (final service in extraServices) {
      await service.dispose();
    }
    await videoServer.dispose();
  }
}

/// Holds all the devices connected
final collection = VideoCollection();

/// Displays logs in the terminal and sends them to the Dashboard
final logger = BurtLogger();
