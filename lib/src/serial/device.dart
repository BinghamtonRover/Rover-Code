import "dart:async";
import "dart:typed_data";

import "package:burt_network/burt_network.dart";

/// A wrapper around the `package:libserialport` library.
///
/// - Check [DelegateSerialPort.allPorts] for a list of all available ports.
/// - Call [init] to open the port
/// - Use [write] to write bytes to the port. Strings are not supported
/// - Listen to [stream] to get incoming data
/// - Call [dispose] to close the port
class SerialDevice extends Service {
  /// The port to connect to.
	final String portName;
	/// How often to read from the port.
	final Duration readInterval;
  /// The underlying connection to the serial port.
	final SerialPortInterface _port;
  /// The logger to use
  final BurtLogger logger;

	/// A timer to periodically read from the port (see [readBytes]).
	Timer? _timer;

	/// The controller for [stream].
	final _controller = StreamController<Uint8List>.broadcast();

	/// Manages a connection to a serial device.
	SerialDevice({
    required this.portName,
		required this.readInterval,
    required this.logger,
	}) : _port = SerialPortInterface.factory(portName);


	/// Whether the port is open (ie, the device is connected).
	bool get isOpen => _port.isOpen;

  @override
	Future<bool> init() async {
    try {
      return await _port.init();
    } catch (error) {
      logger.warning("Could not open port $portName", body: "$error");
      return false;
    }
  }

  /// Starts listening to data sent over the serial port via [stream].
  void startListening() => _timer = Timer.periodic(readInterval, _checkForBytes);

  /// Stops listening to the serial port.
  void stopListening() => _timer?.cancel();

  /// Reads bytes from the port. If [count] is provided, only reads that number of bytes.
  Uint8List readBytes([int? count]) {
    try {
      return _port.read(count ?? _port.bytesAvailable);
    } catch (error) {
      logger.error("Could not read from serial port $portName:\n  $error");
      return Uint8List(0);
    }
  }

	/// Reads any data from the port and adds it to the [stream].
	void _checkForBytes(_) {
		try {
      final bytes = readBytes();
      if (bytes.isEmpty) return;
      _controller.add(bytes);
		} catch (error) {
      logger.critical("Could not read $portName", body: error.toString());
      dispose();
		}
	}

  @override
	Future<void> dispose() async {
    _timer?.cancel();
    await _controller.close();
		await _port.dispose();
	}

	/// Writes data to the port.
	void write(Uint8List data) {
    if (!_port.isOpen) return;
    try {
      _port.write(data);
    } catch (error) {
      logger.warning("Could not write data to port $portName");
    }
  }

	/// All incoming bytes coming from the port.
	Stream<Uint8List> get stream => _controller.stream;
}
