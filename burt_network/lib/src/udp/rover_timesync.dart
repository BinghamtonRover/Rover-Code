import "package:burt_network/burt_network.dart";

/// A mixin to automatically handle time synchronization
mixin RoverTimesync on BurtSocket {
  final TimesyncSocket _timesyncSocket = TimesyncSocket();

  set timesyncDestination(SocketInfo destination) {
    _timesyncSocket.timesyncDestination = destination;
  }

  @override
  DateTime get timestamp => _timesyncSocket.timestamp;

  @override
  Future<bool> init() async {
    await super.init();
    await _timesyncSocket.init();
    return true;
  }

  @override
  Future<void> dispose() async {
    await _timesyncSocket.dispose();
    await super.dispose();
  }
}
