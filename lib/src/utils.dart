import "dart:io";

import "package:burt_network/logging.dart";
import "package:rover/rover.dart";

/// The logger for all scripts.
final logger = BurtLogger();

/// Returns whether there are any un-initialized git submodules.
Future<bool> needsGitSubmodules() async {
  // `git submodule status` starts any un-initialized submodules with a `-` character
  final output = await getCommandOutput("git", ["submodule", "status"]);
  for (final line in output.split("\n")) {
    if (line.trimLeft().startsWith("-")) return true;
  }
  return false;
}

/// Returns the stdout output of a command, ignoring the exit code.
///
/// If you just want to run the command, use [runCommand] instead.
Future<String> getCommandOutput(String command, List<String> arguments, {String? workingDirectory}) async {
  logger.debug("Running $command $arguments in ${workingDirectory ?? Directory.current.path}");
  final result = await Process.run(command, arguments, workingDirectory: workingDirectory);
  logger.trace(result.stdout.trim());
  if (result.stderr.isNotEmpty) logger.warning(result.stderr);
  logger.debug("Command finished with exit code ${result.exitCode}");
  return result.stdout as String;
}

/// Runs a command, logs its stdout/stderr, and kills the program if it fails.
Future<void> runCommand(String command, List<String> arguments, {String? workingDirectory, bool hideOutput = false}) async {
  logger.debug("Running $command $arguments in ${workingDirectory ?? Directory.current.path}");
  final process = await Process.start(command, arguments, workingDirectory: workingDirectory);
  process.stdout.listen((output) {
    final line = String.fromCharCodes(output);
    logger.trace(line.trim());
  });
  process.stderr.listen((output) {
    final line = String.fromCharCodes(output);
    hideOutput ? logger.trace(line.trim()) : logger.warning(line.trim());
  });
  final exitCode = await process.exitCode;
  logger.debug("Command finished with exit code $exitCode");
  if (exitCode != 0) {
    final args = arguments.join(" ");
    logger.critical("Failed to execute command: $command $args");
    exit(1);
  }
}

/// Writes a systemd service file to `/etc/systemd/system` for the given rover program.
Future<void> writeSystemdFile(RoverProgram program) async {
  // Note that we can't write directly to the service file because we need to use sudo
  final name = program.name;
  final systemdFile = File("temp.service");
  final service = program.systemdService;
  logger.debug("Writing systemd service for ${program.name}");
  logger.trace(service);
  await systemdFile.writeAsString(service, flush: true);
  await runCommand("sudo", ["cp", "temp.service", "/etc/systemd/system/$name.service"]);
  await runCommand("sudo", ["systemctl", "enable", name], hideOutput: true);  // always uses stderr
  await runCommand("sudo", ["systemctl", "start", name]);
  await systemdFile.delete();
}

/// Writes a udev rules file to `/etc/udev/rules.d` with all devices at once.
Future<void> writeUdevFile() async {
  final buffer = StringBuffer();
  buffer.writeln(udevHeader);
  for (final device in devices) {
    logger.debug("Generating udev rules for ${device.humanName}");
    final rule = device.udevRule;
    logger.trace(rule);
    buffer.write(device.udevRule);
  }

  final contents = buffer.toString();
  // Note that we can't write directly to the udev file because we need to use sudo
  final udevFile = File("temp.rules");
  await udevFile.create(recursive: true);
  await udevFile.writeAsString(contents, flush: true);
  await runCommand("sudo", ["cp", udevFile.path, "/etc/udev/rules.d/15-rover.rules"]);
  await runCommand("sudo", ["udevadm", "control", "--reload-rules"]);
  await runCommand("sudo", ["udevadm", "trigger"]);
  await udevFile.delete();
  logger.debug("Generated udev rules with ${devices.length} devices");
}
