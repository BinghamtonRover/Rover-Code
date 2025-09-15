import "dart:async";
import "dart:io";

import "package:burt_network/burt_network.dart";

/// A UDP socket that will only send timesync messages to a timesync server
///
/// The time synchronization is received and handled from an independent UDP
/// socket, to reduce congestion with other data messages, which lowers latency
/// and improves time accuracy.
class TimesyncSocket extends UdpSocket {
  Duration _timeOffset = Duration.zero;
  Duration _latency = Duration.zero;

  bool _receivedTimesync = false;

  /// The Round-Trip-Time of the last timesync message received.
  ///
  /// This is equivalent to the amount of time it takes for a
  /// message to be sent to the server.
  Duration get latency => _latency;

  /// The current time of the socket, adjusted based on the time synchronization offset.
  DateTime get timestamp => DateTime.timestamp().add(_timeOffset);

  /// Whether or not a timesync event has been received from the server
  ///
  /// If this is true, it means the time received from [timestamp] is
  /// within a close range of the server.
  ///
  /// After the first timesync event is received, this will remain true
  /// until the server address has changed.
  bool get receivedTimesync => _receivedTimesync;

  /// The address and port of the timesync server.
  ///
  /// If this socket is configured to send timesync messages, the [Timesync] message
  /// will be sent to a socket with the specified IP address and port.
  ///
  /// If the Socket Info's IP address is [InternetAddress.anyIPv4], it will be sent to
  /// [InternetAddress.loopbackIPv4]
  ///
  /// By default, the address is [InternetAddress.loopbackIPv4], on port 8020
  SocketInfo get timesyncDestination {
    final address = _timesyncDestination.address != InternetAddress.anyIPv4
        ? _timesyncDestination.address
        : InternetAddress.loopbackIPv4;

    return SocketInfo(address: address, port: _timesyncDestination.port);
  }

  set timesyncDestination(SocketInfo destination) {
    if (_timesyncDestination != destination) {
      _receivedTimesync = false;
      _timeOffset = Duration.zero;
      _latency = Duration.zero;
    }
    _timesyncDestination = destination;
  }

  late SocketInfo _timesyncDestination;

  Timer? _timesyncTimer;

  StreamSubscription<Datagram?>? _subscription;

  /// Default constructor for TimesyncSocket
  TimesyncSocket({super.port, super.quiet = true, SocketInfo? timesyncAddress})
    : _timesyncDestination =
          timesyncAddress ??
          SocketInfo(address: InternetAddress.loopbackIPv4, port: 8020);

  @override
  Future<bool> init() async {
    await super.init();
    _subscription = stream.listen(_onPacket);
    _timesyncTimer = Timer.periodic(const Duration(seconds: 1), sendTimesync);
    return true;
  }

  @override
  Future<void> dispose() async {
    await _subscription?.cancel();
    _subscription = null;

    _timesyncTimer?.cancel();
    _timesyncTimer = null;

    _receivedTimesync = false;
    _timeOffset = Duration.zero;
    _latency = Duration.zero;

    return super.dispose();
  }

  void _onPacket(Datagram packet) {
    final clientRxTime = DateTime.timestamp();
    final wrapper = packet.parseWrapper();
    if (wrapper.name != Timesync().messageName) {
      return;
    }

    final timesyncMessage = Timesync.fromBuffer(wrapper.data);
    final serverReceiveTime = wrapper.timestamp;

    onTimesync(timesyncMessage, serverReceiveTime, clientRxTime, packet.source);
  }

  /// Sends a timesync message to the [timesyncDestination]
  void sendTimesync([_]) => sendMessage(
    Timesync(sendTime: Timestamp.fromDateTime(DateTime.timestamp())),
    destination: timesyncDestination,
  );

  /// Handles an incoming [Timesync] message and updates the
  /// time offsets accordingly
  ///
  /// The message's send time, server receive time, and client receive
  /// time will be used to calculate the estimated time offset between
  /// the socket and timesync server.
  void onTimesync(
    Timesync timesync,
    Timestamp serverReceiveTime,
    DateTime clientReceiveTime,
    SocketInfo source,
  ) {
    if (source != timesyncDestination) {
      if (!quiet) {
        logger.warning(
          "Socket on port $port expected to receive timesync message from $timesyncDestination, but received from $source instead",
        );
      }
      return;
    }

    final pongLocalTime = clientReceiveTime.microsecondsSinceEpoch;
    final pingClientTime = timesync.sendTime
        .toDateTime()
        .microsecondsSinceEpoch;
    final pongServerTime = serverReceiveTime
        .toDateTime()
        .microsecondsSinceEpoch;

    final rtt2 = pongLocalTime - pingClientTime;
    final serverTimeAtRx = pongServerTime + rtt2 ~/ 2;
    final serverOffsetMicros = serverTimeAtRx - pongLocalTime;

    _receivedTimesync = true;
    _latency = Duration(microseconds: rtt2 ~/ 2);

    if (source.address.isLoopback) {
      _timeOffset = Duration.zero;
      return;
    }

    _timeOffset = Duration(microseconds: serverOffsetMicros);
  }
}
