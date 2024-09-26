import "dart:io";
import "dart:async";

import "package:burt_network/burt_network.dart";

extension on RawDatagramSocket {
  Stream<Datagram> onlyData() =>
    where((event) => event == RawSocketEvent.read)
    .map((event) => receive()).notNull();
}

/// Manages a UDP socket.
///
/// UDP differs from TCP in the sense that it does not make any guarantees when sending messages
/// and does not monitor its own connections. Because of this, it is much faster than TCP, which
/// is why we are using it across the rover. Extend this class to implement your own UDP socket.
///
/// - Call [init] to open the socket on the given [port].
/// - Call [send] to send raw data to another socket.
/// - Call [dispose] to close the socket.
/// - Use [stream] to listen to new packets ([Datagram]s) as they arrive over the socket.
class UdpSocket extends Service {
  /// A collection of allowed [OSError] codes.
  ///
  /// These errors represent a network failure, and the socket should be reset. The [init] function
  /// will check for these errors and simply restart the socket if necessary.
  static const allowedErrors = {1234, 10054, 101, 10038, 9};

  /// A logger to capture important events during operation.
  final logger = BurtLogger();

  /// Whether to silence "normal" output, like opening/closing and resetting sockets.
  final bool quiet;

  /// The port this socket is listening on. See [RawDatagramSocket.bind].
  int? get port => _socket?.port;

  /// The port originally requested in the constructor.
  ///
  /// If this is null, a new port is chosen by the operating system. If the socket needs to reset,
  /// [port] will remain set to the OS-chosen port, and not set back to null. Then, when [init] is
  /// called, it will try to re-use the old port, which will fail in some cases. This field tracks
  /// the original value and will re-request the original port when [init] is called.
  final int? _port;

  /// The destination port to send to.
  ///
  /// All the `send` functions allow you to send to a specific [SocketInfo]. This field
  /// is the default destination if those parameters are omitted.
  SocketInfo? destination;

  /// Opens a UDP socket on the given port that can send and receive data.
  UdpSocket({required int? port, this.quiet = false, this.destination}) :
    _port = port;

  /// The UDP socket backed by `dart:io`.
  ///
  /// This socket must be closed in [dispose].
  RawDatagramSocket? _socket;

  /// A stream controller to emit new packets.
  ///
  /// Note that we cannot use [_socket] directly as it will be set to a new instance when [dispose]
  /// is called. This class must be resettable, meaning it must be safe to call [dispose] and [init]
  /// back to back without breaking other logic. If we used the underlying socket directly, resetting
  /// this instance would result in some listeners listening to the old socket and some listening to
  /// the new socket. This controller gives a public API to the underlying socket.
  final _controller = StreamController<Datagram>.broadcast();

  /// Used to forward events from [_socket] to [_controller].
  StreamSubscription<Datagram>? _subscription;

  /// A stream containing all the data coming out of the socket.
  Stream<Datagram> get stream => _controller.stream;

  @override
  Future<bool> init() async {
    await runZonedGuarded<Future<void>>(
      // This code cannot be a try/catch because the SocketException can be thrown at any time,
      // even after this function has finished. It also cannot be caught by the caller of this function.
      // Using [runZonedGuarded] ensures that the error is caught no matter when it is thrown.
      () async {  // Initialize the socket
        _socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, _port ?? 0);
        _subscription = _socket!.onlyData().listen(_controller.add);
        if (!quiet) logger.info("Listening on port $port");
      },
      (Object error, StackTrace stack) async {  // Catch errors and restart the socket
        if (error is SocketException && allowedErrors.contains(error.osError!.errorCode)) {
          if (!quiet) logger.warning("Socket error ${error.osError!.errorCode} on port $port. Restarting...");
          await Future<void>.delayed(const Duration(seconds: 1));
          await dispose();
          await init();
        } else {
          Error.throwWithStackTrace(error, stack);
        }
      }
    );
    return true;
  }

  @override
  Future<void> dispose() async {
    if (!quiet) logger.info("Closing the socket on port $port");
    await _subscription?.cancel(); _subscription = null;
    _socket?.close(); _socket = null;
    destination = null;
  }

  /// Sends data to the given destination.
  ///
  /// Being UDP, this function does not wait for a response or even confirmation of a
  /// successful send and is therefore very quick and non-blocking.
  void send(List<int> data, {SocketInfo? destination}) {
    final target = destination ?? this.destination;
    if (target == null) return;
    if (_socket == null) throw StateError("Cannot use a UdpSocket on port $_port after it's been disposed");
    _socket!.send(data, target.address, target.port);
  }

  /// Sends a [WrappedMessage] over the socket.
  void sendWrapper(WrappedMessage wrapper, {SocketInfo? destination}) =>
    send(wrapper.writeToBuffer(), destination: destination);

  /// Sends a [Message] over the socket (in a [WrappedMessage]).
  void sendMessage(Message message, {SocketInfo? destination}) =>
    sendWrapper(message.wrap(), destination: destination);

  /// Wraps all incoming data in a [WrappedMessage].
  Stream<WrappedMessage> get messages => stream
    .map((packet) => WrappedMessage.fromBuffer(packet.data));
}
