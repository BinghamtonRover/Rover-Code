import "dart:async";
import "dart:io";
import "dart:typed_data";

import "package:burt_network/burt_network.dart";
import "package:video/src/collection.dart";
import "package:video/src/isolates/parent.dart";

/// A service to manage messages from the Lidar program
///
/// Creates a UDP socket to read incoming Lidar data, and parse it into
/// the Lidar protobuf messages to send to the dashboard and Autonomy
class LidarManager extends Service {
  /// The port the Lidar program will be sending data to
  static const lidarPort = 8004;

  /// The UDP socket to listen to incoming data from the lidar program
  final UdpSocket lidarSocket = UdpSocket(port: lidarPort);

  StreamSubscription<Datagram>? _dataSubscription;

  /// Handles an incoming packet from the Lidar stream
  void handleLidarData(Datagram packet) {
    final isCartesian = Float64List.sublistView(packet.data, 0, 8)[0] == 0x01;
    final data = Float64List.sublistView(packet.data, 8);

    List<LidarCartesianPoint>? cartesian;
    List<LidarPolarPoint>? polar;

    if (isCartesian) {
      cartesian = _processCartesianPoints(data);
    } else {
      polar = _processPolarPoints(data);
    }

    final lidarMessage = LidarPointCloud(
      cartesian: cartesian,
      polar: polar,
      version: Version(major: 1, minor: 0),
    );

    collection.videoServer.sendMessage(lidarMessage);
    collection.videoServer.sendMessage(
      lidarMessage,
      destination: autonomySocket,
    );
  }

  List<LidarCartesianPoint> _processCartesianPoints(List<double> data) => [
    for (int i = 0; i < data.length - 1; i += 2)
      LidarCartesianPoint(x: data[i], y: data[i + 1]),
  ];

  List<LidarPolarPoint> _processPolarPoints(List<double> data) => [
    for (int theta = 0; theta < data.length; theta++)
      if (data[theta] > 0.0)
        LidarPolarPoint(
          // The range of the lidar isn't [0, 270], it's [-135, +135].
          angle: (theta - 135).toDouble(),
          distance: data[theta],
        ),
  ];

  @override
  Future<bool> init() async {
    await lidarSocket.init();
    _dataSubscription = lidarSocket.stream.listen(handleLidarData);
    return true;
  }

  @override
  Future<void> dispose() async {
    await _dataSubscription?.cancel();
    await lidarSocket.dispose();
  }
}
