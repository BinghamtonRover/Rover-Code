import "package:burt_network/burt_network.dart";

// Receives data from client.dart and registers itself as Subsystems with the Dashboard

final logger = BurtLogger();

void onData(RoverPacket<ScienceData> data) =>
  logger.info(
  "Received ScienceData message from ${data.source} at ${data.timestamp.toDateTime().toIso8601String()}: ${data.message.toProto3Json()}",
);

void main() async {
	final server = RoverSocket(port: 8001, device: Device.SUBSYSTEMS);
	// final server = RoverServer(port: 8001, device: Device.SUBSYSTEMS);
  server.messages.onPacket(
    name: ScienceData().messageName,
    constructor: ScienceData.fromBuffer,
    callback: onData,
  );
	await server.init();
  await server.waitForConnection();
}
