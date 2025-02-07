import "dart:io";

import "package:burt_network/logging.dart";

final logger = BurtLogger();

extension MapRecords<K, V> on Map<K, V> {
  Iterable<(K, V)> get records => entries.map((entry) => (entry.key, entry.value));
}

Future<bool> needsGitSubmodules() async {
  final output = await getCommandOutput("git", ["submodule", "status"]);
  for (final line in output.split("\n")) {
    if (line.trimLeft().startsWith("-")) return true;
  }
  return false;
}

Future<String> getCommandOutput(String command, List<String> arguments, {String? workingDirectory}) async {
  logger.debug("Running $command $arguments in ${workingDirectory ?? Directory.current.path}");
  final result = await Process.run(command, arguments, workingDirectory: workingDirectory);
  logger.trace(result.stdout.trim());
  if (result.stderr.isNotEmpty) logger.warning(result.stderr);
  logger.debug("Command finished with exit code ${result.exitCode}");
  return result.stdout as String;
}

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
