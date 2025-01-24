// ignore_for_file: avoid_print

import "dart:io";
import "../all_programs.dart";

const header =
r"""
#!/bin/bash

# AUTO-GENERATED FILE. DO NOT EDIT.
# To re-generate this file, edit `all_programs.dart` and run `dart run :compile`
#
# This file compiles all programs and loads them into the home directory

set -e  # Any error will cause the script to fail

# Redirects output on &3 to /dev/null unless -v or --verbose is passed
if [ "$1" = "-v" ]; then
  exec 3>&1
else
  exec 3>/dev/null
fi
""";

const filename = "scripts/compile.sh";
const suffix = ">&3";

void main() async {
  final buffer = StringBuffer();
  buffer.write(header);
  for (final program in programs) {
    final name = program.name;
    buffer.writeln();
    // Stop the service if it was already running
    buffer.writeln('if [[ \$(sudo systemctl is-active $name) == "active]]; then');
    buffer.writeln("  sudo systemctl stop $name $suffix");
    buffer.writeln("  sudo systemctl disable $name $suffix");
    buffer.writeln("fi");

    // Compile the program
    buffer.writeln('echo "Compiling the $name program. This could take a few minutes..."');
    buffer.writeln("cd $name");
    for (final command in program.compileCommands) {
      buffer.writeln(command);
    }
    for (final extraCommand in program.extraCommands ?? []) {
      buffer.writeln("$extraCommand $suffix");
    }
    buffer.writeln("cd ..");

    // Save, enable, and start the service
    buffer.writeln("sudo cp linux/$name.service /etc/systemd/system $suffix");
    buffer.writeln("sudo systemctl enable $name $suffix");
    buffer.writeln("sudo systemctl start $name $suffix");
  }
  final file = File(filename);
  await file.create(recursive: true);
  await file.writeAsString(buffer.toString());
  print("Generated $filename to compile ${programs.length} programs");
}
