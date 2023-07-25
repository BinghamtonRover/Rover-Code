import "package:autonomy/autonomy.dart";

void main(List<String> arguments) async {
  final server = AutonomyServer(port: 8004);
  await server.init();
}
