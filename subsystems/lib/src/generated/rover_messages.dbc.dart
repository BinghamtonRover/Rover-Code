// AUTO GENERATED FILE, DO NOT MODIFY

// ignore_for_file: type=lint
// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:math' as $_math;
import 'dart:typed_data' as $_typed;

import 'package:dart_dbc_generator/dart_dbc_generator.dart' as $_dbc;

class RoverHeartbeatMessage extends $_dbc.DBCMessage {
  @override
  String messageName = 'Rover_Heartbeat';

  @override
  int messageLength = 1;

  @override
  int canId = 0x0;

  /// Whether or not "Rover_Heartbeat" is multiplex
  static const bool isMultiplex = false;

  /// The multiplexor for "Rover_Heartbeat"
  static const String multiplexor = '';

  /// Value of signal "Rover_Status"
  num roverStatus;

  final $_dbc.DBCSignal _roverStatusSignal = $_dbc.DBCSignal(
    name: 'Rover_Status',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 0,
    length: 4,
    mapping: [1, 2, 4, 8, 0, 0, 0, 0],
    mappingIndexes: [0, 1, 2, 3],
    factor: 1,
    offset: 0,
    min: 0,
    max: 5,
    unit: '',
  );

  @override
  List<$_dbc.DBCSignal> get signals => [
    _roverStatusSignal,
  ];

  RoverHeartbeatMessage({
    this.roverStatus = 0,
  });

  /// Creates a clone of this [RoverHeartbeatMessage] with the non-null values replaced
  RoverHeartbeatMessage copyWith({
    num? roverStatus,
  }) => RoverHeartbeatMessage(
    roverStatus: roverStatus ?? this.roverStatus,
  );

  factory RoverHeartbeatMessage.decode(List<int> payload) {
    final message = RoverHeartbeatMessage();
    final typedBuffer = $_typed.Uint8List.fromList(payload);
    final bitField = $_dbc.BitField.from(typedBuffer.sublist(0, message.messageLength));

    message.roverStatus =
        message._roverStatusSignal.decode(bitField) ??
        $_math.max(0, message._roverStatusSignal.min);

    return message;
  }

  factory RoverHeartbeatMessage.fromJson(Map<String, dynamic> json) =>
      RoverHeartbeatMessage(
        roverStatus: json['Rover_Status'] ?? 0,
      );

  @override
  $_typed.Uint8List encode() {
    final Map<$_dbc.DBCSignal, num> values = {
      _roverStatusSignal: roverStatus,
    };

    return encodeWithValues(values);
  }

  @override
  Map<String, dynamic> toJson() => {
    'Rover_Status': roverStatus,
  };

  @override
  String toString() {
    return 'Rover_Heartbeat(\n  Rover_Status=$roverStatus\n)';
  }
}

class DeviceBroadcastMessage extends $_dbc.DBCMessage {
  @override
  String messageName = 'Device_Broadcast';

  @override
  int messageLength = 2;

  @override
  int canId = 0x1;

  /// Whether or not "Device_Broadcast" is multiplex
  static const bool isMultiplex = false;

  /// The multiplexor for "Device_Broadcast"
  static const String multiplexor = '';

  /// Value of signal "Device_Value"
  num deviceValue;

  /// Value of signal "FW_Version_Major"
  num fwVersionMajor;

  /// Value of signal "FW_Version_Minor"
  num fwVersionMinor;

  final $_dbc.DBCSignal _deviceValueSignal = $_dbc.DBCSignal(
    name: 'Device_Value',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 0,
    length: 5,
    mapping: [1, 2, 4, 8, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [0, 1, 2, 3, 4],
    factor: 1,
    offset: 0,
    min: 0,
    max: 15,
    unit: '',
  );

  final $_dbc.DBCSignal _fwVersionMajorSignal = $_dbc.DBCSignal(
    name: 'FW_Version_Major',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 5,
    length: 4,
    mapping: [0, 0, 0, 0, 0, 1, 2, 4, 8, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [5, 6, 7, 8],
    factor: 1,
    offset: 0,
    min: 0,
    max: 8,
    unit: '',
  );

  final $_dbc.DBCSignal _fwVersionMinorSignal = $_dbc.DBCSignal(
    name: 'FW_Version_Minor',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 9,
    length: 4,
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 8, 0, 0, 0],
    mappingIndexes: [9, 10, 11, 12],
    factor: 1,
    offset: 0,
    min: 0,
    max: 8,
    unit: '',
  );

  @override
  List<$_dbc.DBCSignal> get signals => [
    _deviceValueSignal,
    _fwVersionMajorSignal,
    _fwVersionMinorSignal,
  ];

  DeviceBroadcastMessage({
    this.deviceValue = 0,
    this.fwVersionMajor = 0,
    this.fwVersionMinor = 0,
  });

  /// Creates a clone of this [DeviceBroadcastMessage] with the non-null values replaced
  DeviceBroadcastMessage copyWith({
    num? deviceValue,
    num? fwVersionMajor,
    num? fwVersionMinor,
  }) => DeviceBroadcastMessage(
    deviceValue: deviceValue ?? this.deviceValue,
    fwVersionMajor: fwVersionMajor ?? this.fwVersionMajor,
    fwVersionMinor: fwVersionMinor ?? this.fwVersionMinor,
  );

  factory DeviceBroadcastMessage.decode(List<int> payload) {
    final message = DeviceBroadcastMessage();
    final typedBuffer = $_typed.Uint8List.fromList(payload);
    final bitField = $_dbc.BitField.from(typedBuffer.sublist(0, message.messageLength));

    message.deviceValue =
        message._deviceValueSignal.decode(bitField) ??
        $_math.max(0, message._deviceValueSignal.min);
    message.fwVersionMajor =
        message._fwVersionMajorSignal.decode(bitField) ??
        $_math.max(0, message._fwVersionMajorSignal.min);
    message.fwVersionMinor =
        message._fwVersionMinorSignal.decode(bitField) ??
        $_math.max(0, message._fwVersionMinorSignal.min);

    return message;
  }

  factory DeviceBroadcastMessage.fromJson(Map<String, dynamic> json) =>
      DeviceBroadcastMessage(
        deviceValue: json['Device_Value'] ?? 0,
        fwVersionMajor: json['FW_Version_Major'] ?? 0,
        fwVersionMinor: json['FW_Version_Minor'] ?? 0,
      );

  @override
  $_typed.Uint8List encode() {
    final Map<$_dbc.DBCSignal, num> values = {
      _deviceValueSignal: deviceValue,
      _fwVersionMajorSignal: fwVersionMajor,
      _fwVersionMinorSignal: fwVersionMinor,
    };

    return encodeWithValues(values);
  }

  @override
  Map<String, dynamic> toJson() => {
    'Device_Value': deviceValue,
    'FW_Version_Major': fwVersionMajor,
    'FW_Version_Minor': fwVersionMinor,
  };

  @override
  String toString() {
    return 'Device_Broadcast(\n  Device_Value=$deviceValue\n  FW_Version_Major=$fwVersionMajor\n  FW_Version_Minor=$fwVersionMinor\n)';
  }
}

class DriveSetSpeedsMessage extends $_dbc.DBCMessage {
  @override
  String messageName = 'Drive_Set_Speeds';

  @override
  int messageLength = 7;

  @override
  int canId = 0x10;

  /// Whether or not "Drive_Set_Speeds" is multiplex
  static const bool isMultiplex = false;

  /// The multiplexor for "Drive_Set_Speeds"
  static const String multiplexor = '';

  /// Value of signal "Should_Set_Left"
  num shouldSetLeft;

  /// Value of signal "Should_Set_Right"
  num shouldSetRight;

  /// Value of signal "Should_Set_Throttle"
  num shouldSetThrottle;

  /// Value of signal "Left_Speed"
  num leftSpeed;

  /// Value of signal "Right_Speed"
  num rightSpeed;

  /// Value of signal "Throttle"
  num throttle;

  final $_dbc.DBCSignal _shouldSetLeftSignal = $_dbc.DBCSignal(
    name: 'Should_Set_Left',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 0,
    length: 1,
    mapping: [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [0],
    factor: 1,
    offset: 0,
    min: 0,
    max: 1,
    unit: '',
  );

  final $_dbc.DBCSignal _shouldSetRightSignal = $_dbc.DBCSignal(
    name: 'Should_Set_Right',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 1,
    length: 1,
    mapping: [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [1],
    factor: 1,
    offset: 0,
    min: 0,
    max: 1,
    unit: '',
  );

  final $_dbc.DBCSignal _shouldSetThrottleSignal = $_dbc.DBCSignal(
    name: 'Should_Set_Throttle',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 2,
    length: 1,
    mapping: [0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [2],
    factor: 1,
    offset: 0,
    min: 0,
    max: 1,
    unit: '',
  );

  final $_dbc.DBCSignal _leftSpeedSignal = $_dbc.DBCSignal(
    name: 'Left_Speed',
    signalSignedness: $_dbc.DBCSignalSignedness.SIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 3,
    length: 16,
    mapping: [0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18],
    factor: 0.000062,
    offset: 0,
    min: -1,
    max: 1,
    unit: '',
  );

  final $_dbc.DBCSignal _rightSpeedSignal = $_dbc.DBCSignal(
    name: 'Right_Speed',
    signalSignedness: $_dbc.DBCSignalSignedness.SIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 19,
    length: 16,
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34],
    factor: 0.000062,
    offset: 0,
    min: -1,
    max: 1,
    unit: '',
  );

  final $_dbc.DBCSignal _throttleSignal = $_dbc.DBCSignal(
    name: 'Throttle',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 35,
    length: 16,
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 0, 0, 0, 0, 0],
    mappingIndexes: [35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50],
    factor: 0.000016,
    offset: 0,
    min: 0,
    max: 1,
    unit: '',
  );

  @override
  List<$_dbc.DBCSignal> get signals => [
    _shouldSetLeftSignal,
    _shouldSetRightSignal,
    _shouldSetThrottleSignal,
    _leftSpeedSignal,
    _rightSpeedSignal,
    _throttleSignal,
  ];

  DriveSetSpeedsMessage({
    this.shouldSetLeft = 0,
    this.shouldSetRight = 0,
    this.shouldSetThrottle = 0,
    this.leftSpeed = 0,
    this.rightSpeed = 0,
    this.throttle = 0,
  });

  /// Creates a clone of this [DriveSetSpeedsMessage] with the non-null values replaced
  DriveSetSpeedsMessage copyWith({
    num? shouldSetLeft,
    num? shouldSetRight,
    num? shouldSetThrottle,
    num? leftSpeed,
    num? rightSpeed,
    num? throttle,
  }) => DriveSetSpeedsMessage(
    shouldSetLeft: shouldSetLeft ?? this.shouldSetLeft,
    shouldSetRight: shouldSetRight ?? this.shouldSetRight,
    shouldSetThrottle: shouldSetThrottle ?? this.shouldSetThrottle,
    leftSpeed: leftSpeed ?? this.leftSpeed,
    rightSpeed: rightSpeed ?? this.rightSpeed,
    throttle: throttle ?? this.throttle,
  );

  factory DriveSetSpeedsMessage.decode(List<int> payload) {
    final message = DriveSetSpeedsMessage();
    final typedBuffer = $_typed.Uint8List.fromList(payload);
    final bitField = $_dbc.BitField.from(typedBuffer.sublist(0, message.messageLength));

    message.shouldSetLeft =
        message._shouldSetLeftSignal.decode(bitField) ??
        $_math.max(0, message._shouldSetLeftSignal.min);
    message.shouldSetRight =
        message._shouldSetRightSignal.decode(bitField) ??
        $_math.max(0, message._shouldSetRightSignal.min);
    message.shouldSetThrottle =
        message._shouldSetThrottleSignal.decode(bitField) ??
        $_math.max(0, message._shouldSetThrottleSignal.min);
    message.leftSpeed =
        message._leftSpeedSignal.decode(bitField) ??
        $_math.max(0, message._leftSpeedSignal.min);
    message.rightSpeed =
        message._rightSpeedSignal.decode(bitField) ??
        $_math.max(0, message._rightSpeedSignal.min);
    message.throttle =
        message._throttleSignal.decode(bitField) ??
        $_math.max(0, message._throttleSignal.min);

    return message;
  }

  factory DriveSetSpeedsMessage.fromJson(Map<String, dynamic> json) =>
      DriveSetSpeedsMessage(
        shouldSetLeft: json['Should_Set_Left'] ?? 0,
        shouldSetRight: json['Should_Set_Right'] ?? 0,
        shouldSetThrottle: json['Should_Set_Throttle'] ?? 0,
        leftSpeed: json['Left_Speed'] ?? 0,
        rightSpeed: json['Right_Speed'] ?? 0,
        throttle: json['Throttle'] ?? 0,
      );

  @override
  $_typed.Uint8List encode() {
    final Map<$_dbc.DBCSignal, num> values = {
      _shouldSetLeftSignal: shouldSetLeft,
      _shouldSetRightSignal: shouldSetRight,
      _shouldSetThrottleSignal: shouldSetThrottle,
      _leftSpeedSignal: leftSpeed,
      _rightSpeedSignal: rightSpeed,
      _throttleSignal: throttle,
    };

    return encodeWithValues(values);
  }

  @override
  Map<String, dynamic> toJson() => {
    'Should_Set_Left': shouldSetLeft,
    'Should_Set_Right': shouldSetRight,
    'Should_Set_Throttle': shouldSetThrottle,
    'Left_Speed': leftSpeed,
    'Right_Speed': rightSpeed,
    'Throttle': throttle,
  };

  @override
  String toString() {
    return 'Drive_Set_Speeds(\n  Should_Set_Left=$shouldSetLeft\n  Should_Set_Right=$shouldSetRight\n  Should_Set_Throttle=$shouldSetThrottle\n  Left_Speed=$leftSpeed\n  Right_Speed=$rightSpeed\n  Throttle=$throttle\n)';
  }
}

class DriveSetLedMessage extends $_dbc.DBCMessage {
  @override
  String messageName = 'Drive_SetLED';

  @override
  int messageLength = 1;

  @override
  int canId = 0x11;

  /// Whether or not "Drive_SetLED" is multiplex
  static const bool isMultiplex = false;

  /// The multiplexor for "Drive_SetLED"
  static const String multiplexor = '';

  /// Value of signal "Color"
  num color;

  /// Value of signal "Blink"
  num blink;

  final $_dbc.DBCSignal _colorSignal = $_dbc.DBCSignal(
    name: 'Color',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 0,
    length: 4,
    mapping: [1, 2, 4, 8, 0, 0, 0, 0],
    mappingIndexes: [0, 1, 2, 3],
    factor: 1,
    offset: 0,
    min: 0,
    max: 8,
    unit: '',
  );

  final $_dbc.DBCSignal _blinkSignal = $_dbc.DBCSignal(
    name: 'Blink',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 4,
    length: 1,
    mapping: [0, 0, 0, 0, 1, 0, 0, 0],
    mappingIndexes: [4],
    factor: 1,
    offset: 0,
    min: 0,
    max: 1,
    unit: '',
  );

  @override
  List<$_dbc.DBCSignal> get signals => [
    _colorSignal,
    _blinkSignal,
  ];

  DriveSetLedMessage({
    this.color = 0,
    this.blink = 0,
  });

  /// Creates a clone of this [DriveSetLedMessage] with the non-null values replaced
  DriveSetLedMessage copyWith({
    num? color,
    num? blink,
  }) => DriveSetLedMessage(
    color: color ?? this.color,
    blink: blink ?? this.blink,
  );

  factory DriveSetLedMessage.decode(List<int> payload) {
    final message = DriveSetLedMessage();
    final typedBuffer = $_typed.Uint8List.fromList(payload);
    final bitField = $_dbc.BitField.from(typedBuffer.sublist(0, message.messageLength));

    message.color =
        message._colorSignal.decode(bitField) ??
        $_math.max(0, message._colorSignal.min);
    message.blink =
        message._blinkSignal.decode(bitField) ??
        $_math.max(0, message._blinkSignal.min);

    return message;
  }

  factory DriveSetLedMessage.fromJson(Map<String, dynamic> json) =>
      DriveSetLedMessage(
        color: json['Color'] ?? 0,
        blink: json['Blink'] ?? 0,
      );

  @override
  $_typed.Uint8List encode() {
    final Map<$_dbc.DBCSignal, num> values = {
      _colorSignal: color,
      _blinkSignal: blink,
    };

    return encodeWithValues(values);
  }

  @override
  Map<String, dynamic> toJson() => {
    'Color': color,
    'Blink': blink,
  };

  @override
  String toString() {
    return 'Drive_SetLED(\n  Color=$color\n  Blink=$blink\n)';
  }
}

class DriveLedMessage extends $_dbc.DBCMessage {
  @override
  String messageName = 'Drive_LED';

  @override
  int messageLength = 1;

  @override
  int canId = 0x17;

  /// Whether or not "Drive_LED" is multiplex
  static const bool isMultiplex = false;

  /// The multiplexor for "Drive_LED"
  static const String multiplexor = '';

  /// Value of signal "Color"
  num color;

  /// Value of signal "Blink"
  num blink;

  final $_dbc.DBCSignal _colorSignal = $_dbc.DBCSignal(
    name: 'Color',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 0,
    length: 4,
    mapping: [1, 2, 4, 8, 0, 0, 0, 0],
    mappingIndexes: [0, 1, 2, 3],
    factor: 1,
    offset: 0,
    min: 0,
    max: 8,
    unit: '',
  );

  final $_dbc.DBCSignal _blinkSignal = $_dbc.DBCSignal(
    name: 'Blink',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 4,
    length: 1,
    mapping: [0, 0, 0, 0, 1, 0, 0, 0],
    mappingIndexes: [4],
    factor: 1,
    offset: 0,
    min: 0,
    max: 1,
    unit: '',
  );

  @override
  List<$_dbc.DBCSignal> get signals => [
    _colorSignal,
    _blinkSignal,
  ];

  DriveLedMessage({
    this.color = 0,
    this.blink = 0,
  });

  /// Creates a clone of this [DriveLedMessage] with the non-null values replaced
  DriveLedMessage copyWith({
    num? color,
    num? blink,
  }) => DriveLedMessage(
    color: color ?? this.color,
    blink: blink ?? this.blink,
  );

  factory DriveLedMessage.decode(List<int> payload) {
    final message = DriveLedMessage();
    final typedBuffer = $_typed.Uint8List.fromList(payload);
    final bitField = $_dbc.BitField.from(typedBuffer.sublist(0, message.messageLength));

    message.color =
        message._colorSignal.decode(bitField) ??
        $_math.max(0, message._colorSignal.min);
    message.blink =
        message._blinkSignal.decode(bitField) ??
        $_math.max(0, message._blinkSignal.min);

    return message;
  }

  factory DriveLedMessage.fromJson(Map<String, dynamic> json) =>
      DriveLedMessage(
        color: json['Color'] ?? 0,
        blink: json['Blink'] ?? 0,
      );

  @override
  $_typed.Uint8List encode() {
    final Map<$_dbc.DBCSignal, num> values = {
      _colorSignal: color,
      _blinkSignal: blink,
    };

    return encodeWithValues(values);
  }

  @override
  Map<String, dynamic> toJson() => {
    'Color': color,
    'Blink': blink,
  };

  @override
  String toString() {
    return 'Drive_LED(\n  Color=$color\n  Blink=$blink\n)';
  }
}

class DriveAppliedOutputMessage extends $_dbc.DBCMessage {
  @override
  String messageName = 'Drive_Applied_Output';

  @override
  int messageLength = 6;

  @override
  int canId = 0x15;

  /// Whether or not "Drive_Applied_Output" is multiplex
  static const bool isMultiplex = false;

  /// The multiplexor for "Drive_Applied_Output"
  static const String multiplexor = '';

  /// Value of signal "Throttle"
  num throttle;

  /// Value of signal "Left_Speed"
  num leftSpeed;

  /// Value of signal "Right_Speed"
  num rightSpeed;

  final $_dbc.DBCSignal _throttleSignal = $_dbc.DBCSignal(
    name: 'Throttle',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 0,
    length: 16,
    mapping: [1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15],
    factor: 0.000016,
    offset: 0,
    min: 0,
    max: 1,
    unit: '',
  );

  final $_dbc.DBCSignal _leftSpeedSignal = $_dbc.DBCSignal(
    name: 'Left_Speed',
    signalSignedness: $_dbc.DBCSignalSignedness.SIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 16,
    length: 16,
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31],
    factor: 0.000062,
    offset: 0,
    min: -1,
    max: 1,
    unit: '',
  );

  final $_dbc.DBCSignal _rightSpeedSignal = $_dbc.DBCSignal(
    name: 'Right_Speed',
    signalSignedness: $_dbc.DBCSignalSignedness.SIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 32,
    length: 16,
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768],
    mappingIndexes: [32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47],
    factor: 0.000062,
    offset: 0,
    min: -1,
    max: 1,
    unit: '',
  );

  @override
  List<$_dbc.DBCSignal> get signals => [
    _throttleSignal,
    _leftSpeedSignal,
    _rightSpeedSignal,
  ];

  DriveAppliedOutputMessage({
    this.throttle = 0,
    this.leftSpeed = 0,
    this.rightSpeed = 0,
  });

  /// Creates a clone of this [DriveAppliedOutputMessage] with the non-null values replaced
  DriveAppliedOutputMessage copyWith({
    num? throttle,
    num? leftSpeed,
    num? rightSpeed,
  }) => DriveAppliedOutputMessage(
    throttle: throttle ?? this.throttle,
    leftSpeed: leftSpeed ?? this.leftSpeed,
    rightSpeed: rightSpeed ?? this.rightSpeed,
  );

  factory DriveAppliedOutputMessage.decode(List<int> payload) {
    final message = DriveAppliedOutputMessage();
    final typedBuffer = $_typed.Uint8List.fromList(payload);
    final bitField = $_dbc.BitField.from(typedBuffer.sublist(0, message.messageLength));

    message.throttle =
        message._throttleSignal.decode(bitField) ??
        $_math.max(0, message._throttleSignal.min);
    message.leftSpeed =
        message._leftSpeedSignal.decode(bitField) ??
        $_math.max(0, message._leftSpeedSignal.min);
    message.rightSpeed =
        message._rightSpeedSignal.decode(bitField) ??
        $_math.max(0, message._rightSpeedSignal.min);

    return message;
  }

  factory DriveAppliedOutputMessage.fromJson(Map<String, dynamic> json) =>
      DriveAppliedOutputMessage(
        throttle: json['Throttle'] ?? 0,
        leftSpeed: json['Left_Speed'] ?? 0,
        rightSpeed: json['Right_Speed'] ?? 0,
      );

  @override
  $_typed.Uint8List encode() {
    final Map<$_dbc.DBCSignal, num> values = {
      _throttleSignal: throttle,
      _leftSpeedSignal: leftSpeed,
      _rightSpeedSignal: rightSpeed,
    };

    return encodeWithValues(values);
  }

  @override
  Map<String, dynamic> toJson() => {
    'Throttle': throttle,
    'Left_Speed': leftSpeed,
    'Right_Speed': rightSpeed,
  };

  @override
  String toString() {
    return 'Drive_Applied_Output(\n  Throttle=$throttle\n  Left_Speed=$leftSpeed\n  Right_Speed=$rightSpeed\n)';
  }
}

class DriveBatteryMessage extends $_dbc.DBCMessage {
  @override
  String messageName = 'Drive_Battery';

  @override
  int messageLength = 6;

  @override
  int canId = 0x16;

  /// Whether or not "Drive_Battery" is multiplex
  static const bool isMultiplex = false;

  /// The multiplexor for "Drive_Battery"
  static const String multiplexor = '';

  /// Value of signal "Voltage"
  num voltage;

  /// Value of signal "Temperature"
  num temperature;

  /// Value of signal "Current"
  num current;

  final $_dbc.DBCSignal _voltageSignal = $_dbc.DBCSignal(
    name: 'Voltage',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 0,
    length: 16,
    mapping: [1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15],
    factor: 0.00055,
    offset: 0,
    min: 0,
    max: 36,
    unit: 'V',
  );

  final $_dbc.DBCSignal _temperatureSignal = $_dbc.DBCSignal(
    name: 'Temperature',
    signalSignedness: $_dbc.DBCSignalSignedness.SIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 16,
    length: 12,
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27],
    factor: 0.09,
    offset: 50,
    min: -40,
    max: 150,
    unit: 'C',
  );

  final $_dbc.DBCSignal _currentSignal = $_dbc.DBCSignal(
    name: 'Current',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 28,
    length: 16,
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 0, 0, 0, 0],
    mappingIndexes: [28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43],
    factor: 0.1,
    offset: 0,
    min: 0,
    max: 30,
    unit: 'A',
  );

  @override
  List<$_dbc.DBCSignal> get signals => [
    _voltageSignal,
    _temperatureSignal,
    _currentSignal,
  ];

  DriveBatteryMessage({
    this.voltage = 0,
    this.temperature = 50,
    this.current = 0,
  });

  /// Creates a clone of this [DriveBatteryMessage] with the non-null values replaced
  DriveBatteryMessage copyWith({
    num? voltage,
    num? temperature,
    num? current,
  }) => DriveBatteryMessage(
    voltage: voltage ?? this.voltage,
    temperature: temperature ?? this.temperature,
    current: current ?? this.current,
  );

  factory DriveBatteryMessage.decode(List<int> payload) {
    final message = DriveBatteryMessage();
    final typedBuffer = $_typed.Uint8List.fromList(payload);
    final bitField = $_dbc.BitField.from(typedBuffer.sublist(0, message.messageLength));

    message.voltage =
        message._voltageSignal.decode(bitField) ??
        $_math.max(0, message._voltageSignal.min);
    message.temperature =
        message._temperatureSignal.decode(bitField) ??
        $_math.max(0, message._temperatureSignal.min);
    message.current =
        message._currentSignal.decode(bitField) ??
        $_math.max(0, message._currentSignal.min);

    return message;
  }

  factory DriveBatteryMessage.fromJson(Map<String, dynamic> json) =>
      DriveBatteryMessage(
        voltage: json['Voltage'] ?? 0,
        temperature: json['Temperature'] ?? 50,
        current: json['Current'] ?? 0,
      );

  @override
  $_typed.Uint8List encode() {
    final Map<$_dbc.DBCSignal, num> values = {
      _voltageSignal: voltage,
      _temperatureSignal: temperature,
      _currentSignal: current,
    };

    return encodeWithValues(values);
  }

  @override
  Map<String, dynamic> toJson() => {
    'Voltage': voltage,
    'Temperature': temperature,
    'Current': current,
  };

  @override
  String toString() {
    return 'Drive_Battery(\n  Voltage=$voltage\n  Temperature=$temperature\n  Current=$current\n)';
  }
}

class DriveSwivelMessage extends $_dbc.DBCMessage {
  @override
  String messageName = 'Drive_Swivel';

  @override
  int messageLength = 6;

  @override
  int canId = 0x18;

  /// Whether or not "Drive_Swivel" is multiplex
  static const bool isMultiplex = false;

  /// The multiplexor for "Drive_Swivel"
  static const String multiplexor = '';

  /// Value of signal "Front_Swivel"
  num frontSwivel;

  /// Value of signal "Front_Tilt"
  num frontTilt;

  /// Value of signal "Rear_Swivel"
  num rearSwivel;

  /// Value of signal "Rear_Tilt"
  num rearTilt;

  final $_dbc.DBCSignal _frontSwivelSignal = $_dbc.DBCSignal(
    name: 'Front_Swivel',
    signalSignedness: $_dbc.DBCSignalSignedness.SIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 0,
    length: 12,
    mapping: [1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
    factor: 0.044,
    offset: 0,
    min: -90,
    max: 90,
    unit: '°',
  );

  final $_dbc.DBCSignal _frontTiltSignal = $_dbc.DBCSignal(
    name: 'Front_Tilt',
    signalSignedness: $_dbc.DBCSignalSignedness.SIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 12,
    length: 12,
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23],
    factor: 0.044,
    offset: 0,
    min: -90,
    max: 90,
    unit: '°',
  );

  final $_dbc.DBCSignal _rearSwivelSignal = $_dbc.DBCSignal(
    name: 'Rear_Swivel',
    signalSignedness: $_dbc.DBCSignalSignedness.SIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 24,
    length: 12,
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35],
    factor: 0.044,
    offset: 0,
    min: -90,
    max: 90,
    unit: '°',
  );

  final $_dbc.DBCSignal _rearTiltSignal = $_dbc.DBCSignal(
    name: 'Rear_Tilt',
    signalSignedness: $_dbc.DBCSignalSignedness.SIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 36,
    length: 12,
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048],
    mappingIndexes: [36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47],
    factor: 0.044,
    offset: 0,
    min: -90,
    max: 90,
    unit: '°',
  );

  @override
  List<$_dbc.DBCSignal> get signals => [
    _frontSwivelSignal,
    _frontTiltSignal,
    _rearSwivelSignal,
    _rearTiltSignal,
  ];

  DriveSwivelMessage({
    this.frontSwivel = 0,
    this.frontTilt = 0,
    this.rearSwivel = 0,
    this.rearTilt = 0,
  });

  /// Creates a clone of this [DriveSwivelMessage] with the non-null values replaced
  DriveSwivelMessage copyWith({
    num? frontSwivel,
    num? frontTilt,
    num? rearSwivel,
    num? rearTilt,
  }) => DriveSwivelMessage(
    frontSwivel: frontSwivel ?? this.frontSwivel,
    frontTilt: frontTilt ?? this.frontTilt,
    rearSwivel: rearSwivel ?? this.rearSwivel,
    rearTilt: rearTilt ?? this.rearTilt,
  );

  factory DriveSwivelMessage.decode(List<int> payload) {
    final message = DriveSwivelMessage();
    final typedBuffer = $_typed.Uint8List.fromList(payload);
    final bitField = $_dbc.BitField.from(typedBuffer.sublist(0, message.messageLength));

    message.frontSwivel =
        message._frontSwivelSignal.decode(bitField) ??
        $_math.max(0, message._frontSwivelSignal.min);
    message.frontTilt =
        message._frontTiltSignal.decode(bitField) ??
        $_math.max(0, message._frontTiltSignal.min);
    message.rearSwivel =
        message._rearSwivelSignal.decode(bitField) ??
        $_math.max(0, message._rearSwivelSignal.min);
    message.rearTilt =
        message._rearTiltSignal.decode(bitField) ??
        $_math.max(0, message._rearTiltSignal.min);

    return message;
  }

  factory DriveSwivelMessage.fromJson(Map<String, dynamic> json) =>
      DriveSwivelMessage(
        frontSwivel: json['Front_Swivel'] ?? 0,
        frontTilt: json['Front_Tilt'] ?? 0,
        rearSwivel: json['Rear_Swivel'] ?? 0,
        rearTilt: json['Rear_Tilt'] ?? 0,
      );

  @override
  $_typed.Uint8List encode() {
    final Map<$_dbc.DBCSignal, num> values = {
      _frontSwivelSignal: frontSwivel,
      _frontTiltSignal: frontTilt,
      _rearSwivelSignal: rearSwivel,
      _rearTiltSignal: rearTilt,
    };

    return encodeWithValues(values);
  }

  @override
  Map<String, dynamic> toJson() => {
    'Front_Swivel': frontSwivel,
    'Front_Tilt': frontTilt,
    'Rear_Swivel': rearSwivel,
    'Rear_Tilt': rearTilt,
  };

  @override
  String toString() {
    return 'Drive_Swivel(\n  Front_Swivel=$frontSwivel\n  Front_Tilt=$frontTilt\n  Rear_Swivel=$rearSwivel\n  Rear_Tilt=$rearTilt\n)';
  }
}

class RelaySetStateMessage extends $_dbc.DBCMessage {
  @override
  String messageName = 'Relay_Set_State';

  @override
  int messageLength = 2;

  @override
  int canId = 0x20;

  /// Whether or not "Relay_Set_State" is multiplex
  static const bool isMultiplex = false;

  /// The multiplexor for "Relay_Set_State"
  static const String multiplexor = '';

  /// Value of signal "Update_Front_Left_Motor"
  num updateFrontLeftMotor;

  /// Value of signal "Front_Left_Motor"
  num frontLeftMotor;

  /// Value of signal "Update_Front_Right_Motor"
  num updateFrontRightMotor;

  /// Value of signal "Front_Right_Motor"
  num frontRightMotor;

  /// Value of signal "Update_Back_Left_Motor"
  num updateBackLeftMotor;

  /// Value of signal "Back_Left_Motor"
  num backLeftMotor;

  /// Value of signal "Update_Back_Right_Motor"
  num updateBackRightMotor;

  /// Value of signal "Back_Right_Motor"
  num backRightMotor;

  /// Value of signal "Update_Arm"
  num updateArm;

  /// Value of signal "Arm"
  num arm;

  /// Value of signal "Update_Science"
  num updateScience;

  /// Value of signal "Science"
  num science;

  /// Value of signal "Update_Drive"
  num updateDrive;

  /// Value of signal "Drive"
  num drive;

  final $_dbc.DBCSignal _updateFrontLeftMotorSignal = $_dbc.DBCSignal(
    name: 'Update_Front_Left_Motor',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 0,
    length: 1,
    mapping: [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [0],
    factor: 1,
    offset: 0,
    min: 0,
    max: 1,
    unit: '',
  );

  final $_dbc.DBCSignal _frontLeftMotorSignal = $_dbc.DBCSignal(
    name: 'Front_Left_Motor',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 1,
    length: 1,
    mapping: [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [1],
    factor: 1,
    offset: 0,
    min: 0,
    max: 1,
    unit: '',
  );

  final $_dbc.DBCSignal _updateFrontRightMotorSignal = $_dbc.DBCSignal(
    name: 'Update_Front_Right_Motor',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 2,
    length: 1,
    mapping: [0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [2],
    factor: 1,
    offset: 0,
    min: 0,
    max: 1,
    unit: '',
  );

  final $_dbc.DBCSignal _frontRightMotorSignal = $_dbc.DBCSignal(
    name: 'Front_Right_Motor',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 3,
    length: 1,
    mapping: [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [3],
    factor: 1,
    offset: 0,
    min: 0,
    max: 1,
    unit: '',
  );

  final $_dbc.DBCSignal _updateBackLeftMotorSignal = $_dbc.DBCSignal(
    name: 'Update_Back_Left_Motor',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 4,
    length: 1,
    mapping: [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [4],
    factor: 1,
    offset: 0,
    min: 0,
    max: 1,
    unit: '',
  );

  final $_dbc.DBCSignal _backLeftMotorSignal = $_dbc.DBCSignal(
    name: 'Back_Left_Motor',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 5,
    length: 1,
    mapping: [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [5],
    factor: 1,
    offset: 0,
    min: 0,
    max: 1,
    unit: '',
  );

  final $_dbc.DBCSignal _updateBackRightMotorSignal = $_dbc.DBCSignal(
    name: 'Update_Back_Right_Motor',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 6,
    length: 1,
    mapping: [0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [6],
    factor: 1,
    offset: 0,
    min: 0,
    max: 1,
    unit: '',
  );

  final $_dbc.DBCSignal _backRightMotorSignal = $_dbc.DBCSignal(
    name: 'Back_Right_Motor',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 7,
    length: 1,
    mapping: [0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [7],
    factor: 1,
    offset: 0,
    min: 0,
    max: 1,
    unit: '',
  );

  final $_dbc.DBCSignal _updateArmSignal = $_dbc.DBCSignal(
    name: 'Update_Arm',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 8,
    length: 1,
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [8],
    factor: 1,
    offset: 0,
    min: 0,
    max: 1,
    unit: '',
  );

  final $_dbc.DBCSignal _armSignal = $_dbc.DBCSignal(
    name: 'Arm',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 9,
    length: 1,
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [9],
    factor: 1,
    offset: 0,
    min: 0,
    max: 1,
    unit: '',
  );

  final $_dbc.DBCSignal _updateScienceSignal = $_dbc.DBCSignal(
    name: 'Update_Science',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 10,
    length: 1,
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
    mappingIndexes: [10],
    factor: 1,
    offset: 0,
    min: 0,
    max: 1,
    unit: '',
  );

  final $_dbc.DBCSignal _scienceSignal = $_dbc.DBCSignal(
    name: 'Science',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 11,
    length: 1,
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0],
    mappingIndexes: [11],
    factor: 1,
    offset: 0,
    min: 0,
    max: 1,
    unit: '',
  );

  final $_dbc.DBCSignal _updateDriveSignal = $_dbc.DBCSignal(
    name: 'Update_Drive',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 12,
    length: 1,
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0],
    mappingIndexes: [12],
    factor: 1,
    offset: 0,
    min: 0,
    max: 1,
    unit: '',
  );

  final $_dbc.DBCSignal _driveSignal = $_dbc.DBCSignal(
    name: 'Drive',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 13,
    length: 1,
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0],
    mappingIndexes: [13],
    factor: 1,
    offset: 0,
    min: 0,
    max: 1,
    unit: '',
  );

  @override
  List<$_dbc.DBCSignal> get signals => [
    _updateFrontLeftMotorSignal,
    _frontLeftMotorSignal,
    _updateFrontRightMotorSignal,
    _frontRightMotorSignal,
    _updateBackLeftMotorSignal,
    _backLeftMotorSignal,
    _updateBackRightMotorSignal,
    _backRightMotorSignal,
    _updateArmSignal,
    _armSignal,
    _updateScienceSignal,
    _scienceSignal,
    _updateDriveSignal,
    _driveSignal,
  ];

  RelaySetStateMessage({
    this.updateFrontLeftMotor = 0,
    this.frontLeftMotor = 0,
    this.updateFrontRightMotor = 0,
    this.frontRightMotor = 0,
    this.updateBackLeftMotor = 0,
    this.backLeftMotor = 0,
    this.updateBackRightMotor = 0,
    this.backRightMotor = 0,
    this.updateArm = 0,
    this.arm = 0,
    this.updateScience = 0,
    this.science = 0,
    this.updateDrive = 0,
    this.drive = 0,
  });

  /// Creates a clone of this [RelaySetStateMessage] with the non-null values replaced
  RelaySetStateMessage copyWith({
    num? updateFrontLeftMotor,
    num? frontLeftMotor,
    num? updateFrontRightMotor,
    num? frontRightMotor,
    num? updateBackLeftMotor,
    num? backLeftMotor,
    num? updateBackRightMotor,
    num? backRightMotor,
    num? updateArm,
    num? arm,
    num? updateScience,
    num? science,
    num? updateDrive,
    num? drive,
  }) => RelaySetStateMessage(
    updateFrontLeftMotor: updateFrontLeftMotor ?? this.updateFrontLeftMotor,
    frontLeftMotor: frontLeftMotor ?? this.frontLeftMotor,
    updateFrontRightMotor: updateFrontRightMotor ?? this.updateFrontRightMotor,
    frontRightMotor: frontRightMotor ?? this.frontRightMotor,
    updateBackLeftMotor: updateBackLeftMotor ?? this.updateBackLeftMotor,
    backLeftMotor: backLeftMotor ?? this.backLeftMotor,
    updateBackRightMotor: updateBackRightMotor ?? this.updateBackRightMotor,
    backRightMotor: backRightMotor ?? this.backRightMotor,
    updateArm: updateArm ?? this.updateArm,
    arm: arm ?? this.arm,
    updateScience: updateScience ?? this.updateScience,
    science: science ?? this.science,
    updateDrive: updateDrive ?? this.updateDrive,
    drive: drive ?? this.drive,
  );

  factory RelaySetStateMessage.decode(List<int> payload) {
    final message = RelaySetStateMessage();
    final typedBuffer = $_typed.Uint8List.fromList(payload);
    final bitField = $_dbc.BitField.from(typedBuffer.sublist(0, message.messageLength));

    message.updateFrontLeftMotor =
        message._updateFrontLeftMotorSignal.decode(bitField) ??
        $_math.max(0, message._updateFrontLeftMotorSignal.min);
    message.frontLeftMotor =
        message._frontLeftMotorSignal.decode(bitField) ??
        $_math.max(0, message._frontLeftMotorSignal.min);
    message.updateFrontRightMotor =
        message._updateFrontRightMotorSignal.decode(bitField) ??
        $_math.max(0, message._updateFrontRightMotorSignal.min);
    message.frontRightMotor =
        message._frontRightMotorSignal.decode(bitField) ??
        $_math.max(0, message._frontRightMotorSignal.min);
    message.updateBackLeftMotor =
        message._updateBackLeftMotorSignal.decode(bitField) ??
        $_math.max(0, message._updateBackLeftMotorSignal.min);
    message.backLeftMotor =
        message._backLeftMotorSignal.decode(bitField) ??
        $_math.max(0, message._backLeftMotorSignal.min);
    message.updateBackRightMotor =
        message._updateBackRightMotorSignal.decode(bitField) ??
        $_math.max(0, message._updateBackRightMotorSignal.min);
    message.backRightMotor =
        message._backRightMotorSignal.decode(bitField) ??
        $_math.max(0, message._backRightMotorSignal.min);
    message.updateArm =
        message._updateArmSignal.decode(bitField) ??
        $_math.max(0, message._updateArmSignal.min);
    message.arm =
        message._armSignal.decode(bitField) ??
        $_math.max(0, message._armSignal.min);
    message.updateScience =
        message._updateScienceSignal.decode(bitField) ??
        $_math.max(0, message._updateScienceSignal.min);
    message.science =
        message._scienceSignal.decode(bitField) ??
        $_math.max(0, message._scienceSignal.min);
    message.updateDrive =
        message._updateDriveSignal.decode(bitField) ??
        $_math.max(0, message._updateDriveSignal.min);
    message.drive =
        message._driveSignal.decode(bitField) ??
        $_math.max(0, message._driveSignal.min);

    return message;
  }

  factory RelaySetStateMessage.fromJson(Map<String, dynamic> json) =>
      RelaySetStateMessage(
        updateFrontLeftMotor: json['Update_Front_Left_Motor'] ?? 0,
        frontLeftMotor: json['Front_Left_Motor'] ?? 0,
        updateFrontRightMotor: json['Update_Front_Right_Motor'] ?? 0,
        frontRightMotor: json['Front_Right_Motor'] ?? 0,
        updateBackLeftMotor: json['Update_Back_Left_Motor'] ?? 0,
        backLeftMotor: json['Back_Left_Motor'] ?? 0,
        updateBackRightMotor: json['Update_Back_Right_Motor'] ?? 0,
        backRightMotor: json['Back_Right_Motor'] ?? 0,
        updateArm: json['Update_Arm'] ?? 0,
        arm: json['Arm'] ?? 0,
        updateScience: json['Update_Science'] ?? 0,
        science: json['Science'] ?? 0,
        updateDrive: json['Update_Drive'] ?? 0,
        drive: json['Drive'] ?? 0,
      );

  @override
  $_typed.Uint8List encode() {
    final Map<$_dbc.DBCSignal, num> values = {
      _updateFrontLeftMotorSignal: updateFrontLeftMotor,
      _frontLeftMotorSignal: frontLeftMotor,
      _updateFrontRightMotorSignal: updateFrontRightMotor,
      _frontRightMotorSignal: frontRightMotor,
      _updateBackLeftMotorSignal: updateBackLeftMotor,
      _backLeftMotorSignal: backLeftMotor,
      _updateBackRightMotorSignal: updateBackRightMotor,
      _backRightMotorSignal: backRightMotor,
      _updateArmSignal: updateArm,
      _armSignal: arm,
      _updateScienceSignal: updateScience,
      _scienceSignal: science,
      _updateDriveSignal: updateDrive,
      _driveSignal: drive,
    };

    return encodeWithValues(values);
  }

  @override
  Map<String, dynamic> toJson() => {
    'Update_Front_Left_Motor': updateFrontLeftMotor,
    'Front_Left_Motor': frontLeftMotor,
    'Update_Front_Right_Motor': updateFrontRightMotor,
    'Front_Right_Motor': frontRightMotor,
    'Update_Back_Left_Motor': updateBackLeftMotor,
    'Back_Left_Motor': backLeftMotor,
    'Update_Back_Right_Motor': updateBackRightMotor,
    'Back_Right_Motor': backRightMotor,
    'Update_Arm': updateArm,
    'Arm': arm,
    'Update_Science': updateScience,
    'Science': science,
    'Update_Drive': updateDrive,
    'Drive': drive,
  };

  @override
  String toString() {
    return 'Relay_Set_State(\n  Update_Front_Left_Motor=$updateFrontLeftMotor\n  Front_Left_Motor=$frontLeftMotor\n  Update_Front_Right_Motor=$updateFrontRightMotor\n  Front_Right_Motor=$frontRightMotor\n  Update_Back_Left_Motor=$updateBackLeftMotor\n  Back_Left_Motor=$backLeftMotor\n  Update_Back_Right_Motor=$updateBackRightMotor\n  Back_Right_Motor=$backRightMotor\n  Update_Arm=$updateArm\n  Arm=$arm\n  Update_Science=$updateScience\n  Science=$science\n  Update_Drive=$updateDrive\n  Drive=$drive\n)';
  }
}

class RelayStateMessage extends $_dbc.DBCMessage {
  @override
  String messageName = 'Relay_State';

  @override
  int messageLength = 1;

  @override
  int canId = 0x25;

  /// Whether or not "Relay_State" is multiplex
  static const bool isMultiplex = false;

  /// The multiplexor for "Relay_State"
  static const String multiplexor = '';

  /// Value of signal "Front_Left_Motor"
  num frontLeftMotor;

  /// Value of signal "Front_Right_Motor"
  num frontRightMotor;

  /// Value of signal "Back_Left_Motor"
  num backLeftMotor;

  /// Value of signal "Back_Right_Motor"
  num backRightMotor;

  /// Value of signal "Drive"
  num drive;

  /// Value of signal "Arm"
  num arm;

  /// Value of signal "Science"
  num science;

  /// Value of signal "Physical_Override"
  num physicalOverride;

  final $_dbc.DBCSignal _frontLeftMotorSignal = $_dbc.DBCSignal(
    name: 'Front_Left_Motor',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 0,
    length: 1,
    mapping: [1, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [0],
    factor: 1,
    offset: 0,
    min: 0,
    max: 1,
    unit: '',
  );

  final $_dbc.DBCSignal _frontRightMotorSignal = $_dbc.DBCSignal(
    name: 'Front_Right_Motor',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 1,
    length: 1,
    mapping: [0, 1, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [1],
    factor: 1,
    offset: 0,
    min: 0,
    max: 1,
    unit: '',
  );

  final $_dbc.DBCSignal _backLeftMotorSignal = $_dbc.DBCSignal(
    name: 'Back_Left_Motor',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 2,
    length: 1,
    mapping: [0, 0, 1, 0, 0, 0, 0, 0],
    mappingIndexes: [2],
    factor: 1,
    offset: 0,
    min: 0,
    max: 1,
    unit: '',
  );

  final $_dbc.DBCSignal _backRightMotorSignal = $_dbc.DBCSignal(
    name: 'Back_Right_Motor',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 3,
    length: 1,
    mapping: [0, 0, 0, 1, 0, 0, 0, 0],
    mappingIndexes: [3],
    factor: 1,
    offset: 0,
    min: 0,
    max: 1,
    unit: '',
  );

  final $_dbc.DBCSignal _driveSignal = $_dbc.DBCSignal(
    name: 'Drive',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 4,
    length: 1,
    mapping: [0, 0, 0, 0, 1, 0, 0, 0],
    mappingIndexes: [4],
    factor: 1,
    offset: 0,
    min: 0,
    max: 1,
    unit: '',
  );

  final $_dbc.DBCSignal _armSignal = $_dbc.DBCSignal(
    name: 'Arm',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 5,
    length: 1,
    mapping: [0, 0, 0, 0, 0, 1, 0, 0],
    mappingIndexes: [5],
    factor: 1,
    offset: 0,
    min: 0,
    max: 1,
    unit: '',
  );

  final $_dbc.DBCSignal _scienceSignal = $_dbc.DBCSignal(
    name: 'Science',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 6,
    length: 1,
    mapping: [0, 0, 0, 0, 0, 0, 1, 0],
    mappingIndexes: [6],
    factor: 1,
    offset: 0,
    min: 0,
    max: 1,
    unit: '',
  );

  final $_dbc.DBCSignal _physicalOverrideSignal = $_dbc.DBCSignal(
    name: 'Physical_Override',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 7,
    length: 1,
    mapping: [0, 0, 0, 0, 0, 0, 0, 1],
    mappingIndexes: [7],
    factor: 1,
    offset: 0,
    min: 0,
    max: 1,
    unit: '',
  );

  @override
  List<$_dbc.DBCSignal> get signals => [
    _frontLeftMotorSignal,
    _frontRightMotorSignal,
    _backLeftMotorSignal,
    _backRightMotorSignal,
    _driveSignal,
    _armSignal,
    _scienceSignal,
    _physicalOverrideSignal,
  ];

  RelayStateMessage({
    this.frontLeftMotor = 0,
    this.frontRightMotor = 0,
    this.backLeftMotor = 0,
    this.backRightMotor = 0,
    this.drive = 0,
    this.arm = 0,
    this.science = 0,
    this.physicalOverride = 0,
  });

  /// Creates a clone of this [RelayStateMessage] with the non-null values replaced
  RelayStateMessage copyWith({
    num? frontLeftMotor,
    num? frontRightMotor,
    num? backLeftMotor,
    num? backRightMotor,
    num? drive,
    num? arm,
    num? science,
    num? physicalOverride,
  }) => RelayStateMessage(
    frontLeftMotor: frontLeftMotor ?? this.frontLeftMotor,
    frontRightMotor: frontRightMotor ?? this.frontRightMotor,
    backLeftMotor: backLeftMotor ?? this.backLeftMotor,
    backRightMotor: backRightMotor ?? this.backRightMotor,
    drive: drive ?? this.drive,
    arm: arm ?? this.arm,
    science: science ?? this.science,
    physicalOverride: physicalOverride ?? this.physicalOverride,
  );

  factory RelayStateMessage.decode(List<int> payload) {
    final message = RelayStateMessage();
    final typedBuffer = $_typed.Uint8List.fromList(payload);
    final bitField = $_dbc.BitField.from(typedBuffer.sublist(0, message.messageLength));

    message.frontLeftMotor =
        message._frontLeftMotorSignal.decode(bitField) ??
        $_math.max(0, message._frontLeftMotorSignal.min);
    message.frontRightMotor =
        message._frontRightMotorSignal.decode(bitField) ??
        $_math.max(0, message._frontRightMotorSignal.min);
    message.backLeftMotor =
        message._backLeftMotorSignal.decode(bitField) ??
        $_math.max(0, message._backLeftMotorSignal.min);
    message.backRightMotor =
        message._backRightMotorSignal.decode(bitField) ??
        $_math.max(0, message._backRightMotorSignal.min);
    message.drive =
        message._driveSignal.decode(bitField) ??
        $_math.max(0, message._driveSignal.min);
    message.arm =
        message._armSignal.decode(bitField) ??
        $_math.max(0, message._armSignal.min);
    message.science =
        message._scienceSignal.decode(bitField) ??
        $_math.max(0, message._scienceSignal.min);
    message.physicalOverride =
        message._physicalOverrideSignal.decode(bitField) ??
        $_math.max(0, message._physicalOverrideSignal.min);

    return message;
  }

  factory RelayStateMessage.fromJson(Map<String, dynamic> json) =>
      RelayStateMessage(
        frontLeftMotor: json['Front_Left_Motor'] ?? 0,
        frontRightMotor: json['Front_Right_Motor'] ?? 0,
        backLeftMotor: json['Back_Left_Motor'] ?? 0,
        backRightMotor: json['Back_Right_Motor'] ?? 0,
        drive: json['Drive'] ?? 0,
        arm: json['Arm'] ?? 0,
        science: json['Science'] ?? 0,
        physicalOverride: json['Physical_Override'] ?? 0,
      );

  @override
  $_typed.Uint8List encode() {
    final Map<$_dbc.DBCSignal, num> values = {
      _frontLeftMotorSignal: frontLeftMotor,
      _frontRightMotorSignal: frontRightMotor,
      _backLeftMotorSignal: backLeftMotor,
      _backRightMotorSignal: backRightMotor,
      _driveSignal: drive,
      _armSignal: arm,
      _scienceSignal: science,
      _physicalOverrideSignal: physicalOverride,
    };

    return encodeWithValues(values);
  }

  @override
  Map<String, dynamic> toJson() => {
    'Front_Left_Motor': frontLeftMotor,
    'Front_Right_Motor': frontRightMotor,
    'Back_Left_Motor': backLeftMotor,
    'Back_Right_Motor': backRightMotor,
    'Drive': drive,
    'Arm': arm,
    'Science': science,
    'Physical_Override': physicalOverride,
  };

  @override
  String toString() {
    return 'Relay_State(\n  Front_Left_Motor=$frontLeftMotor\n  Front_Right_Motor=$frontRightMotor\n  Back_Left_Motor=$backLeftMotor\n  Back_Right_Motor=$backRightMotor\n  Drive=$drive\n  Arm=$arm\n  Science=$science\n  Physical_Override=$physicalOverride\n)';
  }
}

class DriveSetSwivelMessage extends $_dbc.DBCMessage {
  @override
  String messageName = 'Drive_SetSwivel';

  @override
  int messageLength = 7;

  @override
  int canId = 0x12;

  /// Whether or not "Drive_SetSwivel" is multiplex
  static const bool isMultiplex = false;

  /// The multiplexor for "Drive_SetSwivel"
  static const String multiplexor = '';

  /// Value of signal "Set_Front_Swivel"
  num setFrontSwivel;

  /// Value of signal "Set_Front_Tilt"
  num setFrontTilt;

  /// Value of signal "Set_Rear_Swivel"
  num setRearSwivel;

  /// Value of signal "Set_Rear_Tilt"
  num setRearTilt;

  /// Value of signal "Front_Swivel"
  num frontSwivel;

  /// Value of signal "Front_Tilt"
  num frontTilt;

  /// Value of signal "Rear_Swivel"
  num rearSwivel;

  /// Value of signal "Rear_Tilt"
  num rearTilt;

  final $_dbc.DBCSignal _setFrontSwivelSignal = $_dbc.DBCSignal(
    name: 'Set_Front_Swivel',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 0,
    length: 1,
    mapping: [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [0],
    factor: 1,
    offset: 0,
    min: 0,
    max: 1,
    unit: '',
  );

  final $_dbc.DBCSignal _setFrontTiltSignal = $_dbc.DBCSignal(
    name: 'Set_Front_Tilt',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 1,
    length: 1,
    mapping: [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [1],
    factor: 1,
    offset: 0,
    min: 0,
    max: 1,
    unit: '',
  );

  final $_dbc.DBCSignal _setRearSwivelSignal = $_dbc.DBCSignal(
    name: 'Set_Rear_Swivel',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 2,
    length: 1,
    mapping: [0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [2],
    factor: 1,
    offset: 0,
    min: 0,
    max: 1,
    unit: '',
  );

  final $_dbc.DBCSignal _setRearTiltSignal = $_dbc.DBCSignal(
    name: 'Set_Rear_Tilt',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 3,
    length: 1,
    mapping: [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [3],
    factor: 1,
    offset: 0,
    min: 0,
    max: 1,
    unit: '',
  );

  final $_dbc.DBCSignal _frontSwivelSignal = $_dbc.DBCSignal(
    name: 'Front_Swivel',
    signalSignedness: $_dbc.DBCSignalSignedness.SIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 4,
    length: 12,
    mapping: [0, 0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15],
    factor: 0.044,
    offset: 0,
    min: -90,
    max: 90,
    unit: '°',
  );

  final $_dbc.DBCSignal _frontTiltSignal = $_dbc.DBCSignal(
    name: 'Front_Tilt',
    signalSignedness: $_dbc.DBCSignalSignedness.SIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 16,
    length: 12,
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27],
    factor: 0.044,
    offset: 0,
    min: -90,
    max: 90,
    unit: '°',
  );

  final $_dbc.DBCSignal _rearSwivelSignal = $_dbc.DBCSignal(
    name: 'Rear_Swivel',
    signalSignedness: $_dbc.DBCSignalSignedness.SIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 28,
    length: 12,
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39],
    factor: 0.044,
    offset: 0,
    min: -90,
    max: 90,
    unit: '°',
  );

  final $_dbc.DBCSignal _rearTiltSignal = $_dbc.DBCSignal(
    name: 'Rear_Tilt',
    signalSignedness: $_dbc.DBCSignalSignedness.SIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 40,
    length: 12,
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 0, 0, 0, 0],
    mappingIndexes: [40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51],
    factor: 0.044,
    offset: 0,
    min: -90,
    max: 90,
    unit: '°',
  );

  @override
  List<$_dbc.DBCSignal> get signals => [
    _setFrontSwivelSignal,
    _setFrontTiltSignal,
    _setRearSwivelSignal,
    _setRearTiltSignal,
    _frontSwivelSignal,
    _frontTiltSignal,
    _rearSwivelSignal,
    _rearTiltSignal,
  ];

  DriveSetSwivelMessage({
    this.setFrontSwivel = 0,
    this.setFrontTilt = 0,
    this.setRearSwivel = 0,
    this.setRearTilt = 0,
    this.frontSwivel = 0,
    this.frontTilt = 0,
    this.rearSwivel = 0,
    this.rearTilt = 0,
  });

  /// Creates a clone of this [DriveSetSwivelMessage] with the non-null values replaced
  DriveSetSwivelMessage copyWith({
    num? setFrontSwivel,
    num? setFrontTilt,
    num? setRearSwivel,
    num? setRearTilt,
    num? frontSwivel,
    num? frontTilt,
    num? rearSwivel,
    num? rearTilt,
  }) => DriveSetSwivelMessage(
    setFrontSwivel: setFrontSwivel ?? this.setFrontSwivel,
    setFrontTilt: setFrontTilt ?? this.setFrontTilt,
    setRearSwivel: setRearSwivel ?? this.setRearSwivel,
    setRearTilt: setRearTilt ?? this.setRearTilt,
    frontSwivel: frontSwivel ?? this.frontSwivel,
    frontTilt: frontTilt ?? this.frontTilt,
    rearSwivel: rearSwivel ?? this.rearSwivel,
    rearTilt: rearTilt ?? this.rearTilt,
  );

  factory DriveSetSwivelMessage.decode(List<int> payload) {
    final message = DriveSetSwivelMessage();
    final typedBuffer = $_typed.Uint8List.fromList(payload);
    final bitField = $_dbc.BitField.from(typedBuffer.sublist(0, message.messageLength));

    message.setFrontSwivel =
        message._setFrontSwivelSignal.decode(bitField) ??
        $_math.max(0, message._setFrontSwivelSignal.min);
    message.setFrontTilt =
        message._setFrontTiltSignal.decode(bitField) ??
        $_math.max(0, message._setFrontTiltSignal.min);
    message.setRearSwivel =
        message._setRearSwivelSignal.decode(bitField) ??
        $_math.max(0, message._setRearSwivelSignal.min);
    message.setRearTilt =
        message._setRearTiltSignal.decode(bitField) ??
        $_math.max(0, message._setRearTiltSignal.min);
    message.frontSwivel =
        message._frontSwivelSignal.decode(bitField) ??
        $_math.max(0, message._frontSwivelSignal.min);
    message.frontTilt =
        message._frontTiltSignal.decode(bitField) ??
        $_math.max(0, message._frontTiltSignal.min);
    message.rearSwivel =
        message._rearSwivelSignal.decode(bitField) ??
        $_math.max(0, message._rearSwivelSignal.min);
    message.rearTilt =
        message._rearTiltSignal.decode(bitField) ??
        $_math.max(0, message._rearTiltSignal.min);

    return message;
  }

  factory DriveSetSwivelMessage.fromJson(Map<String, dynamic> json) =>
      DriveSetSwivelMessage(
        setFrontSwivel: json['Set_Front_Swivel'] ?? 0,
        setFrontTilt: json['Set_Front_Tilt'] ?? 0,
        setRearSwivel: json['Set_Rear_Swivel'] ?? 0,
        setRearTilt: json['Set_Rear_Tilt'] ?? 0,
        frontSwivel: json['Front_Swivel'] ?? 0,
        frontTilt: json['Front_Tilt'] ?? 0,
        rearSwivel: json['Rear_Swivel'] ?? 0,
        rearTilt: json['Rear_Tilt'] ?? 0,
      );

  @override
  $_typed.Uint8List encode() {
    final Map<$_dbc.DBCSignal, num> values = {
      _setFrontSwivelSignal: setFrontSwivel,
      _setFrontTiltSignal: setFrontTilt,
      _setRearSwivelSignal: setRearSwivel,
      _setRearTiltSignal: setRearTilt,
      _frontSwivelSignal: frontSwivel,
      _frontTiltSignal: frontTilt,
      _rearSwivelSignal: rearSwivel,
      _rearTiltSignal: rearTilt,
    };

    return encodeWithValues(values);
  }

  @override
  Map<String, dynamic> toJson() => {
    'Set_Front_Swivel': setFrontSwivel,
    'Set_Front_Tilt': setFrontTilt,
    'Set_Rear_Swivel': setRearSwivel,
    'Set_Rear_Tilt': setRearTilt,
    'Front_Swivel': frontSwivel,
    'Front_Tilt': frontTilt,
    'Rear_Swivel': rearSwivel,
    'Rear_Tilt': rearTilt,
  };

  @override
  String toString() {
    return 'Drive_SetSwivel(\n  Set_Front_Swivel=$setFrontSwivel\n  Set_Front_Tilt=$setFrontTilt\n  Set_Rear_Swivel=$setRearSwivel\n  Set_Rear_Tilt=$setRearTilt\n  Front_Swivel=$frontSwivel\n  Front_Tilt=$frontTilt\n  Rear_Swivel=$rearSwivel\n  Rear_Tilt=$rearTilt\n)';
  }
}

class ArmSetMotorMessage extends $_dbc.DBCMessage {
  @override
  String messageName = 'Arm_Set_Motor';

  @override
  int messageLength = 8;

  @override
  int canId = 0x30;

  /// Whether or not "Arm_Set_Motor" is multiplex
  static const bool isMultiplex = false;

  /// The multiplexor for "Arm_Set_Motor"
  static const String multiplexor = '';

  /// Value of signal "Motor_Value"
  num motorValue;

  /// Value of signal "Move_Steps"
  num moveSteps;

  /// Value of signal "Move_Radians"
  num moveRadians;

  /// Value of signal "Angle"
  num angle;

  final $_dbc.DBCSignal _motorValueSignal = $_dbc.DBCSignal(
    name: 'Motor_Value',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 0,
    length: 3,
    mapping: [1, 2, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [0, 1, 2],
    factor: 1,
    offset: 0,
    min: 0,
    max: 7,
    unit: '',
  );

  final $_dbc.DBCSignal _moveStepsSignal = $_dbc.DBCSignal(
    name: 'Move_Steps',
    signalSignedness: $_dbc.DBCSignalSignedness.SIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 3,
    length: 24,
    mapping: [0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4194304, 8388608, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26],
    factor: 1,
    offset: 0,
    min: -8388608,
    max: 8388608,
    unit: '',
  );

  final $_dbc.DBCSignal _moveRadiansSignal = $_dbc.DBCSignal(
    name: 'Move_Radians',
    signalSignedness: $_dbc.DBCSignalSignedness.SIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 27,
    length: 16,
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42],
    factor: 0.0000958738,
    offset: 0,
    min: -3.1415,
    max: 3.1415,
    unit: '',
  );

  final $_dbc.DBCSignal _angleSignal = $_dbc.DBCSignal(
    name: 'Angle',
    signalSignedness: $_dbc.DBCSignalSignedness.SIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 43,
    length: 16,
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 0, 0, 0, 0, 0],
    mappingIndexes: [43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58],
    factor: 0.0000958738,
    offset: 0,
    min: -3.1415,
    max: -3.1415,
    unit: '',
  );

  @override
  List<$_dbc.DBCSignal> get signals => [
    _motorValueSignal,
    _moveStepsSignal,
    _moveRadiansSignal,
    _angleSignal,
  ];

  ArmSetMotorMessage({
    this.motorValue = 0,
    this.moveSteps = 0,
    this.moveRadians = 0,
    this.angle = 0,
  });

  /// Creates a clone of this [ArmSetMotorMessage] with the non-null values replaced
  ArmSetMotorMessage copyWith({
    num? motorValue,
    num? moveSteps,
    num? moveRadians,
    num? angle,
  }) => ArmSetMotorMessage(
    motorValue: motorValue ?? this.motorValue,
    moveSteps: moveSteps ?? this.moveSteps,
    moveRadians: moveRadians ?? this.moveRadians,
    angle: angle ?? this.angle,
  );

  factory ArmSetMotorMessage.decode(List<int> payload) {
    final message = ArmSetMotorMessage();
    final typedBuffer = $_typed.Uint8List.fromList(payload);
    final bitField = $_dbc.BitField.from(typedBuffer.sublist(0, message.messageLength));

    message.motorValue =
        message._motorValueSignal.decode(bitField) ??
        $_math.max(0, message._motorValueSignal.min);
    message.moveSteps =
        message._moveStepsSignal.decode(bitField) ??
        $_math.max(0, message._moveStepsSignal.min);
    message.moveRadians =
        message._moveRadiansSignal.decode(bitField) ??
        $_math.max(0, message._moveRadiansSignal.min);
    message.angle =
        message._angleSignal.decode(bitField) ??
        $_math.max(0, message._angleSignal.min);

    return message;
  }

  factory ArmSetMotorMessage.fromJson(Map<String, dynamic> json) =>
      ArmSetMotorMessage(
        motorValue: json['Motor_Value'] ?? 0,
        moveSteps: json['Move_Steps'] ?? 0,
        moveRadians: json['Move_Radians'] ?? 0,
        angle: json['Angle'] ?? 0,
      );

  @override
  $_typed.Uint8List encode() {
    final Map<$_dbc.DBCSignal, num> values = {
      _motorValueSignal: motorValue,
      _moveStepsSignal: moveSteps,
      _moveRadiansSignal: moveRadians,
      _angleSignal: angle,
    };

    return encodeWithValues(values);
  }

  @override
  Map<String, dynamic> toJson() => {
    'Motor_Value': motorValue,
    'Move_Steps': moveSteps,
    'Move_Radians': moveRadians,
    'Angle': angle,
  };

  @override
  String toString() {
    return 'Arm_Set_Motor(\n  Motor_Value=$motorValue\n  Move_Steps=$moveSteps\n  Move_Radians=$moveRadians\n  Angle=$angle\n)';
  }
}

class ArmMotorMoveDataMessage extends $_dbc.DBCMessage {
  @override
  String messageName = 'Arm_Motor_Move_Data';

  @override
  int messageLength = 2;

  @override
  int canId = 0x35;

  /// Whether or not "Arm_Motor_Move_Data" is multiplex
  static const bool isMultiplex = false;

  /// The multiplexor for "Arm_Motor_Move_Data"
  static const String multiplexor = '';

  /// Value of signal "Motor_Value"
  num motorValue;

  /// Value of signal "Is_Moving"
  num isMoving;

  /// Value of signal "Is_Limit_Switch_Pressed"
  num isLimitSwitchPressed;

  /// Value of signal "Motor_Direction"
  num motorDirection;

  final $_dbc.DBCSignal _motorValueSignal = $_dbc.DBCSignal(
    name: 'Motor_Value',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 0,
    length: 3,
    mapping: [1, 2, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [0, 1, 2],
    factor: 1,
    offset: 0,
    min: 0,
    max: 7,
    unit: '',
  );

  final $_dbc.DBCSignal _isMovingSignal = $_dbc.DBCSignal(
    name: 'Is_Moving',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 3,
    length: 2,
    mapping: [0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [3, 4],
    factor: 1,
    offset: 0,
    min: 0,
    max: 2,
    unit: '',
  );

  final $_dbc.DBCSignal _isLimitSwitchPressedSignal = $_dbc.DBCSignal(
    name: 'Is_Limit_Switch_Pressed',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 5,
    length: 2,
    mapping: [0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [5, 6],
    factor: 1,
    offset: 0,
    min: 0,
    max: 2,
    unit: '',
  );

  final $_dbc.DBCSignal _motorDirectionSignal = $_dbc.DBCSignal(
    name: 'Motor_Direction',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 7,
    length: 4,
    mapping: [0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 8, 0, 0, 0, 0, 0],
    mappingIndexes: [7, 8, 9, 10],
    factor: 1,
    offset: 0,
    min: 0,
    max: 9,
    unit: '',
  );

  @override
  List<$_dbc.DBCSignal> get signals => [
    _motorValueSignal,
    _isMovingSignal,
    _isLimitSwitchPressedSignal,
    _motorDirectionSignal,
  ];

  ArmMotorMoveDataMessage({
    this.motorValue = 0,
    this.isMoving = 0,
    this.isLimitSwitchPressed = 0,
    this.motorDirection = 0,
  });

  /// Creates a clone of this [ArmMotorMoveDataMessage] with the non-null values replaced
  ArmMotorMoveDataMessage copyWith({
    num? motorValue,
    num? isMoving,
    num? isLimitSwitchPressed,
    num? motorDirection,
  }) => ArmMotorMoveDataMessage(
    motorValue: motorValue ?? this.motorValue,
    isMoving: isMoving ?? this.isMoving,
    isLimitSwitchPressed: isLimitSwitchPressed ?? this.isLimitSwitchPressed,
    motorDirection: motorDirection ?? this.motorDirection,
  );

  factory ArmMotorMoveDataMessage.decode(List<int> payload) {
    final message = ArmMotorMoveDataMessage();
    final typedBuffer = $_typed.Uint8List.fromList(payload);
    final bitField = $_dbc.BitField.from(typedBuffer.sublist(0, message.messageLength));

    message.motorValue =
        message._motorValueSignal.decode(bitField) ??
        $_math.max(0, message._motorValueSignal.min);
    message.isMoving =
        message._isMovingSignal.decode(bitField) ??
        $_math.max(0, message._isMovingSignal.min);
    message.isLimitSwitchPressed =
        message._isLimitSwitchPressedSignal.decode(bitField) ??
        $_math.max(0, message._isLimitSwitchPressedSignal.min);
    message.motorDirection =
        message._motorDirectionSignal.decode(bitField) ??
        $_math.max(0, message._motorDirectionSignal.min);

    return message;
  }

  factory ArmMotorMoveDataMessage.fromJson(Map<String, dynamic> json) =>
      ArmMotorMoveDataMessage(
        motorValue: json['Motor_Value'] ?? 0,
        isMoving: json['Is_Moving'] ?? 0,
        isLimitSwitchPressed: json['Is_Limit_Switch_Pressed'] ?? 0,
        motorDirection: json['Motor_Direction'] ?? 0,
      );

  @override
  $_typed.Uint8List encode() {
    final Map<$_dbc.DBCSignal, num> values = {
      _motorValueSignal: motorValue,
      _isMovingSignal: isMoving,
      _isLimitSwitchPressedSignal: isLimitSwitchPressed,
      _motorDirectionSignal: motorDirection,
    };

    return encodeWithValues(values);
  }

  @override
  Map<String, dynamic> toJson() => {
    'Motor_Value': motorValue,
    'Is_Moving': isMoving,
    'Is_Limit_Switch_Pressed': isLimitSwitchPressed,
    'Motor_Direction': motorDirection,
  };

  @override
  String toString() {
    return 'Arm_Motor_Move_Data(\n  Motor_Value=$motorValue\n  Is_Moving=$isMoving\n  Is_Limit_Switch_Pressed=$isLimitSwitchPressed\n  Motor_Direction=$motorDirection\n)';
  }
}

class ArmMotorStepDataMessage extends $_dbc.DBCMessage {
  @override
  String messageName = 'Arm_Motor_Step_Data';

  @override
  int messageLength = 7;

  @override
  int canId = 0x36;

  /// Whether or not "Arm_Motor_Step_Data" is multiplex
  static const bool isMultiplex = false;

  /// The multiplexor for "Arm_Motor_Step_Data"
  static const String multiplexor = '';

  /// Value of signal "Motor_Value"
  num motorValue;

  /// Value of signal "Current_Step"
  num currentStep;

  /// Value of signal "Target_Step"
  num targetStep;

  final $_dbc.DBCSignal _motorValueSignal = $_dbc.DBCSignal(
    name: 'Motor_Value',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 0,
    length: 3,
    mapping: [1, 2, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [0, 1, 2],
    factor: 1,
    offset: 0,
    min: 0,
    max: 7,
    unit: '',
  );

  final $_dbc.DBCSignal _currentStepSignal = $_dbc.DBCSignal(
    name: 'Current_Step',
    signalSignedness: $_dbc.DBCSignalSignedness.SIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 3,
    length: 24,
    mapping: [0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4194304, 8388608, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26],
    factor: 1,
    offset: 0,
    min: -8388608,
    max: 8388608,
    unit: '',
  );

  final $_dbc.DBCSignal _targetStepSignal = $_dbc.DBCSignal(
    name: 'Target_Step',
    signalSignedness: $_dbc.DBCSignalSignedness.SIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 27,
    length: 24,
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4194304, 8388608, 0, 0, 0, 0, 0],
    mappingIndexes: [27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50],
    factor: 1,
    offset: 0,
    min: -8388608,
    max: 8388608,
    unit: '',
  );

  @override
  List<$_dbc.DBCSignal> get signals => [
    _motorValueSignal,
    _currentStepSignal,
    _targetStepSignal,
  ];

  ArmMotorStepDataMessage({
    this.motorValue = 0,
    this.currentStep = 0,
    this.targetStep = 0,
  });

  /// Creates a clone of this [ArmMotorStepDataMessage] with the non-null values replaced
  ArmMotorStepDataMessage copyWith({
    num? motorValue,
    num? currentStep,
    num? targetStep,
  }) => ArmMotorStepDataMessage(
    motorValue: motorValue ?? this.motorValue,
    currentStep: currentStep ?? this.currentStep,
    targetStep: targetStep ?? this.targetStep,
  );

  factory ArmMotorStepDataMessage.decode(List<int> payload) {
    final message = ArmMotorStepDataMessage();
    final typedBuffer = $_typed.Uint8List.fromList(payload);
    final bitField = $_dbc.BitField.from(typedBuffer.sublist(0, message.messageLength));

    message.motorValue =
        message._motorValueSignal.decode(bitField) ??
        $_math.max(0, message._motorValueSignal.min);
    message.currentStep =
        message._currentStepSignal.decode(bitField) ??
        $_math.max(0, message._currentStepSignal.min);
    message.targetStep =
        message._targetStepSignal.decode(bitField) ??
        $_math.max(0, message._targetStepSignal.min);

    return message;
  }

  factory ArmMotorStepDataMessage.fromJson(Map<String, dynamic> json) =>
      ArmMotorStepDataMessage(
        motorValue: json['Motor_Value'] ?? 0,
        currentStep: json['Current_Step'] ?? 0,
        targetStep: json['Target_Step'] ?? 0,
      );

  @override
  $_typed.Uint8List encode() {
    final Map<$_dbc.DBCSignal, num> values = {
      _motorValueSignal: motorValue,
      _currentStepSignal: currentStep,
      _targetStepSignal: targetStep,
    };

    return encodeWithValues(values);
  }

  @override
  Map<String, dynamic> toJson() => {
    'Motor_Value': motorValue,
    'Current_Step': currentStep,
    'Target_Step': targetStep,
  };

  @override
  String toString() {
    return 'Arm_Motor_Step_Data(\n  Motor_Value=$motorValue\n  Current_Step=$currentStep\n  Target_Step=$targetStep\n)';
  }
}

class ArmMotorAngleDataMessage extends $_dbc.DBCMessage {
  @override
  String messageName = 'Arm_Motor_Angle_Data';

  @override
  int messageLength = 5;

  @override
  int canId = 0x37;

  /// Whether or not "Arm_Motor_Angle_Data" is multiplex
  static const bool isMultiplex = false;

  /// The multiplexor for "Arm_Motor_Angle_Data"
  static const String multiplexor = '';

  /// Value of signal "Motor_Value"
  num motorValue;

  /// Value of signal "Current_Angle"
  num currentAngle;

  /// Value of signal "Target_Angle"
  num targetAngle;

  final $_dbc.DBCSignal _motorValueSignal = $_dbc.DBCSignal(
    name: 'Motor_Value',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 0,
    length: 3,
    mapping: [1, 2, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [0, 1, 2],
    factor: 1,
    offset: 0,
    min: 0,
    max: 7,
    unit: '',
  );

  final $_dbc.DBCSignal _currentAngleSignal = $_dbc.DBCSignal(
    name: 'Current_Angle',
    signalSignedness: $_dbc.DBCSignalSignedness.SIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 3,
    length: 16,
    mapping: [0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18],
    factor: 0.00009587379,
    offset: 0,
    min: -3.14159,
    max: 3.14159,
    unit: '',
  );

  final $_dbc.DBCSignal _targetAngleSignal = $_dbc.DBCSignal(
    name: 'Target_Angle',
    signalSignedness: $_dbc.DBCSignalSignedness.SIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 19,
    length: 16,
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 0, 0, 0, 0, 0],
    mappingIndexes: [19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34],
    factor: 0.00009587379,
    offset: 0,
    min: -3.14159,
    max: 3.14159,
    unit: '',
  );

  @override
  List<$_dbc.DBCSignal> get signals => [
    _motorValueSignal,
    _currentAngleSignal,
    _targetAngleSignal,
  ];

  ArmMotorAngleDataMessage({
    this.motorValue = 0,
    this.currentAngle = 0,
    this.targetAngle = 0,
  });

  /// Creates a clone of this [ArmMotorAngleDataMessage] with the non-null values replaced
  ArmMotorAngleDataMessage copyWith({
    num? motorValue,
    num? currentAngle,
    num? targetAngle,
  }) => ArmMotorAngleDataMessage(
    motorValue: motorValue ?? this.motorValue,
    currentAngle: currentAngle ?? this.currentAngle,
    targetAngle: targetAngle ?? this.targetAngle,
  );

  factory ArmMotorAngleDataMessage.decode(List<int> payload) {
    final message = ArmMotorAngleDataMessage();
    final typedBuffer = $_typed.Uint8List.fromList(payload);
    final bitField = $_dbc.BitField.from(typedBuffer.sublist(0, message.messageLength));

    message.motorValue =
        message._motorValueSignal.decode(bitField) ??
        $_math.max(0, message._motorValueSignal.min);
    message.currentAngle =
        message._currentAngleSignal.decode(bitField) ??
        $_math.max(0, message._currentAngleSignal.min);
    message.targetAngle =
        message._targetAngleSignal.decode(bitField) ??
        $_math.max(0, message._targetAngleSignal.min);

    return message;
  }

  factory ArmMotorAngleDataMessage.fromJson(Map<String, dynamic> json) =>
      ArmMotorAngleDataMessage(
        motorValue: json['Motor_Value'] ?? 0,
        currentAngle: json['Current_Angle'] ?? 0,
        targetAngle: json['Target_Angle'] ?? 0,
      );

  @override
  $_typed.Uint8List encode() {
    final Map<$_dbc.DBCSignal, num> values = {
      _motorValueSignal: motorValue,
      _currentAngleSignal: currentAngle,
      _targetAngleSignal: targetAngle,
    };

    return encodeWithValues(values);
  }

  @override
  Map<String, dynamic> toJson() => {
    'Motor_Value': motorValue,
    'Current_Angle': currentAngle,
    'Target_Angle': targetAngle,
  };

  @override
  String toString() {
    return 'Arm_Motor_Angle_Data(\n  Motor_Value=$motorValue\n  Current_Angle=$currentAngle\n  Target_Angle=$targetAngle\n)';
  }
}

class ArmSystemActionMessage extends $_dbc.DBCMessage {
  @override
  String messageName = 'Arm_System_Action';

  @override
  int messageLength = 1;

  @override
  int canId = 0x31;

  /// Whether or not "Arm_System_Action" is multiplex
  static const bool isMultiplex = false;

  /// The multiplexor for "Arm_System_Action"
  static const String multiplexor = '';

  /// Value of signal "Stop"
  num stop;

  /// Value of signal "Calibrate"
  num calibrate;

  /// Value of signal "Jab"
  num jab;

  final $_dbc.DBCSignal _stopSignal = $_dbc.DBCSignal(
    name: 'Stop',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 0,
    length: 1,
    mapping: [1, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [0],
    factor: 1,
    offset: 0,
    min: 0,
    max: 1,
    unit: '',
  );

  final $_dbc.DBCSignal _calibrateSignal = $_dbc.DBCSignal(
    name: 'Calibrate',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 1,
    length: 1,
    mapping: [0, 1, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [1],
    factor: 1,
    offset: 0,
    min: 0,
    max: 1,
    unit: '',
  );

  final $_dbc.DBCSignal _jabSignal = $_dbc.DBCSignal(
    name: 'Jab',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    multiplexGroup: -1,
    start: 2,
    length: 1,
    mapping: [0, 0, 1, 0, 0, 0, 0, 0],
    mappingIndexes: [2],
    factor: 1,
    offset: 0,
    min: 0,
    max: 1,
    unit: '',
  );

  @override
  List<$_dbc.DBCSignal> get signals => [
    _stopSignal,
    _calibrateSignal,
    _jabSignal,
  ];

  ArmSystemActionMessage({
    this.stop = 0,
    this.calibrate = 0,
    this.jab = 0,
  });

  /// Creates a clone of this [ArmSystemActionMessage] with the non-null values replaced
  ArmSystemActionMessage copyWith({
    num? stop,
    num? calibrate,
    num? jab,
  }) => ArmSystemActionMessage(
    stop: stop ?? this.stop,
    calibrate: calibrate ?? this.calibrate,
    jab: jab ?? this.jab,
  );

  factory ArmSystemActionMessage.decode(List<int> payload) {
    final message = ArmSystemActionMessage();
    final typedBuffer = $_typed.Uint8List.fromList(payload);
    final bitField = $_dbc.BitField.from(typedBuffer.sublist(0, message.messageLength));

    message.stop =
        message._stopSignal.decode(bitField) ??
        $_math.max(0, message._stopSignal.min);
    message.calibrate =
        message._calibrateSignal.decode(bitField) ??
        $_math.max(0, message._calibrateSignal.min);
    message.jab =
        message._jabSignal.decode(bitField) ??
        $_math.max(0, message._jabSignal.min);

    return message;
  }

  factory ArmSystemActionMessage.fromJson(Map<String, dynamic> json) =>
      ArmSystemActionMessage(
        stop: json['Stop'] ?? 0,
        calibrate: json['Calibrate'] ?? 0,
        jab: json['Jab'] ?? 0,
      );

  @override
  $_typed.Uint8List encode() {
    final Map<$_dbc.DBCSignal, num> values = {
      _stopSignal: stop,
      _calibrateSignal: calibrate,
      _jabSignal: jab,
    };

    return encodeWithValues(values);
  }

  @override
  Map<String, dynamic> toJson() => {
    'Stop': stop,
    'Calibrate': calibrate,
    'Jab': jab,
  };

  @override
  String toString() {
    return 'Arm_System_Action(\n  Stop=$stop\n  Calibrate=$calibrate\n  Jab=$jab\n)';
  }
}
