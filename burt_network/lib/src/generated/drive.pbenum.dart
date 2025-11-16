//
//  Generated code. Do not modify.
//  source: drive.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class DriveMotor extends $pb.ProtobufEnum {
  static const DriveMotor FRONT_LEFT = DriveMotor._(0, _omitEnumNames ? '' : 'FRONT_LEFT');
  static const DriveMotor FRONT_RIGHT = DriveMotor._(1, _omitEnumNames ? '' : 'FRONT_RIGHT');
  static const DriveMotor MIDDLE_LEFT = DriveMotor._(3, _omitEnumNames ? '' : 'MIDDLE_LEFT');
  static const DriveMotor MIDDLE_RIGHT = DriveMotor._(4, _omitEnumNames ? '' : 'MIDDLE_RIGHT');
  static const DriveMotor BACK_LEFT = DriveMotor._(5, _omitEnumNames ? '' : 'BACK_LEFT');
  static const DriveMotor BACK_RIGHT = DriveMotor._(6, _omitEnumNames ? '' : 'BACK_RIGHT');

  static const $core.List<DriveMotor> values = <DriveMotor> [
    FRONT_LEFT,
    FRONT_RIGHT,
    MIDDLE_LEFT,
    MIDDLE_RIGHT,
    BACK_LEFT,
    BACK_RIGHT,
  ];

  static final $core.Map<$core.int, DriveMotor> _byValue = $pb.ProtobufEnum.initByValue(values);
  static DriveMotor? valueOf($core.int value) => _byValue[value];

  const DriveMotor._($core.int v, $core.String n) : super(v, n);
}

class ProtoColor extends $pb.ProtobufEnum {
  static const ProtoColor PROTO_COLOR_UNDEFINED = ProtoColor._(0, _omitEnumNames ? '' : 'PROTO_COLOR_UNDEFINED');
  static const ProtoColor RED = ProtoColor._(1, _omitEnumNames ? '' : 'RED');
  static const ProtoColor GREEN = ProtoColor._(2, _omitEnumNames ? '' : 'GREEN');
  static const ProtoColor BLUE = ProtoColor._(3, _omitEnumNames ? '' : 'BLUE');
  static const ProtoColor UNLIT = ProtoColor._(4, _omitEnumNames ? '' : 'UNLIT');

  static const $core.List<ProtoColor> values = <ProtoColor> [
    PROTO_COLOR_UNDEFINED,
    RED,
    GREEN,
    BLUE,
    UNLIT,
  ];

  static final $core.Map<$core.int, ProtoColor> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ProtoColor? valueOf($core.int value) => _byValue[value];

  const ProtoColor._($core.int v, $core.String n) : super(v, n);
}

class MotorErrorCode extends $pb.ProtobufEnum {
  static const MotorErrorCode NO_FAULT = MotorErrorCode._(0, _omitEnumNames ? '' : 'NO_FAULT');
  static const MotorErrorCode OVER_TEMP = MotorErrorCode._(1, _omitEnumNames ? '' : 'OVER_TEMP');
  static const MotorErrorCode OVER_CURRENT = MotorErrorCode._(2, _omitEnumNames ? '' : 'OVER_CURRENT');
  static const MotorErrorCode OVER_VOLTAGE = MotorErrorCode._(3, _omitEnumNames ? '' : 'OVER_VOLTAGE');
  static const MotorErrorCode UNDER_VOLTAGE = MotorErrorCode._(4, _omitEnumNames ? '' : 'UNDER_VOLTAGE');
  static const MotorErrorCode ENCODER_FAULT = MotorErrorCode._(5, _omitEnumNames ? '' : 'ENCODER_FAULT');
  static const MotorErrorCode MOSFET_OVER_TEMP = MotorErrorCode._(6, _omitEnumNames ? '' : 'MOSFET_OVER_TEMP');
  static const MotorErrorCode UNKNOWN_ERROR = MotorErrorCode._(7, _omitEnumNames ? '' : 'UNKNOWN_ERROR');

  static const $core.List<MotorErrorCode> values = <MotorErrorCode> [
    NO_FAULT,
    OVER_TEMP,
    OVER_CURRENT,
    OVER_VOLTAGE,
    UNDER_VOLTAGE,
    ENCODER_FAULT,
    MOSFET_OVER_TEMP,
    UNKNOWN_ERROR,
  ];

  static final $core.Map<$core.int, MotorErrorCode> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MotorErrorCode? valueOf($core.int value) => _byValue[value];

  const MotorErrorCode._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
