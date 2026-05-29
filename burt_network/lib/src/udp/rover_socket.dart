import "burt_socket.dart";
import "rover_heartbeats.dart";
import "rover_timesync.dart";
import "rover_logger.dart";
import "rover_settings.dart";
import "socket_info.dart";

/// A UDP socket which acts as a server onboard the rover, handling heartbeats,
/// time synchronization, logging, and settings
///
/// An instance of this class will act as a server that a client can connect and send data to
class RoverSocket extends BurtSocket
    with RoverHeartbeats, RoverTimesync, RoverLogger, RoverSettings {
  /// The amount of time the program should go before determining it has disconnected with the dashboard
  final Duration timeout;

  @override
  Duration get heartbeatInterval => timeout;

  /// Default constructor for [RoverSocket], initializing all necessary fields
  RoverSocket({
    required super.port,
    required super.device,
    this.timeout = const Duration(seconds: 2),
    super.quiet,
    super.keepDestination,
    super.destinations,
    super.destination,
    SocketInfo? timesyncAddress,
    int maxClients = 5,
    super.collection,
  }) {
    this.maxClients = maxClients;
    if (timesyncAddress != null) {
      timesyncDestination = timesyncAddress;
    }
  }
}
