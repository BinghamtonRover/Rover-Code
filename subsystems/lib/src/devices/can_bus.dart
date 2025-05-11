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

  BoolState get armBoolState {
    if (this == 1) {
      return BoolState.YES;
    } else if (this == 2) {
      return BoolState.NO;
    }
    return BoolState.BOOL_UNDEFINED;
  }
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

  Message toArmProto() => ArmData(version: version);

  Message toGripperProto() => GripperData(version: version);

  Message toScienceProto() => ScienceData(version: version);

  Message? toProtoMessage() {
    if (deviceValue.toInt() == Device.DRIVE.value) {
      return toDriveProto();
    } else if (deviceValue.toInt() == Device.RELAY.value) {
      return toRelayProto();
    } else if (deviceValue.toInt() == Device.ARM.value) {
      return toArmProto();
    } else if (deviceValue.toInt() == Device.GRIPPER.value) {
      return toGripperProto();
    } else if (deviceValue.toInt() == Device.SCIENCE.value) {
      return toScienceProto();
    }
    return null;
  }

  Version get version =>
      Version(major: fwVersionMajor.toInt(), minor: fwVersionMinor.toInt());
}

extension on DriveAppliedOutputDataMessage {
  DriveData toDriveProto() => DriveData(
    throttle: throttle.toDouble(),
    left: leftSpeed.toDouble(),
    right: rightSpeed.toDouble(),
    setLeft: true,
    setRight: true,
    setThrottle: true,
  );
}

extension on DriveBatteryDataMessage {
  DriveData toDriveProto() => DriveData(
    batteryVoltage: voltage.toDouble(),
    batteryTemperature: temperature.toDouble(),
    batteryCurrent: current.toDouble(),
  );
}

extension on DriveLedDataMessage {
  DriveData toDriveProto() =>
      DriveData(color: ProtoColor.valueOf(color.toInt()));
}

extension on DriveSwivelDataMessage {
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

extension on RelayStateDataMessage {
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

extension on ArmMotorMoveDataMessage {
  MotorData toMotorData() => MotorData(
    isMoving: isMoving.armBoolState,
    isLimitSwitchPressed: isLimitSwitchPressed.armBoolState,
    direction: MotorDirection.valueOf(motorDirection.toInt()),
  );

  ArmData toArmProto() {
    final data = ArmData();

    if (motorValue == ArmMotor.SWIVEL.value) {
      data.base = toMotorData();
    } else if (motorValue == ArmMotor.SHOULDER.value) {
      data.shoulder = toMotorData();
    } else if (motorValue == ArmMotor.ELBOW.value) {
      data.elbow = toMotorData();
    }

    return data;
  }
}

extension on ArmMotorStepDataMessage {
  MotorData toMotorData() => MotorData(
    currentStep: currentStep.toInt(),
    targetStep: targetStep.toInt(),
  );

  ArmData toArmProto() {
    final data = ArmData();

    if (motorValue == ArmMotor.SWIVEL.value) {
      data.base = toMotorData();
    } else if (motorValue == ArmMotor.SHOULDER.value) {
      data.shoulder = toMotorData();
    } else if (motorValue == ArmMotor.ELBOW.value) {
      data.elbow = toMotorData();
    }

    return data;
  }
}

extension on ArmMotorAngleDataMessage {
  MotorData toMotorData() => MotorData(
    currentAngle: currentAngle.toDouble(),
    targetAngle: targetAngle.toDouble(),
  );

  ArmData toArmProto() {
    final data = ArmData();

    if (motorValue == ArmMotor.SWIVEL.value) {
      data.base = toMotorData();
    } else if (motorValue == ArmMotor.SHOULDER.value) {
      data.shoulder = toMotorData();
    } else if (motorValue == ArmMotor.ELBOW.value) {
      data.elbow = toMotorData();
    }

    return data;
  }
}

extension on ArmCommand {
  DBCMessage asAsSetSwivel() => ArmSetMotorMessage(
    motorValue: ArmMotor.SWIVEL.value,
    angle: swivel.angle,
    moveRadians: swivel.moveRadians,
    moveSteps: swivel.moveSteps,
  );

  DBCMessage asAsSetShoulder() => ArmSetMotorMessage(
    motorValue: ArmMotor.SHOULDER.value,
    angle: shoulder.angle,
    moveRadians: shoulder.moveRadians,
    moveSteps: shoulder.moveSteps,
  );

  DBCMessage asAsSetElbow() => ArmSetMotorMessage(
    motorValue: ArmMotor.ELBOW.value,
    angle: elbow.angle,
    moveRadians: elbow.moveRadians,
    moveSteps: elbow.moveSteps,
  );

  DBCMessage asSystemAction() => ArmSetSystemActionMessage(
    stop: stop.intValue,
    calibrate: calibrate.intValue,
    jab: jab.intValue,
  );

  List<DBCMessage> toDBC() {
    final output = <DBCMessage>[];

    if (hasSwivel()) {
      output.add(asAsSetSwivel());
    }
    if (hasShoulder()) {
      output.add(asAsSetShoulder());
    }
    if (hasElbow()) {
      output.add(asAsSetElbow());
    }

    if (stop == true || calibrate == true || jab == true) {
      output.add(asSystemAction());
    }

    return output;
  }
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
  StreamSubscription<ArmCommand>? _armSubscription;
  StreamSubscription<GripperCommand>? _gripperSubscription;
  StreamSubscription<ScienceCommand>? _scienceSubscription;

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

    _armSubscription = collection.server.messages.onMessage(
      name: ArmCommand().messageName,
      constructor: ArmCommand.fromBuffer,
      callback: sendArmCommand,
    );

    _gripperSubscription = collection.server.messages.onMessage(
      name: GripperCommand().messageName,
      constructor: GripperCommand.fromBuffer,
      callback: sendGripperCommand,
    );

    _scienceSubscription = collection.server.messages.onMessage(
      name: ScienceCommand().messageName,
      constructor: ScienceCommand.fromBuffer,
      callback: sendScienceCommand,
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
    await _armSubscription?.cancel();
    await _gripperSubscription?.cancel();
    await _scienceSubscription?.cancel();
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

  /// Sends an arm command over the CAN bus
  ///
  /// If [override] is set to false, the command will only be sent if the rover
  /// has received heartbeats from the arm device. The [override] should only
  /// be true if this is a stop command.
  Future<void> sendArmCommand(
    ArmCommand command, {
    bool override = false,
  }) async {
    if (!_deviceConnected(Device.ARM) && !override) {
      return;
    }
    return Future.forEach(command.toDBC(), sendDBCMessage);
  }

  /// Sends a gripper command over the CAN bus
  ///
  /// If [override] is set to false, the command will only be sent if the rover
  /// has received heartbeats from the gripper device. The [override] should only
  /// be true if this is a stop command.
  Future<void> sendGripperCommand(
    GripperCommand command, {
    bool override = false,
  }) async {
    if (!_deviceConnected(Device.GRIPPER) && !override) {
      return;
    }
  }

  /// Sends a science command over the CAN bus
  ///
  /// If [override] is set to false, the command will only be sent if the rover
  /// has received heartbeats from the science device. The [override] should only
  /// be true if this is a stop command.
  Future<void> sendScienceCommand(
    ScienceCommand command, {
    bool override = false,
  }) async {
    if (!_deviceConnected(Device.SCIENCE) && !override) {
      return;
    }
  }

  /// Sends a message's DBC equivalent over the CAN bus
  Future<void> send(Message message) async {
    if (message is DriveCommand) {
      return sendDriveCommand(message);
    } else if (message is RelaysCommand) {
      return sendRelaysCommand(message);
    } else if (message is ArmCommand) {
      return sendArmCommand(message);
    } else if (message is GripperCommand) {
      return sendGripperCommand(message);
    } else if (message is ScienceCommand) {
      return sendScienceCommand(message);
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
        ?.send(CanFrame.standard(id: message.canId, data: message.encode()))
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
    final device = Device.valueOf(broadcast.deviceValue.toInt());
    if (device == null) {
      logger.warning(
        "Unknown Device Number",
        body: "Received broadcast from device ${broadcast.deviceValue.toInt()}",
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
          _handleDeviceBroadcast(DeviceBroadcastMessage.decode(data));
        } else if (id == DriveAppliedOutputDataMessage().canId) {
          collection.server.sendMessage(
            DriveAppliedOutputDataMessage.decode(data).toDriveProto(),
          );
        } else if (id == DriveBatteryDataMessage().canId) {
          collection.server.sendMessage(
            DriveBatteryDataMessage.decode(data).toDriveProto(),
          );
        } else if (id == DriveLedDataMessage().canId) {
          collection.server.sendMessage(
            DriveLedDataMessage.decode(data).toDriveProto(),
          );
        } else if (id == DriveSwivelDataMessage().canId) {
          collection.server.sendMessage(
            DriveSwivelDataMessage.decode(data).toDriveProto(),
          );
        } else if (id == RelayStateDataMessage().canId) {
          collection.server.sendMessage(
            RelayStateDataMessage.decode(data).toRelayProto(),
          );
        } else if (id == ArmMotorMoveDataMessage().canId) {
          collection.server.sendMessage(
            ArmMotorMoveDataMessage.decode(data).toArmProto(),
          );
        } else if (id == ArmMotorStepDataMessage().canId) {
          collection.server.sendMessage(
            ArmMotorStepDataMessage.decode(data).toArmProto(),
          );
        } else if (id == ArmMotorAngleDataMessage().canId) {
          collection.server.sendMessage(
            ArmMotorAngleDataMessage.decode(data).toArmProto(),
          );
        }
      case CanRemoteFrame _:
        break;
    }
  }
}
