import "dart:typed_data";
import "package:test/test.dart";

import "package:burt_network/burt_network.dart";

import "failing_port.dart";

const readInterval = Duration(milliseconds: 100);

void main() async {
  Logger.level = LogLevel.off;
  final logger = BurtLogger();
  SerialPortInterface.factory = FailingSerialPort.new;  
  final device = SerialDevice(logger: logger, portName: "portName", readInterval: readInterval);
  SerialPortInterface.factory = DelegateSerialPort.new;  

  group("Failing Serial port", () {
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
}
