import "package:autonomy/autonomy.dart";
import "package:burt_network/logging.dart";

void main(List<String> arguments) async {
  final tankMode = arguments.contains("--tank");
  if (tankMode) logger.info("Running in tank mode");
  await collection.init(tankMode: arguments.contains("--tank"));
}
