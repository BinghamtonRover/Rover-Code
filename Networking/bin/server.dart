import "package:burt_network/burt_network.dart";

// Receives data from client.dart and registers itself as Subsystems with the Dashboard

final logger = BurtLogger();

void onData(ScienceData data) =>
  logger.info("Received ScienceData message at ${DateTime.now()}: ${data.toProto3Json()}");

void main() async {
	final server = RoverSocket(port: 8001, device: Device.SUBSYSTEMS);
  server.messages.onMessage(
    name: ScienceData().messageName,
    constructor: ScienceData.fromBuffer,
    callback: onData,
  );
	await server.init();
}
