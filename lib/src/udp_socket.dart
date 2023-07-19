import "dart:io";
import "dart:async";

import "package:meta/meta.dart";

import "socket.dart";
import "log.dart";

/// Manages a UDP socket.
/// 
/// UDP differs from TCP in the sense that it does not make any guarantees when sending messages
/// and does not monitor its own connections. Because of this, it is much faster than TCP, which
/// is why we are using it across the rover. Extend this class to implement your own UDP socket.
/// 
/// - Call [init] to open the socket on the given [port].
/// - Call [sendData] to send raw data to another socket.
/// - Override [onData] to handle incoming data.
/// - Call [dispose] to close the socket. Messages can no longer be sent or received after this. 
abstract class UdpSocket {
  /// The port this socket is listening on. See [RawDatagramSocket.bind].
  final int port;

  /// Opens a UDP socket on the given port that can send and receive data.
  UdpSocket({required this.port});

  /// The UDP socket backed by `dart:io`.
  /// 
  /// This socket must be closed in [dispose].
  late RawDatagramSocket _socket;

  /// The subscription that listens for incoming data.
  /// 
  /// This must be cancelled in [dispose].
  late StreamSubscription<RawSocketEvent> _subscription;

  /// Initializes the socket.
  @mustCallSuper
  Future<void> init() async {
    logger.info("Listening on port $port");
    _socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, port);
    _subscription = _socket.listenForData(onData);
  }

  /// Closes the socket.
  @mustCallSuper
  Future<void> dispose() async {
    logger.info("Closed the socket on port $port");
    await _subscription.cancel();
    _socket.close();
  }

  /// Sends data to the given destination.
  /// 
  /// Being UDP, this function does not wait for a response or even confirmation of a
  /// successful send and is therefore very quick and non-blocking.
  void sendData(List<int> data, SocketInfo destination) {
    _socket.send(data, destination.address, destination.port);
  }

  /// Override this function to process incoming data, along with the source address and port.
  void onData(Datagram packet);
}

/// Helper methods on raw data streams.
extension on RawDatagramSocket {
  /// Parses out empty data before handling it. 
  StreamSubscription<RawSocketEvent> listenForData(void Function(Datagram packet) handler) => listen((event) {
    final datagram = receive();
    if (datagram == null) return; 
    handler(datagram);
  });
}
