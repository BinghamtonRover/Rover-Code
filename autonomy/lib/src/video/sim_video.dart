import "package:autonomy/interfaces.dart";

class VideoSimulator extends VideoInterface {
  VideoSimulator({required super.collection});

  @override
  Future<bool> init() async {
    hasValue = true;
    return super.init();
  }

  @override
  void updateFrame(VideoData result) {}
}
