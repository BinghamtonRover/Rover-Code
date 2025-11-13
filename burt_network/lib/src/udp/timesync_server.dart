import "dart:async";
import "dart:io";

import "package:burt_network/burt_network.dart";

/// A UDP socket to act as the "time server" for time synchronization events
///
/// The time synchronization is received and handled from an independent UDP
/// socket, to reduce congestion with other data messages, which lowers latency
/// and improves time accuracy.
class TimesyncServer extends UdpSocket {
  StreamSubscription<Datagram>? _subscription;

  /// Default constructor for [TimesyncServer]
  TimesyncServer({required super.port, super.quiet});

  @override
  Future<bool> init() async {
    await super.init();
    _subscription = stream.listen(_onPacket);
    return true;
  }

  @override
  Future<void> dispose() async {
    await _subscription?.cancel();
    await super.dispose();
  }

  void _onPacket(Datagram packet) {
    final rxTime = DateTime.timestamp();
    final wrapper = packet.parseWrapper();
    wrapper.timestamp = Timestamp.fromDateTime(rxTime);

    sendWrapper(wrapper, destination: packet.source);
  }
}
