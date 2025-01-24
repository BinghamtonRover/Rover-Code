//
//  Generated code. Do not modify.
//  source: motor.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class MotorDirection extends $pb.ProtobufEnum {
  static const MotorDirection MOTOR_DIRECTION_UNDEFINED = MotorDirection._(0, _omitEnumNames ? '' : 'MOTOR_DIRECTION_UNDEFINED');
  static const MotorDirection UP = MotorDirection._(1, _omitEnumNames ? '' : 'UP');
  static const MotorDirection DOWN = MotorDirection._(2, _omitEnumNames ? '' : 'DOWN');
  static const MotorDirection LEFT = MotorDirection._(3, _omitEnumNames ? '' : 'LEFT');
  static const MotorDirection RIGHT = MotorDirection._(4, _omitEnumNames ? '' : 'RIGHT');
  static const MotorDirection CLOCKWISE = MotorDirection._(5, _omitEnumNames ? '' : 'CLOCKWISE');
  static const MotorDirection COUNTER_CLOCKWISE = MotorDirection._(6, _omitEnumNames ? '' : 'COUNTER_CLOCKWISE');
  static const MotorDirection OPENING = MotorDirection._(7, _omitEnumNames ? '' : 'OPENING');
  static const MotorDirection CLOSING = MotorDirection._(8, _omitEnumNames ? '' : 'CLOSING');
  static const MotorDirection NOT_MOVING = MotorDirection._(9, _omitEnumNames ? '' : 'NOT_MOVING');

  static const $core.List<MotorDirection> values = <MotorDirection> [
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

  static final $core.Map<$core.int, MotorDirection> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MotorDirection? valueOf($core.int value) => _byValue[value];

  const MotorDirection._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
