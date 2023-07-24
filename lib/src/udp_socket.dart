import "dart:io";
import "dart:async";

import "package:meta/meta.dart";

import "socket_info.dart";
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
  /// A collection of allowed [OSError] codes.
  static const allowedErrors = {1234, 10054, 101, 10038, 9};

  /// The port this socket is listening on. See [RawDatagramSocket.bind].
  int? port;

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

  /// Initializes the socket, and restarts it if a known "safe" error occurs (see [allowedErrors]).
  @mustCallSuper
  Future<void> init() async => runZonedGuarded<Future<void>>(
    // This code cannot be a try/catch because the SocketException can be thrown at any time,
    // even after this function has finished. It also cannot be caught by the caller of this function.
    // Using [runZonedGuarded] ensures that the error is caught no matter when it is thrown.
    () async {  // Initialize the socket
      _socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, port ?? 0);
      _subscription = _socket.listenForData(onData);
      if (port == null || port == 0) port = _socket.port;
      logger.info("Listening on port $port");
    },
    (Object error, StackTrace stack) async {  // Catch errors and restart the socket
      if (error is SocketException && allowedErrors.contains(error.osError!.errorCode)) {
        logger.warning("Socket error ${error.osError!.errorCode} on port $port. Restarting...");
        await dispose();
        await init();
      } else {
        Error.throwWithStackTrace(error, stack);
      }
    }
  );

  /// Closes the socket.
  @mustCallSuper
  Future<void> dispose() async {
    await _subscription.cancel();
    _socket.close();
    logger.info("Closed the socket on port $port");
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
