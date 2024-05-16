import "package:autonomy/rover.dart";

void main() async {
  final rover = RoverAutonomy();
  await rover.init();
}
