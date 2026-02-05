import "package:args/args.dart";
import "package:burt_network/logging.dart";
import "package:rover/rover.dart";

late bool offline;

void main(List<String> cliArgs) async {
  final parser = ArgParser();
  final programNames = { for (final program in programs) program.name };
  parser.addOption("only", help: "Only compile the given program", allowed: programNames);
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
  Logger.level = verbose ? LogLevel.all : LogLevel.info;

  if (showHelp) {
    // ignore: avoid_print
    print("\nUsage: dart run :rover [--offline] [--verbose] [--only <program>] [--help]\n${parser.usage}");
    return;
  }

  if (compile) {
    await compileAllPrograms(only);
  }

  if (udev) {
    logger.info("Generating udev rules...");
    await writeUdevFile();
  }

  logger.info("Done!");
}

Future<void> compileAllPrograms(String? only) async {
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

  final programsToCompile = only != null 
    ? programs.where((p) => p.name == only).toList()
    : programs;

  // Install all apt dependencies first to avoid package manager conflicts
  if (!offline) {
    await installAllAptDependencies(programsToCompile);
  }

  logger.info("Starting parallel compilation of ${programsToCompile.length} programs...");

  await Future.wait(programsToCompile.map((program) async {
    await compileProgram(program);
  }));
}

Future<void> installAllAptDependencies(List<RoverProgram> programsToCompile) async {
  final aptCommands = <ExtraCommand>[];
  
  for (final program in programsToCompile) {
    final extraCommands = program.extraCommands;
    if (extraCommands != null) {
      for (final command in extraCommands) {
        if (command.requiresInternet && 
            (command.command == "sudo" && command.args.isNotEmpty && 
             (command.args[0] == "apt-get" || command.args[0] == "apt"))) {
          aptCommands.add(command);
        }
      }
    }
  }

  for (final aptCommand in aptCommands) {
    logger.info("Installing dependencies: ${aptCommand.task}...");
    await runCommand(aptCommand.command, aptCommand.args);
  }
}

Future<void> compileProgram(RoverProgram program) async {
  final name = program.name;
  logger.info("Processing the $name program");

  // Stop the service if it was already running
  if (await isServiceRunning(name)) {
    logger.debug("Stopping $name...");
    await runCommand("sudo", ["systemctl", "stop", name]);
    await runCommand("sudo", ["systemctl", "disable", name], hideOutput: true);  // always uses stderr
  }

  // Run any pre-requisite commands (except apt commands which were already handled)
  final extraCommands = program.extraCommands;
  if (extraCommands != null) {
    for (final extraCommand in extraCommands) {
      if (offline && extraCommand.requiresInternet) {
        logger.debug("Skipping '${extraCommand.task}' because it requires internet");
        continue;
      }
      
      // Skip apt commands since they were already executed serially
      if (extraCommand.requiresInternet && 
          extraCommand.command == "sudo" && extraCommand.args.isNotEmpty && 
          (extraCommand.args[0] == "apt-get" || extraCommand.args[0] == "apt")) {
        logger.debug("Skipping apt command '${extraCommand.task}' (already installed)");
        continue;
      }
      
      logger.info("- $name: ${extraCommand.task}...");
      await runCommand(extraCommand.command, extraCommand.args, workingDirectory: program.sourceDir);
    }
  }

  // Compile the program
  final command = program.compileCommand;
  if (command != null) {
    logger.info("- $name: Compiling. This could take a few minutes...");
    final (cmd, args) = command;
    await runCommand(cmd, args, workingDirectory: program.sourceDir);
  }

  // Save, enable, and start the systemd service
  await writeSystemdFile(program);
  logger.info("- $name: Compilation complete!");
}
