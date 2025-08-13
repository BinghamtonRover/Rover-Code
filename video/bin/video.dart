import "package:burt_network/logging.dart";
import "package:video/video.dart";

void main() async {
  Logger.level = LogLevel.all;
  await collection.init();
}
