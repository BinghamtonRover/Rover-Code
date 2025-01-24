import "package:subsystems/subsystems.dart";
import "package:burt_network/logging.dart";

void main() async {
  Logger.level = LogLevel.trace;
  if (!await collection.init()) await collection.dispose();
}
