import "dart:typed_data";

import "package:burt_network/burt_network.dart";

class FailingSerialPort extends SerialPortInterface {
  FailingSerialPort(super.portName);

  @override bool get isOpen => false;
  @override int get bytesAvailable => 0;

  @override Future<bool> init() => throw UnsupportedError("Test port cannot open");
  @override Uint8List read(int count) => throw UnsupportedError("Test port cannot read");

  @override Future<void> dispose({bool isSafe = true}) async { }
  @override bool write(Uint8List bytes) => throw UnsupportedError("Test port cannot write");
}

class DisconnectedSerialPort extends SerialPortInterface {
  DisconnectedSerialPort(super.portName);

  var _shouldFail = false;
  var _isOpen = false;

  @override
  bool get isOpen => _isOpen;

  @override
  int get bytesAvailable => 4;

  @override
  Future<bool> init() async {
    _shouldFail = false;
    _isOpen = true;
    return true;
  }

  @override
  Uint8List read(int count) {
    if (_shouldFail) {
      throw Exception("The device was suddenly unplugged!");
    } else {
      _shouldFail = true;
      return Uint8List.fromList([1, 2, 3, 4]);
    }
  }

  @override
  Future<void> dispose({bool isSafe = true}) async {
    _isOpen = false;
    if (_shouldFail && isSafe) throw Exception("You shouldn't try to call dispose");
  }

  @override
  bool write(Uint8List bytes) => true;
}
