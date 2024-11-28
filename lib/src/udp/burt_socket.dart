import "dart:async";
import "dart:io";

import "package:burt_network/burt_network.dart";
import "package:meta/meta.dart";

extension on Datagram {
  WrappedMessage parseWrapper() => WrappedMessage.fromBuffer(data);
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
  final _controller = StreamController<WrappedMessage>.broadcast();

  /// The device this socket will be used on.
  ///
  /// Used to properly respond to heartbeats and for thorough logging.
  final Device device;

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
    super.destination,
    super.quiet,
    this.collection,
  });

  /// A stream of [WrappedMessage]s as they arrive in the UDP socket.
  @override
  Stream<WrappedMessage> get messages => _controller.stream;

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
    await super.dispose();
  }

  void _onPacket(Datagram packet) {
    final wrapper = packet.parseWrapper();
    if (wrapper.name == Connect().messageName) {
      final heartbeat = Connect.fromBuffer(wrapper.data);
      onHeartbeat(heartbeat, packet.source);
    } else if (wrapper.name == UpdateSetting().messageName) {
      final settings = UpdateSetting.fromBuffer(wrapper.data);
      onSettings(settings);
    } else {
      _controller.add(wrapper);
    }
  }

  /// Handle an incoming heartbeat coming from a given source.
  ///
  /// Be sure to check [Connect.sender] and [Connect.receiver], and compare the [source] against
  /// the current [destination] to properly handle the heartbeat.
  void onHeartbeat(Heartbeat heartbeat, SocketInfo source);

  /// Handle an incoming request to change network settings.
  ///
  /// Be sure to echo the message back using [sendMessage], to confirm receipt.
  void onSettings(NetworkSettings settings);

  /// How often to check for new heartbeats.
  Duration get heartbeatInterval;

  /// Whether the device on the other end is connected.
  bool get isConnected;

  /// Sends or waits for heartbeats to or from the other device.
  void checkHeartbeats();

  /// Sets [destination] to the incoming [source].
  ///
  /// Override this function to run custom code when a device connects to this socket.
  @mustCallSuper
  void onConnect(SocketInfo source) {
    destination = source;
    _connectionCompleter?.complete();
    _connectionCompleter = null;  // to avoid completing twice
    logger.info("Port $port is connected to $source");
  }

  /// Sends a [Disconnect] message to the dashboard and sets [destination] to `null`.
  ///
  /// Override this function to run custom code when the device on the other end disconnects.
  /// For example, put code to stop the rover from driving in here when connection is lost.
  @override
  Future<void> onDisconnect() async {
    logger.info("Port $port is disconnected from $destination");
    sendMessage(Disconnect(sender: device));
    destination = null;
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
