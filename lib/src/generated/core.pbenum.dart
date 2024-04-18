//
//  Generated code. Do not modify.
//  source: core.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Device extends $pb.ProtobufEnum {
  static const Device DEVICE_UNDEFINED = Device._(0, _omitEnumNames ? '' : 'DEVICE_UNDEFINED');
  static const Device DASHBOARD = Device._(1, _omitEnumNames ? '' : 'DASHBOARD');
  static const Device SUBSYSTEMS = Device._(2, _omitEnumNames ? '' : 'SUBSYSTEMS');
  static const Device VIDEO = Device._(3, _omitEnumNames ? '' : 'VIDEO');
  static const Device AUTONOMY = Device._(4, _omitEnumNames ? '' : 'AUTONOMY');
  static const Device FIRMWARE = Device._(5, _omitEnumNames ? '' : 'FIRMWARE');
  static const Device ARM = Device._(6, _omitEnumNames ? '' : 'ARM');
  static const Device GRIPPER = Device._(7, _omitEnumNames ? '' : 'GRIPPER');
  static const Device SCIENCE = Device._(8, _omitEnumNames ? '' : 'SCIENCE');
  static const Device DRIVE = Device._(9, _omitEnumNames ? '' : 'DRIVE');

  static const $core.List<Device> values = <Device> [
    DEVICE_UNDEFINED,
    DASHBOARD,
    SUBSYSTEMS,
    VIDEO,
    AUTONOMY,
    FIRMWARE,
    ARM,
    GRIPPER,
    SCIENCE,
    DRIVE,
  ];

  static final $core.Map<$core.int, Device> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Device? valueOf($core.int value) => _byValue[value];

  const Device._($core.int v, $core.String n) : super(v, n);
}

/// / Changes the way the rover listens to incoming commands.
/// /
/// / - When IDLE, all subsystems will ignore all commands
/// / - When MANUAL, all subsystems will accept all commands
/// / - When AUTONOMOUS, the rover will ignore commands from the dashboard
class RoverStatus extends $pb.ProtobufEnum {
  static const RoverStatus DISCONNECTED = RoverStatus._(0, _omitEnumNames ? '' : 'DISCONNECTED');
  static const RoverStatus IDLE = RoverStatus._(1, _omitEnumNames ? '' : 'IDLE');
  static const RoverStatus MANUAL = RoverStatus._(2, _omitEnumNames ? '' : 'MANUAL');
  static const RoverStatus AUTONOMOUS = RoverStatus._(3, _omitEnumNames ? '' : 'AUTONOMOUS');
  static const RoverStatus POWER_OFF = RoverStatus._(4, _omitEnumNames ? '' : 'POWER_OFF');
  static const RoverStatus RESTART = RoverStatus._(5, _omitEnumNames ? '' : 'RESTART');

  static const $core.List<RoverStatus> values = <RoverStatus> [
    DISCONNECTED,
    IDLE,
    MANUAL,
    AUTONOMOUS,
    POWER_OFF,
    RESTART,
  ];

  static final $core.Map<$core.int, RoverStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static RoverStatus? valueOf($core.int value) => _byValue[value];

  const RoverStatus._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
