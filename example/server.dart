import "package:burt_network/burt_network.dart";

class BasicServer extends ServerSocket {
	BasicServer({required super.port, required super.device});

	@override
	void onMessage(WrappedMessage wrapper) => logger.info("Received ${wrapper.name} message: ${wrapper.data}");
}

void main() async {
	Logger.level = LogLevel.info;
	final server = BasicServer(port: 8001, device: Device.SUBSYSTEMS);  // Registers as the Subsystems Server on the Dashboard
	final server2 = BasicServer(port: 8002, device: Device.VIDEO);  // Registers as the Subsystems Server on the Dashboard
	await server.init();
	await server2.init();
}
