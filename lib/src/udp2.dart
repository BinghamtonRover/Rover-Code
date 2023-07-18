import "dart:io";
import "dart:async";

/// A callback to execute with raw Protobuf data.
typedef RawDataHandler = void Function(Datagram packet);

class SocketInfo {
	final InternetAddress address;
	final int port;
	const SocketInfo({required this.address, required this.port}); 
}

void log(String message) => print(message);  // ignore: avoid_print

abstract class UdpSocket {
	final int listenPort;

	UdpSocket({required this.listenPort});

	/// The UDP socket backed by `dart:io`.
	/// 
	/// This socket must be closed in [dispose].
	late RawDatagramSocket _socket;

	/// The subscription that listens for incoming data.
	/// 
	/// This must be cancelled in [dispose].
	late StreamSubscription<RawSocketEvent> _subscription;

	Future<void> init() async {
		log("Listening on port $listenPort");
		_socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, listenPort);
		_subscription = _socket.listenForData(onData);
	}

	Future<void> dispose() async {
		log("Closed the socket on port $listenPort");
		await _subscription.cancel();
		_socket.close();
	}

	void onData(Datagram packet);

	void sendData(List<int> data, SocketInfo destination) {
		_socket.send(data, destination.address, destination.port);
	}
}

/// Helper methods on raw data streams.
extension on RawDatagramSocket {
	/// Parses out empty data before handling it. 
	StreamSubscription<RawSocketEvent> listenForData(RawDataHandler handler) => listen((event) {
		final datagram = receive();
		if (datagram == null) return; 
		handler(datagram);
	});
}
