import "dart:io";
import "package:burt_network/burt_network.dart";

// Sends data to server.dart, on the same device or across devices

final destination = SocketInfo(
  // Replace this with a real IP address for testing
  // address: InternetAddress("192.168.1.10"),
	address: InternetAddress.loopbackIPv4,
	port: 8001,
);

void main() async {
  final client = UdpSocket(port: 8000);
	await client.init();
	final message = ScienceData(temperature: 1, co2: 2);
  while (true) {
    client.sendMessage(message, destination: destination);
    await Future<void>.delayed(const Duration(seconds: 1));
  }
}
