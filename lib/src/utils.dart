import "dart:io";

import "package:burt_network/logging.dart";

final logger = BurtLogger();

extension MapRecords<K, V> on Map<K, V> {
  Iterable<(K, V)> get records => entries.map((entry) => (entry.key, entry.value));
}

Future<String?> getCommandOutput(String command, List<String> arguments, {bool checkErrors = false}) async {
  final result = await Process.run(command, arguments);
  if (checkErrors && result.exitCode != 0) return null;
  return result.stdout as String;
}

Future<void> runCommand(String command, List<String> arguments, {String? workingDirectory, bool isFatal = true}) async {
  final result = await Process.run(command, arguments, workingDirectory: workingDirectory);
  if (result.exitCode != 0) {
    final logFunction = isFatal ? logger.critical : logger.warning;
    final args = arguments.join(" ");
    logFunction(
      "Failed to execute command: $command $args",
      body: "${result.stdout}\n${result.stderr}",
    );
    if (isFatal) exit(1);
  }
}
