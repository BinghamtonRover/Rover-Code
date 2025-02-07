import "dart:io";
import "package:rover/rover.dart";

void main() async {
  for (final program in programs) {
    final name = program.name;
    logger.info("Processing $name program");

    // Stop the service if it was already running
    if (await isServiceRunning(name)) {
      logger.debug("Stopping $name...");
      await runCommand("sudo", ["systemctl", "stop", name]);
      await runCommand("sudo", ["systemctl", "disable", name]);
    }

    // Run any pre-requisite commands
    final extraCommands = program.extraCommands;
    if (extraCommands != null) {
      for (final extraCommand in extraCommands) {
        logger.info("$name: ${extraCommand.task}...");
        await runCommand(extraCommand.command, extraCommand.args);
      }
    }

    // Compile the program
    final command = program.compileCommand;
    if (command != null) {
      logger.info("Compiling the $name program. This could take a few minutes...");
      final (cmd, args) = command;
      await runCommand(cmd, args, workingDirectory: program.sourceDir);
    }

    // Save, enable, and start the systemd service
    final systemdFile = File("/etc/systemd/systemd/$name.service");
    await systemdFile.writeAsString(program.systemdService);
    await runCommand("sudo", ["systemctl", "enable", name]);
    await runCommand("sudo", ["systemctl", "start", name]);
  }
}
