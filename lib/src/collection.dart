import "dart:io";

import "package:burt_network/burt_network.dart";

import "lidar_stub.dart";

class LidarCollection extends Service {
  final lidar = LidarStub();

  final server = RoverSocket(port: 8004, device: Device.VIDEO);

  @override
  Future<bool> init() async {
    bool status = true;
    status &= await lidar.init();
    status &= await server.init();
    return status;
  }

  @override
  Future<void> dispose() async {
    await lidar.dispose();
    await server.dispose();
  } 

  void run() async {
    while(true){
      final data = await lidar.readFrame();
      server.sendMessage(data, destination: SocketInfo(address: InternetAddress("127.0.0.1"), port: 8002));
      //print("sending message ${data}");
      print("sending");
      await Future<void>.delayed(const Duration(milliseconds: 100));
    }
  }
}

final collection = LidarCollection();