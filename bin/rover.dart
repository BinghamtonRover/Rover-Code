import "dart:convert";
import "dart:io";

import "package:args/args.dart";
import "package:burt_network/burt_network.dart";
import "package:rover/rover.dart";

late bool offline;

void main(List<String> cliArgs) async {
  final parser = ArgParser();
  final programNames = { for (final program in programs) program.name };
  parser.addOption("only", help: "Only compile the given program", allowed: programNames);
  parser.addOption("config", help: "Path to JSON config file for device mappings and program settings");
  parser.addFlag("compile", help: "Compile all rover programs", defaultsTo: true);
  parser.addFlag("udev", help: "Generate udev rules", defaultsTo: true);
  parser.addFlag("offline", help: "Skip any steps that require internet", negatable: false);
  parser.addFlag("help", abbr: "h", help: "Show this help message and exits", negatable: false);
  parser.addFlag("verbose", abbr: "v", help: "Show all output", negatable: false);

  final args = parser.parse(cliArgs);
  offline = args.flag("offline");
  final verbose = args.flag("verbose");
  final showHelp = args.flag("help");
  final udev = args.flag("udev");
  final compile = args.flag("compile");
  final only = args.option("only");
  final configPath = args.option("config");
  Logger.level = verbose ? LogLevel.all : LogLevel.info;

  if (showHelp) {
    // ignore: avoid_print
    print("\nUsage: dart run :rover [--offline] [--verbose] [--only <program>] [--config <path>] [--help]\n${parser.usage}");
    return;
  }

  if (compile) {
    await compileAllPrograms(only, configPath: configPath);
  }

  if (udev) {
    logger.info("Generating udev rules...");
    await writeUdevFile(configPath: configPath);
  }

  logger.info("Done!");
}

Future<void> compileAllPrograms(String? only, {String? configPath}) async {
  // Load program settings from config if provided
  Map<String, bool>? programSettings;
  
  if (configPath != null) {
    final configFile = File(configPath);
    if (configFile.existsSync()) {
      try {
        final configContent = await configFile.readAsString();
        final configJson = jsonDecode(configContent) as Json;
        if (configJson.containsKey("programs")) {
          programSettings = Map<String, bool>.from(configJson["programs"] as Map);
          logger.info("Loaded program settings from config");
        }
      } catch (error) {
        logger.warning("Failed to load program settings from config: $error");
      }
    }
  }

  if (await needsGitSubmodules()) {
    if (offline) {
      logger.warning("Not all git submodules have been initialized, but --offline was passed");
    } else {
      logger.info("Updating submodules. This requires internet...");
      await runCommand("git", ["submodule", "update", "--init", "--recursive"]);
    }
  }

  if (!offline) {
    await runCommand("sudo", ["apt", "update", "-y"]);
  }

  for (final program in programs) {
    final name = program.name;
    if (only != null && name != only) continue;
    
    // Check if program is disabled in config
    if (programSettings != null && programSettings.containsKey(name)) {
      if (programSettings[name] == false) {
        logger.info("Skipping $name (disabled in config)");
        continue;
      }
    }
    
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
    await writeSystemdFile(program);
  }
}
