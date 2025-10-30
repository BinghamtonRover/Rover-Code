import "dart:io";

import "package:burt_network/burt_network.dart";

/// Configuration for the Rover's drive behavior
///
/// Each rover or device that is tested will have different behaviors
/// depending on the mechanical and electrical setup, ranging from subsystems
/// program address, to drive speeds, or the time it takes to move forward
/// and turn.
///
/// This class is to make testing on different devices easier
class DriveConfig {
  /// The throttle to set the drive to when moving forward
  final double forwardThrottle;

  /// The throttle to set the drive to when turning
  final double turnThrottle;

  /// The time it takes to turn 90 degrees
  final Duration turnDelay;

  /// The time it takes to move one meter forward
  final Duration oneMeterDelay;

  /// The IP address for the subsystems program
  final String subsystemsAddress;

  /// Constructor for DriveConfig initializing all final fields
  const DriveConfig({
    required this.forwardThrottle,
    required this.turnThrottle,
    required this.turnDelay,
    required this.oneMeterDelay,
    required this.subsystemsAddress,
  });

  /// Creates a copy of this drive config with the provided fields replaced
  DriveConfig copyWith({
    double? forwardThrottle,
    double? turnThrottle,
    Duration? oneMeterDelay,
    Duration? turnDelay,
    String? subsystemsAddress,
  }) => DriveConfig(
    forwardThrottle: forwardThrottle ?? this.forwardThrottle,
    turnThrottle: turnThrottle ?? this.turnThrottle,
    turnDelay: turnDelay ?? this.turnDelay,
    oneMeterDelay: oneMeterDelay ?? this.oneMeterDelay,
    subsystemsAddress: subsystemsAddress ?? this.subsystemsAddress,
  );

  /// The [SocketInfo] for Subsystems, created using [subsystemsAddress] and port 8001
  SocketInfo get subsystems =>
      SocketInfo(address: InternetAddress(subsystemsAddress), port: 8001);
}

/// The [DriveConfig] for the rover
const roverConfig = DriveConfig(
  forwardThrottle: 0.2,
  turnThrottle: 0.075,
  oneMeterDelay: Duration(milliseconds: 2250 ~/ 2),
  turnDelay: Duration(milliseconds: 4500),
  subsystemsAddress: "192.168.1.20",
);

/// The [DriveConfig] for the tank
const tankConfig = DriveConfig(
  forwardThrottle: 0.3,
  turnThrottle: 0.35,
  turnDelay: Duration(milliseconds: 1000),
  oneMeterDelay: Duration(milliseconds: 2000),
  subsystemsAddress: "127.0.0.1",
);
