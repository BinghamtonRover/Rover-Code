import "package:burt_network/generated.dart";

import "burt_protocol.dart";

mixin RoverLogger on BurtUdpProtocol {
  /// A list of important logs that need to be sent when the dashboard connects.
  final List<BurtLog> _logBuffer = [];

  /// Sends all the logs in [_logBuffer].
  Future<void> flushLogBuffer() async {
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
  void sendLog(BurtLog log) {
    if (isConnected) {
      sendMessage(log);
    } else {
      _logBuffer.add(log);
    }
  }
}
