import "dart:typed_data";

import "package:libserialport/libserialport.dart";

import "port_interface.dart";

/// A serial port implementation that delegates to [`package:libserialport`](https://pub.dev/packages/libserialport)
class DelegateSerialPort extends SerialPortInterface {
  /// A list of all available ports on the device.
  static List<String> get allPorts => SerialPort.availablePorts;

  SerialPort? _delegate;

  /// Creates a serial port that delegates to the `libserialport` package.
  DelegateSerialPort(
    super.portName, {
    super.baudRate,
    super.bits,
    super.parity,
    super.stopBits,
    super.dtr,
    super.xonXoff,
    super.flowControl,
  });

  @override
  bool get isOpen => _delegate?.isOpen ?? false;

  @override
  Future<bool> init() async {
    _delegate = SerialPort(portName);
    final result = _delegate!.openReadWrite();
    final config = _delegate!.config;
    config.baudRate = baudRate;

    // Before setting any config option, check if it's valid,
    // otherwise this will throw an OS level error
    if (config.parity != SerialPortParity.invalid && parity != null) {
      config.parity = parity!;
    }
    if (config.bits != -1 && bits != null) {
      config.bits = bits!;
    }
    if (config.stopBits != -1 && stopBits != null) {
      config.stopBits = stopBits!;
    }
    if (config.dtr != SerialPortDtr.invalid && dtr != null) {
      config.dtr = dtr!;
    }
    if (config.xonXoff != SerialPortXonXoff.invalid && xonXoff != null) {
      config.xonXoff = xonXoff!;
    }
    // Disable DTR, RTS, CTS, and DSR by default, these will be managed by
    // the flow control setting
    if (config.dtr != SerialPortDtr.invalid && dtr == null) {
      // Only apply if there's no manual dtr setting
      config.dtr = SerialPortDtr.off;
    }
    if (config.rts != SerialPortRts.invalid) {
      config.rts = SerialPortRts.off;
    }
    if (config.cts != SerialPortCts.invalid) {
      config.cts = SerialPortCts.ignore;
    }
    if (config.dsr != SerialPortDsr.invalid) {
      config.dsr = SerialPortDsr.ignore;
    }
    config.setFlowControl(flowControl);
    _delegate!.config = config;
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
