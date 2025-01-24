import "dart:async";

import "package:collection/collection.dart";

import "package:subsystems/subsystems.dart";
import "package:burt_network/burt_network.dart";

import "serial_utils.dart";

/// Maps command names to [Device]s.
final nameToDevice = <String, Device>{
  ArmCommand().messageName: Device.ARM,
  GripperCommand().messageName: Device.GRIPPER,
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
/// ([_sendToSerial]), and forwarding serial messages to the Dashboard ([RoverSocket.sendWrapper]).
class FirmwareManager extends Service {
  /// The amount of time to wait before automatically sending a
  /// stop command to the firmware after not receiving messages
  static const Duration firmwareStopTimeout = Duration(milliseconds: 500);

  /// Subscriptions to each of the firmware devices.
  final List<StreamSubscription<WrappedMessage>> _subscriptions = [];

  /// A list of firmware devices attached to the rover.
  List<BurtFirmwareSerial> devices = [];

  /// A map of devices to their timers to automatically shut
  /// off if no new messages are received
  /// 
  /// This prevents a scenario where commands aren't sent
  /// from the dashboard, and that program disconnects, leaving
  /// the motors to run freely
  final Map<Device, Timer> deviceStopTimers = {};

  /// The current status of the rover, as received from [UpdateSetting]
  RoverStatus currentStatus = RoverStatus.MANUAL;

  /// Whether or not the firmware should be sent any messages, the firmware
  /// should only be instructed to move when [currentStatus] is either [RoverStatus.AUTONOMOUS]
  /// or [RoverStatus.MANUAL]
  bool get shouldMove =>
      currentStatus == RoverStatus.AUTONOMOUS ||
      currentStatus == RoverStatus.MANUAL;

  StreamSubscription<UpdateSetting>? _roverStatusSubscription;

  /// The command to stop the drive motors
  final stopDrive = DriveCommand(throttle: 0, setThrottle: true);
  /// The command to stop the arm
  final stopArm = ArmCommand(stop: true);
  /// The command to stop the gripper
  final stopGripper = GripperCommand(stop: true);
  /// The command to stop science
  final stopScience = ScienceCommand(stop: true);

  /// Map of each firmware [Device] to its corresponding stop command
  late final Map<Device, Message> deviceToStopCommand = {
    Device.DRIVE: stopDrive,
    Device.ARM: stopArm,
    Device.GRIPPER: stopGripper,
    Device.SCIENCE: stopScience,
  };

  @override
  Future<bool> init() async {
    devices = await getFirmwareDevices();
    collection.server.messages.listen(_sendToSerial);
    var result = true;
    for (final device in devices) {
      logger.debug("Initializing device: ${device.port}");
      result &= await device.init();
      if (!device.isReady) continue;
      final subscription = device.messages.listen(collection.server.sendWrapper);
      _subscriptions.add(subscription);
    }
    currentStatus = RoverStatus.MANUAL;

    _roverStatusSubscription = collection.server.messages.onMessage(
      name: UpdateSetting().messageName,
      constructor: UpdateSetting.fromBuffer,
      callback: onSettingsUpdate,
    );
    return result;
  }

  /// Handles an incoming [UpdateSetting] message
  void onSettingsUpdate(UpdateSetting setting) {
    if (!setting.hasStatus()) return;
    final status = setting.status;

    currentStatus = setting.status;
    
    if (status == RoverStatus.AUTONOMOUS) {
      stopDevice(Device.DRIVE);
    } else if (status != RoverStatus.MANUAL) {
      stopHardware();
    }
  }

  @override
  Future<void> dispose() async {
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
    for (final device in devices) {
      await device.dispose();
    }
    await _roverStatusSubscription?.cancel();
  }

  /// Sends a message to the firmware [device] to stop the device
  void stopDevice(Device device) {
    logger.debug("Stopping device $device");
    final stopCommand = deviceToStopCommand[device];
    if (stopCommand != null) {
      sendMessage(stopCommand);
    }
  }

  /// Sends a [WrappedMessage] to the correct Serial device.
  ///
  /// The notes on [sendMessage] apply here as well.
  void _sendToSerial(WrappedMessage wrapper, {bool fromNetwork = true}) {
    final device = nameToDevice[wrapper.name];
    if (device == null) return;
    deviceStopTimers[device]?.cancel();
    if (fromNetwork) {
      if (!shouldMove) {
        logger.debug("Ignoring incoming ${wrapper.name}, status is currently ${currentStatus.name}");
        return;
      }
      deviceStopTimers[device] = Timer(firmwareStopTimeout, () {
        logger.info(
          "Device timed out: $device",
          body: "No commands have been received for ${firmwareStopTimeout.inMilliseconds} milliseconds",
        );
        stopDevice(device);
      });
    }
    final serial = devices.firstWhereOrNull((s) => s.device == device);
    if (serial == null) return;
    serial.sendBytes(wrapper.data);
  }

  /// Sends a [Message] to the appropriate firmware device.
  ///
  /// This does nothing if the appropriate device is not connected. Specifically, this is not an
  /// error because the Dashboard may be used during testing, when the hardware devices may not be
  /// assembled, connected, or functional yet.
  void sendMessage(Message message, {bool fromNetwork = false}) =>
      _sendToSerial(message.wrap(), fromNetwork: fromNetwork);

  /// Sends messages to all over the firmware devices to stop all movement
  /// 
  /// This is used as a safety stop to prevent any damage to hardware
  void stopHardware() {
    stopDevice(Device.DRIVE);
    stopDevice(Device.ARM);
    stopDevice(Device.GRIPPER);
    stopDevice(Device.SCIENCE);
  }
}
