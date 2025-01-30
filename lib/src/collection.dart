import "dart:io";

import "package:burt_network/burt_network.dart";

import "lidar_stub.dart";

class LidarCollection extends Service {
  final lidar = LidarStub();

  final server = RoverSocket(port: 8002, device: Device.VIDEO);

  bool status = true;

  @override
  Future<bool> init() async {
    status &= await lidar.init();
    status &= await server.init();
    return status;
  }

  @override
  Future<void> dispose() async {
    await lidar.dispose();
    await server.dispose();
  } 

  /// Run the service.
  Future<void> run() async {
    while(status){
      final data = await lidar.readFrame();
      status = lidar.getStatus();
      server.sendMessage(data, destination: SocketInfo(address: InternetAddress("127.0.0.1"), port: 8002));
      print("sending from Lidar program");
      await Future<void>.delayed(const Duration(milliseconds: 100));
    }
  }
}

final collection = LidarCollection();