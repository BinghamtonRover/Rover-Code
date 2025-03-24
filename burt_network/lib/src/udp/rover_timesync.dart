import "package:burt_network/burt_network.dart";

/// A mixin to automatically handle time synchronization
mixin RoverTimesync on BurtSocket {
  Duration _timeOffset = Duration.zero;

  @override
  bool get shouldSendTimesync => true;

  @override
  DateTime get timestamp => DateTime.timestamp().add(_timeOffset);

  @override
  void onTimesync(
    Timesync timesync,
    Timestamp serverReceiveTime,
    DateTime clientReceiveTime,
    SocketInfo source,
  ) {
    if (timesync.sender != device) {
      if (!quiet) {
        logger.warning(
          "Device ${device.name} received a timesync event for ${timesync.sender.name}",
        );
      }
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
    if (source.address.isLoopback) {
      _timeOffset = Duration.zero;
      return;
    }

    final pongLocalTime = clientReceiveTime.microsecondsSinceEpoch;
    final pingClientTime =
        timesync.sendTime.toDateTime().microsecondsSinceEpoch;
    final pongServerTime =
        serverReceiveTime.toDateTime().microsecondsSinceEpoch;

    final rtt2 = pongLocalTime - pingClientTime;
    final serverTimeAtRx = pongServerTime + rtt2 ~/ 2;
    final serverOffsetMicros = serverTimeAtRx - pongLocalTime;
    _timeOffset = Duration(microseconds: serverOffsetMicros);
  }
}
