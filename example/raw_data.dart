import "dart:io";
import "package:burt_network/burt_network.dart";

class TestSocket extends UdpSocket {
	TestSocket({required super.port});

	@override
	void onData(Datagram packet) => logger.info("Received data: ${packet.data} from ${packet.port}");
}

void main() async {
	final socket1 = TestSocket(port: 8001);
	final socket2 = TestSocket(port: 8002);

	await socket1.init();
	await socket2.init();

	socket1.sendData([1, 2, 3], SocketInfo(address: InternetAddress.loopbackIPv4, port: 8002));
}
