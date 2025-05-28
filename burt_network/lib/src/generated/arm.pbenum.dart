//
//  Generated code. Do not modify.
//  source: arm.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ArmMotor extends $pb.ProtobufEnum {
  static const ArmMotor ARM_MOTOR_UNDEFINED = ArmMotor._(0, _omitEnumNames ? '' : 'ARM_MOTOR_UNDEFINED');
  static const ArmMotor SWIVEL = ArmMotor._(1, _omitEnumNames ? '' : 'SWIVEL');
  static const ArmMotor SHOULDER = ArmMotor._(2, _omitEnumNames ? '' : 'SHOULDER');
  static const ArmMotor ELBOW = ArmMotor._(3, _omitEnumNames ? '' : 'ELBOW');
  static const ArmMotor WRIST = ArmMotor._(4, _omitEnumNames ? '' : 'WRIST');

  static const $core.List<ArmMotor> values = <ArmMotor> [
    ARM_MOTOR_UNDEFINED,
    SWIVEL,
    SHOULDER,
    ELBOW,
    WRIST,
  ];

  static final $core.List<ArmMotor?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 4);
  static ArmMotor? valueOf($core.int value) =>  value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ArmMotor._(super.v, super.n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
