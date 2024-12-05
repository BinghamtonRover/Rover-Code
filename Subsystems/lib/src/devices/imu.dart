import "dart:async";
import "dart:typed_data";

import "package:osc/osc.dart";

import "package:subsystems/subsystems.dart";
import "package:burt_network/burt_network.dart";

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

  /// Parses an OSC bundle from a list of bytes.
  void handleOsc(List<int> data) {
    try {
      // skip 8 byte "#bundle" + 8 byte timestamp + 4 byte data length
      final buffer = data.sublist(20);
      final message = OSCMessage.fromBytes(buffer);
      if (message.address != "/euler") return;
      final orientation = Orientation(
        x: message.arguments[0] as double,
        y: message.arguments[1] as double,
        z: message.arguments[2] as double,
      );
      final position = RoverPosition(orientation: orientation, version: positionVersion);
      collection.server.sendMessage(position);
      collection.server.sendMessage(position, destination: autonomySocket);
    } catch (error) {
      /* Ignore corrupt data */
    }
  }

  /// Removes bytes inserted by the SLIP protocol.
  ///
  /// This function is here until `package:osc` supports SLIP, mandated by the OSC v1.1 spec.
  /// See this issue: https://github.com/pq/osc/issues/24
  /// See: https://en.wikipedia.org/wiki/Serial_Line_Internet_Protocol
  Uint8List processSlip(List<int> data) {
    const end = 192;
    const esc = 219;
    const escEnd = 220;
    const escEsc = 221;
    final newPacket = <int>[];
    var prevElement = 0;
    for (final element in data) {
      if (prevElement == esc && element == escEnd) {
        newPacket.last = end;  // ESC + ESC_END -> END
      } else if (prevElement == esc && element == escEsc) {
        newPacket.last = esc;  // ESC + ESC_ESC -> ESC
      } else {
        newPacket.add(element);
      }
      prevElement = element;
    }
    if (newPacket.last == end) newPacket.removeLast();
    return Uint8List.fromList(newPacket);
  }

  @override
  Future<bool> init() async {
    try {
      if (!await serial.init()) {
        logger.critical("Could not open IMU on port $imuPort");
        return false;
      }
      subscription = serial.stream.map(processSlip).listen(handleOsc);
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
    await serial.dispose();
  }
}
