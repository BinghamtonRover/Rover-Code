import "package:burt_network/burt_network.dart";
import "package:burt_network/logging.dart";

final logger = BurtLogger();

class BasicServer extends ServerSocket {
	BasicServer({required super.port, required super.device});

	@override
	void onMessage(WrappedMessage wrapper) => logger.info("Received ${wrapper.name} message: ${wrapper.data}");
}

void main() async {
	final server = BasicServer(port: 8001, device: Device.SUBSYSTEMS);  // Registers as the Subsystems Server on the Dashboard
	await server.init();
}
