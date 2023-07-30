import "dart:io";
import "package:burt_network/burt_network.dart";

final destination = SocketInfo(
	address: InternetAddress("192.168.47.223"),
	port: 8001,
);

class BasicServer extends ProtoSocket {
	BasicServer({required super.port, required super.device}) : super(
		destination: destination,
		heartbeatInterval: const Duration(seconds: 1),
	);

	@override
	void onMessage(WrappedMessage wrapper) => logger.info("Received ${wrapper.name} message: ${wrapper.data}");

	@override
	void onHeartbeat(Connect heartbeat, SocketInfo source) { }

	@override
	Future<void> checkHeartbeats() async { }

	@override
	void updateSettings(UpdateSetting setting) { }
}

void main() async {
	final client = BasicServer(port: 8000, device: Device.DASHBOARD);
	await client.init();
	final message = ScienceData(methane: 1, co2: 2);
	client.sendMessage(message);
}
