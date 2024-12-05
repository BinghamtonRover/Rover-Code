import "dart:async";
import "dart:convert";
import "dart:io";

import "package:burt_network/burt_network.dart";
import "package:subsystems/subsystems.dart";

/// The port/device file to listen to the GPS on.
const gpsPort = "/dev/rover-gps";

/// The UDP socket on the Autonomy program.
final autonomySocket = SocketInfo(address: InternetAddress("192.168.1.30"), port: 8001);

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
      return GpsCoordinates(
        latitude: _nmeaToDecimal(double.tryParse(parts[2]) ?? 0.0),
        longitude: _nmeaToDecimal(double.tryParse(parts[4]) ?? 0.0),
        altitude: double.tryParse(parts[9]) ?? 0.0,
      );
    } else if (tag.endsWith("RMC")) {
      return GpsCoordinates(
        latitude: _nmeaToDecimal(double.tryParse(parts[3]) ?? 0.0),
        longitude: _nmeaToDecimal(double.tryParse(parts[5]) ?? 0.0),
      );
    } else if (tag.endsWith("GLL")) {
      return GpsCoordinates(
        latitude: _nmeaToDecimal(double.tryParse(parts[1]) ?? 0.0),
        longitude: _nmeaToDecimal(double.tryParse(parts[3]) ?? 0.0),
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
    readInterval: const Duration(seconds: 1),
    logger: logger,
  );

  /// The subscription to the serial port.
  StreamSubscription<List<int>>? _subscription;

  /// Parses a line of NMEA output and sends the GPS coordinates to the dashboard.
  void _handleLine(String line) {
    final coordinates = parseNMEA(line);
    if (coordinates == null) return;
    if (coordinates.latitude == 0 || coordinates.longitude == 0 || coordinates.altitude == 0) {
      // No fix
      return;
    }
    final roverPosition = RoverPosition(gps: coordinates);
    collection.server.sendMessage(roverPosition);
    collection.server.sendMessage(roverPosition, destination: autonomySocket);
  }

  /// Parses a packet into several NMEA sentences and handles them.
  void _handlePacket(List<int> bytes) {
    final string = utf8.decode(bytes);
    final lines = string.split("\n");
    lines.forEach(_handleLine);
  }

  @override
  Future<bool> init() async {
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
    await device.dispose();
  }
}
