import "dart:io";
import "package:burt_network/burt_network.dart";

final destination = SocketInfo(
	// address: InternetAddress("192.168.47.223"),
	address: InternetAddress.loopbackIPv4,
	port: 8001,
);

class BasicServer extends ProtoSocket {
	BasicServer({required super.port, required super.device});

  @override
  void onWrapper(WrappedMessage wrapper, SocketInfo source) => 
    logger.info("Received ${wrapper.name} message: ${wrapper.data}");
}

void main() async {
	final client = BasicServer(port: 8000, device: Device.DASHBOARD);
	await client.init();
  client.destination = destination;
	final message = ScienceData(temperature: 1, co2: 2);
  while (true) {
    client.sendMessage(message);
    await Future<void>.delayed(const Duration(seconds: 1));
  }
}
