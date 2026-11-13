// This is a generated file - do not edit.
//
// Generated from arm.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ArmMotorData_ErrorCode extends $pb.ProtobufEnum {
  static const ArmMotorData_ErrorCode NO_FAULT =
      ArmMotorData_ErrorCode._(0, _omitEnumNames ? '' : 'NO_FAULT');
  static const ArmMotorData_ErrorCode OVER_TEMP =
      ArmMotorData_ErrorCode._(1, _omitEnumNames ? '' : 'OVER_TEMP');
  static const ArmMotorData_ErrorCode OVER_CURRENT =
      ArmMotorData_ErrorCode._(2, _omitEnumNames ? '' : 'OVER_CURRENT');
  static const ArmMotorData_ErrorCode OVER_VOLTAGE =
      ArmMotorData_ErrorCode._(3, _omitEnumNames ? '' : 'OVER_VOLTAGE');
  static const ArmMotorData_ErrorCode UNDER_VOLTAGE =
      ArmMotorData_ErrorCode._(4, _omitEnumNames ? '' : 'UNDER_VOLTAGE');
  static const ArmMotorData_ErrorCode ENCODER_FAULT =
      ArmMotorData_ErrorCode._(5, _omitEnumNames ? '' : 'ENCODER_FAULT');
  static const ArmMotorData_ErrorCode MOSFET_OVER_TEMP =
      ArmMotorData_ErrorCode._(6, _omitEnumNames ? '' : 'MOSFET_OVER_TEMP');
  static const ArmMotorData_ErrorCode UNKNOWN_ERROR =
      ArmMotorData_ErrorCode._(7, _omitEnumNames ? '' : 'UNKNOWN_ERROR');

  static const $core.List<ArmMotorData_ErrorCode> values =
      <ArmMotorData_ErrorCode>[
    NO_FAULT,
    OVER_TEMP,
    OVER_CURRENT,
    OVER_VOLTAGE,
    UNDER_VOLTAGE,
    ENCODER_FAULT,
    MOSFET_OVER_TEMP,
    UNKNOWN_ERROR,
  ];

  static final $core.List<ArmMotorData_ErrorCode?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 7);
  static ArmMotorData_ErrorCode? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ArmMotorData_ErrorCode._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
