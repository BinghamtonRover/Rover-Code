import "dart:async";
import "dart:io";
import "package:meta/meta.dart";

import "package:burt_network/generated.dart";

import "udp_socket.dart";
import "socket.dart";
import "log.dart";

/// How often to check for heartbeats.
const heartbeatInterval = Duration(seconds: 2);

/// A [UdpSocket] to send and receive Protobuf messages.
/// 
/// This class can handle all the structured data the dashboard may send:
/// 
/// 1. normal commands, to be handled by the specific server (for example, "enable a camera")
/// 2. handshake messages, which require some sort of confirmation response from the server.
/// 3. heartbeat messages, periodic handshakes to confirm that the servers are still connected.
/// 
/// The [Connect] message serves as both the handshake and the heartbeat. A [Connect] message indicates
/// who initiated the handshake and who it was intended for. The recipient is then to send another
/// [Connect] message in response, but with the updated [Connect.sender] and [Connect.receiver] fields. 
/// 
/// This class calls [checkHeartbeats] every [heartbeatInterval]. Override that class to either send
/// or receive heartbeats and act accordingly.
/// 
/// To use this class, extend it and:
/// 
/// - Call [init] to open the socket. Override to add your own initialization code.
/// - Call [sendMessage] to send a [Message].
/// - Override [onMessage] to handle incoming messages.
/// - Override [updateSettings] to handle [UpdateSetting] requests.
/// - Override [checkHeartbeats] to check for or send out heartbeats.
/// - Override [onHeartbeat] to handle incoming heartbeats.
/// - Call [dispose] to close the socket. Override to add your own cleanup code.
/// - For convenience, set [destination] to avoid passing a socket to each call to [sendMessage].
abstract class ProtoSocket extends UdpSocket {
  /// The device using this socket. Used to fill [Connect.sender].
  final Device device;

  /// A timer to call [checkHeartbeats] every [heartbeatInterval].
  late Timer heartbeatTimer;

  /// A UDP socket that can send and receive Protobuf [Message]s.
  ProtoSocket({required this.device, required super.port});

  /// The socket to send messages to.
  SocketInfo? destination;

  @override
  Future<void> init() async {
    await super.init();
    heartbeatTimer = Timer.periodic(heartbeatInterval, (_) => checkHeartbeats());
  }

  @override
  Future<void> dispose() async {
    heartbeatTimer.cancel();
    await super.dispose();
  }

  /// Handles incoming data as Protobuf messages. 
  /// 
  /// - If the message is a heartbeat, respond to it with [onHeartbeat].
  /// - If the message is an [UpdateSetting] message, calls [updateSettings]. 
  /// - Otherwise, calls [onMessage] with the [WrappedMessage].
  @override
  void onData(Datagram packet) {
    final wrapper = WrappedMessage.fromBuffer(packet.data);
    if (wrapper.name == UpdateSetting().messageName) {
      final settings = UpdateSetting.fromBuffer(wrapper.data);
      updateSettings(settings);
    } else if (wrapper.name == Connect().messageName) {
      final heartbeat = Connect.fromBuffer(wrapper.data);
      final socket = SocketInfo(address: packet.address, port: packet.port);
      onHeartbeat(heartbeat, socket);
    } else {
      onMessage(wrapper);
    }
  }

  /// Wraps a [Message] and sends it to the [destination], or the given [socketOverride] if specified.
  void sendMessage(Message message, {SocketInfo? socketOverride}) {
    final wrapper = message.wrap();
    final target = socketOverride ?? destination;
    if (target == null) {
      logger.critical("No destination or override was specificed");
      throw ArgumentError.notNull("socketOverride");
    }
    sendData(wrapper.writeToBuffer(), target);
  }

  /// Handles incoming [UpdateSetting] requests.
  /// 
  /// To ensure critical settings are updated, the server must respond with its settings after
  /// making the requested change. That way, the dashboard can warn the user if it fails.
  @mustCallSuper
  void updateSettings(UpdateSetting settings);

  /// Override this function to be notified of new Protobuf messages.
  /// 
  /// Since Protobuf is not self-describing, it's impossible to tell which type of message a binary
  /// payload contains. To get around this, we use [WrappedMessage]s to contain both an identifier
  /// of the type of message and the message itself. 
  void onMessage(WrappedMessage wrapper);

  /// Override this function to be notified of incoming heartbeats.
  void onHeartbeat(Connect heartbeat, SocketInfo source);

  /// Override this function to send or receive heartbeats.
  /// 
  /// The dashboard should send heartbeats to all devices, and the onboard computers should check
  /// if a heartbeat has been received recently and act accordingly.
  Future<void> checkHeartbeats();
}
