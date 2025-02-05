// ignore_for_file: avoid_print

import "package:burt_network/burt_network.dart";

import "lidar.dart";

/// The collection for the lidar program
class LidarCollection extends Service {
  /// A class to manage the lidar.
  final lidar = Lidar();

  // SIMPLY UN-COMMENTING THIS LINE CAUSES SEGFAULTS. NEED TO TEST MORE
  // final server = RoverSocket(port: 8002, device: Device.VIDEO);

  /// Whether the collection successfully initialized.
  bool status = true;

  //RawDatagramSocket? socket;

  @override
  Future<bool> init() async {
     //status &= await server.init();
    status &= await lidar.init();
    print("Initialized with status $status");
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
      if(data != null) print("Got Lidar JPG: ${data.frame.length} bytes");
       //final socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 8005, reuseAddress: false, reusePort: false);
      //socket.close();
      //if (data == null) {
      //  await Future<void>.delayed(const Duration(milliseconds: 1000));
      //  continue;
      //}
      // server.sendMessage(data, destination: SocketInfo(address: InternetAddress("127.0.0.1"), port: 8002));
      await Future<void>.delayed(const Duration(milliseconds: 1000));
    }
  }
}

/// The Lidar program's global collection.
final collection = LidarCollection();
