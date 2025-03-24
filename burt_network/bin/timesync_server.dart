import "package:burt_network/src/udp/timesync_server.dart";

void main() async {
  final timesync = TimesyncServer(port: 8020);
  await timesync.init();
}
