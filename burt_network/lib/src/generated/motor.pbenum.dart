// This is a generated file - do not edit.
//
// Generated from motor.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class MotorDirection extends $pb.ProtobufEnum {
  static const MotorDirection MOTOR_DIRECTION_UNDEFINED =
      MotorDirection._(0, _omitEnumNames ? '' : 'MOTOR_DIRECTION_UNDEFINED');
  static const MotorDirection UP =
      MotorDirection._(1, _omitEnumNames ? '' : 'UP');
  static const MotorDirection DOWN =
      MotorDirection._(2, _omitEnumNames ? '' : 'DOWN');
  static const MotorDirection LEFT =
      MotorDirection._(3, _omitEnumNames ? '' : 'LEFT');
  static const MotorDirection RIGHT =
      MotorDirection._(4, _omitEnumNames ? '' : 'RIGHT');
  static const MotorDirection CLOCKWISE =
      MotorDirection._(5, _omitEnumNames ? '' : 'CLOCKWISE');
  static const MotorDirection COUNTER_CLOCKWISE =
      MotorDirection._(6, _omitEnumNames ? '' : 'COUNTER_CLOCKWISE');
  static const MotorDirection OPENING =
      MotorDirection._(7, _omitEnumNames ? '' : 'OPENING');
  static const MotorDirection CLOSING =
      MotorDirection._(8, _omitEnumNames ? '' : 'CLOSING');
  static const MotorDirection NOT_MOVING =
      MotorDirection._(9, _omitEnumNames ? '' : 'NOT_MOVING');

  static const $core.List<MotorDirection> values = <MotorDirection>[
    MOTOR_DIRECTION_UNDEFINED,
    UP,
    DOWN,
    LEFT,
    RIGHT,
    CLOCKWISE,
    COUNTER_CLOCKWISE,
    OPENING,
    CLOSING,
    NOT_MOVING,
  ];

  static final $core.List<MotorDirection?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 9);
  static MotorDirection? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const MotorDirection._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
