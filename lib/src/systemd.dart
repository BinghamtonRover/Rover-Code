import "program.dart";
import "utils.dart";

/// The header to prepend to the top of all generated systemd files.
const systemdHeader =
"""
# AUTO-GENERATED FILE. DO NOT EDIT.
# To re-generate this file, edit `~/rover/lib/all_programs.dart` and run `dart run :systemd`
#
# This file defines a program that automatically starts on boot.
# Place this file in /etc/systemd/system.
#
# For more information, see: https://bing-rover.gitbook.io/docs/v/software/onboard-computers/configuring-systemd
""";

/// Returns whether the given systemd service is running.
Future<bool> isServiceRunning(String service) async {
  final result = await getCommandOutput("sudo", ["systemctl", "is-active", service]);
  return result.trim() == "active";
}

/// Generates systemd service files for rover programs.
extension SystemdGenerator on RoverProgram {
  /// The systemd service file for this service.
  ///
  /// For more information, see: https://www.digitalocean.com/community/tutorials/understanding-systemd-units-and-unit-files
  String get systemdService {
    final buffer = StringBuffer();
    buffer.writeln(systemdHeader);
    buffer.writeln("[Unit]");
    buffer.writeln("Description=$description");
    buffer.writeln("After=network-online.target");
    buffer.writeln();
    buffer.writeln("[Service]");
    buffer.writeln("WorkingDirectory=$sourceDir");
    buffer.writeln("ExecStart=$executable");
    buffer.writeln("TimeoutStopSec=3");
    buffer.writeln();
    buffer.writeln("[Install]");
    buffer.writeln("WantedBy=multi-user.target");
    return buffer.toString();
  }
}
