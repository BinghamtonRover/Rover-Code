import "package:autonomy/rover.dart";
import "package:burt_network/logging.dart";

void main() async {
  Logger.level = Level.debug;
  final rover = RoverAutonomy();
  await rover.init();
}
