
import "package:burt_network/burt_network.dart";

void main() async {
	final server = RoverSocket(port: 8002, device: Device.VIDEO);
	await server.init();
	await Future<void>.delayed(const Duration(seconds: 10));
	await server.dispose();
	return;
}
