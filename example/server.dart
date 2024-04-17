import "package:burt_network/burt_network.dart";

final logger = BurtLogger();

class BasicServer extends ProtoSocket {
	BasicServer({required super.port, required super.device});

	@override
	void onWrapper(WrappedMessage wrapper, SocketInfo source) {
    final message = ScienceData.fromBuffer(wrapper.data); 
    logger.info("Received ${wrapper.name} message: ${message.co2} & ${message.methane}");
  }
}

void main() async {
	final server = BasicServer(port: 8001, device: Device.SUBSYSTEMS);  // Registers as the Subsystems Server on the Dashboard
	await server.init();
}
