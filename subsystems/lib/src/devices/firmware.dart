import "dart:async";

import "package:collection/collection.dart";

import "package:subsystems/subsystems.dart";
import "package:burt_network/burt_network.dart";

import "serial_utils.dart";

final nameToDevice = <String, Device>{
  ArmCommand().messageName: Device.ARM,
  DriveCommand().messageName: Device.DRIVE,
  ScienceCommand().messageName: Device.SCIENCE,
  RelaysCommand().messageName: Device.RELAY,
  ControlCommand().messageName: Device.CONTROL_BOARD,
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
/// ([_sendToSerial]), and forwarding serial messages to the Dashboard ([RoverSocket.sendWrapper]).
class FirmwareManager extends Service {
  /// Subscriptions to each of the firmware devices.
  final List<StreamSubscription<WrappedMessage>> _subscriptions = [];

  /// A list of firmware devices attached to the rover.
  List<BurtFirmwareSerial> devices = [];

  @override
  Future<bool> init() async {
    devices = await getFirmwareDevices();
    collection.server.messages.listen(_sendToSerial);
    var result = true;
    for (final device in devices) {
      logger.debug("Initializing device: ${device.port}");
      result &= await device.init();
      if (!device.isReady) continue;
      final subscription = device.messages.listen((wrapper) {
        if (wrapper.name == ControlData().messageName) {
          final controlData = ControlData.fromBuffer(wrapper.data);
          if (controlData.hasDrive()) {
            collection.server.sendMessage(controlData.drive);
            return;
          } else if (controlData.hasRelays()) {
            collection.server.sendMessage(controlData.relays);
            return;
          }
        }
        collection.server.sendWrapper(wrapper);
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
  void _sendToSerial(WrappedMessage wrapper) {
    final controlConnected = devices.any(
      (e) => e.device == Device.CONTROL_BOARD,
    );
    var device = nameToDevice[wrapper.name];
    if (device == null) return;
    var bytesToSend = wrapper.data;

    // Handle incoming ControlCommand messages by unwrapping them
    if (wrapper.name == ControlCommand().messageName) {
      final controlCommand = ControlCommand.fromBuffer(wrapper.data);
      if (controlCommand.hasDrive()) {
        // Send the DriveCommand directly to the drive device
        device = Device.DRIVE;
        bytesToSend = controlCommand.drive.writeToBuffer();
      } else if (controlCommand.hasRelays()) {
        // Send the RelaysCommand directly to the relay device
        device = Device.RELAY;
        bytesToSend = controlCommand.relays.writeToBuffer();
      } else {
        return;
      }
    } else if (controlConnected) {
      // Wrap outgoing commands in ControlCommand if control board is connected
      if (device == Device.DRIVE) {
        bytesToSend = ControlCommand(
          drive: DriveCommand.fromBuffer(wrapper.data),
        ).writeToBuffer();
        device = Device.CONTROL_BOARD;
      } else if (device == Device.RELAY) {
        bytesToSend = ControlCommand(
          relays: RelaysCommand.fromBuffer(wrapper.data),
        ).writeToBuffer();
        device = Device.CONTROL_BOARD;
      }
    }
    final serial = devices.firstWhereOrNull((s) => s.device == device);
    if (serial == null) return;
    serial.sendBytes(bytesToSend);
  }

  /// Sends a [Message] to the appropriate firmware device.
  ///
  /// This does nothing if the appropriate device is not connected. Specifically, this is not an
  /// error because the Dashboard may be used during testing, when the hardware devices may not be
  /// assembled, connected, or functional yet.
  void sendMessage(Message message) => _sendToSerial(message.wrap());
}
