import "dart:typed_data";

import "package:burt_network/burt_network.dart";
import "package:test/test.dart";

void main() {
  Logger.level = LogLevel.off;
  final logger = BurtLogger();

  group("Disconnected Serial device", () {
    const readInterval = Duration(milliseconds: 100);
    final device = SerialDevice(logger: logger, portName: "port", readInterval: readInterval);
    setUp(device.init);
    tearDown(device.dispose);

    test("reports when a device is not connected", () async {
      final device2 = SerialDevice(logger: logger, portName: "port", readInterval: readInterval);
      final result = await device2.init();
      expect(result, isFalse);
    });

    test("reads nothing", () {
      final data1 = device.readBytes();
      expect(data1, isEmpty);
      final data2 = device.readBytes(10);
      expect(data2, isEmpty);
    });

    test("streams nothing", () async {
      device.stream.listen(neverCalled);
      device.startListening();
      await Future<void>.delayed(const Duration(seconds: 1));
      device.stopListening();
    });

    test("does not error on write", () async {
      const data = [1, 2, 3, 4, 5, 6, 7, 8];
      final bytes = Uint8List.fromList(data);
      void func() => device.write(bytes);
      expect(func, returnsNormally);
    });

    test("only closes its stream when asked to", () async {
      // Someone may call [stopListening] at any time.
      // This will detach any other listeners, if there are any.
      var count = 0;
      device.stream.listen(neverCalled, onDone: () => count++);
      device.startListening();
      device.stopListening();
      await device.dispose();
      expect(count, 0);
      await device.closeStream();
      expect(device.stream, emitsDone);
      expect(count, 1);
    });
  });
}
