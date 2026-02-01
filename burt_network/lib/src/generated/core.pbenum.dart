// This is a generated file - do not edit.
//
// Generated from core.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Device extends $pb.ProtobufEnum {
  static const Device DEVICE_UNDEFINED =
      Device._(0, _omitEnumNames ? '' : 'DEVICE_UNDEFINED');
  static const Device DASHBOARD =
      Device._(1, _omitEnumNames ? '' : 'DASHBOARD');
  static const Device SUBSYSTEMS =
      Device._(2, _omitEnumNames ? '' : 'SUBSYSTEMS');
  static const Device VIDEO = Device._(3, _omitEnumNames ? '' : 'VIDEO');
  static const Device AUTONOMY = Device._(4, _omitEnumNames ? '' : 'AUTONOMY');
  static const Device FIRMWARE = Device._(5, _omitEnumNames ? '' : 'FIRMWARE');
  static const Device ARM = Device._(6, _omitEnumNames ? '' : 'ARM');
  static const Device GRIPPER = Device._(7, _omitEnumNames ? '' : 'GRIPPER');
  static const Device SCIENCE = Device._(8, _omitEnumNames ? '' : 'SCIENCE');
  static const Device DRIVE = Device._(9, _omitEnumNames ? '' : 'DRIVE');
  static const Device RELAY = Device._(10, _omitEnumNames ? '' : 'RELAY');
  static const Device BASE_STATION =
      Device._(11, _omitEnumNames ? '' : 'BASE_STATION');
  static const Device ANTENNA = Device._(12, _omitEnumNames ? '' : 'ANTENNA');
  static const Device VISION = Device._(13, _omitEnumNames ? '' : 'VISION');
  static const Device LIDAR = Device._(14, _omitEnumNames ? '' : 'LIDAR');
  static const Device CONTROL_BOARD =
      Device._(15, _omitEnumNames ? '' : 'CONTROL_BOARD');

  static const $core.List<Device> values = <Device>[
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
    RELAY,
    BASE_STATION,
    ANTENNA,
    VISION,
    LIDAR,
    CONTROL_BOARD,
  ];

  static final $core.List<Device?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 15);
  static Device? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const Device._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
