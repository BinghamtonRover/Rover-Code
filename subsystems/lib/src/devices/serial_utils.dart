import "dart:io";

import "package:burt_network/burt_network.dart";
import "package:subsystems/subsystems.dart";

/// Gets the real path to a Linux symlink path.
///
/// Relies on the `realpath` command line tool, and must be run on Linux.
Future<String> getRealPath(String symlink) async =>
    (await Process.run("realpath", [symlink])).stdout.trim();

/// Gets a list of all /dev/rover_ paths
Future<List<String>> getRoverPaths() async {
  final devDir = Directory("/dev");
  const prefix = "/dev/rover_";

  final output = <String>[];

  await for (final entity in devDir.list()) {
    if (entity.path.startsWith(prefix)) {
      output.add(entity.path);
    }
  }
  return output;
}

/// Gets all the names of all the ports.
Future<Iterable<String>> getPortNames() async {
  final allPorts = DelegateSerialPort.allPorts.toSet();
  if (!Platform.isLinux) return allPorts;

  final forbiddenPorts = {"/dev/ttyAMA10"};
  final roverPaths = await getRoverPaths();
  for (final path in roverPaths) {
    forbiddenPorts.add(await getRealPath(path));
  }
  return allPorts.toSet().difference(forbiddenPorts);
}

/// Gets all firmware devices attached to the device, ignoring the GPS and IMU ports.
Future<List<BurtFirmwareSerial>> getFirmwareDevices() async => [
  for (final port in await getPortNames())
    BurtFirmwareSerial(port: port, logger: logger),
];
