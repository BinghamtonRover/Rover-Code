import "dart:io";
import "dart:async";
import "package:meta/meta.dart";

import "package:burt_network/generated.dart";
import "package:burt_network/logging.dart";

import "socket_info.dart";
import "proto_socket.dart";

/// A [ProtoSocket] that expects heartbeats from the dashboard.
/// 
/// Use this class as a server on the rover. Usage:
/// 
/// - Call [init] to open the socket. Override to add your own initialization code.
/// - Call [sendMessage] to send a [Message].
/// - Override [onConnect] to be notified when the dashboard connects.
/// - Override [onDisconnect] to be notified when the dashboard disconnects.
/// - Override [onMessage] to handle incoming messages.
/// - Override [updateSettings] to handle [UpdateSetting] requests.
/// - Call [dispose] to close the socket. Override to add your own cleanup.
abstract class ServerSocket extends ProtoSocket {
  /// A list of important logs that need to be sent when the dashboard connects.
  final List<BurtLog> _logBuffer = [];

  final _logger = BurtLogger();
  
  /// A server that expects handshakes from the dashboard.
  ServerSocket({required super.device, required super.port, super.quiet}) : 
    super(heartbeatInterval: const Duration(seconds: 2));

  /// Whether this socket is connected to the dashboard.
  bool get isConnected => destination != null;

  /// Whether this socket received a heartbeat since the last call to [checkHeartbeats].
  bool didReceivedHeartbeat = false;

  /// Sets [destination] to the incoming [source].
  /// 
  /// Override this function to run custom code when the dashboard connects, but be sure to call
  /// `super.onConnect(source)` as well.
  @mustCallSuper
  void onConnect(SocketInfo source) {
    destination = source;
    _logger.info("Port $port is connected to $destination");
    Timer(const Duration(milliseconds: 500), _flushLogBuffer);
  }

  /// Sends all the logs in [_logBuffer].
  Future<void> _flushLogBuffer() async {
    if (_logBuffer.isEmpty) return;
    for (final log in _logBuffer) {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      sendMessage(log);
    }
    _logBuffer.clear();
  }

  /// Sends a [Disconnect] message to the dashboard and sets [destination] to `null`.
  /// 
  /// Override this function to run custom code when the dashboard disconnects, but be sure to call
  /// `super.onDisconnect()` as well. For example, put code to stop the rover from driving in here
  /// to prevent it from crashing when connection is lost.
  @mustCallSuper
  void onDisconnect() {
    _logger.info("Port $port is disconnected from $destination");
    sendMessage(Disconnect(sender: device));
    destination = null;
  }

  @override
  Future<void> dispose() async {
    onDisconnect();
    await super.dispose();
  }

  /// Checks if a heartbeat has been received. If not, calls [onDisconnect].
  /// 
  /// This function runs every [heartbeatInterval] seconds via [heartbeatTimer].
  @override
  Future<void> checkHeartbeats() async {
    if (didReceivedHeartbeat) {
      didReceivedHeartbeat = false;
    } else if (isConnected) {
      _logger.warning("Heartbeat not received. Assuming the dashboard has disconnected");
      onDisconnect();
    }
  }

  /// Handles incoming heartbeats.
  /// 
  /// 1. If the heartbeat was meant for another device, log it and ignore it.
  /// 2. If it came from our dashboard, respond to it with [sendResponse].
  /// 3. If it came from another dashboard, log it and ignore it.
  /// 4. If we are not connected to any dashboard, call [onConnect] and respond to it.
  @override
  void onHeartbeat(Connect heartbeat, SocketInfo source) {
    if (heartbeat.receiver != device) {  // (1)
      _logger.warning("Received a misaddressed heartbeat for ${heartbeat.receiver}");
    } else if (isConnected) {
      if (destination == source) {  // (2)
        sendResponse();
      } else {  // (3)
        _logger.warning("Port $port is connected to $destination but received a heartbeat from $source");
      }
    } else {  // (4)
      onConnect(source);
      sendResponse();
    }
  }

  /// Sends a response heartbeat to the dashboard. 
  void sendResponse() {
    final response = Connect(sender: device, receiver: Device.DASHBOARD);
    sendMessage(response);
    didReceivedHeartbeat = true;
  }

  /// Handles incoming [UpdateSetting] requests.
  /// 
  /// This function handles basic, shared settings, but you may override this to handle your
  /// own settings. Be sure to call `super.updateSetting(settings)` in your override.
  @override
  void updateSettings(UpdateSetting settings) {
    sendMessage(settings);
    if (settings.status == RoverStatus.POWER_OFF) {
      _logger.critical("Shutting down...");
      Process.run("sudo shutdown now", []);
    }
  }

  /// Sends a log message or saves it until a Dashboard is connected.
  /// 
  /// Use this for logs that need to make it to the Dashboard, such as errors or warnings.
  void sendLog(BurtLog log) {
    if (isConnected) {
      sendMessage(log);
    } else {
      _logBuffer.add(log);
    }
  }
}
