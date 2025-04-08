import "dart:async";
import "dart:io";

import "package:burt_network/protobuf.dart";
import "package:burt_network/service.dart";
import "package:dart_dbc_generator/dart_dbc_generator.dart";
import "package:linux_can/linux_can.dart";
import "package:subsystems/src/generated/rover_messages.dbc.dart";
import "package:subsystems/subsystems.dart" hide CanSocket;

extension on num {
  bool get boolValue => this == 1;

  BoolState get boolState => boolValue ? BoolState.YES : BoolState.NO;
}

extension on bool {
  int get intValue => this ? 1 : 0;
}

extension on BoolState {
  int get intValue => this == BoolState.YES ? 1 : 0;
}

extension on DeviceBroadcastMessage {
  Message toDriveProto() => DriveData(version: version);

  Message toRelayProto() => RelaysData();

  Message? toProtoMessage() {
    if (deviceName.toInt() == Device.DRIVE.value) {
      return toDriveProto();
    } else if (deviceName.toInt() == Device.RELAY.value) {
      return toRelayProto();
    }
    return null;
  }

  Version get version =>
      Version(major: fwVersionMajor.toInt(), minor: fwVersionMinor.toInt());
}

extension on DriveAppliedOutputMessage {
  DriveData toDriveProto() => DriveData(
    throttle: throttle.toDouble(),
    left: leftSpeed.toDouble(),
    right: rightSpeed.toDouble(),
    setLeft: true,
    setRight: true,
    setThrottle: true,
  );
}

extension on DriveBatteryMessage {
  DriveData toDriveProto() => DriveData(
    batteryVoltage: voltage.toDouble(),
    batteryTemperature: temperature.toDouble(),
    batteryCurrent: current.toDouble(),
  );
}

extension on DriveLedMessage {
  DriveData toDriveProto() =>
      DriveData(color: ProtoColor.valueOf(color.toInt()));
}

extension on DriveSwivelMessage {
  DriveData toDriveProto() => DriveData(
    frontSwivel: frontSwivel.toDouble(),
    frontTilt: frontTilt.toDouble(),
    rearSwivel: rearSwivel.toDouble(),
    rearTilt: rearTilt.toDouble(),
  );
}

extension on DriveCommand {
  DBCMessage get asSetSpeeds => DriveSetSpeedsMessage(
    shouldSetLeft: setLeft.intValue,
    shouldSetRight: setRight.intValue,
    shouldSetThrottle: setThrottle.intValue,
    leftSpeed: left,
    rightSpeed: right,
    throttle: throttle,
  );

  DBCMessage get asSetLEDS =>
      DriveSetLedMessage(color: color.value, blink: blink.intValue);

  DBCMessage get asSetSwivels => DriveSetSwivelMessage(
    setFrontSwivel: hasFrontSwivel().intValue,
    setFrontTilt: hasFrontTilt().intValue,
    setRearSwivel: hasRearSwivel().intValue,
    setRearTilt: hasRearTilt().intValue,
    frontSwivel: frontSwivel,
    frontTilt: frontTilt,
    rearSwivel: rearSwivel,
    rearTilt: rearTilt,
  );

  List<DBCMessage> toDBC() {
    final output = <DBCMessage>[];
    if (setLeft || setRight || setThrottle) {
      output.add(asSetSpeeds);
    }
    if (hasColor() || hasBlink()) {
      output.add(asSetLEDS);
    }
    if (hasFrontSwivel() ||
        hasFrontTilt() ||
        hasRearSwivel() ||
        hasRearTilt()) {
      output.add(asSetSwivels);
    }
    return output;
  }
}

extension on RelayStateMessage {
  RelaysData toRelayProto() => RelaysData(
    frontLeftMotor: frontLeftMotor.boolState,
    frontRightMotor: frontRightMotor.boolState,
    backLeftMotor: backLeftMotor.boolState,
    backRightMotor: backRightMotor.boolState,
    arm: arm.boolState,
    drive: drive.boolState,
    science: science.boolState,
  );
}

extension on RelaysCommand {
  DBCMessage get asSetState => RelaySetStateMessage(
    updateArm: hasArm().intValue,
    arm: arm.intValue,
    updateFrontLeftMotor: hasFrontLeftMotor().intValue,
    frontLeftMotor: frontLeftMotor.intValue,
    updateFrontRightMotor: hasFrontRightMotor().intValue,
    frontRightMotor: frontRightMotor.intValue,
    updateBackLeftMotor: hasBackLeftMotor().intValue,
    backLeftMotor: backLeftMotor.intValue,
    updateBackRightMotor: hasBackRightMotor().intValue,
    backRightMotor: backRightMotor.intValue,
    updateDrive: hasDrive().intValue,
    drive: drive.intValue,
    updateScience: hasScience().intValue,
    science: science.intValue,
  );

  List<DBCMessage> toDBC() => [asSetState];
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

  StreamSubscription<CanFrame>? _frameSubscription;
  StreamSubscription<DriveCommand>? _driveSubscription;
  StreamSubscription<RelaysCommand>? _relaySubscription;

  @override
  Future<bool> init() async {
    if (Platform.isWindows) {
      return true;
    }
    await Process.run("sudo", ["ip", "link", "set", "can0", "down"]);
    await Process.run("sudo", [
      "ip",
      "link",
      "set",
      "can0",
      "up",
      "type",
      "can",
      "bitrate",
      "500000",
    ]);
    device = LinuxCan.instance.devices.singleWhere(
      (device) => device.networkInterface.name == "can0",
    );
    if (!device!.isUp) {
      logger.error("CAN0 is not up", body: "Device state: ${device!.state}");
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

    _driveSubscription = collection.server.messages.onMessage(
      name: DriveCommand().messageName,
      constructor: DriveCommand.fromBuffer,
      callback: sendDriveCommand,
    );

    _relaySubscription = collection.server.messages.onMessage(
      name: RelaysCommand().messageName,
      constructor: RelaysCommand.fromBuffer,
      callback: sendRelaysCommand,
    );

    return true;
  }

  @override
  Future<void> dispose() async {
    _sendHeartbeatTimer?.cancel();
    _checkHeartbeatsTimer?.cancel();

    await socket?.close();
    socket = null;

    await _driveSubscription?.cancel();
    await _relaySubscription?.cancel();
    await _frameSubscription?.cancel();

    deviceHeartbeats.clear();
  }

  bool _deviceConnected(Device device) => deviceHeartbeats.containsKey(device);

  /// Sends a drive command over the CAN bus
  ///
  /// If [override] is set to false, the command will only be sent if the rover
  /// has received heartbeats from the drive device. The [override] should only
  /// be true if this is a stop command.
  Future<void> sendDriveCommand(
    DriveCommand command, {
    bool override = false,
  }) async {
    if (!_deviceConnected(Device.DRIVE) && !override) {
      return;
    }
    return Future.forEach(command.toDBC(), sendDBCMessage);
  }

  /// Sends a relay command over the CAN bus
  ///
  /// If [override] is set to false, the command will only be sent if the rover
  /// has received heartbeats from the relay device. The [override] should only
  /// be true if this is a stop command.
  Future<void> sendRelaysCommand(
    RelaysCommand command, {
    bool override = false,
  }) async {
    if (!_deviceConnected(Device.RELAY) && !override) {
      return;
    }
    return Future.forEach(command.toDBC(), sendDBCMessage);
  }

  /// Sends a message's DBC equivalent over the CAN bus
  Future<void> send(Message message) async {
    if (message is DriveCommand) {
      return sendDriveCommand(message);
    } else if (message is RelaysCommand) {
      return sendRelaysCommand(message);
    }
  }

  /// Sends a heartbeat message over the CAN bus
  Future<void> sendHeartbeat() {
    final heartbeat = RoverHeartbeatMessage();
    return sendDBCMessage(heartbeat);
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
  Future<void> sendDBCMessage(DBCMessage message) async {
    if (socket == null) {
      return;
    }
    if (!(device?.isUp ?? false)) {
      logger.warning(
        "Device is not up while trying to send message, restarting CAN socket",
      );
      await dispose();
      await Future<void>.delayed(const Duration(milliseconds: 1000));
      await init();
      return;
    }
    return socket
        ?.send(
          CanFrame.standard(id: message.canId, data: message.writeToBuffer()),
        )
        .catchError((Object e) async {
          if (e.toString().contains("No buffer space")) {
            logger.debug("Error when sending CAN message", body: e.toString());
          } else {
            logger.error("Error when sending CAN message", body: e.toString());
          }

          if (!(device?.isUp ?? false)) {
            await dispose();
            await init();
          }
        });
  }

  void _handleDeviceBroadcast(DeviceBroadcastMessage broadcast) {
    final device = Device.valueOf(broadcast.deviceName.toInt());
    if (device == null) {
      logger.warning(
        "Unknown Device Number",
        body: "Received broadcast from device ${broadcast.deviceName.toInt()}",
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
    switch (frame) {
      case CanDataFrame(:final id, :final data):
        if (id == DeviceBroadcastMessage().canId) {
          _handleDeviceBroadcast(DeviceBroadcastMessage.fromBuffer(data));
        } else if (id == DriveAppliedOutputMessage().canId) {
          collection.server.sendMessage(
            DriveAppliedOutputMessage.fromBuffer(data).toDriveProto(),
          );
        } else if (id == DriveBatteryMessage().canId) {
          collection.server.sendMessage(
            DriveBatteryMessage.fromBuffer(data).toDriveProto(),
          );
        } else if (id == DriveLedMessage().canId) {
          collection.server.sendMessage(
            DriveLedMessage.fromBuffer(data).toDriveProto(),
          );
        } else if (id == DriveSwivelMessage().canId) {
          collection.server.sendMessage(
            DriveSwivelMessage.fromBuffer(data).toDriveProto(),
          );
        } else if (id == RelayStateMessage().canId) {
          collection.server.sendMessage(
            RelayStateMessage.fromBuffer(data).toRelayProto(),
          );
        }
      case CanRemoteFrame _:
        break;
    }
  }
}
