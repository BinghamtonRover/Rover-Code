import "dart:io";

import "package:burt_network/burt_network.dart";

import "lidar_stub.dart";

class LidarCollection extends Service {
  final lidar = LidarStub();

  //final server = RoverSocket(port: 8002, device: Device.VIDEO);

  bool status = true;

  //RawDatagramSocket? socket;

  @override
  Future<bool> init() async {
     //status &= await server.init();
    status &= await lidar.init();
    print("inited lidar $status");
    return status;
  }

  @override
  Future<void> dispose() async {
    await lidar.dispose();
     //await server.dispose();
  } 

  /// Run the service.
  Future<void> run() async {
    while(true){

      final data = await lidar.readFrame();
       //final socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 8005, reuseAddress: false, reusePort: false);
      //socket.close();
      print("Got lidar frame: $data");
      //if (data == null) {
      //  await Future<void>.delayed(const Duration(milliseconds: 1000));
      //  continue;
      //}
      // server.sendMessage(data, destination: SocketInfo(address: InternetAddress("127.0.0.1"), port: 8002));
      print("sending from Lidar program");
      await Future<void>.delayed(const Duration(milliseconds: 1000));
    }
    print("Lidar program stopped");
  }
}

final collection = LidarCollection();