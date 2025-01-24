import "dart:typed_data";
import "package:test/test.dart";

import "package:burt_network/burt_network.dart";

import "failing_port.dart";

const readInterval = Duration(milliseconds: 100);

void main() async {
  Logger.level = LogLevel.off;
  final logger = BurtLogger();

  group("Failing Serial port", () {
    final port = FailingSerialPort("portName");
    final device = SerialDevice.fromPort(port, logger: logger, readInterval: readInterval);
    setUp(device.init);
    tearDown(device.dispose);

    test("can safely restart", () async {
      await device.dispose();
      await device.init();
    });

    test("reports errors when opening", () async {
      await device.dispose();
      final result = await device.init();
      expect(result, isFalse);
    });

    test("handles errors when listening", () async {
      device.startListening();
      const listenDelay = Duration(seconds: 1);
      await Future<void>.delayed(listenDelay);
      device.stopListening();
    });

    test("handles errors when reading", () {
      final bytes1 = device.readBytes();
      expect(bytes1, isEmpty);
      final bytes2 = device.readBytes(10);
      expect(bytes2, isEmpty);
    });

    test("handles errors when writing", () {
      const data = [1, 2, 3, 4, 5, 6, 7, 8];
      final buffer = Uint8List.fromList(data);
      device.write(buffer);
    });
  });

  group("Suddenly disconnected port", () {
    final port = DisconnectedSerialPort("portName");
    final device = SerialDevice.fromPort(port, logger: logger, readInterval: readInterval);
    setUp(device.init);
    tearDown(device.dispose);

    test("can handle being suddenly disconnected: read()", () async {
      expect(device.isOpen, true);
      expect(device.readBytes(), Uint8List.fromList([1, 2, 3, 4]));
      expect(device.isOpen, true);
      expect(device.readBytes().isEmpty, true);
      expect(device.isOpen, false);
    });

    test("can handle being suddenly disconnected: stream", () async {
      final sub = device.stream.listen((_) { });
      expect(device.isOpen, true);
      device.startListening();
      await Future<void>.delayed(const Duration(milliseconds: 500));
      expect(device.isOpen, false);
      await device.dispose();
      await sub.cancel();
    });

    test("does not try to call dispose", () async {
      final sub = device.stream.listen((_) { });
      expect(device.isOpen, true);
      device.startListening();
      await Future<void>.delayed(const Duration(milliseconds: 500));
      expect(device.isOpen, false);
      await device.dispose();
      await sub.cancel();
    });
  });
}
