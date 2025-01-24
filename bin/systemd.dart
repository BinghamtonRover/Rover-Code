// ignore_for_file: avoid_print

import "dart:io";

import "../all_programs.dart";

const header =
"""
# AUTO-GENERATED FILE. DO NOT EDIT.
# To re-generate this file, edit `all_programs.dart` and run `dart run :systemd`
#
# This file defines a program that automatically starts on boot.
# Place this file in /etc/systemd/system.
#
# For more information, see: https://bing-rover.gitbook.io/docs/v/software/onboard-computers/configuring-systemd
""";

void main() async {
  for (final program in programs) {
    final file = File("linux/${program.name}.service");
    final buffer = StringBuffer();
    buffer.writeln(header);
    buffer.writeln("[Unit]");
    buffer.writeln("Description=${program.description}");
    buffer.writeln("After=network-online.target");
    buffer.writeln();
    buffer.writeln("[Service]");
    buffer.writeln("ExecStart=${program.fullPathToExecutable}");
    buffer.writeln("TimeoutStopSec=3");
    buffer.writeln();
    buffer.writeln("[Install]");
    buffer.writeln("WantedBy=multi-user.target");
    await file.create(recursive: true);
    await file.writeAsString(buffer.toString());
    print("Generated ${file.path}");
  }
}
