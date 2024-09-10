import "package:burt_network/generated.dart";

import "burt_socket.dart";
import "socket_info.dart";

/// A socket that can log messages using [sendLog].
///
/// If connected, this socket will send log messages immediately. If not, it will hold onto
/// messages and send them when the device finally connects.
mixin RoverLogger on BurtSocket {
  /// A list of important logs that need to be sent when the dashboard connects.
  final List<BurtLog> _logBuffer = [];

  /// Sends all the logs in [_logBuffer].
  Future<void> _flushLogBuffer() async {
    final temp = List<BurtLog>.from(_logBuffer);
    if (temp.isEmpty) return;
    for (final log in temp) {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      sendMessage(log);
    }
    _logBuffer.clear();
  }

  /// Sends a log message or saves it until a Dashboard is connected.
  ///
  /// Use this for logs that need to make it to the Dashboard, such as errors or warnings.
  void sendLog(BurtLog log) => isConnected
    ? sendMessage(log) : _logBuffer.add(log);

  @override
  void onConnect(SocketInfo source) {
    super.onConnect(source);
    _flushLogBuffer();
  }
}
