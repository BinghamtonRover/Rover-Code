import "dart:io";
import "package:args/args.dart";
import "package:burt_network/logging.dart";
import "package:rover/rover.dart";

void main(List<String> cliArgs) async {
  final parser = ArgParser();
  parser.addFlag("help", abbr: "h", help: "Show this help message and exits", negatable: false);
  parser.addFlag("offline", help: "Skip any steps that require internet", negatable: false);
  parser.addFlag("verbose", help: "Show all output", negatable: false);
  final args = parser.parse(cliArgs);
  final offline = args.flag("offline");
  final verbose = args.flag("verbose");
  final showHelp = args.flag("help");
  Logger.level = verbose ? LogLevel.all : LogLevel.info;

  if (showHelp) {
    // ignore: avoid_print
    print("\nUsage: dart run :compile [--offline] [--verbose] [--help]\n${parser.usage}");
    return;
  }

  if (await needsGitSubmodules()) {
    if (offline) {
      logger.warning("Not all git submodules have been initialized, but --offline was passed");
    } else {
      logger.info("Updating submodules. This requires internet...");
      await runCommand("git", ["submodule", "update", "--init"]);
    }
  }

  for (final program in programs) {
    final name = program.name;
    logger.info("Processing the $name program");

    // Stop the service if it was already running
    if (await isServiceRunning(name)) {
      logger.debug("Stopping $name...");
      await runCommand("sudo", ["systemctl", "stop", name]);
      await runCommand("sudo", ["systemctl", "disable", name], hideOutput: true);  // always uses stderr
    }

    // Run any pre-requisite commands
    final extraCommands = program.extraCommands;
    if (extraCommands != null) {
      for (final extraCommand in extraCommands) {
        if (offline && extraCommand.requiresInternet) {
          logger.debug("Skipping '${extraCommand.task}' because it requires internet");
          continue;
        }
        logger.info("- ${extraCommand.task}...");
        await runCommand(extraCommand.command, extraCommand.args, workingDirectory: program.sourceDir);
      }
    }

    // Compile the program
    final command = program.compileCommand;
    if (command != null) {
      logger.info("- Compiling. This could take a few minutes...");
      final (cmd, args) = command;
      await runCommand(cmd, args, workingDirectory: program.sourceDir);
    }

    // Save, enable, and start the systemd service
    // Note that we can't write directly to the service file because we need to use sudo
    final systemdFile = File("temp.service");
    await systemdFile.writeAsString(program.systemdService, flush: true);
    await runCommand("sudo", ["cp", "temp.service", "/etc/systemd/system/$name.service"]);
    await runCommand("sudo", ["systemctl", "enable", name], hideOutput: true);  // always uses stderr
    await runCommand("sudo", ["systemctl", "start", name]);
    await systemdFile.delete();
  }
  logger.info("Done!");
}
