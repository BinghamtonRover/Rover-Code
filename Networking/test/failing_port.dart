import "dart:typed_data";

import "package:burt_network/burt_network.dart";

class FailingSerialPort extends SerialPortInterface {
  FailingSerialPort(super.portName);

  @override bool get isOpen => false;
  @override int get bytesAvailable => 0;

  @override Future<bool> init() => throw UnsupportedError("Test port cannot open");
  @override Uint8List read(int count) => throw UnsupportedError("Test port cannot read");

  @override Future<void> dispose() async { }
  @override bool write(Uint8List bytes) => throw UnsupportedError("Test port cannot write");
}
