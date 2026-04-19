import "dart:typed_data";

import "package:protobuf/protobuf.dart";

import "package:burt_network/burt_network.dart";

/// Represents a firmware device connected over Serial.
///
/// This device starts with an unknown [device]. Calling [init] starts a handshake with the device
/// that identifies it. If the handshake fails, [isReady] will be false. Calling [dispose] will
/// reset the device and close the connection.
class BurtFirmwareSerial extends Service {
  /// The interval to read serial data at.
  static const readInterval = Duration(milliseconds: 10);
  /// How long it should take for a firmware device to respond to a handshake.
  static const handshakeDelay = Duration(milliseconds: 1200);
  static const handshakeTimeout = Duration(milliseconds: 1500);
  /// The reset code to send to a firmware device.
  static final resetCode = Uint8List.fromList([0, 0, 0, 0]);

  /// The underlying serial connection.
  final SerialDevice _serial;

  /// The logger to use.
  final BurtLogger logger;

  /// Creates a firmware device with the given serial port and baud rate.
  BurtFirmwareSerial({
    required String port,
    required this.logger,
    int baudRate = 9600,
  }) : _serial = SerialDevice(
         portName: port,
         readInterval: readInterval,
         logger: logger,
         baudRate: baudRate,
         parity: SerialPortParity.none,
         bits: 8,
         stopBits: 1,
         dtr: SerialPortDtr.on,
         xonXoff: SerialPortXonXoff.disabled,
       );

  /// The name of this device.
  Device device = Device.FIRMWARE;

  /// The port this device is attached to.
  String get port => _serial.portName;

  /// The stream of raw data coming from this device.
  Stream<Uint8List> get rawStream => _serial.stream;

  /// The stream of incoming messages, wrapped into [WrappedMessage]s.
  Stream<WrappedMessage> get messages => _serial.stream
    .map((packet) => WrappedMessage(data: packet, name: deviceToDataName(device)));

  /// Whether this device has passed the handshake.
	bool get isReady => device != Device.FIRMWARE && _serial.isOpen;

  @override
  Future<bool> init() async {
    // Open the port
    logger.debug("Opening $port");
    if (!await _serial.init()) {
      logger.warning("Could not open firmware device on port $port");
      return false;
    }

    // Execute the handshake
    if (!(await _reset() || await _reset())) logger.warning("The Teensy on port $port failed to reset");
    
    // Retry handshake up to 3 times with brief backoff
    var handshakeSuccess = false;
    for (var attempt = 0; attempt < 3; attempt++) {
      if (await _sendHandshake()) {
        handshakeSuccess = true;
        break;
      }
      await Future<void>.delayed(const Duration(milliseconds: 200));
    }

    if (!handshakeSuccess) {
      logger.warning("Could not connect to Teensy", body: "Device on port $port failed the handshake");
      return false;
    }

    logger.info("Connected to the ${device.name} Teensy on port $port");
    _serial.startListening();
    return true;
  }

  /// Sends the handshake to the device and returns whether it was successful.
  Future<bool> _sendHandshake() async {
    logger.debug("Sending handshake to port $port...");
    final handshake = Connect(sender: Device.SUBSYSTEMS, receiver: Device.FIRMWARE);
    _serial.write(handshake.writeToBuffer());

    // Wait for MCU boot, then poll for response
    await Future<void>.delayed(handshakeDelay);
    
    final deadline = DateTime.now().add(handshakeTimeout);
    final response = <int>[];
    
    while (DateTime.now().isBefore(deadline) && response.length < 4) {
      final chunk = _serial.readBytes(4 - response.length);
      if (chunk.isNotEmpty) {
        response.addAll(chunk);
      } else {
        await Future<void>.delayed(const Duration(milliseconds: 20));
      }
    }

    if (response.isEmpty) {
      logger.trace("Device did not respond");
      return false;
    }

    if (response.length < 4) {
      logger.trace("Device responded with incomplete handshake: $response");
      return false;
    }

    try {
      final message = Connect.fromBuffer(response);
      logger.trace("Device responded with: ${message.toProto3Json()}");
      if (message.receiver != Device.SUBSYSTEMS) return false;
      device = message.sender;
      return true;
    } on InvalidProtocolBufferException {
      final extra = _serial.readBytes();
      final full = response + extra;
      logger.trace("Device responded with malformed data: $full");
      return false;
    }
  }

  /// Sends the reset code and returns whether the device confirmed its reset.
  Future<bool> _reset() async {
    _serial.write(resetCode);
    await Future<void>.delayed(const Duration(milliseconds: 100));
    final response = _serial.readBytes();
    // The response should end with [1, 1, 1, 1], but may have elements before that
    if (response.length < 4) return false;
    if (response.sublist(response.length - 4).any((x) => x != 1)) return false;
    logger.debug("The ${device.name} Teensy has been reset");
    return true;
  }

  /// Sends bytes to the device.
  void sendBytes(List<int> bytes) => _serial.write(Uint8List.fromList(bytes));

  /// Sends a Protobuf message to the device.
  void sendMessage(Message message) => _serial.write(message.writeToBuffer());

  /// Resets the device and closes the port.
  @override
  Future<void> dispose() async {
    _serial.stopListening();
    if (!await _reset()) logger.warning("The $device device on port $port did not reset");
    await _serial.dispose();
    device = Device.FIRMWARE;
  }
}
