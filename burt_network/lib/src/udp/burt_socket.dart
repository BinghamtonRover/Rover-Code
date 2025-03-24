import "dart:async";
import "dart:io";

import "package:burt_network/burt_network.dart";
import "package:meta/meta.dart";

/// Utility methods for parsing datagram messages as wrapped messages
extension DatagramUtil on Datagram {
  /// Returns the wrapped message parsed from the data of the datagram
  WrappedMessage parseWrapper() => WrappedMessage.fromBuffer(data);

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
/// - Override [onTimesync] to handle [Timesync] messages
///
/// To ensure connectedness, even over UDP, we send [Heartbeat] messages periodically. Override
/// [checkHeartbeats] and [heartbeatInterval] to send or wait for heartbeats, and set [isConnected]
/// accordingly. When the value changes, call [onConnect] or [onDisconnect] as needed.
///
/// This class is meant to be used by all BURT devices, both on-rover and at the base station. For
/// example, the rover might override [checkHeartbeats] to ensure a heartbeat has been sent, while
/// the Dashboard might use it to send a heartbeat and await a response.
abstract class BurtSocket extends UdpSocket {
  final _controller = StreamController<WrappedMessage>.broadcast();

  /// The device this socket will be used on.
  ///
  /// Used to properly respond to heartbeats and for thorough logging.
  final Device device;

  /// The destinations this socket will send to.
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

  /// The maximum number of clients that can be connected to this socket.
  ///
  /// Once the maximum number of clients have been connected, and incoming
  /// connection attempts will be rejected, and will not have any data sent
  /// to them.
  final int maxClients;

  /// The port to send and receive timesync messages from
  /// If this socket is configured to send timesync messages,
  /// the [Timesync] message will be sent to a socket with
  /// the first address in [destinations] IP address, and timesync port.
  /// 
  /// By default, the timesync port is 8020
  final int timesyncPort;

  Timer? _heartbeatTimer;
  Timer? _timesyncTimer;

  StreamSubscription<Datagram?>? _subscription;

  /// The main service, or collection of services, of the program, if any.
  ///
  /// This service may be shut down, restarted, or have its [onDisconnect] handler called.
  Service? collection;

  /// Creates a [UdpSocket] that follows BURT protocols.
  BurtSocket({
    required super.port,
    required this.device,
    this.timesyncPort = 8020,
    super.quiet,
    this.keepDestination = false,
    this.maxClients = 5,
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

  /// A stream of [WrappedMessage]s as they arrive in the UDP socket.
  @override
  Stream<WrappedMessage> get messages => _controller.stream;

  @override
  Future<bool> init() async {
    await super.init();
    _subscription = stream.listen(_onPacket);
    _heartbeatTimer = Timer.periodic(heartbeatInterval, (_) => checkHeartbeats());
    if (shouldSendTimesync) {
      _timesyncTimer = Timer.periodic(const Duration(seconds: 1), (_) => sendTimesync());
    }
    return true;
  }

  @override
  Future<void> dispose() async {
    await _subscription?.cancel();
    _heartbeatTimer?.cancel();
    _timesyncTimer?.cancel();
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
    final receiveTime = DateTime.timestamp();
    final wrapper = packet.parseWrapper();
    if (wrapper.name == Connect().messageName) {
      final heartbeat = Connect.fromBuffer(wrapper.data);
      onHeartbeat(heartbeat, packet.source);
    } else if (wrapper.name == Timesync().messageName) {
      final timesync = Timesync.fromBuffer(wrapper.data);
      onTimesync(timesync, wrapper.timestamp, receiveTime, packet.source);
    } else if (wrapper.name == UpdateSetting().messageName) {
      final settings = UpdateSetting.fromBuffer(wrapper.data);
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

  /// Handle an incoming Timesync message from a given source.
  ///
  /// The message's send time, server receive time, and client receive
  /// time will be used to calculate the estimated time offset between
  /// the socket and timesync server
  void onTimesync(
    Timesync timesync,
    Timestamp serverReceiveTime,
    DateTime clientReceiveTime,
    SocketInfo source,
  ) {}

  /// Handle an incoming request to change network settings.
  ///
  /// Be sure to echo the message back using [sendMessage], to confirm receipt.
  void onSettings(NetworkSettings settings);

  /// How often to check for new heartbeats.
  Duration get heartbeatInterval;

  /// Whether the device on the other end is connected.
  bool get isConnected;

  /// Whether or not this socket should be sending timesync events to its destination
  /// If true, it will periodically send timesync events to a destination timesync server.
  ///
  /// This serves a separate function than heartbeats. Heartbeats are used solely to
  /// keep up the connection, wheras timesync is used to ensure that the dashboard and
  /// rover are on the same time scale, allowing message timestamps to be consistent
  /// regardless of where they are sent to or from.
  bool get shouldSendTimesync => false;

  /// The current time of the socket.
  /// This timestamp is used as the default timestamp when sending a message.
  DateTime get timestamp => DateTime.timestamp();

  /// Sends or waits for heartbeats to or from the other device.
  void checkHeartbeats();

  /// Sends a timesync message to the destination IP address on port [timesyncPort]
  void sendTimesync() {
    if (destinations.isEmpty) {
      return;
    }
    sendMessage(
      Timesync(
        sender: device,
        sendTime: Timestamp.fromDateTime(DateTime.timestamp()),
      ),
      destination: SocketInfo(
        address: destinations.first.address,
        port: timesyncPort,
      ),
    );
  }

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
