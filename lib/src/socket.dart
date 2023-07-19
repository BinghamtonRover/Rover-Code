import "dart:io";

/// Information about a socket.
class SocketInfo {
	/// The IP address of this socket.
	final InternetAddress address;
	/// The port that the socket is connected to.
	final int port;
	
	/// A const constructor.
	const SocketInfo({required this.address, required this.port}); 
}
