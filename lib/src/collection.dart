import "package:burt_network/burt_network.dart";

import "lidar_stub.dart";

class LidarCollection extends Service {
  final lidar = LidarStub();

  final server = RoverSocket(port: 8004, device: Device.VIDEO);

  @override
  Future<bool> init() async => (await lidar.init()) && (await server.init());

  @override
  Future<void> dispose() async {
    await lidar.dispose();
    await server.dispose();
  } 

  void run() async {
    while(true){
      final data = await lidar.readFrame();
      server.sendMessage(data);
      print("sending message ${data}");
      await Future<void>.delayed(const Duration(seconds: 1));
    }
  }
}

final collection = LidarCollection();