import "package:subsystems/subsystems.dart";

void main() async {
  final reader = ImuReader();
  await reader.init();
}
