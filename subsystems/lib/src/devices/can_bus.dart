import "dart:async";
import "dart:io";

import "package:burt_network/protobuf.dart";
import "package:burt_network/service.dart";
import "package:dart_dbc_generator/dart_dbc_generator.dart";
import "package:linux_can/linux_can.dart";
import "package:subsystems/src/generated/rover_messages.dbc.dart";
import "package:subsystems/src/utils/dbc_conversions.dart";
import "package:subsystems/subsystems.dart" hide CanSocket;

/// Utility method to convert a message into a list of DBC messages
List<DBCMessage> getDBCMessages(Message message) => switch (message) {
  final DriveCommand m => m.toDBC(),
  final RelaysCommand m => m.toDBC(),
  final ArmCommand m => m.toDBC(),
  final ScienceCommand _ => [],
  _ => [],
};

/// A map of CAN IDs to a function to convert them into a protobuf message
final Map<int, Message Function(List<int> data)> canIDToMessage = {
  DriveAppliedOutputDataMessage().canId: (data) =>
      DriveAppliedOutputDataMessage.decode(data).toDriveProto(),
  DriveBatteryDataMessage().canId: (data) =>
      DriveBatteryDataMessage.decode(data).toDriveProto(),
  DriveLedDataMessage().canId: (data) =>
      DriveLedDataMessage.decode(data).toDriveProto(),
  DriveSwivelDataMessage().canId: (data) =>
      DriveSwivelDataMessage.decode(data).toDriveProto(),
  DriveMotorDataMessage().canId: (data) =>
      DriveMotorDataMessage.decode(data).toDriveProto(),
  RelayStateDataMessage().canId: (data) =>
      RelayStateDataMessage.decode(data).toRelayProto(),
  RelayBatteryDataMessage().canId: (data) =>
      RelayBatteryDataMessage.decode(data).toRelayProto(),
  ArmMotorMoveDataMessage().canId: (data) =>
      ArmMotorMoveDataMessage.decode(data).toArmProto(),
  ArmMotorStepDataMessage().canId: (data) =>
      ArmMotorStepDataMessage.decode(data).toArmProto(),
  ArmMotorAngleDataMessage().canId: (data) =>
      ArmMotorAngleDataMessage.decode(data).toArmProto(),
};

extension on DeviceBroadcastMessage {
  Message toDriveProto() => DriveData(version: version);

  Message toRelayProto() => RelaysData();

  Message toArmProto() => ArmData(version: version);

  Message toScienceProto() => ScienceData(version: version);

  Message? toProtoMessage() {
    if (deviceValue == Device.DRIVE.value) {
      return toDriveProto();
    } else if (deviceValue == Device.RELAY.value) {
      return toRelayProto();
    } else if (deviceValue == Device.ARM.value) {
      return toArmProto();
    } else if (deviceValue == Device.SCIENCE.value) {
      return toScienceProto();
    }
    return null;
  }

  Version get version => Version(major: fwVersionMajor, minor: fwVersionMinor);
}

/// A service to forward messages between CAN and UDP
///
/// Simliar to the firmware service, this service will stream incoming
/// messages from the network, and send specific types of messages over
/// the CAN bus as its corresponding DBC message.
///
/// For safety reasons, this service will send and receive heartbeats
/// over the CAN bus, to ensure every device knows it's connected to the
/// rover, and so the rover can determine every device connected, and their
/// firmware versions.
class CanBus extends Service {
  /// The CAN interface to send messages on
  static const String canInterface = "can0";

  /// How often to send a rover heartbeat over the CAN bus
  static const Duration heartbeatPeriod = Duration(milliseconds: 100);

  /// The maximum time the program should wait for a device's heartbeat before
  /// it's considered disconnected
  static const Duration heartbeatTimeout = Duration(milliseconds: 250);

  /// A map of devices and the last time their broadcast message was received
  final Map<Device, DateTime> deviceHeartbeats = {};

  /// A list of all the devices connected to the CAN bus
  List<Device> get connectedDevices => deviceHeartbeats.keys.toList();

  /// The CAN device for the CAN bus
  CanDevice? device;

  /// The CAN socket for the CAN bus
  CanSocket? socket;
  Timer? _sendHeartbeatTimer;
  Timer? _checkHeartbeatsTimer;

  bool _heartbeatSendSuccessful = false;

  StreamSubscription<CanFrame>? _frameSubscription;

  Future<void>? _resetFuture;

  @override
  Future<bool> init() async {
    if (Platform.isWindows) {
      return true;
    }

    if (!await bringUpCAN(canInterface)) {
      return false;
    }
    try {
      device = LinuxCan.instance.devices.singleWhere(
        (device) => device.networkInterface.name == canInterface,
      );
    } catch (e) {
      if (e is StateError) {
        logger.error("No CAN interface found named $canInterface");
        return false;
      }
      rethrow;
    }
    if (!device!.isUp) {
      logger.error(
        "$canInterface is not up",
        body: "Device state: ${device!.state}",
      );
      return false;
    }
    logger.info(
      "Initializing CAN socket for device ${device!.networkInterface.name}",
    );
    socket = device!.open();
    _frameSubscription = socket!.receive().listen(_onCanFrame);
    _sendHeartbeatTimer = Timer.periodic(
      heartbeatPeriod,
      (_) => sendHeartbeat(),
    );
    _checkHeartbeatsTimer = Timer.periodic(
      heartbeatTimeout,
      (_) => checkHeartbeats(),
    );
    return true;
  }

  @override
  Future<void> dispose() async {
    _sendHeartbeatTimer?.cancel();
    _checkHeartbeatsTimer?.cancel();

    _heartbeatSendSuccessful = false;

    await socket?.close();
    socket = null;

    device = null;

    await _frameSubscription?.cancel();

    deviceHeartbeats.clear();
  }

  /// Initializes and brings up the CAN interface named [interfaceName]
  ///
  /// Returns whether or not the device was successfully brought up.
  Future<bool> bringUpCAN(String interfaceName) async {
    await Process.run("sudo", ["ip", "link", "set", interfaceName, "down"]);
    await Process.run("sudo", [
      "ip",
      "link",
      "set",
      interfaceName,
      "type",
      "can",
      "bitrate",
      "500000",
      "restart-ms",
      "100",
    ]);
    final upResult = await Process.run("sudo", [
      "ip",
      "link",
      "set",
      interfaceName,
      "up",
    ]);

    if (upResult.exitCode != 0) {
      logger.error("Could not set $canInterface up", body: upResult.stderr);
      return false;
    }

    return true;
  }

  /// Whether or not a broadcast message has been received from [device] within
  /// the past [heartbeatTimeout] amount of time
  bool deviceConnected(Device device) => deviceHeartbeats.containsKey(device);

  /// Sends the [dbcMessages] over the CAN bus only if a broadcast message has been
  /// received from [device] and a heartbeat has been successfully sent
  ///
  /// If [forceSend] is true, it will send the message regardless of connection
  /// or heartbeat status
  Future<bool> _sendDeviceCommand({
    required Device device,
    required Iterable<DBCMessage> dbcMessages,
    bool forceSend = false,
  }) async {
    if ((!deviceConnected(device) || !_heartbeatSendSuccessful) && !forceSend) {
      return false;
    }
    return !(await Future.wait(
      dbcMessages.map(sendDBCMessage),
    )).contains(false);
  }

  /// Sends a wrapped message over the CAN bus, returns
  /// whether or not the message was successfully sent
  Future<bool> sendWrapper(WrappedMessage message) async {
    if (message.name == DriveCommand().messageName) {
      return sendMessage(DriveCommand.fromBuffer(message.data));
    } else if (message.name == RelaysCommand().messageName) {
      return sendMessage(RelaysCommand.fromBuffer(message.data));
    } else if (message.name == ArmCommand().messageName) {
      return sendMessage(ArmCommand.fromBuffer(message.data));
    } else if (message.name == ScienceCommand().messageName) {
      return sendMessage(ScienceCommand.fromBuffer(message.data));
    }
    return false;
  }

  /// Sends a message's DBC equivalent over the CAN bus
  ///
  /// Returns whether or not the message was sent over the bus
  Future<bool> sendMessage(Message message) {
    final device = commandToDevice[message.messageName];
    if (device == null) {
      return Future.value(false);
    }

    return _sendDeviceCommand(
      device: device,
      dbcMessages: getDBCMessages(message),
    );
  }

  /// Whether or not [message] can be successfully sent over the bus
  ///
  /// If no broadcast has been received from the device corresponding to [message],
  /// it will return false. If there was an error while sending a heartbeat, this
  /// will also return false;
  bool canSendWrapper(WrappedMessage message) {
    if (!_heartbeatSendSuccessful ||
        !commandToDevice.containsKey(message.name)) {
      return false;
    }

    return deviceConnected(commandToDevice[message.name]!);
  }

  /// Sends a heartbeat message over the CAN bus
  Future<bool> sendHeartbeat() async {
    final heartbeat = RoverHeartbeatMessage();
    return _heartbeatSendSuccessful = await sendDBCMessage(heartbeat);
  }

  /// Checks all device's heartbeats and determines if they are still connected
  void checkHeartbeats() {
    final now = DateTime.timestamp();
    deviceHeartbeats.removeWhere((device, time) {
      if (now.difference(time) > heartbeatTimeout) {
        logger.warning(
          "${device.name} disconnected from CAN bus",
          body: "Broadcast message not received after $heartbeatTimeout",
        );
        return true;
      }
      return false;
    });
  }

  /// Sends a DBC message over the CAN bus
  ///
  /// Returns whether or not the message was successfully sent
  Future<bool> sendDBCMessage(DBCMessage message) async {
    if (socket == null || device == null || _resetFuture != null) {
      return false;
    }

    if (!device!.isUp) {
      logger.warning(
        "Device is not up while trying to send message",
        body: "Restarting CAN interface",
      );
      _resetFuture ??= Future(() async {
        if (await bringUpCAN(canInterface)) {
          // Wait a small amount after bringing up the device, for
          // some reason device.isUp returns false for a short period
          // of time after
          await Future<void>.delayed(const Duration(milliseconds: 100));
        }
      }).whenComplete(() => _resetFuture = null);
      return false;
    }

    if (device!.state == CanState.busOff) {
      logger.warning("Cannot send message, bus is off");
      return false;
    }

    try {
      await socket?.send(
        CanFrame.standard(id: message.canId, data: message.encode()),
      );
      return true;
    } catch (error) {
      if (error.toString().contains("No buffer space")) {
        logger.debug("Error when sending CAN message", body: error.toString());
      } else {
        logger.error("Error when sending CAN message", body: error.toString());
      }
      return false;
    }
  }

  void _handleDeviceBroadcast(DeviceBroadcastMessage broadcast) {
    final device = Device.valueOf(broadcast.deviceValue);
    if (device == null) {
      logger.warning(
        "Unknown Device Number",
        body: "Received broadcast from device ${broadcast.deviceValue}",
      );
      return;
    }
    if (!deviceHeartbeats.containsKey(device)) {
      logger.info("${device.name} connected via CAN bus");
    }
    deviceHeartbeats[device] = DateTime.timestamp();

    final versionProto = broadcast.toProtoMessage();
    if (versionProto != null) {
      collection.server.sendMessage(versionProto);
    }
  }

  void _onCanFrame(CanFrame frame) {
    if (frame is! CanDataFrame) return;

    final id = frame.id;
    final data = frame.data;

    if (canIDToMessage[id] case final constructor?) {
      collection.server.sendMessage(constructor(data));
      return;
    }

    if (id != 0 && (id & 0xFF) == DeviceBroadcastMessage().canId) {
      _handleDeviceBroadcast(DeviceBroadcastMessage.decode(data));
      return;
    }

    logger.warning(
      "Received message with unmapped ID: 0x${id.toRadixString(16).padLeft(2, '0')}",
    );
  }
}
