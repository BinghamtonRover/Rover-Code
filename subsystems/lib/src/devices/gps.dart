import "dart:async";
import "dart:convert";
import "dart:io";
import "dart:typed_data";

import "package:burt_network/burt_network.dart";
import "package:subsystems/subsystems.dart";

/// The port/device file to listen to the GPS on.
const gpsPort = "/dev/rover-gps";

/// The UDP socket on the Autonomy program.
final autonomySocket = SocketInfo(
  address: InternetAddress("192.168.1.30"),
  port: 8001,
);

/// The UDP socket for the Base Station program
final baseStationSocket = SocketInfo(
  address: InternetAddress("192.168.1.50"),
  port: 8005,
);

/// Listens to the GPS and sends its output to the Dashboard.
///
/// Call [init] to start listening and [dispose] to stop.
class GpsReader extends Service {
  /// Parses an NMEA sentence into a [GpsCoordinates] object.
  ///
  /// See https://shadyelectronics.com/gps-nmea-sentence-structure.
  static GpsCoordinates? parseNMEA(String nmeaSentence) {
    final parts = nmeaSentence.split(",");
    final tag = parts.first;
    if (tag.endsWith("GGA")) {
      var latitude = _nmeaToDecimal(double.tryParse(parts[2]) ?? 0);
      var longitude = _nmeaToDecimal(double.tryParse(parts[4]) ?? 0);
      if (parts[3] == "S") {
        latitude *= -1;
      }
      if (parts[5] == "W") {
        longitude *= -1;
      }
      final quality = int.tryParse(parts[6]);
      final rtkMode = switch (quality) {
        4 => RTKMode.RTK_FIXED,
        5 => RTKMode.RTK_FLOAT,
        _ => RTKMode.RTK_NONE,
      };
      return GpsCoordinates(
        latitude: latitude,
        longitude: longitude,
        altitude: double.tryParse(parts[9]) ?? 0.0,
        rtkMode: rtkMode,
      );
    } else if (tag.endsWith("RMC")) {
      var latitude = _nmeaToDecimal(double.tryParse(parts[3]) ?? 0.0);
      if (parts[4] == "S") {
        latitude *= -1;
      }
      var longitude = _nmeaToDecimal(double.tryParse(parts[5]) ?? 0.0);
      if (parts[6] == "W") {
        longitude *= -1;
      }
      final posMode = parts[12];
      final rtkMode = switch (posMode) {
        "F" => RTKMode.RTK_FLOAT,
        "R" => RTKMode.RTK_FIXED,
        _ => RTKMode.RTK_NONE,
      };
      return GpsCoordinates(
        latitude: latitude,
        longitude: longitude,
        rtkMode: rtkMode,
      );
    } else if (tag.endsWith("GLL")) {
      var latitude = _nmeaToDecimal(double.tryParse(parts[1]) ?? 0.0);
      if (parts[2] == "S") {
        latitude *= -1;
      }
      var longitude = _nmeaToDecimal(double.tryParse(parts[3]) ?? 0.0);
      if (parts[4] == "W") {
        longitude *= -1;
      }
      return GpsCoordinates(
        latitude: latitude,
        longitude: longitude,
      );
    } else {
      return null;
    }
  }

  static double _nmeaToDecimal(double nmeaValue) {
    final degrees = nmeaValue ~/ 100;
    final minutes = nmeaValue % 100;
    return degrees + minutes / 60.0;
  }

  /// The serial device representing the GPS.
  final SerialDevice device = SerialDevice(
    portName: gpsPort,
    readInterval: const Duration(milliseconds: 250),
    logger: logger,
    baudRate: 38400,
  );

  /// The subscription to the serial port.
  StreamSubscription<List<int>>? _subscription;

  /// The subscription to incoming protobuf messages from the server
  StreamSubscription<RoverPosition>? _messageSubscription;

  /// Parses a line of NMEA output and sends the GPS coordinates to the dashboard.
  void _handleLine(String line) {
    final coordinates = parseNMEA(line);
    if (coordinates == null) return;
    if (coordinates.latitude == 0
      || coordinates.longitude == 0
      || coordinates.altitude == 0
    ) {
      // No fix
      return;
    }
    final roverPosition = RoverPosition(gps: coordinates);
    collection.server.sendMessage(roverPosition);
    collection.server.sendMessage(roverPosition, destination: autonomySocket);
    collection.server.sendMessage(roverPosition, destination: baseStationSocket);
  }

  /// Parses a packet into several NMEA sentences and handles them.
  void _handlePacket(List<int> bytes) {
    try {
      final string = utf8.decode(bytes);
      final lines = string.split("\n");
      lines.forEach(_handleLine);
    } catch (e) {
      logger.error("Failed to decode NMEA Packet", body: e.toString());
    }
  }

  /// Handles incoming position message data and writes necessary data to the
  /// gps serial device
  void _handleIncomingMessage(RoverPosition message) {
    if (!device.isOpen || !message.hasRtkMessage()) {
      return;
    }

    final rtkMessage = Uint8List.fromList(message.rtkMessage);
    logger.debug("Writing RTK Message", body: "Writing a ${rtkMessage.lengthInBytes}-byte RTCM packet to serial");
    device.write(rtkMessage);
  }

  @override
  Future<bool> init() async {
    _messageSubscription = collection.server.messages.onMessage(
      name: RoverPosition().messageName,
      constructor: RoverPosition.fromBuffer,
      callback: _handleIncomingMessage,
    );
    try {
      if (!await device.init()) {
        logger.critical("Could not open GPS on port $gpsPort");
        return false;
      }
      _subscription = device.stream.listen(_handlePacket);
      device.startListening();
      logger.info("Reading GPS over port $gpsPort");
      return true;
    } catch (error) {
      logger.critical("Could not open GPS", body: "Port $gpsPort, Error=$error");
      return false;
    }
  }

  @override
  Future<void> dispose() async {
    await _subscription?.cancel();
    await _messageSubscription?.cancel();
    await device.dispose();
  }
}
