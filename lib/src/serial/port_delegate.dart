import "dart:typed_data";

import "package:libserialport/libserialport.dart";

import "port_interface.dart";

/// A serial port implementation that delegates to [`package:libserialport`](https://pub.dev/packages/libserialport)
class DelegateSerialPort extends SerialPortInterface {
	/// A list of all available ports on the device.
	static List<String> allPorts = SerialPort.availablePorts;
  
  SerialPort? _delegate;

  /// Creates a serial port that delegates to the `libserialport` package.
  DelegateSerialPort(super.portName);

  @override
  bool get isOpen => _delegate?.isOpen ?? false;
  
  @override
  Future<bool> init() async {
    try { 
      _delegate = SerialPort(portName);
      return _delegate!.openReadWrite();
    } catch (error) {
      return false;
    }
  }

  @override
  int get bytesAvailable => _delegate?.bytesAvailable ?? 0;
  
  @override
  Uint8List read(int count) => _delegate?.read(count) ?? Uint8List.fromList([]);
  
  @override
  void write(Uint8List bytes) => _delegate?.write(bytes);
  
  @override
  Future<void> dispose() async {
    if (!isOpen) return;
    _delegate?.close();
    _delegate?.dispose();
  }
}
