// ignore_for_file: avoid_unused_constructor_parameters

import "dart:io";

import "udp2.dart";

const heartbeatInterval = 1;

enum Device { subsystems, dashboard }
class Message { 
	List<int> writeToBuffer() => []; 
	WrappedMessage get wrapped => WrappedMessage.fromBuffer([]);
	String get messageName => "";
}
class WrappedMessage extends Message {
	String get name => "";
	List<int> get data => [];

	WrappedMessage.fromBuffer(List<int> buffer);
}
class Connect extends Message { 
	Device get receiver => Device.subsystems;
	Connect({Device? sender, Device? receiver});
	Connect.fromBuffer(List<int> buffer);
} 
class Disconnect extends Message { 
	Disconnect({required Device sender});
}

abstract class ProtoSocket extends UdpSocket {
	final Device device;
	SocketInfo? destination;

	ProtoSocket({required this.device, required super.listenPort, this.destination});

	bool receivedHeartbeat = false;
	bool get isConnected => destination != null;

	// Override this
	void onConnect(SocketInfo source) {
		destination = source;
		log("Port $listenPort is connected to $destination");
	} 

	// Override this
	void onDisconnect() {
		sendMessage(Disconnect(sender: device));
		destination = null;
	}

	// Override this
	void onMessage(WrappedMessage wrapper);

	void sendMessage(Message message, {SocketInfo? destinationOverride}) {
		final wrapper = message.wrapped;
		final target = destinationOverride ?? destination;
		if (target == null) throw ArgumentError("No destination specified");
		sendData(wrapper.writeToBuffer(), target);
	}

	void checkHeartbeat() {
		if (receivedHeartbeat) {
			receivedHeartbeat = false;
		} else if (isConnected) {
			log("Heartbeat not received. Assuming dashboard has disconnected");
			onDisconnect();
		}
	}

	@override
	void onData(Datagram packet) {
		final wrapper = WrappedMessage.fromBuffer(packet.data);
		final socket = SocketInfo(address: packet.address, port: packet.port);
		if (wrapper.name == Connect().messageName) {
			final heartbeat = Connect.fromBuffer(wrapper.data);
			onHeartbeat(heartbeat, socket);
		} else {
			onMessage(wrapper);
		}
	}

	void onHeartbeat(Connect heartbeat, SocketInfo source) {
		if (heartbeat.receiver != device) {
			log("Received a misaddressed heartbeat for ${heartbeat.receiver}");
		} else if (isConnected) {
			if (destination == source) {
				sendHeartbeat();
			} else {
				log("Port $listenPort is connected to $destination but received a heartbeat from $source");
			}
		} else {
			onConnect(source);
			sendHeartbeat();
		}
	}

	void sendHeartbeat() {
		final response = Connect(sender: device, receiver: Device.dashboard);
		sendMessage(response);
		receivedHeartbeat = true;
	}
}
