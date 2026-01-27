// AUTO GENERATED FILE, DO NOT MODIFY

// ignore_for_file: type=lint
// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:typed_data' as $_typed;

import 'package:dart_dbc_generator/dart_dbc_generator.dart' as $_dbc;

class DeviceBroadcastMessage extends $_dbc.DBCMessage {
  @override
  final String messageName = 'Device_Broadcast';

  @override
  final int messageLength = 2;

  @override
  final int canId = 0x0;

  /// Whether or not "Device_Broadcast" is multiplex
  static const bool isMultiplex = false;

  /// The multiplexor for "Device_Broadcast"
  static const String multiplexor = '';

  /// Value of signal "Device_Value"
  int deviceValue;

  /// Value of signal "FW_Version_Major"
  int fwVersionMajor;

  /// Value of signal "FW_Version_Minor"
  int fwVersionMinor;

  final $_dbc.DBCSignal _deviceValueSignal = $_dbc.DBCSignal(
    name: 'Device_Value',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    start: 0,
    length: 5,
    // dart format off
    mapping: [1, 2, 4, 8, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [0, 1, 2, 3, 4],
    // dart format on
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
    start: 5,
    length: 4,
    // dart format off
    mapping: [0, 0, 0, 0, 0, 1, 2, 4, 8, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [5, 6, 7, 8],
    // dart format on
    factor: 1,
    offset: 0,
    min: 1,
    max: 15,
    unit: '',
  );

  final $_dbc.DBCSignal _fwVersionMinorSignal = $_dbc.DBCSignal(
    name: 'FW_Version_Minor',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    start: 9,
    length: 4,
    // dart format off
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 8, 0, 0, 0],
    mappingIndexes: [9, 10, 11, 12],
    // dart format on
    factor: 1,
    offset: 0,
    min: 0,
    max: 15,
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
    this.fwVersionMajor = 1,
    this.fwVersionMinor = 0,
  });

  /// Creates a clone of this [DeviceBroadcastMessage] with the non-null values replaced
  DeviceBroadcastMessage copyWith({
    int? deviceValue,
    int? fwVersionMajor,
    int? fwVersionMinor,
  }) => DeviceBroadcastMessage(
    deviceValue: deviceValue ?? this.deviceValue,
    fwVersionMajor: fwVersionMajor ?? this.fwVersionMajor,
    fwVersionMinor: fwVersionMinor ?? this.fwVersionMinor,
  );

  factory DeviceBroadcastMessage.decode(List<int> payload) {
    final message = DeviceBroadcastMessage();
    final typedBuffer = $_typed.Uint8List.fromList(payload);
    final bitField = $_dbc.BitField.from(
      typedBuffer.sublist(0, message.messageLength),
    );

    message.deviceValue = (message._deviceValueSignal.decode(bitField) ?? 0)
        .toInt();
    message.fwVersionMajor =
        (message._fwVersionMajorSignal.decode(bitField) ?? 1).toInt();
    message.fwVersionMinor =
        (message._fwVersionMinorSignal.decode(bitField) ?? 0).toInt();

    return message;
  }

  factory DeviceBroadcastMessage.fromJson(Map<String, dynamic> json) =>
      DeviceBroadcastMessage(
        deviceValue: json['Device_Value'] ?? 0,
        fwVersionMajor: json['FW_Version_Major'] ?? 1,
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
  String toString() =>
      'Device_Broadcast(\n  Device_Value=$deviceValue\n  FW_Version_Major=$fwVersionMajor\n  FW_Version_Minor=$fwVersionMinor\n)';
}

class RoverHeartbeatMessage extends $_dbc.DBCMessage {
  @override
  final String messageName = 'Rover_Heartbeat';

  @override
  final int messageLength = 1;

  @override
  final int canId = 0x1;

  /// Whether or not "Rover_Heartbeat" is multiplex
  static const bool isMultiplex = false;

  /// The multiplexor for "Rover_Heartbeat"
  static const String multiplexor = '';

  /// Value of signal "Rover_Status"
  int roverStatus;

  final $_dbc.DBCSignal _roverStatusSignal = $_dbc.DBCSignal(
    name: 'Rover_Status',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    start: 0,
    length: 4,
    // dart format off
    mapping: [1, 2, 4, 8, 0, 0, 0, 0],
    mappingIndexes: [0, 1, 2, 3],
    // dart format on
    factor: 1,
    offset: 0,
    min: 0,
    max: 5,
    unit: '',
  );

  @override
  List<$_dbc.DBCSignal> get signals => [_roverStatusSignal];

  RoverHeartbeatMessage({this.roverStatus = 0});

  /// Creates a clone of this [RoverHeartbeatMessage] with the non-null values replaced
  RoverHeartbeatMessage copyWith({int? roverStatus}) =>
      RoverHeartbeatMessage(roverStatus: roverStatus ?? this.roverStatus);

  factory RoverHeartbeatMessage.decode(List<int> payload) {
    final message = RoverHeartbeatMessage();
    final typedBuffer = $_typed.Uint8List.fromList(payload);
    final bitField = $_dbc.BitField.from(
      typedBuffer.sublist(0, message.messageLength),
    );

    message.roverStatus = (message._roverStatusSignal.decode(bitField) ?? 0)
        .toInt();

    return message;
  }

  factory RoverHeartbeatMessage.fromJson(Map<String, dynamic> json) =>
      RoverHeartbeatMessage(roverStatus: json['Rover_Status'] ?? 0);

  @override
  $_typed.Uint8List encode() {
    final Map<$_dbc.DBCSignal, num> values = {_roverStatusSignal: roverStatus};

    return encodeWithValues(values);
  }

  @override
  Map<String, dynamic> toJson() => {'Rover_Status': roverStatus};

  @override
  String toString() => 'Rover_Heartbeat(\n  Rover_Status=$roverStatus\n)';
}

class DriveSetSpeedsMessage extends $_dbc.DBCMessage {
  @override
  final String messageName = 'Drive_Set_Speeds';

  @override
  final int messageLength = 7;

  @override
  final int canId = 0x101;

  /// Whether or not "Drive_Set_Speeds" is multiplex
  static const bool isMultiplex = false;

  /// The multiplexor for "Drive_Set_Speeds"
  static const String multiplexor = '';

  /// Value of signal "Should_Set_Left"
  int shouldSetLeft;

  /// Value of signal "Should_Set_Right"
  int shouldSetRight;

  /// Value of signal "Should_Set_Throttle"
  int shouldSetThrottle;

  /// Value of signal "Left_Speed"
  double leftSpeed;

  /// Value of signal "Right_Speed"
  double rightSpeed;

  /// Value of signal "Throttle"
  double throttle;

  final $_dbc.DBCSignal _shouldSetLeftSignal = $_dbc.DBCSignal(
    name: 'Should_Set_Left',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    start: 0,
    length: 1,
    // dart format off
    mapping: [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [0],
    // dart format on
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
    start: 1,
    length: 1,
    // dart format off
    mapping: [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [1],
    // dart format on
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
    start: 2,
    length: 1,
    // dart format off
    mapping: [0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [2],
    // dart format on
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
    start: 3,
    length: 16,
    // dart format off
    mapping: [0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18],
    // dart format on
    factor: 0.00003051850947599719,
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
    start: 19,
    length: 16,
    // dart format off
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34],
    // dart format on
    factor: 0.00003051850947599719,
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
    start: 35,
    length: 16,
    // dart format off
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 0, 0, 0, 0, 0],
    mappingIndexes: [35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50],
    // dart format on
    factor: 0.000015259254737998596,
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
    int? shouldSetLeft,
    int? shouldSetRight,
    int? shouldSetThrottle,
    double? leftSpeed,
    double? rightSpeed,
    double? throttle,
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
    final bitField = $_dbc.BitField.from(
      typedBuffer.sublist(0, message.messageLength),
    );

    message.shouldSetLeft = (message._shouldSetLeftSignal.decode(bitField) ?? 0)
        .toInt();
    message.shouldSetRight =
        (message._shouldSetRightSignal.decode(bitField) ?? 0).toInt();
    message.shouldSetThrottle =
        (message._shouldSetThrottleSignal.decode(bitField) ?? 0).toInt();
    message.leftSpeed = (message._leftSpeedSignal.decode(bitField) ?? 0)
        .toDouble();
    message.rightSpeed = (message._rightSpeedSignal.decode(bitField) ?? 0)
        .toDouble();
    message.throttle = (message._throttleSignal.decode(bitField) ?? 0)
        .toDouble();

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
  String toString() =>
      'Drive_Set_Speeds(\n  Should_Set_Left=$shouldSetLeft\n  Should_Set_Right=$shouldSetRight\n  Should_Set_Throttle=$shouldSetThrottle\n  Left_Speed=$leftSpeed\n  Right_Speed=$rightSpeed\n  Throttle=$throttle\n)';
}

class DriveSetLedMessage extends $_dbc.DBCMessage {
  @override
  final String messageName = 'Drive_Set_LED';

  @override
  final int messageLength = 1;

  @override
  final int canId = 0x102;

  /// Whether or not "Drive_Set_LED" is multiplex
  static const bool isMultiplex = false;

  /// The multiplexor for "Drive_Set_LED"
  static const String multiplexor = '';

  /// Value of signal "Color"
  int color;

  /// Value of signal "Blink"
  int blink;

  final $_dbc.DBCSignal _colorSignal = $_dbc.DBCSignal(
    name: 'Color',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    start: 0,
    length: 4,
    // dart format off
    mapping: [1, 2, 4, 8, 0, 0, 0, 0],
    mappingIndexes: [0, 1, 2, 3],
    // dart format on
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
    start: 4,
    length: 1,
    // dart format off
    mapping: [0, 0, 0, 0, 1, 0, 0, 0],
    mappingIndexes: [4],
    // dart format on
    factor: 1,
    offset: 0,
    min: 0,
    max: 1,
    unit: '',
  );

  @override
  List<$_dbc.DBCSignal> get signals => [_colorSignal, _blinkSignal];

  DriveSetLedMessage({this.color = 0, this.blink = 0});

  /// Creates a clone of this [DriveSetLedMessage] with the non-null values replaced
  DriveSetLedMessage copyWith({int? color, int? blink}) => DriveSetLedMessage(
    color: color ?? this.color,
    blink: blink ?? this.blink,
  );

  factory DriveSetLedMessage.decode(List<int> payload) {
    final message = DriveSetLedMessage();
    final typedBuffer = $_typed.Uint8List.fromList(payload);
    final bitField = $_dbc.BitField.from(
      typedBuffer.sublist(0, message.messageLength),
    );

    message.color = (message._colorSignal.decode(bitField) ?? 0).toInt();
    message.blink = (message._blinkSignal.decode(bitField) ?? 0).toInt();

    return message;
  }

  factory DriveSetLedMessage.fromJson(Map<String, dynamic> json) =>
      DriveSetLedMessage(color: json['Color'] ?? 0, blink: json['Blink'] ?? 0);

  @override
  $_typed.Uint8List encode() {
    final Map<$_dbc.DBCSignal, num> values = {
      _colorSignal: color,
      _blinkSignal: blink,
    };

    return encodeWithValues(values);
  }

  @override
  Map<String, dynamic> toJson() => {'Color': color, 'Blink': blink};

  @override
  String toString() => 'Drive_Set_LED(\n  Color=$color\n  Blink=$blink\n)';
}

class DriveSetSwivelMessage extends $_dbc.DBCMessage {
  @override
  final String messageName = 'Drive_Set_Swivel';

  @override
  final int messageLength = 7;

  @override
  final int canId = 0x103;

  /// Whether or not "Drive_Set_Swivel" is multiplex
  static const bool isMultiplex = false;

  /// The multiplexor for "Drive_Set_Swivel"
  static const String multiplexor = '';

  /// Value of signal "Set_Front_Swivel"
  int setFrontSwivel;

  /// Value of signal "Set_Front_Tilt"
  int setFrontTilt;

  /// Value of signal "Set_Rear_Swivel"
  int setRearSwivel;

  /// Value of signal "Set_Rear_Tilt"
  int setRearTilt;

  /// Value of signal "Front_Swivel"
  double frontSwivel;

  /// Value of signal "Front_Tilt"
  double frontTilt;

  /// Value of signal "Rear_Swivel"
  double rearSwivel;

  /// Value of signal "Rear_Tilt"
  double rearTilt;

  final $_dbc.DBCSignal _setFrontSwivelSignal = $_dbc.DBCSignal(
    name: 'Set_Front_Swivel',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    start: 0,
    length: 1,
    // dart format off
    mapping: [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [0],
    // dart format on
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
    start: 1,
    length: 1,
    // dart format off
    mapping: [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [1],
    // dart format on
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
    start: 2,
    length: 1,
    // dart format off
    mapping: [0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [2],
    // dart format on
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
    start: 3,
    length: 1,
    // dart format off
    mapping: [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [3],
    // dart format on
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
    start: 4,
    length: 12,
    // dart format off
    mapping: [0, 0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15],
    // dart format on
    factor: 0.04396678065461651,
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
    start: 16,
    length: 12,
    // dart format off
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27],
    // dart format on
    factor: 0.04396678065461651,
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
    start: 28,
    length: 12,
    // dart format off
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39],
    // dart format on
    factor: 0.04396678065461651,
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
    start: 40,
    length: 12,
    // dart format off
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 0, 0, 0, 0],
    mappingIndexes: [40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51],
    // dart format on
    factor: 0.04396678065461651,
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
    int? setFrontSwivel,
    int? setFrontTilt,
    int? setRearSwivel,
    int? setRearTilt,
    double? frontSwivel,
    double? frontTilt,
    double? rearSwivel,
    double? rearTilt,
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
    final bitField = $_dbc.BitField.from(
      typedBuffer.sublist(0, message.messageLength),
    );

    message.setFrontSwivel =
        (message._setFrontSwivelSignal.decode(bitField) ?? 0).toInt();
    message.setFrontTilt = (message._setFrontTiltSignal.decode(bitField) ?? 0)
        .toInt();
    message.setRearSwivel = (message._setRearSwivelSignal.decode(bitField) ?? 0)
        .toInt();
    message.setRearTilt = (message._setRearTiltSignal.decode(bitField) ?? 0)
        .toInt();
    message.frontSwivel = (message._frontSwivelSignal.decode(bitField) ?? 0)
        .toDouble();
    message.frontTilt = (message._frontTiltSignal.decode(bitField) ?? 0)
        .toDouble();
    message.rearSwivel = (message._rearSwivelSignal.decode(bitField) ?? 0)
        .toDouble();
    message.rearTilt = (message._rearTiltSignal.decode(bitField) ?? 0)
        .toDouble();

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
  String toString() =>
      'Drive_Set_Swivel(\n  Set_Front_Swivel=$setFrontSwivel\n  Set_Front_Tilt=$setFrontTilt\n  Set_Rear_Swivel=$setRearSwivel\n  Set_Rear_Tilt=$setRearTilt\n  Front_Swivel=$frontSwivel\n  Front_Tilt=$frontTilt\n  Rear_Swivel=$rearSwivel\n  Rear_Tilt=$rearTilt\n)';
}

class DriveAppliedOutputDataMessage extends $_dbc.DBCMessage {
  @override
  final String messageName = 'Drive_Applied_Output_Data';

  @override
  final int messageLength = 6;

  @override
  final int canId = 0x105;

  /// Whether or not "Drive_Applied_Output_Data" is multiplex
  static const bool isMultiplex = false;

  /// The multiplexor for "Drive_Applied_Output_Data"
  static const String multiplexor = '';

  /// Value of signal "Throttle"
  double throttle;

  /// Value of signal "Left_Speed"
  double leftSpeed;

  /// Value of signal "Right_Speed"
  double rightSpeed;

  final $_dbc.DBCSignal _throttleSignal = $_dbc.DBCSignal(
    name: 'Throttle',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    start: 0,
    length: 16,
    // dart format off
    mapping: [1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15],
    // dart format on
    factor: 0.000015259254737998596,
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
    start: 16,
    length: 16,
    // dart format off
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31],
    // dart format on
    factor: 0.00003051850947599719,
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
    start: 32,
    length: 16,
    // dart format off
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768],
    mappingIndexes: [32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47],
    // dart format on
    factor: 0.00003051850947599719,
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

  DriveAppliedOutputDataMessage({
    this.throttle = 0,
    this.leftSpeed = 0,
    this.rightSpeed = 0,
  });

  /// Creates a clone of this [DriveAppliedOutputDataMessage] with the non-null values replaced
  DriveAppliedOutputDataMessage copyWith({
    double? throttle,
    double? leftSpeed,
    double? rightSpeed,
  }) => DriveAppliedOutputDataMessage(
    throttle: throttle ?? this.throttle,
    leftSpeed: leftSpeed ?? this.leftSpeed,
    rightSpeed: rightSpeed ?? this.rightSpeed,
  );

  factory DriveAppliedOutputDataMessage.decode(List<int> payload) {
    final message = DriveAppliedOutputDataMessage();
    final typedBuffer = $_typed.Uint8List.fromList(payload);
    final bitField = $_dbc.BitField.from(
      typedBuffer.sublist(0, message.messageLength),
    );

    message.throttle = (message._throttleSignal.decode(bitField) ?? 0)
        .toDouble();
    message.leftSpeed = (message._leftSpeedSignal.decode(bitField) ?? 0)
        .toDouble();
    message.rightSpeed = (message._rightSpeedSignal.decode(bitField) ?? 0)
        .toDouble();

    return message;
  }

  factory DriveAppliedOutputDataMessage.fromJson(Map<String, dynamic> json) =>
      DriveAppliedOutputDataMessage(
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
  String toString() =>
      'Drive_Applied_Output_Data(\n  Throttle=$throttle\n  Left_Speed=$leftSpeed\n  Right_Speed=$rightSpeed\n)';
}

class DriveBatteryDataMessage extends $_dbc.DBCMessage {
  @override
  final String messageName = 'Drive_Battery_Data';

  @override
  final int messageLength = 5;

  @override
  final int canId = 0x106;

  /// Whether or not "Drive_Battery_Data" is multiplex
  static const bool isMultiplex = false;

  /// The multiplexor for "Drive_Battery_Data"
  static const String multiplexor = '';

  /// Value of signal "Voltage"
  double voltage;

  /// Value of signal "Temperature"
  double temperature;

  /// Value of signal "Current"
  double current;

  final $_dbc.DBCSignal _voltageSignal = $_dbc.DBCSignal(
    name: 'Voltage',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    start: 0,
    length: 10,
    // dart format off
    mapping: [1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
    // dart format on
    factor: 0.03548387097,
    offset: 0,
    min: 0,
    max: 36.3,
    unit: 'V',
  );

  final $_dbc.DBCSignal _temperatureSignal = $_dbc.DBCSignal(
    name: 'Temperature',
    signalSignedness: $_dbc.DBCSignalSignedness.SIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    start: 10,
    length: 12,
    // dart format off
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21],
    // dart format on
    factor: 0.046409379579872984,
    offset: 55,
    min: -40,
    max: 150,
    unit: '°C',
  );

  final $_dbc.DBCSignal _currentSignal = $_dbc.DBCSignal(
    name: 'Current',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    start: 22,
    length: 16,
    // dart format off
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 0, 0],
    mappingIndexes: [22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37],
    // dart format on
    factor: 0.0004577776421399579,
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

  DriveBatteryDataMessage({
    this.voltage = 0,
    this.temperature = 55,
    this.current = 0,
  });

  /// Creates a clone of this [DriveBatteryDataMessage] with the non-null values replaced
  DriveBatteryDataMessage copyWith({
    double? voltage,
    double? temperature,
    double? current,
  }) => DriveBatteryDataMessage(
    voltage: voltage ?? this.voltage,
    temperature: temperature ?? this.temperature,
    current: current ?? this.current,
  );

  factory DriveBatteryDataMessage.decode(List<int> payload) {
    final message = DriveBatteryDataMessage();
    final typedBuffer = $_typed.Uint8List.fromList(payload);
    final bitField = $_dbc.BitField.from(
      typedBuffer.sublist(0, message.messageLength),
    );

    message.voltage = (message._voltageSignal.decode(bitField) ?? 0).toDouble();
    message.temperature = (message._temperatureSignal.decode(bitField) ?? 0)
        .toDouble();
    message.current = (message._currentSignal.decode(bitField) ?? 0).toDouble();

    return message;
  }

  factory DriveBatteryDataMessage.fromJson(Map<String, dynamic> json) =>
      DriveBatteryDataMessage(
        voltage: json['Voltage'] ?? 0,
        temperature: json['Temperature'] ?? 55,
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
  String toString() =>
      'Drive_Battery_Data(\n  Voltage=$voltage\n  Temperature=$temperature\n  Current=$current\n)';
}

class DriveLedDataMessage extends $_dbc.DBCMessage {
  @override
  final String messageName = 'Drive_LED_Data';

  @override
  final int messageLength = 1;

  @override
  final int canId = 0x107;

  /// Whether or not "Drive_LED_Data" is multiplex
  static const bool isMultiplex = false;

  /// The multiplexor for "Drive_LED_Data"
  static const String multiplexor = '';

  /// Value of signal "Color"
  int color;

  /// Value of signal "Blink"
  int blink;

  final $_dbc.DBCSignal _colorSignal = $_dbc.DBCSignal(
    name: 'Color',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    start: 0,
    length: 4,
    // dart format off
    mapping: [1, 2, 4, 8, 0, 0, 0, 0],
    mappingIndexes: [0, 1, 2, 3],
    // dart format on
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
    start: 4,
    length: 1,
    // dart format off
    mapping: [0, 0, 0, 0, 1, 0, 0, 0],
    mappingIndexes: [4],
    // dart format on
    factor: 1,
    offset: 0,
    min: 0,
    max: 1,
    unit: '',
  );

  @override
  List<$_dbc.DBCSignal> get signals => [_colorSignal, _blinkSignal];

  DriveLedDataMessage({this.color = 0, this.blink = 0});

  /// Creates a clone of this [DriveLedDataMessage] with the non-null values replaced
  DriveLedDataMessage copyWith({int? color, int? blink}) => DriveLedDataMessage(
    color: color ?? this.color,
    blink: blink ?? this.blink,
  );

  factory DriveLedDataMessage.decode(List<int> payload) {
    final message = DriveLedDataMessage();
    final typedBuffer = $_typed.Uint8List.fromList(payload);
    final bitField = $_dbc.BitField.from(
      typedBuffer.sublist(0, message.messageLength),
    );

    message.color = (message._colorSignal.decode(bitField) ?? 0).toInt();
    message.blink = (message._blinkSignal.decode(bitField) ?? 0).toInt();

    return message;
  }

  factory DriveLedDataMessage.fromJson(Map<String, dynamic> json) =>
      DriveLedDataMessage(color: json['Color'] ?? 0, blink: json['Blink'] ?? 0);

  @override
  $_typed.Uint8List encode() {
    final Map<$_dbc.DBCSignal, num> values = {
      _colorSignal: color,
      _blinkSignal: blink,
    };

    return encodeWithValues(values);
  }

  @override
  Map<String, dynamic> toJson() => {'Color': color, 'Blink': blink};

  @override
  String toString() => 'Drive_LED_Data(\n  Color=$color\n  Blink=$blink\n)';
}

class DriveSwivelDataMessage extends $_dbc.DBCMessage {
  @override
  final String messageName = 'Drive_Swivel_Data';

  @override
  final int messageLength = 6;

  @override
  final int canId = 0x108;

  /// Whether or not "Drive_Swivel_Data" is multiplex
  static const bool isMultiplex = false;

  /// The multiplexor for "Drive_Swivel_Data"
  static const String multiplexor = '';

  /// Value of signal "Front_Swivel"
  double frontSwivel;

  /// Value of signal "Front_Tilt"
  double frontTilt;

  /// Value of signal "Rear_Swivel"
  double rearSwivel;

  /// Value of signal "Rear_Tilt"
  double rearTilt;

  final $_dbc.DBCSignal _frontSwivelSignal = $_dbc.DBCSignal(
    name: 'Front_Swivel',
    signalSignedness: $_dbc.DBCSignalSignedness.SIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    start: 0,
    length: 12,
    // dart format off
    mapping: [1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
    // dart format on
    factor: 0.04396678065461651,
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
    start: 12,
    length: 12,
    // dart format off
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23],
    // dart format on
    factor: 0.04396678065461651,
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
    start: 24,
    length: 12,
    // dart format off
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35],
    // dart format on
    factor: 0.04396678065461651,
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
    start: 36,
    length: 12,
    // dart format off
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048],
    mappingIndexes: [36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47],
    // dart format on
    factor: 0.04396678065461651,
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

  DriveSwivelDataMessage({
    this.frontSwivel = 0,
    this.frontTilt = 0,
    this.rearSwivel = 0,
    this.rearTilt = 0,
  });

  /// Creates a clone of this [DriveSwivelDataMessage] with the non-null values replaced
  DriveSwivelDataMessage copyWith({
    double? frontSwivel,
    double? frontTilt,
    double? rearSwivel,
    double? rearTilt,
  }) => DriveSwivelDataMessage(
    frontSwivel: frontSwivel ?? this.frontSwivel,
    frontTilt: frontTilt ?? this.frontTilt,
    rearSwivel: rearSwivel ?? this.rearSwivel,
    rearTilt: rearTilt ?? this.rearTilt,
  );

  factory DriveSwivelDataMessage.decode(List<int> payload) {
    final message = DriveSwivelDataMessage();
    final typedBuffer = $_typed.Uint8List.fromList(payload);
    final bitField = $_dbc.BitField.from(
      typedBuffer.sublist(0, message.messageLength),
    );

    message.frontSwivel = (message._frontSwivelSignal.decode(bitField) ?? 0)
        .toDouble();
    message.frontTilt = (message._frontTiltSignal.decode(bitField) ?? 0)
        .toDouble();
    message.rearSwivel = (message._rearSwivelSignal.decode(bitField) ?? 0)
        .toDouble();
    message.rearTilt = (message._rearTiltSignal.decode(bitField) ?? 0)
        .toDouble();

    return message;
  }

  factory DriveSwivelDataMessage.fromJson(Map<String, dynamic> json) =>
      DriveSwivelDataMessage(
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
  String toString() =>
      'Drive_Swivel_Data(\n  Front_Swivel=$frontSwivel\n  Front_Tilt=$frontTilt\n  Rear_Swivel=$rearSwivel\n  Rear_Tilt=$rearTilt\n)';
}

class DriveMotorDataMessage extends $_dbc.DBCMessage {
  @override
  final String messageName = 'Drive_Motor_Data';

  @override
  final int messageLength = 6;

  @override
  final int canId = 0x109;

  /// Whether or not "Drive_Motor_Data" is multiplex
  static const bool isMultiplex = false;

  /// The multiplexor for "Drive_Motor_Data"
  static const String multiplexor = '';

  /// Value of signal "Motor_Value"
  int motorValue;

  /// Value of signal "Speed"
  double speed;

  /// Value of signal "Current"
  double current;

  /// Value of signal "Temperature"
  int temperature;

  /// Value of signal "Error_Code"
  int errorCode;

  final $_dbc.DBCSignal _motorValueSignal = $_dbc.DBCSignal(
    name: 'Motor_Value',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    start: 0,
    length: 3,
    // dart format off
    mapping: [1, 2, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [0, 1, 2],
    // dart format on
    factor: 1,
    offset: 0,
    min: 0,
    max: 6,
    unit: '',
  );

  final $_dbc.DBCSignal _speedSignal = $_dbc.DBCSignal(
    name: 'Speed',
    signalSignedness: $_dbc.DBCSignalSignedness.SIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    start: 3,
    length: 16,
    // dart format off
    mapping: [0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18],
    // dart format on
    factor: 10,
    offset: 0,
    min: -320000,
    max: 320000,
    unit: 'RPM',
  );

  final $_dbc.DBCSignal _currentSignal = $_dbc.DBCSignal(
    name: 'Current',
    signalSignedness: $_dbc.DBCSignalSignedness.SIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    start: 19,
    length: 16,
    // dart format off
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34],
    // dart format on
    factor: 0.1,
    offset: 0,
    min: -60,
    max: 60,
    unit: 'A',
  );

  final $_dbc.DBCSignal _temperatureSignal = $_dbc.DBCSignal(
    name: 'Temperature',
    signalSignedness: $_dbc.DBCSignalSignedness.SIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    start: 35,
    length: 8,
    // dart format off
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 0, 0, 0, 0, 0],
    mappingIndexes: [35, 36, 37, 38, 39, 40, 41, 42],
    // dart format on
    factor: 1,
    offset: 0,
    min: -20,
    max: 127,
    unit: '°C',
  );

  final $_dbc.DBCSignal _errorCodeSignal = $_dbc.DBCSignal(
    name: 'Error_Code',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    start: 43,
    length: 3,
    // dart format off
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 0, 0],
    mappingIndexes: [43, 44, 45],
    // dart format on
    factor: 1,
    offset: 0,
    min: 0,
    max: 7,
    unit: '',
  );

  @override
  List<$_dbc.DBCSignal> get signals => [
    _motorValueSignal,
    _speedSignal,
    _currentSignal,
    _temperatureSignal,
    _errorCodeSignal,
  ];

  DriveMotorDataMessage({
    this.motorValue = 0,
    this.speed = 0,
    this.current = 0,
    this.temperature = 0,
    this.errorCode = 0,
  });

  /// Creates a clone of this [DriveMotorDataMessage] with the non-null values replaced
  DriveMotorDataMessage copyWith({
    int? motorValue,
    double? speed,
    double? current,
    int? temperature,
    int? errorCode,
  }) => DriveMotorDataMessage(
    motorValue: motorValue ?? this.motorValue,
    speed: speed ?? this.speed,
    current: current ?? this.current,
    temperature: temperature ?? this.temperature,
    errorCode: errorCode ?? this.errorCode,
  );

  factory DriveMotorDataMessage.decode(List<int> payload) {
    final message = DriveMotorDataMessage();
    final typedBuffer = $_typed.Uint8List.fromList(payload);
    final bitField = $_dbc.BitField.from(
      typedBuffer.sublist(0, message.messageLength),
    );

    message.motorValue = (message._motorValueSignal.decode(bitField) ?? 0)
        .toInt();
    message.speed = (message._speedSignal.decode(bitField) ?? 0).toDouble();
    message.current = (message._currentSignal.decode(bitField) ?? 0).toDouble();
    message.temperature = (message._temperatureSignal.decode(bitField) ?? 0)
        .toInt();
    message.errorCode = (message._errorCodeSignal.decode(bitField) ?? 0)
        .toInt();

    return message;
  }

  factory DriveMotorDataMessage.fromJson(Map<String, dynamic> json) =>
      DriveMotorDataMessage(
        motorValue: json['Motor_Value'] ?? 0,
        speed: json['Speed'] ?? 0,
        current: json['Current'] ?? 0,
        temperature: json['Temperature'] ?? 0,
        errorCode: json['Error_Code'] ?? 0,
      );

  @override
  $_typed.Uint8List encode() {
    final Map<$_dbc.DBCSignal, num> values = {
      _motorValueSignal: motorValue,
      _speedSignal: speed,
      _currentSignal: current,
      _temperatureSignal: temperature,
      _errorCodeSignal: errorCode,
    };

    return encodeWithValues(values);
  }

  @override
  Map<String, dynamic> toJson() => {
    'Motor_Value': motorValue,
    'Speed': speed,
    'Current': current,
    'Temperature': temperature,
    'Error_Code': errorCode,
  };

  @override
  String toString() =>
      'Drive_Motor_Data(\n  Motor_Value=$motorValue\n  Speed=$speed\n  Current=$current\n  Temperature=$temperature\n  Error_Code=$errorCode\n)';
}

class RelaySetStateMessage extends $_dbc.DBCMessage {
  @override
  final String messageName = 'Relay_Set_State';

  @override
  final int messageLength = 2;

  @override
  final int canId = 0x201;

  /// Whether or not "Relay_Set_State" is multiplex
  static const bool isMultiplex = false;

  /// The multiplexor for "Relay_Set_State"
  static const String multiplexor = '';

  /// Value of signal "Front_Left_Motor"
  int frontLeftMotor;

  /// Value of signal "Front_Right_Motor"
  int frontRightMotor;

  /// Value of signal "Back_Left_Motor"
  int backLeftMotor;

  /// Value of signal "Back_Right_Motor"
  int backRightMotor;

  /// Value of signal "Arm"
  int arm;

  /// Value of signal "Science"
  int science;

  /// Value of signal "Drive"
  int drive;

  final $_dbc.DBCSignal _frontLeftMotorSignal = $_dbc.DBCSignal(
    name: 'Front_Left_Motor',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    start: 0,
    length: 2,
    // dart format off
    mapping: [1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [0, 1],
    // dart format on
    factor: 1,
    offset: 0,
    min: 0,
    max: 3,
    unit: '',
  );

  final $_dbc.DBCSignal _frontRightMotorSignal = $_dbc.DBCSignal(
    name: 'Front_Right_Motor',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    start: 2,
    length: 2,
    // dart format off
    mapping: [0, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [2, 3],
    // dart format on
    factor: 1,
    offset: 0,
    min: 0,
    max: 3,
    unit: '',
  );

  final $_dbc.DBCSignal _backLeftMotorSignal = $_dbc.DBCSignal(
    name: 'Back_Left_Motor',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    start: 4,
    length: 2,
    // dart format off
    mapping: [0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [4, 5],
    // dart format on
    factor: 1,
    offset: 0,
    min: 0,
    max: 3,
    unit: '',
  );

  final $_dbc.DBCSignal _backRightMotorSignal = $_dbc.DBCSignal(
    name: 'Back_Right_Motor',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    start: 6,
    length: 2,
    // dart format off
    mapping: [0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [6, 7],
    // dart format on
    factor: 1,
    offset: 0,
    min: 0,
    max: 3,
    unit: '',
  );

  final $_dbc.DBCSignal _armSignal = $_dbc.DBCSignal(
    name: 'Arm',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    start: 8,
    length: 2,
    // dart format off
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [8, 9],
    // dart format on
    factor: 1,
    offset: 0,
    min: 0,
    max: 3,
    unit: '',
  );

  final $_dbc.DBCSignal _scienceSignal = $_dbc.DBCSignal(
    name: 'Science',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    start: 10,
    length: 2,
    // dart format off
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0],
    mappingIndexes: [10, 11],
    // dart format on
    factor: 1,
    offset: 0,
    min: 0,
    max: 3,
    unit: '',
  );

  final $_dbc.DBCSignal _driveSignal = $_dbc.DBCSignal(
    name: 'Drive',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    start: 12,
    length: 2,
    // dart format off
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0],
    mappingIndexes: [12, 13],
    // dart format on
    factor: 1,
    offset: 0,
    min: 0,
    max: 3,
    unit: '',
  );

  @override
  List<$_dbc.DBCSignal> get signals => [
    _frontLeftMotorSignal,
    _frontRightMotorSignal,
    _backLeftMotorSignal,
    _backRightMotorSignal,
    _armSignal,
    _scienceSignal,
    _driveSignal,
  ];

  RelaySetStateMessage({
    this.frontLeftMotor = 0,
    this.frontRightMotor = 0,
    this.backLeftMotor = 0,
    this.backRightMotor = 0,
    this.arm = 0,
    this.science = 0,
    this.drive = 0,
  });

  /// Creates a clone of this [RelaySetStateMessage] with the non-null values replaced
  RelaySetStateMessage copyWith({
    int? frontLeftMotor,
    int? frontRightMotor,
    int? backLeftMotor,
    int? backRightMotor,
    int? arm,
    int? science,
    int? drive,
  }) => RelaySetStateMessage(
    frontLeftMotor: frontLeftMotor ?? this.frontLeftMotor,
    frontRightMotor: frontRightMotor ?? this.frontRightMotor,
    backLeftMotor: backLeftMotor ?? this.backLeftMotor,
    backRightMotor: backRightMotor ?? this.backRightMotor,
    arm: arm ?? this.arm,
    science: science ?? this.science,
    drive: drive ?? this.drive,
  );

  factory RelaySetStateMessage.decode(List<int> payload) {
    final message = RelaySetStateMessage();
    final typedBuffer = $_typed.Uint8List.fromList(payload);
    final bitField = $_dbc.BitField.from(
      typedBuffer.sublist(0, message.messageLength),
    );

    message.frontLeftMotor =
        (message._frontLeftMotorSignal.decode(bitField) ?? 0).toInt();
    message.frontRightMotor =
        (message._frontRightMotorSignal.decode(bitField) ?? 0).toInt();
    message.backLeftMotor = (message._backLeftMotorSignal.decode(bitField) ?? 0)
        .toInt();
    message.backRightMotor =
        (message._backRightMotorSignal.decode(bitField) ?? 0).toInt();
    message.arm = (message._armSignal.decode(bitField) ?? 0).toInt();
    message.science = (message._scienceSignal.decode(bitField) ?? 0).toInt();
    message.drive = (message._driveSignal.decode(bitField) ?? 0).toInt();

    return message;
  }

  factory RelaySetStateMessage.fromJson(Map<String, dynamic> json) =>
      RelaySetStateMessage(
        frontLeftMotor: json['Front_Left_Motor'] ?? 0,
        frontRightMotor: json['Front_Right_Motor'] ?? 0,
        backLeftMotor: json['Back_Left_Motor'] ?? 0,
        backRightMotor: json['Back_Right_Motor'] ?? 0,
        arm: json['Arm'] ?? 0,
        science: json['Science'] ?? 0,
        drive: json['Drive'] ?? 0,
      );

  @override
  $_typed.Uint8List encode() {
    final Map<$_dbc.DBCSignal, num> values = {
      _frontLeftMotorSignal: frontLeftMotor,
      _frontRightMotorSignal: frontRightMotor,
      _backLeftMotorSignal: backLeftMotor,
      _backRightMotorSignal: backRightMotor,
      _armSignal: arm,
      _scienceSignal: science,
      _driveSignal: drive,
    };

    return encodeWithValues(values);
  }

  @override
  Map<String, dynamic> toJson() => {
    'Front_Left_Motor': frontLeftMotor,
    'Front_Right_Motor': frontRightMotor,
    'Back_Left_Motor': backLeftMotor,
    'Back_Right_Motor': backRightMotor,
    'Arm': arm,
    'Science': science,
    'Drive': drive,
  };

  @override
  String toString() =>
      'Relay_Set_State(\n  Front_Left_Motor=$frontLeftMotor\n  Front_Right_Motor=$frontRightMotor\n  Back_Left_Motor=$backLeftMotor\n  Back_Right_Motor=$backRightMotor\n  Arm=$arm\n  Science=$science\n  Drive=$drive\n)';
}

class RelayStateDataMessage extends $_dbc.DBCMessage {
  @override
  final String messageName = 'Relay_State_Data';

  @override
  final int messageLength = 1;

  @override
  final int canId = 0x205;

  /// Whether or not "Relay_State_Data" is multiplex
  static const bool isMultiplex = false;

  /// The multiplexor for "Relay_State_Data"
  static const String multiplexor = '';

  /// Value of signal "Front_Left_Motor"
  int frontLeftMotor;

  /// Value of signal "Front_Right_Motor"
  int frontRightMotor;

  /// Value of signal "Back_Left_Motor"
  int backLeftMotor;

  /// Value of signal "Back_Right_Motor"
  int backRightMotor;

  /// Value of signal "Drive"
  int drive;

  /// Value of signal "Arm"
  int arm;

  /// Value of signal "Science"
  int science;

  /// Value of signal "Physical_Override"
  int physicalOverride;

  final $_dbc.DBCSignal _frontLeftMotorSignal = $_dbc.DBCSignal(
    name: 'Front_Left_Motor',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    start: 0,
    length: 1,
    // dart format off
    mapping: [1, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [0],
    // dart format on
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
    start: 1,
    length: 1,
    // dart format off
    mapping: [0, 1, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [1],
    // dart format on
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
    start: 2,
    length: 1,
    // dart format off
    mapping: [0, 0, 1, 0, 0, 0, 0, 0],
    mappingIndexes: [2],
    // dart format on
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
    start: 3,
    length: 1,
    // dart format off
    mapping: [0, 0, 0, 1, 0, 0, 0, 0],
    mappingIndexes: [3],
    // dart format on
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
    start: 4,
    length: 1,
    // dart format off
    mapping: [0, 0, 0, 0, 1, 0, 0, 0],
    mappingIndexes: [4],
    // dart format on
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
    start: 5,
    length: 1,
    // dart format off
    mapping: [0, 0, 0, 0, 0, 1, 0, 0],
    mappingIndexes: [5],
    // dart format on
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
    start: 6,
    length: 1,
    // dart format off
    mapping: [0, 0, 0, 0, 0, 0, 1, 0],
    mappingIndexes: [6],
    // dart format on
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
    start: 7,
    length: 1,
    // dart format off
    mapping: [0, 0, 0, 0, 0, 0, 0, 1],
    mappingIndexes: [7],
    // dart format on
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

  RelayStateDataMessage({
    this.frontLeftMotor = 0,
    this.frontRightMotor = 0,
    this.backLeftMotor = 0,
    this.backRightMotor = 0,
    this.drive = 0,
    this.arm = 0,
    this.science = 0,
    this.physicalOverride = 0,
  });

  /// Creates a clone of this [RelayStateDataMessage] with the non-null values replaced
  RelayStateDataMessage copyWith({
    int? frontLeftMotor,
    int? frontRightMotor,
    int? backLeftMotor,
    int? backRightMotor,
    int? drive,
    int? arm,
    int? science,
    int? physicalOverride,
  }) => RelayStateDataMessage(
    frontLeftMotor: frontLeftMotor ?? this.frontLeftMotor,
    frontRightMotor: frontRightMotor ?? this.frontRightMotor,
    backLeftMotor: backLeftMotor ?? this.backLeftMotor,
    backRightMotor: backRightMotor ?? this.backRightMotor,
    drive: drive ?? this.drive,
    arm: arm ?? this.arm,
    science: science ?? this.science,
    physicalOverride: physicalOverride ?? this.physicalOverride,
  );

  factory RelayStateDataMessage.decode(List<int> payload) {
    final message = RelayStateDataMessage();
    final typedBuffer = $_typed.Uint8List.fromList(payload);
    final bitField = $_dbc.BitField.from(
      typedBuffer.sublist(0, message.messageLength),
    );

    message.frontLeftMotor =
        (message._frontLeftMotorSignal.decode(bitField) ?? 0).toInt();
    message.frontRightMotor =
        (message._frontRightMotorSignal.decode(bitField) ?? 0).toInt();
    message.backLeftMotor = (message._backLeftMotorSignal.decode(bitField) ?? 0)
        .toInt();
    message.backRightMotor =
        (message._backRightMotorSignal.decode(bitField) ?? 0).toInt();
    message.drive = (message._driveSignal.decode(bitField) ?? 0).toInt();
    message.arm = (message._armSignal.decode(bitField) ?? 0).toInt();
    message.science = (message._scienceSignal.decode(bitField) ?? 0).toInt();
    message.physicalOverride =
        (message._physicalOverrideSignal.decode(bitField) ?? 0).toInt();

    return message;
  }

  factory RelayStateDataMessage.fromJson(Map<String, dynamic> json) =>
      RelayStateDataMessage(
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
  String toString() =>
      'Relay_State_Data(\n  Front_Left_Motor=$frontLeftMotor\n  Front_Right_Motor=$frontRightMotor\n  Back_Left_Motor=$backLeftMotor\n  Back_Right_Motor=$backRightMotor\n  Drive=$drive\n  Arm=$arm\n  Science=$science\n  Physical_Override=$physicalOverride\n)';
}

class RelayBatteryDataMessage extends $_dbc.DBCMessage {
  @override
  final String messageName = 'Relay_Battery_Data';

  @override
  final int messageLength = 2;

  @override
  final int canId = 0x206;

  /// Whether or not "Relay_Battery_Data" is multiplex
  static const bool isMultiplex = false;

  /// The multiplexor for "Relay_Battery_Data"
  static const String multiplexor = '';

  /// Value of signal "Voltage"
  double voltage;

  final $_dbc.DBCSignal _voltageSignal = $_dbc.DBCSignal(
    name: 'Voltage',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    start: 0,
    length: 10,
    // dart format off
    mapping: [1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
    // dart format on
    factor: 0.03548387097,
    offset: 0,
    min: 0,
    max: 36.3,
    unit: 'V',
  );

  @override
  List<$_dbc.DBCSignal> get signals => [_voltageSignal];

  RelayBatteryDataMessage({this.voltage = 0});

  /// Creates a clone of this [RelayBatteryDataMessage] with the non-null values replaced
  RelayBatteryDataMessage copyWith({double? voltage}) =>
      RelayBatteryDataMessage(voltage: voltage ?? this.voltage);

  factory RelayBatteryDataMessage.decode(List<int> payload) {
    final message = RelayBatteryDataMessage();
    final typedBuffer = $_typed.Uint8List.fromList(payload);
    final bitField = $_dbc.BitField.from(
      typedBuffer.sublist(0, message.messageLength),
    );

    message.voltage = (message._voltageSignal.decode(bitField) ?? 0).toDouble();

    return message;
  }

  factory RelayBatteryDataMessage.fromJson(Map<String, dynamic> json) =>
      RelayBatteryDataMessage(voltage: json['Voltage'] ?? 0);

  @override
  $_typed.Uint8List encode() {
    final Map<$_dbc.DBCSignal, num> values = {_voltageSignal: voltage};

    return encodeWithValues(values);
  }

  @override
  Map<String, dynamic> toJson() => {'Voltage': voltage};

  @override
  String toString() => 'Relay_Battery_Data(\n  Voltage=$voltage\n)';
}

class ArmSetMotorMessage extends $_dbc.DBCMessage {
  @override
  final String messageName = 'Arm_Set_Motor';

  @override
  final int messageLength = 8;

  @override
  final int canId = 0x301;

  /// Whether or not "Arm_Set_Motor" is multiplex
  static const bool isMultiplex = false;

  /// The multiplexor for "Arm_Set_Motor"
  static const String multiplexor = '';

  /// Value of signal "Motor_Value"
  int motorValue;

  /// Value of signal "Move_Steps"
  int moveSteps;

  /// Value of signal "Move_Radians"
  double moveRadians;

  /// Value of signal "Angle"
  double angle;

  final $_dbc.DBCSignal _motorValueSignal = $_dbc.DBCSignal(
    name: 'Motor_Value',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    start: 0,
    length: 3,
    // dart format off
    mapping: [1, 2, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [0, 1, 2],
    // dart format on
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
    start: 3,
    length: 24,
    // dart format off
    mapping: [0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4194304, 8388608, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26],
    // dart format on
    factor: 1,
    offset: 0,
    min: -8388607,
    max: 8388607,
    unit: '',
  );

  final $_dbc.DBCSignal _moveRadiansSignal = $_dbc.DBCSignal(
    name: 'Move_Radians',
    signalSignedness: $_dbc.DBCSignalSignedness.SIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    start: 27,
    length: 16,
    // dart format off
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42],
    // dart format on
    factor: 0.00009587389751884518,
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
    start: 43,
    length: 16,
    // dart format off
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 0, 0, 0, 0, 0],
    mappingIndexes: [43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58],
    // dart format on
    factor: 0.00009587389751884518,
    offset: 0,
    min: -3.1415,
    max: 3.1415,
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
    int? motorValue,
    int? moveSteps,
    double? moveRadians,
    double? angle,
  }) => ArmSetMotorMessage(
    motorValue: motorValue ?? this.motorValue,
    moveSteps: moveSteps ?? this.moveSteps,
    moveRadians: moveRadians ?? this.moveRadians,
    angle: angle ?? this.angle,
  );

  factory ArmSetMotorMessage.decode(List<int> payload) {
    final message = ArmSetMotorMessage();
    final typedBuffer = $_typed.Uint8List.fromList(payload);
    final bitField = $_dbc.BitField.from(
      typedBuffer.sublist(0, message.messageLength),
    );

    message.motorValue = (message._motorValueSignal.decode(bitField) ?? 0)
        .toInt();
    message.moveSteps = (message._moveStepsSignal.decode(bitField) ?? 0)
        .toInt();
    message.moveRadians = (message._moveRadiansSignal.decode(bitField) ?? 0)
        .toDouble();
    message.angle = (message._angleSignal.decode(bitField) ?? 0).toDouble();

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
  String toString() =>
      'Arm_Set_Motor(\n  Motor_Value=$motorValue\n  Move_Steps=$moveSteps\n  Move_Radians=$moveRadians\n  Angle=$angle\n)';
}

class ArmSetSystemActionMessage extends $_dbc.DBCMessage {
  @override
  final String messageName = 'Arm_Set_System_Action';

  @override
  final int messageLength = 1;

  @override
  final int canId = 0x302;

  /// Whether or not "Arm_Set_System_Action" is multiplex
  static const bool isMultiplex = false;

  /// The multiplexor for "Arm_Set_System_Action"
  static const String multiplexor = '';

  /// Value of signal "Stop"
  int stop;

  /// Value of signal "Calibrate"
  int calibrate;

  /// Value of signal "Jab"
  int jab;

  final $_dbc.DBCSignal _stopSignal = $_dbc.DBCSignal(
    name: 'Stop',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    start: 0,
    length: 1,
    // dart format off
    mapping: [1, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [0],
    // dart format on
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
    start: 1,
    length: 1,
    // dart format off
    mapping: [0, 1, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [1],
    // dart format on
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
    start: 2,
    length: 1,
    // dart format off
    mapping: [0, 0, 1, 0, 0, 0, 0, 0],
    mappingIndexes: [2],
    // dart format on
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

  ArmSetSystemActionMessage({this.stop = 0, this.calibrate = 0, this.jab = 0});

  /// Creates a clone of this [ArmSetSystemActionMessage] with the non-null values replaced
  ArmSetSystemActionMessage copyWith({int? stop, int? calibrate, int? jab}) =>
      ArmSetSystemActionMessage(
        stop: stop ?? this.stop,
        calibrate: calibrate ?? this.calibrate,
        jab: jab ?? this.jab,
      );

  factory ArmSetSystemActionMessage.decode(List<int> payload) {
    final message = ArmSetSystemActionMessage();
    final typedBuffer = $_typed.Uint8List.fromList(payload);
    final bitField = $_dbc.BitField.from(
      typedBuffer.sublist(0, message.messageLength),
    );

    message.stop = (message._stopSignal.decode(bitField) ?? 0).toInt();
    message.calibrate = (message._calibrateSignal.decode(bitField) ?? 0)
        .toInt();
    message.jab = (message._jabSignal.decode(bitField) ?? 0).toInt();

    return message;
  }

  factory ArmSetSystemActionMessage.fromJson(Map<String, dynamic> json) =>
      ArmSetSystemActionMessage(
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
  String toString() =>
      'Arm_Set_System_Action(\n  Stop=$stop\n  Calibrate=$calibrate\n  Jab=$jab\n)';
}

class ArmMotorMoveDataMessage extends $_dbc.DBCMessage {
  @override
  final String messageName = 'Arm_Motor_Move_Data';

  @override
  final int messageLength = 2;

  @override
  final int canId = 0x305;

  /// Whether or not "Arm_Motor_Move_Data" is multiplex
  static const bool isMultiplex = false;

  /// The multiplexor for "Arm_Motor_Move_Data"
  static const String multiplexor = '';

  /// Value of signal "Motor_Value"
  int motorValue;

  /// Value of signal "Is_Moving"
  int isMoving;

  /// Value of signal "Is_Limit_Switch_Pressed"
  int isLimitSwitchPressed;

  /// Value of signal "Motor_Direction"
  int motorDirection;

  final $_dbc.DBCSignal _motorValueSignal = $_dbc.DBCSignal(
    name: 'Motor_Value',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    start: 0,
    length: 3,
    // dart format off
    mapping: [1, 2, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [0, 1, 2],
    // dart format on
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
    start: 3,
    length: 2,
    // dart format off
    mapping: [0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [3, 4],
    // dart format on
    factor: 1,
    offset: 0,
    min: 0,
    max: 3,
    unit: '',
  );

  final $_dbc.DBCSignal _isLimitSwitchPressedSignal = $_dbc.DBCSignal(
    name: 'Is_Limit_Switch_Pressed',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    start: 5,
    length: 2,
    // dart format off
    mapping: [0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [5, 6],
    // dart format on
    factor: 1,
    offset: 0,
    min: 0,
    max: 3,
    unit: '',
  );

  final $_dbc.DBCSignal _motorDirectionSignal = $_dbc.DBCSignal(
    name: 'Motor_Direction',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    start: 7,
    length: 4,
    // dart format off
    mapping: [0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 8, 0, 0, 0, 0, 0],
    mappingIndexes: [7, 8, 9, 10],
    // dart format on
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
    int? motorValue,
    int? isMoving,
    int? isLimitSwitchPressed,
    int? motorDirection,
  }) => ArmMotorMoveDataMessage(
    motorValue: motorValue ?? this.motorValue,
    isMoving: isMoving ?? this.isMoving,
    isLimitSwitchPressed: isLimitSwitchPressed ?? this.isLimitSwitchPressed,
    motorDirection: motorDirection ?? this.motorDirection,
  );

  factory ArmMotorMoveDataMessage.decode(List<int> payload) {
    final message = ArmMotorMoveDataMessage();
    final typedBuffer = $_typed.Uint8List.fromList(payload);
    final bitField = $_dbc.BitField.from(
      typedBuffer.sublist(0, message.messageLength),
    );

    message.motorValue = (message._motorValueSignal.decode(bitField) ?? 0)
        .toInt();
    message.isMoving = (message._isMovingSignal.decode(bitField) ?? 0).toInt();
    message.isLimitSwitchPressed =
        (message._isLimitSwitchPressedSignal.decode(bitField) ?? 0).toInt();
    message.motorDirection =
        (message._motorDirectionSignal.decode(bitField) ?? 0).toInt();

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
  String toString() =>
      'Arm_Motor_Move_Data(\n  Motor_Value=$motorValue\n  Is_Moving=$isMoving\n  Is_Limit_Switch_Pressed=$isLimitSwitchPressed\n  Motor_Direction=$motorDirection\n)';
}

class ArmMotorStepDataMessage extends $_dbc.DBCMessage {
  @override
  final String messageName = 'Arm_Motor_Step_Data';

  @override
  final int messageLength = 8;

  @override
  final int canId = 0x306;

  /// Whether or not "Arm_Motor_Step_Data" is multiplex
  static const bool isMultiplex = false;

  /// The multiplexor for "Arm_Motor_Step_Data"
  static const String multiplexor = '';

  /// Value of signal "Motor_Value"
  int motorValue;

  /// Value of signal "Current_Step"
  int currentStep;

  /// Value of signal "Target_Step"
  int targetStep;

  final $_dbc.DBCSignal _motorValueSignal = $_dbc.DBCSignal(
    name: 'Motor_Value',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    start: 0,
    length: 3,
    // dart format off
    mapping: [1, 2, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [0, 1, 2],
    // dart format on
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
    start: 3,
    length: 28,
    // dart format off
    mapping: [0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4194304, 8388608, 16777216, 33554432, 67108864, 134217728, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30],
    // dart format on
    factor: 1,
    offset: 0,
    min: -134217727,
    max: 134217727,
    unit: '',
  );

  final $_dbc.DBCSignal _targetStepSignal = $_dbc.DBCSignal(
    name: 'Target_Step',
    signalSignedness: $_dbc.DBCSignalSignedness.SIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    start: 31,
    length: 28,
    // dart format off
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4194304, 8388608, 16777216, 33554432, 67108864, 134217728, 0, 0, 0, 0, 0],
    mappingIndexes: [31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58],
    // dart format on
    factor: 1,
    offset: 0,
    min: -134217727,
    max: 134217727,
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
    int? motorValue,
    int? currentStep,
    int? targetStep,
  }) => ArmMotorStepDataMessage(
    motorValue: motorValue ?? this.motorValue,
    currentStep: currentStep ?? this.currentStep,
    targetStep: targetStep ?? this.targetStep,
  );

  factory ArmMotorStepDataMessage.decode(List<int> payload) {
    final message = ArmMotorStepDataMessage();
    final typedBuffer = $_typed.Uint8List.fromList(payload);
    final bitField = $_dbc.BitField.from(
      typedBuffer.sublist(0, message.messageLength),
    );

    message.motorValue = (message._motorValueSignal.decode(bitField) ?? 0)
        .toInt();
    message.currentStep = (message._currentStepSignal.decode(bitField) ?? 0)
        .toInt();
    message.targetStep = (message._targetStepSignal.decode(bitField) ?? 0)
        .toInt();

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
  String toString() =>
      'Arm_Motor_Step_Data(\n  Motor_Value=$motorValue\n  Current_Step=$currentStep\n  Target_Step=$targetStep\n)';
}

class ArmMotorAngleDataMessage extends $_dbc.DBCMessage {
  @override
  final String messageName = 'Arm_Motor_Angle_Data';

  @override
  final int messageLength = 5;

  @override
  final int canId = 0x307;

  /// Whether or not "Arm_Motor_Angle_Data" is multiplex
  static const bool isMultiplex = false;

  /// The multiplexor for "Arm_Motor_Angle_Data"
  static const String multiplexor = '';

  /// Value of signal "Motor_Value"
  int motorValue;

  /// Value of signal "Current_Angle"
  double currentAngle;

  /// Value of signal "Target_Angle"
  double targetAngle;

  final $_dbc.DBCSignal _motorValueSignal = $_dbc.DBCSignal(
    name: 'Motor_Value',
    signalSignedness: $_dbc.DBCSignalSignedness.UNSIGNED,
    signalType: $_dbc.DBCSignalType.INTEL,
    signalMode: $_dbc.DBCSignalMode.SIGNAL,
    start: 0,
    length: 3,
    // dart format off
    mapping: [1, 2, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [0, 1, 2],
    // dart format on
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
    start: 3,
    length: 16,
    // dart format off
    mapping: [0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    mappingIndexes: [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18],
    // dart format on
    factor: 0.00009587664418469802,
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
    start: 19,
    length: 16,
    // dart format off
    mapping: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 0, 0, 0, 0, 0],
    mappingIndexes: [19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34],
    // dart format on
    factor: 0.00009587664418469802,
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
    int? motorValue,
    double? currentAngle,
    double? targetAngle,
  }) => ArmMotorAngleDataMessage(
    motorValue: motorValue ?? this.motorValue,
    currentAngle: currentAngle ?? this.currentAngle,
    targetAngle: targetAngle ?? this.targetAngle,
  );

  factory ArmMotorAngleDataMessage.decode(List<int> payload) {
    final message = ArmMotorAngleDataMessage();
    final typedBuffer = $_typed.Uint8List.fromList(payload);
    final bitField = $_dbc.BitField.from(
      typedBuffer.sublist(0, message.messageLength),
    );

    message.motorValue = (message._motorValueSignal.decode(bitField) ?? 0)
        .toInt();
    message.currentAngle = (message._currentAngleSignal.decode(bitField) ?? 0)
        .toDouble();
    message.targetAngle = (message._targetAngleSignal.decode(bitField) ?? 0)
        .toDouble();

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
  String toString() =>
      'Arm_Motor_Angle_Data(\n  Motor_Value=$motorValue\n  Current_Angle=$currentAngle\n  Target_Angle=$targetAngle\n)';
}
