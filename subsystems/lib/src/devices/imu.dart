import "dart:async";

import "package:collection/collection.dart";
import "package:osc/osc.dart";

import "package:subsystems/subsystems.dart";
import "package:burt_network/burt_network.dart";

import "../osc.dart";

/// The serial port that the IMU is connected to.
const imuPort = "/dev/rover-imu";

/// The version that we are using for [RoverPosition] data.
final positionVersion = Version(major: 1, minor: 0);

/// A service to read orientation data from the connected IMU.
class ImuReader extends Service {
  /// The device that reads from the serial port.
  final serial = SerialDevice(
    portName: imuPort,
    readInterval: const Duration(milliseconds: 10),
    logger: logger,
  );

  /// The subscription that will be notified when a new serial packet arrives.
  StreamSubscription<List<int>>? subscription;
  StreamSubscription<SubsystemsCommand>? _commandSubscription;

  /// Handles an incoming [SubsystemsCommand]
  void handleCommand(SubsystemsCommand command) {
    if (command.zeroIMU && serial.isOpen) {
      final message = OSCMessage("/ahrs/zero", arguments: []).toBytes();
      serial.write(slip.encode(message).toUint8List());
    }
  }

  /// Handles incoming serial bytes
  void handleSerial(List<int> bytes) {
    for (final packet in bytes.splitAfter((element) => element == end)) {
      final message = parseOsc(slip.decode(packet));
      if (message == null) {
        continue;
      }
      if (message.address == "/button") {
        handleCommand(SubsystemsCommand(zeroIMU: true));
      }
      if (message.address == "/ahrs/zero") {
        // signal that the zero was received and processed
        if (serial.isOpen) {
          final command = OSCMessage("/identify", arguments: []);
          serial.write(slip.encode(command.toBytes()).toUint8List());
        }
        // send a duplicate of a subsystems command as a "handshake"
        collection.server.sendMessage(SubsystemsCommand(zeroIMU: true));
      }
      if (message.address == "/euler") {
        final orientation = Orientation(
          x: message.arguments[0] as double,
          y: message.arguments[1] as double,
          z: message.arguments[2] as double,
        );
        final position = RoverPosition(orientation: orientation, version: positionVersion);
        collection.server.sendMessage(position);
        collection.server.sendMessage(position, destination: autonomySocket);
      }
    }
  }

  @override
  Future<bool> init() async {
    try {
      if (!await serial.init()) {
        logger.critical("Could not open IMU on port $imuPort");
        return false;
      }
      subscription = serial.stream.listen(handleSerial);
      _commandSubscription = collection.server.messages.onMessage(
        name: SubsystemsCommand().messageName,
        constructor: SubsystemsCommand.fromBuffer,
        callback: handleCommand,
      );
      serial.startListening();
      logger.info("Reading IMU on port $imuPort");
      return true;
    } catch (error) {
      logger.critical("Could not open IMU", body: "Port $imuPort, Error: $error");
      return false;
    }
  }

  @override
  Future<void> dispose() async {
    await subscription?.cancel();
    await _commandSubscription?.cancel();
    await serial.dispose();
  }
}
