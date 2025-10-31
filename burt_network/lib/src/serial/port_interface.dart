import "dart:typed_data";

import "package:burt_network/burt_network.dart";
import "package:libserialport/libserialport.dart"
    show SerialPortConfig, SerialPortFlowControl;

export "package:libserialport/libserialport.dart"
    show
        SerialPortDtr,
        SerialPortFlowControl,
        SerialPortParity,
        SerialPortXonXoff;
export "port_delegate.dart";

/// An interface to a serial port.
abstract class SerialPortInterface extends Service {
  /// The name of the port.
  final String portName;

  /// The baud rate to communicate with the Serial device.
  final int baudRate;

  /// The number of data bits for the Serial port, see [SerialPortConfig.bits]
  final int? bits;

  /// The parity configuration for the serial port, null if the default value should be used
  ///
  /// See [SerialPortParity]
  final int? parity;

  /// The stop bits configuration for the serial port, null if the default value should be used
  final int? stopBits;

  /// The DTR configuration for the port, null if the default value should be used
  ///
  /// See [SerialPortDtr]
  final int? dtr;

  /// The XON/XOFF configuration for the port, null if the default value should be used
  ///
  /// See [SerialPortXonXoff]
  final int? xonXoff;

  /// The flow control configuration for the port, defaults to [SerialPortFlowControl.none]
  final int flowControl;

  /// Creates a serial port at the given name.
  SerialPortInterface(
    this.portName, {
    this.baudRate = 9600,
    this.bits,
    this.parity,
    this.stopBits,
    this.dtr,
    this.xonXoff,
    this.flowControl = SerialPortFlowControl.none,
  });

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
