import "dart:typed_data";

import "package:autonomy/interfaces.dart";

abstract class RealSenseInterface extends Service {
  final AutonomyInterface collection;
  RealSenseInterface({required this.collection});

  Uint16List get depthFrame;
  void updateFrame(Uint16List newFrame);
}
