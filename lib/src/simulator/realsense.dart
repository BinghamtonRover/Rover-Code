import "dart:typed_data";

import "package:autonomy/interfaces.dart";

class RealSenseSimulator extends RealSenseInterface {
  RealSenseSimulator({required super.collection});
  
  @override
  Future<bool> init() async {
    hasValue = true;
    return true;
  }

  @override
  Future<void> dispose() async => depthFrame = Uint16List.fromList([]);
  
  Uint16List depthFrame = Uint16List.fromList([]);

  @override
  void updateFrame(Uint16List newFrame) => depthFrame = newFrame;
}
