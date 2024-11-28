import "dart:typed_data";

import "package:burt_network/burt_network.dart";

export "port_delegate.dart";

/// An interface to a serial port.
abstract class SerialPortInterface extends Service {
  /// The name of the port.
  final String portName;

  /// The baud rate to communicate with the Serial device.
  final int baudRate;

  /// Creates a serial port at the given name.
  SerialPortInterface(this.portName, {this.baudRate = 9600});

  /// Whether this port is open.
  bool get isOpen;

  /// How many bytes are available to be read.
  int get bytesAvailable;

  /// Reads the given number of bytes from the port.
  Uint8List read(int count);

  /// Writes data to the port.
  void write(Uint8List bytes);

  @override
  Future<void> dispose({bool isSafe = true});
}
