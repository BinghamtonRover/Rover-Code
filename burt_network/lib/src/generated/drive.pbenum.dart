//
//  Generated code. Do not modify.
//  source: drive.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

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

  static final $core.List<ProtoColor?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 4);
  static ProtoColor? valueOf($core.int value) =>  value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ProtoColor._(super.v, super.n);
}

class DriveMotor extends $pb.ProtobufEnum {
  static const DriveMotor DRIVE_MOTOR_UNDEFINED = DriveMotor._(0, _omitEnumNames ? '' : 'DRIVE_MOTOR_UNDEFINED');
  static const DriveMotor FRONT_LEFT = DriveMotor._(1, _omitEnumNames ? '' : 'FRONT_LEFT');
  static const DriveMotor FRONT_RIGHT = DriveMotor._(2, _omitEnumNames ? '' : 'FRONT_RIGHT');
  static const DriveMotor MIDDLE_LEFT = DriveMotor._(3, _omitEnumNames ? '' : 'MIDDLE_LEFT');
  static const DriveMotor MIDDLE_RIGHT = DriveMotor._(4, _omitEnumNames ? '' : 'MIDDLE_RIGHT');
  static const DriveMotor BACK_LEFT = DriveMotor._(5, _omitEnumNames ? '' : 'BACK_LEFT');
  static const DriveMotor BACK_RIGHT = DriveMotor._(6, _omitEnumNames ? '' : 'BACK_RIGHT');

  static const $core.List<DriveMotor> values = <DriveMotor> [
    DRIVE_MOTOR_UNDEFINED,
    FRONT_LEFT,
    FRONT_RIGHT,
    MIDDLE_LEFT,
    MIDDLE_RIGHT,
    BACK_LEFT,
    BACK_RIGHT,
  ];

  static final $core.List<DriveMotor?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 6);
  static DriveMotor? valueOf($core.int value) =>  value < 0 || value >= _byValue.length ? null : _byValue[value];

  const DriveMotor._(super.v, super.n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
