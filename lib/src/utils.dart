import "dart:io";

import "package:burt_network/logging.dart";

final logger = BurtLogger();

extension MapRecords<K, V> on Map<K, V> {
  Iterable<(K, V)> get records => entries.map((entry) => (entry.key, entry.value));
}

Future<String?> getCommandOutput(String command, List<String> arguments) async {
  logger.debug("Running $command $arguments");
  final result = await Process.run(command, arguments);
  logger.trace(result.stdout);
  if (result.stderr.isNotEmpty) logger.warning(result.stderr);
  logger.debug("Command finished with exit code ${result.exitCode}");
  return result.stdout as String;
}

Future<void> runCommand(String command, List<String> arguments, {String? workingDirectory}) async {
  logger.debug("Running $command $arguments");
  final result = await Process.run(command, arguments, workingDirectory: workingDirectory);
  logger.trace(result.stdout);
  logger.debug("Command finished with exit code ${result.exitCode}");
  if (result.exitCode != 0) {
    final args = arguments.join(" ");
    logger.critical(
      "Failed to execute command: $command $args",
      body: "${result.stdout}\n${result.stderr}",
    );
    exit(1);
  }
}
