import "dart:typed_data";

import "package:libserialport/libserialport.dart";

import "port_interface.dart";

/// A serial port implementation that delegates to [`package:libserialport`](https://pub.dev/packages/libserialport)
class DelegateSerialPort extends SerialPortInterface {
	/// A list of all available ports on the device.
	static List<String> get allPorts => SerialPort.availablePorts;

  SerialPort? _delegate;

  /// Creates a serial port that delegates to the `libserialport` package.
  DelegateSerialPort(super.portName, {super.baudRate});

  @override
  bool get isOpen => _delegate?.isOpen ?? false;

  @override
  Future<bool> init() async {
    _delegate = SerialPort(portName);
    final result = _delegate!.openReadWrite();
    final config = SerialPortConfig()..baudRate = baudRate;
    _delegate!.config = config;
    config.dispose();
    return result;
  }

  @override
  int get bytesAvailable => _delegate?.bytesAvailable ?? 0;

  @override
  Uint8List read(int count) => _delegate?.read(count) ?? Uint8List.fromList([]);

  @override
  void write(Uint8List bytes) => _delegate?.write(bytes);

  @override
  Future<void> dispose({bool isSafe = true}) async {
    if (!isOpen) return;
    if (isSafe) {
      _delegate?.close();
      _delegate?.dispose();
    }
    _delegate = null;
  }
}
