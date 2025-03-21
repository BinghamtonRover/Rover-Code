import "package:burt_network/burt_network.dart";

/// A mixin to automatically handle time synchronization
mixin RoverTimesync on BurtSocket {
  Duration _timeOffset = Duration.zero;

  @override
  bool get shouldSendTimesync => true;

  @override
  DateTime get timestamp => DateTime.timestamp().subtract(_timeOffset);

  @override
  void onTimesync(Timesync timesync, Timestamp serverReceiveTime, DateTime clientReceiveTime, SocketInfo source) {
    if (timesync.sender != device) {
      if (!quiet) {
      logger.warning(
        "Device ${device.name} received a timesync event for ${timesync.sender.name}",
      );}
      return;
    }
    if (source.port != timesyncPort) {
      if (!quiet) {
        logger.warning(
          "Socket on port ${destination?.port} expected to receive timesync message from port $timesyncPort, but received from ${source.port} instead",
        );
      }
      return;
    }
    final pongLocalTime = clientReceiveTime.microsecondsSinceEpoch;
    final pingClientTime = timesync.sendTime.toDateTime().microsecondsSinceEpoch;
    final pongServerTime = serverReceiveTime.toDateTime().microsecondsSinceEpoch;

    final rtt = pongLocalTime - pingClientTime;
    final serverOffsetMicros = pongServerTime - rtt ~/ 2 - pingClientTime;
    _timeOffset = Duration(microseconds: serverOffsetMicros);
  }
}
