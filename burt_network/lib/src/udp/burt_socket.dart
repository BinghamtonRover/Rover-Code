import "dart:async";
import "dart:io";

import "package:burt_network/burt_network.dart";
import "package:meta/meta.dart";

/// Utility methods for parsing datagram messages as wrapped messages
extension DatagramUtil on Datagram {
  /// Returns the wrapped message parsed from the data of the datagram
  WrappedMessage parseWrapper() => WrappedMessage.fromBuffer(data);

  /// Returns the wrapped message and its source
  WrapperDatagram parseWrapperDatagram() {
    final wrapper = WrappedMessage.fromBuffer(data);

    return WrapperDatagram(
      message: wrapper,
      timestamp: wrapper.timestamp,
      source: source,
    );
  }

  /// The source that the datagram was sent from
  SocketInfo get source => SocketInfo(address: address, port: port);
}

/// A better name for [Connect].
typedef Heartbeat = Connect;

/// A better name for [UpdateSetting].
typedef NetworkSettings = UpdateSetting;

/// A [UdpSocket] that follows the BURT protocols.
///
/// Instead of raw bytes, we send Protobuf messages. This class transforms [stream] into [messages],
/// a stream of [WrappedMessage]s. Instead of using [send], you may want to use [sendMessage] or
/// [sendWrapper] to send [Message]s or [WrappedMessage]s, respectively.
///
/// This class also filters incoming messages to handle special types of messages:
/// - Override [onHeartbeat] to handle [Heartbeat] messages
/// - Override [onSettings] to handle [NetworkSettings] messages
///
/// To ensure connectedness, even over UDP, we send [Heartbeat] messages periodically. Override
/// [checkHeartbeats] and [heartbeatInterval] to send or wait for heartbeats, and set [isConnected]
/// accordingly. When the value changes, call [onConnect] or [onDisconnect] as needed.
///
/// This class is meant to be used by all BURT devices, both on-rover and at the base station. For
/// example, the rover might override [checkHeartbeats] to ensure a heartbeat has been sent, while
/// the Dashboard might use it to send a heartbeat and await a response.
abstract class BurtSocket extends UdpSocket {
  final _controller = StreamController<WrapperDatagram>.broadcast();

  /// The device this socket will be used on.
  ///
  /// Used to properly respond to heartbeats and for thorough logging.
  final Device device;

  /// The destinations this socket will send to by default.
  ///
  /// All the `send` functions allow you to send to a specific [SocketInfo]. This field
  /// is the default destinations it will send to if those parameters are omitted.
  final Set<SocketInfo> destinations = {};

  /// Whether or not the default destination should be kept when the socket is dispose.
  ///
  /// If this is true, [destinations] will not be cleared when [dispose] is called.
  ///
  /// This is intended to prevent scenarios where the socket automatically restarts due
  /// to an allowed OS error (see [allowedErrors]), and the socket's destination can no
  /// longer receive messages by this socket due to [destinations] being empty.
  ///
  /// It only makes sense to use this when communicating with a static IP. If the destination port
  /// can change between resets, using this may mean the socket will try to communicate with a port
  /// that no longer exists. Practically, that means only the Dashboard should set this to be true.
  final bool keepDestination;

  Timer? _heartbeatTimer;

  StreamSubscription<Datagram?>? _subscription;

  /// The main service, or collection of services, of the program, if any.
  ///
  /// This service may be shut down, restarted, or have its [onDisconnect] handler called.
  Service? collection;

  /// Creates a [UdpSocket] that follows BURT protocols.
  BurtSocket({
    required super.port,
    required this.device,
    super.quiet,
    this.keepDestination = false,
    List<SocketInfo>? destinations,
    SocketInfo? destination,
    this.collection,
  }) : assert(
         destinations == null || destination == null,
         "Either destinations or destination must be null. Cannot initialize a singular and multiple destinations at the same time",
       ) {
    if (destinations != null) {
      this.destinations.addAll(destinations);
    }
    if (destination != null) {
      this.destinations.add(destination);
    }
  }

  /// A stream of [WrapperDatagram]s as they arrive from the UDP socket
  Stream<WrapperDatagram> get messages => _controller.stream;

  @override
  Future<bool> init() async {
    await super.init();
    _subscription = stream.listen(_onPacket);
    _heartbeatTimer = Timer.periodic(heartbeatInterval, (_) => checkHeartbeats());
    return true;
  }

  @override
  Future<void> dispose() async {
    await _subscription?.cancel();
    _heartbeatTimer?.cancel();
    if (!keepDestination) {
      destinations.clear();
    }
    await super.dispose();
  }

  @override
  void send(List<int> data, {SocketInfo? destination}) {
    if (destination != null) {
      return super.send(data, destination: destination);
    }
    for (final address in destinations) {
      super.send(data, destination: address);
    }
  }

  @override
  void sendWrapper(WrappedMessage wrapper, {SocketInfo? destination}) {
    send(wrapper.writeToBuffer(), destination: destination);
  }

  @override
  void sendMessage(Message message, {SocketInfo? destination}) =>
    sendWrapper(message.wrap(timestamp), destination: destination);

  /// A utility method to exchange a "handshake" to the destination
  ///
  /// This will immediately send the [message], and will complete once the
  /// message is received again by this socket. If the message is not received
  /// after [timeout] amount of time, then it will complete false
  ///
  /// This assumes that there is a destination that is expecting this
  /// message and will immediately echo it back once receiving it
  Future<bool> tryHandshake<T extends Message>({
    required T message,
    required Duration timeout,
    required T Function(List<int> bytes) constructor,
    SocketInfo? destination,
  }) async {
    sendMessage(message, destination: destination);
    final completer = Completer<bool>();

    late final StreamSubscription<T> subscription;
    subscription = messages.onMessage(
      name: message.messageName,
      constructor: constructor,
      callback: (handshake) {
        completer.complete(true);
        subscription.cancel();
      },
    );

    try {
      return await completer.future.timeout(timeout);
    } on TimeoutException {
      await subscription.cancel();
      return false;
    }
  }

  void _onPacket(Datagram packet) {
    final wrapper = packet.parseWrapperDatagram();
    if (wrapper.message.name == Connect().messageName) {
      final heartbeat = Connect.fromBuffer(wrapper.message.data);
      onHeartbeat(heartbeat, packet.source);
    } else if (wrapper.message.name == UpdateSetting().messageName) {
      final settings = UpdateSetting.fromBuffer(wrapper.message.data);
      onSettings(settings);
      _controller.add(wrapper);
    } else {
      _controller.add(wrapper);
    }
  }

  /// Handle an incoming heartbeat coming from a given source.
  ///
  /// Be sure to check [Connect.sender] and [Connect.receiver], and compare the [source] against
  /// the current [destinations] to properly handle the heartbeat.
  void onHeartbeat(Heartbeat heartbeat, SocketInfo source);

  /// Handle an incoming request to change network settings.
  ///
  /// Be sure to echo the message back using [sendMessage], to confirm receipt.
  void onSettings(NetworkSettings settings);

  /// How often to check for new heartbeats.
  Duration get heartbeatInterval;

  /// Whether the device on the other end is connected.
  bool get isConnected;

  /// The current time of the socket.
  /// This timestamp is used as the default timestamp when sending a message.
  DateTime get timestamp => DateTime.timestamp();

  /// Sends or waits for heartbeats to or from the other device.
  void checkHeartbeats();

  /// Adds [source] to the available [destinations].
  ///
  /// Override this function to run custom code when a device connects to this socket.
  @mustCallSuper
  void onConnect(SocketInfo source) {
    destinations.add(source);
    _connectionCompleter?.complete();
    _connectionCompleter = null;  // to avoid completing twice
    logger.info("Port $port is connected to $source");
  }

  /// Sends a [Disconnect] message to the dashboard.
  ///
  /// Override this function to run custom code when the device on the other end disconnects.
  /// For example, put code to stop the rover from driving in here when connection is lost.
  @override
  Future<void> onDisconnect() async {
    logger.info("Port $port is disconnected from all clients.");
    destinations.clear();
    await collection?.onDisconnect();
    await super.onDisconnect();
  }

  Completer<void>? _connectionCompleter;

  /// Waits for a connection to be established.
  Future<void> waitForConnection() {
    _connectionCompleter = Completer();
    return _connectionCompleter!.future;
  }
}
