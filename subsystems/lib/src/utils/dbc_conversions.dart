import "package:burt_network/protobuf.dart";
import "package:dart_dbc_generator/dart_dbc_generator.dart";
import "package:subsystems/src/generated/rover_messages.dbc.dart";

/// Utility extension to convert a boolean to an integer
extension BoolToInt on bool {
  /// The booleant's integer value, where 1 represents true, and 0 represents false
  int get intValue => this ? 1 : 0;
}

/// Utility extension to convert a [BoolState] into an integer
extension BoolStateToInt on BoolState {
  /// The integer value of the [BoolState], where 1 represents [BoolState.YES],
  /// and 0 represents [BoolState.NO]. If the bool state is [BoolState.BOOL_UNDEFINED],
  /// it is assumed to be false.
  int get intValue => this == BoolState.YES ? 1 : 0;
}

/// Utility extension to convert a [DriveAppliedOutputDataMessage] into a [DriveData] message
extension DriveAppliedOutputToProto on DriveAppliedOutputDataMessage {
  /// The applied output DBC message as a [DriveData] message
  DriveData toDriveProto() => DriveData(
    throttle: throttle,
    left: leftSpeed,
    right: rightSpeed,
    setLeft: true,
    setRight: true,
    setThrottle: true,
  );
}

/// Utility extension to convert a [DriveBatteryDataMessage] into a [DriveData] message
extension DriveBatteryToProto on DriveBatteryDataMessage {
  /// The battery DBC message as a [DriveData] message
  DriveData toDriveProto() => DriveData(
    batteryVoltage: voltage,
    batteryTemperature: temperature,
    batteryCurrent: current,
  );
}

/// Utility extension to convert a [DriveLedDataMessage] into a [DriveData] message
extension DriveLedToProto on DriveLedDataMessage {
  /// The led DBC message as a [DriveData] message
  DriveData toDriveProto() =>
      DriveData(color: ProtoColor.valueOf(color));
}

/// Utility extension to convert a [DriveSwivelDataMessage] into a [DriveData] message
extension DriveSwivelToProto on DriveSwivelDataMessage {
  /// The swivel DBC message as a [DriveData] message
  DriveData toDriveProto() => DriveData(
    frontSwivel: frontSwivel,
    frontTilt: frontTilt,
    rearSwivel: rearSwivel,
    rearTilt: rearTilt,
  );
}

/// Utility extension to convert a [DriveMotorDataMessage] into a [DriveData] message
extension DriveMotorToProto on DriveMotorDataMessage {
  /// The drive motor data as a [DriveMotorData] message
  DriveMotorData toMotorData() => DriveMotorData(
    speed: speed,
    current: current,
    temperature: temperature,
    error: MotorErrorCode.valueOf(errorCode),
  );

  /// The drive motor data as a [DriveData] message
  DriveData toDriveProto() {
    final data = DriveData();
    final motorData = toMotorData();

    if (motorValue == DriveMotor.FRONT_LEFT.value) {
      data.frontLeftMotor = motorData;
    } else if (motorValue == DriveMotor.MIDDLE_LEFT.value) {
      data.middleLeftMotor = motorData;
    } else if (motorValue == DriveMotor.BACK_LEFT.value) {
      data.backLeftMotor = motorData;
    } else if (motorValue == DriveMotor.FRONT_RIGHT.value) {
      data.frontRightMotor = motorData;
    } else if (motorValue == DriveMotor.MIDDLE_RIGHT.value) {
      data.middleRightMotor = motorData;
    } else if (motorValue == DriveMotor.BACK_RIGHT.value) {
      data.backRightMotor = motorData;
    }

    return data;
  }
}

/// Utility extension to convert a [DriveCommand] message into its respective [DBCMessage]
extension DriveCommandToDBC on DriveCommand {
  /// The drive command as a [DriveSetSpeedsMessage] DBC message
  DBCMessage asSetSpeeds() => DriveSetSpeedsMessage(
    shouldSetLeft: setLeft.intValue,
    shouldSetRight: setRight.intValue,
    shouldSetThrottle: setThrottle.intValue,
    leftSpeed: left,
    rightSpeed: right,
    throttle: throttle,
  );

  /// The drive command as a [DriveSetLedMessage] DBC message
  DBCMessage asSetLEDS() =>
      DriveSetLedMessage(color: color.value, blink: blink.intValue);

  /// The drive command as a [DriveSetSwivelMessage] DBC message
  DBCMessage asSetSwivels() => DriveSetSwivelMessage(
    setFrontSwivel: hasFrontSwivel().intValue,
    setFrontTilt: hasFrontTilt().intValue,
    setRearSwivel: hasRearSwivel().intValue,
    setRearTilt: hasRearTilt().intValue,
    frontSwivel: frontSwivel,
    frontTilt: frontTilt,
    rearSwivel: rearSwivel,
    rearTilt: rearTilt,
  );

  /// The drive command as its respective [DBCMessage] messages
  List<DBCMessage> toDBC() => [
    if (setLeft || setRight || setThrottle) asSetSpeeds(),
    if (hasColor() || hasBlink()) asSetLEDS(),
    if (hasFrontSwivel() || hasFrontTilt() || hasRearSwivel() || hasRearTilt())
      asSetSwivels(),
  ];
}

/// Utility extension to convert a [RelayStateDataMessage] to a
extension RelayStateToProto on RelayStateDataMessage {
  BoolState _intToBoolState(num value) =>
      value == 1 ? BoolState.YES : BoolState.NO;

  /// The relay state DBC message as a [RelaysData] message
  RelaysData toRelayProto() => RelaysData(
    frontLeftMotor: _intToBoolState(frontLeftMotor),
    frontRightMotor: _intToBoolState(frontRightMotor),
    backLeftMotor: _intToBoolState(backLeftMotor),
    backRightMotor: _intToBoolState(backRightMotor),
    arm: _intToBoolState(arm),
    drive: _intToBoolState(drive),
    science: _intToBoolState(science),
  );
}

/// Utility extension to convert a [RelaysCommand] command into its respective [DBCMessage]
extension RelaysCommandToDBC on RelaysCommand {
  /// The relays command as a [RelaySetStateMessage] DBC message
  DBCMessage asSetState() => RelaySetStateMessage(
    arm: arm.value,
    frontLeftMotor: frontLeftMotor.value,
    frontRightMotor: frontRightMotor.value,
    backLeftMotor: backLeftMotor.value,
    backRightMotor: backRightMotor.value,
    drive: drive.value,
    science: science.value,
  );

  /// The relays command as its respective [DBCMessage] messages
  List<DBCMessage> toDBC() => [asSetState()];
}

/// Utility extension to convert an [ArmMotorMoveDataMessage] into a [ArmData] message
extension ArmMotorMoveToProto on ArmMotorMoveDataMessage {
  /// The arm motor move data as a [MotorData] message
  MotorData toMotorData() => MotorData(
    isMoving: BoolState.valueOf(isMoving),
    isLimitSwitchPressed: BoolState.valueOf(isLimitSwitchPressed),
    direction: MotorDirection.valueOf(motorDirection),
  );

  /// The arm motor move data as an [ArmData] message
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

/// Utility extension to convert a [ArmMotorStepDataMessage] into a [DriveData] message
extension ArmMotorStepToProto on ArmMotorStepDataMessage {
  /// The motor steps DBC message as a [MotorData] message
  MotorData toMotorData() => MotorData(
    currentStep: currentStep,
    targetStep: targetStep,
  );

  /// The motor steps DBC message as a [MotorData] message
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

/// Utility extension to convert a [ArmMotorAngleDataMessage] into a [ArmMotor] message
extension ArmMotorAngleToProto on ArmMotorAngleDataMessage {
  /// The motor angle DBC message as a [MotorData] message
  MotorData toMotorData() => MotorData(
    currentAngle: currentAngle,
    targetAngle: targetAngle,
  );

  /// The motor angle DBC message as an [ArmData] message
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

/// Utility extension to convert a [ArmCommand] message into its respective [DBCMessage] equivalents
extension ArmCommandToDBC on ArmCommand {
  /// The arm command as a [ArmSetMotorMessage] DBC message
  DBCMessage asSetSwivel() => ArmSetMotorMessage(
    motorValue: ArmMotor.SWIVEL.value,
    angle: swivel.angle,
    moveRadians: swivel.moveRadians,
    moveSteps: swivel.moveSteps,
  );

  /// The arm command as a [ArmSetMotorMessage] DBC message for the shoulder
  DBCMessage asSetShoulder() => ArmSetMotorMessage(
    motorValue: ArmMotor.SHOULDER.value,
    angle: shoulder.angle,
    moveRadians: shoulder.moveRadians,
    moveSteps: shoulder.moveSteps,
  );

  /// The arm command as a [ArmSetMotorMessage] DBC message for the elbow
  DBCMessage asSetElbow() => ArmSetMotorMessage(
    motorValue: ArmMotor.ELBOW.value,
    angle: elbow.angle,
    moveRadians: elbow.moveRadians,
    moveSteps: elbow.moveSteps,
  );

  /// The arm command as a [ArmSetSystemActionMessage] DBC message
  DBCMessage asSystemAction() => ArmSetSystemActionMessage(
    stop: stop.intValue,
    calibrate: calibrate.intValue,
    jab: jab.intValue,
  );

  /// The arm command as its respective [DBCMessage] messages
  List<DBCMessage> toDBC() => [
    if (hasSwivel()) asSetSwivel(),
    if (hasShoulder()) asSetShoulder(),
    if (hasElbow()) asSetElbow(),
    if (hasStop() || hasCalibrate() || hasJab()) asSystemAction(),
  ];
}
