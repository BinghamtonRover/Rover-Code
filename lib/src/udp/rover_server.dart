import "burt_protocol.dart";

import "rover_heartbeats.dart";
import "rover_logger.dart";
import "rover_settings.dart";

/// A UDP socket fit for use on the rover, with heartbeats, logging, and settings included.
abstract class RoverServer = BurtUdpProtocol with RoverHeartbeats, RoverLogger, RoverSettings;
