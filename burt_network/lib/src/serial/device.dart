import "dart:async";
import "dart:typed_data";

import "package:burt_network/burt_network.dart";
import "package:libserialport/libserialport.dart";

/// A wrapper around the `package:libserialport` library.
///
/// - Check [DelegateSerialPort.allPorts] for a list of all available ports.
/// - Call [init] to open the port
/// - Use [write] to write bytes to the port. Strings are not supported
/// - Listen to [stream] to get incoming data
/// - Call [dispose] to close the port
class SerialDevice extends Service {
  /// All available ports on this device.
  static List<String> get allPorts => SerialPort.availablePorts;

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

  /// Opens a new serial connection with the given port name and configuration settings.
  SerialDevice({
    required String portName,
    required this.readInterval,
    required this.logger,
    int baudRate = 9600,
    int? parity,
    int? stopBits,
    int? dtr,
    int? xonXoff,
  }) : _port = DelegateSerialPort(
         portName,
         baudRate: baudRate,
         parity: parity,
         stopBits: stopBits,
         dtr: dtr,
         xonXoff: xonXoff,
       );

  /// Opens a serial connection on the given port.
  SerialDevice.fromPort(this._port, {required this.readInterval, required this.logger});

  /// The name of the port to connect to.
  String get portName => _port.portName;

	/// Whether the port is open (ie, the device is connected).
	bool get isOpen => _port.isOpen;

  @override
	Future<bool> init() async {
    if (_controller.isClosed) throw StateError("A SerialDevice cannot be used after closeStream() is called");
    var result = false;
    try {
      result = await _port.init();
    } catch (error) { /* Ignore, log below */ }
    if (!result) logger.warning("Could not open serial port $portName");
    return result;
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
      logger.error("Serial device on $portName has suddenly disconnected");
      stopListening();
      _port.dispose(isSafe: false);
      return Uint8List(0);
    }
  }

	/// Reads any data from the port and adds it to the [stream].
	void _checkForBytes(_) {
    final bytes = readBytes();
    if (bytes.isEmpty) return;
    _controller.add(bytes);
	}

  @override
	Future<void> dispose() async {
    _timer?.cancel();
		await _port.dispose(isSafe: isOpen);
	}

  /// Closes the [stream] so it cannot be listened to.
  ///
  /// Calling [init] after this is an error.
  Future<void> closeStream() async {
    await _controller.close();
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
