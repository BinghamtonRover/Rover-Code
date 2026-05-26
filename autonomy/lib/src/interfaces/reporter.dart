import "dart:async";
import "package:burt_network/protobuf.dart";

import "package:autonomy/interfaces.dart";

mixin ValueReporter on Service {
  AutonomyInterface get collection;
  Message getMessage();

  Timer? timer;
  Duration get reportInterval => const Duration(milliseconds: 10);

  @override
  Future<bool> init() async {
    timer = Timer.periodic(reportInterval, (timer) => _reportValue());
    return super.init();
  }

  @override
  Future<void> dispose() async => timer?.cancel();

  void _reportValue() => collection.server.sendMessage(getMessage());
}
