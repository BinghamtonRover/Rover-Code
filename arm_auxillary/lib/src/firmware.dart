import "dart:async";
import "package:burt_network/burt_network.dart";
import "package:subsystems/subsystems.dart";
import "package:collection/collection.dart";

/// Maps command names to [Device]s.
final nameToDevice = <String, Device>{
  ArmCommand().messageName: Device.ARM,
  DriveCommand().messageName: Device.DRIVE,
  ScienceCommand().messageName: Device.SCIENCE,
  RelaysCommand().messageName: Device.RELAY,
};

/// Service to manage communication from the arm auxillary board to EA and HREI devices
class FirmwareManager extends Service {
  /// Reference to the server for routing messages
  final RoverSocket? Function() getServer;

  /// Logger instance
  final BurtLogger logger;

  /// Subscriptions to each of the firmware devices.
  final List<StreamSubscription<WrappedMessage>> _subscriptions = [];

  /// A list of firmware devices attached to the rover.
  List<BurtFirmwareSerial> devices = [];

  /// Creates a new FirmwareManager instance
  FirmwareManager({required this.getServer, required this.logger});

  @override
  Future<bool> init() async {
    devices = await getFirmwareDevices();
    final server = getServer();
    server?.messages.listen(_sendToSerial);
    var result = true;
    for (final device in devices) {
      logger.debug("Initializing device: ${device.port}");
      result &= await device.init();
      if (!device.isReady) continue;
      final subscription = device.messages.listen(server?.sendWrapper ?? (_) {});
      _subscriptions.add(subscription);
    }
    return result;
  }

  /// Sends messages from the server to the appropriate serial device
  void _sendToSerial(WrappedMessage message) {
    final device = nameToDevice[message.name];
    if (device == null) return;
    final serial = devices.firstWhereOrNull((s) => s.device == device);
    if (serial == null) return;
    serial.sendBytes(message.data);
  }

  @override
  Future<void> dispose() async {
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
    for (final device in devices) {
      await device.dispose();
    }
  }

  /// Sends a [Message] to the appropriate firmware device.
  ///
  /// This does nothing if the appropriate device is not connected. Specifically, this is not an
  /// error because the Dashboard may be used during testing, when the hardware devices may not be
  /// assembled, connected, or functional yet.
  void sendMessage(Message message) => _sendToSerial(message.wrap());
}
