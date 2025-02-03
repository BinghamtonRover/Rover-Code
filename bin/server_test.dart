import "dart:io";

import "package:burt_network/burt_network.dart";

void main() async {
	final server = RoverSocket(port: 8002, device: Device.VIDEO);
	await server.init();
	print("inited");
	await Future<void>.delayed(Duration(seconds: 10));
	await server.dispose();
	print("disposed");
	return;
}