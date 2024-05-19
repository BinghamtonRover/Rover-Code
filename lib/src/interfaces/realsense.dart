import "dart:typed_data";

import "package:autonomy/interfaces.dart";

abstract class RealSenseInterface extends Service with Receiver {
  final AutonomyInterface collection;
  RealSenseInterface({required this.collection});

  void updateFrame(Uint16List newFrame);
}
