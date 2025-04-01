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

extension on DriveCommand {
  DBCMessage get asSetSpeeds => DriveSetSpeedsMessage(
        shouldSetLeft: setLeft.intValue,
        shouldSetRight: setRight.intValue,
        shouldSetThrottle: setThrottle.intValue,
        leftSpeed: left,
        rightSpeed: right,
        throttle: throttle,
      );

  DBCMessage get asSetLEDS => DriveSetLedMessage(
        color: color.value,
        blink: blink.intValue,
      );

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
        updateFrontLeftMotor: hasFrontLeftMotor().intValue,
        updateFrontRightMotor: hasFrontRightMotor().intValue,
        updateBackLeftMotor: hasBackLeftMotor().intValue,
        updateBackRightMotor: hasBackRightMotor().intValue,
      );

  List<DBCMessage> toDBC() => [asSetState];
}

/// A service to forward messages between CAN and UDP
class CanBus extends Service {
  /// How often to send a rover heartbeat over the CAN bus
  static const Duration heartbeatPeriod = Duration(milliseconds: 100);

  /// The maximum time the program should wait for a device's heartbeat before
  /// it's considered disconnected
  static const Duration heartbeatTimeout = Duration(milliseconds: 500);

  /// A map of devices and the last time their broadcast message was received
  final Map<Device, DateTime> deviceHeartbeats = {};

  /// The CAN socket for the CAN bus
  CanSocket? socket;
  Timer? _heartbeatTimer;

  StreamSubscription<CanFrame>? _frameSubscription;

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
    final canDevice = LinuxCan.instance.devices.singleWhere(
      (device) => device.networkInterface.name == "can0",
    );
    if (!canDevice.isUp) {
      logger.error(
        "CAN0 is not up",
        body: "Device state: ${canDevice.state}",
      );
      return false;
    }
    socket = canDevice.open();
    _frameSubscription = socket!.receive().listen(_onCanFrame);
    _heartbeatTimer = Timer.periodic(heartbeatPeriod, (_) => sendHeartbeat());

    return true;
  }

  @override
  Future<void> dispose() async {
    await _frameSubscription?.cancel();
    await socket?.close();
    _heartbeatTimer?.cancel();
  }

  /// Sends a message's DBC equivalent over the CAN bus
  void send(Message message) {
    if (message is DriveCommand) {
      message.toDBC().forEach(sendDBCMessage);
    } else if (message is RelaysCommand) {
      message.toDBC().forEach(sendDBCMessage);
    }
  }

  /// Sends a heartbeat message over the CAN bus
  void sendHeartbeat() {
    final heartbeat = RoverHeartbeatMessage();
    sendDBCMessage(heartbeat);

    final now = DateTime.timestamp();
    deviceHeartbeats.removeWhere((device, time) {
      if (now.difference(time) > heartbeatTimeout) {
        logger.warning(
          "${device.name} disconnected.",
          body: "Broadcast message not received after $heartbeatTimeout",
        );
        return true;
      }
      return false;
    });
  }

  /// Sends a DBC message over the CAN bus
  void sendDBCMessage(DBCMessage message) {
    try {
      socket?.send(
        CanFrame.standard(
          id: message.canId,
          data: message.writeToBuffer(),
        ),
      );
    } catch (e) {
      logger.error("Error when sending CAN message", body: e.toString());
    }
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
