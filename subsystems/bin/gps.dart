import "package:subsystems/subsystems.dart";

void main() async {
  final reader = GpsReader();
  await reader.init();
}
