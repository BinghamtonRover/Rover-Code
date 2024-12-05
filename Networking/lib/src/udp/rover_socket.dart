import "burt_socket.dart";
import "rover_heartbeats.dart";
import "rover_logger.dart";
import "rover_settings.dart";

/// A UDP socket fit for use on the rover, with heartbeats, logging, and settings included.
class RoverSocket = BurtSocket with RoverHeartbeats, RoverLogger, RoverSettings;
