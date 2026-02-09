import "dart:io";

import "package:burt_network/burt_network.dart";
import "package:subsystems/subsystems.dart";

/// Gets the real path to a Linux symlink path.
///
/// Relies on the `realpath` command line tool, and must be run on Linux.
Future<String> getRealPath(String symlink) async =>
    (await Process.run("realpath", [symlink])).stdout.trim();

/// Gets all the names of all the ports.
Future<Iterable<String>> getPortNames() async {
  final allPorts = DelegateSerialPort.allPorts.toSet();
  if (!Platform.isLinux) return allPorts;
  final imuPath = await getRealPath(imuPort);
  final gpsPath = await getRealPath(gpsPort);
  final forbiddenPorts = {imuPath, gpsPath, "/dev/ttyAMA10"};
  return allPorts.toSet().difference(forbiddenPorts);
}

/// Gets all firmware devices attached to the device, ignoring the GPS and IMU ports.
Future<List<BurtFirmwareSerial>> getFirmwareDevices() async => [
  for (final port in await getPortNames())
    BurtFirmwareSerial(port: port, logger: logger),
];
