import "dart:async";
import "dart:typed_data";

import "package:burt_network/burt_network.dart";
import "package:subsystems/subsystems.dart";

/// The serial port of the range finding sensor
const rangeFinderPort = "/dev/ttyTHS0";

/// Service to read data from a single point lidar range finding sensor
///
/// Reads incoming data from the serial port at [rangeFinderPort]
class RangeFinder extends Service {
  /// The serial device for the range finder
  final SerialDevice device = SerialDevice(
    portName: rangeFinderPort,
    readInterval: const Duration(milliseconds: 1),
    logger: logger,
    baudRate: 115200,
  );

  StreamSubscription<Uint8List>? _dataSubscription;

  final List<int> _readBuffer = [];

  /// The frame header of a packet from the range finder
  static const frameHeader = 0x59;

  void _handlePacket(Uint8List data) {
    _readBuffer.addAll(data);

    while (_readBuffer.contains(frameHeader)) {
      _readBuffer.removeRange(0, _readBuffer.indexOf(frameHeader));

      if (_readBuffer.length < 2) {
        return; // Wait for next byte of the header to come in
      }

      if (_readBuffer[1] != frameHeader) {
        // Frame should start with 0x59 0x59
        _readBuffer.removeRange(0, 2);
        continue;
      }

      if (_readBuffer.length < 9) {
        // Full packet has not come in yet
        return;
      }

      // TODO: Put these in a protobuf message

      // ignore: unused_local_variable
      final distanceCm = _readBuffer[2] | (_readBuffer[3] << 8);
      // ignore: unused_local_variable
      final strength = _readBuffer[4] | (_readBuffer[5] << 8);
      // ignore: unused_local_variable
      final mode = _readBuffer[6];

      final checksum = _readBuffer[8];

      // CheckSum is the low 8 bits of the cumulative sum of the numbers of the first 8 bytes
      var expectedChecksum = 0;
      for (var i = 0; i < 8; i++) {
        expectedChecksum += _readBuffer[i];
      }
      expectedChecksum &= 0xFF;

      if (checksum != expectedChecksum) {
        logger.warning(
          "Packet from Range Finder checksum failed",
          body:
              "Expected checksum: 0x${expectedChecksum.toRadixString(16).padLeft(2, '0')}, Actual: 0x${checksum.toRadixString(16).padLeft(2, '0')}",
        );
        _readBuffer.removeRange(0, 9);
        return;
      }
    }
  }

  @override
  Future<bool> init() async {
    if (!(await device.init())) {
      return false;
    }
    _dataSubscription = device.stream.listen(_handlePacket);
    device.startListening();
    return true;
  }

  @override
  Future<void> dispose() async {
    await _dataSubscription?.cancel();

    device.stopListening();
    await device.dispose();
  }
}
