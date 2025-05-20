import "dart:async";

import "package:collection/collection.dart";

import "package:subsystems/subsystems.dart";
import "package:burt_network/burt_network.dart";

import "serial_utils.dart";

/// Maps command names to [Device]s.
final nameToDevice = <String, Device>{
  ArmCommand().messageName: Device.ARM,
  DriveCommand().messageName: Device.DRIVE,
  ScienceCommand().messageName: Device.SCIENCE,
  RelaysCommand().messageName: Device.RELAY,
};

/// A service to manage all the connected firmware.
///
/// Firmware means any device using the [Firmware-Utilities](https://github.com/BinghamtonRover/Firmware-Utilities)
/// library. In our case, all such devices are Teensy boards running on the Arduino platform,
/// connected via USB (serial).
///
/// This service relies on the [BurtFirmwareSerial] class defined in `package:burt_network`. That
/// class takes care of connecting to, identifying, and streaming from a firmware device. This
/// service is responsible for routing incoming UDP messages to the correct firmware device
/// ([sendToSerial]), and forwarding serial messages to the Dashboard ([RoverSocket.sendWrapper]).
class FirmwareManager extends Service {
  /// Subscriptions to each of the firmware devices.
  final List<StreamSubscription<WrappedMessage>> _subscriptions = [];

  /// A list of firmware devices attached to the rover.
  List<BurtFirmwareSerial> devices = [];

  @override
  Future<bool> init() async {
    devices = await getFirmwareDevices();
    var result = true;
    for (final device in devices) {
      logger.debug("Initializing device: ${device.port}");
      result &= await device.init();
      if (!device.isReady) continue;
      final subscription = device.messages.listen((message) {
        // Don't send data if the device is also connected via CAN
        if (!collection.can.deviceConnected(device.device)) {
          collection.server.sendWrapper(message);
        }
      });
      _subscriptions.add(subscription);
    }
    return result;
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

  /// Sends a [WrappedMessage] to the correct Serial device.
  ///
  /// The notes on [sendMessage] apply here as well.
  void sendToSerial(WrappedMessage wrapper) {
    final device = nameToDevice[wrapper.name];
    if (device == null) return;
    final serial = devices.firstWhereOrNull((s) => s.device == device);
    if (serial == null) return;
    serial.sendBytes(wrapper.data);
  }

  /// Sends a [Message] to the appropriate firmware device.
  ///
  /// This does nothing if the appropriate device is not connected. Specifically, this is not an
  /// error because the Dashboard may be used during testing, when the hardware devices may not be
  /// assembled, connected, or functional yet.
  void sendMessage(Message message) => sendToSerial(message.wrap());
}
