//
//  Generated code. Do not modify.
//  source: autonomy.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class AutonomyState extends $pb.ProtobufEnum {
  static const AutonomyState AUTONOMY_STATE_UNDEFINED = AutonomyState._(0, _omitEnumNames ? '' : 'AUTONOMY_STATE_UNDEFINED');
  static const AutonomyState PATHING = AutonomyState._(2, _omitEnumNames ? '' : 'PATHING');
  static const AutonomyState APPROACHING = AutonomyState._(3, _omitEnumNames ? '' : 'APPROACHING');
  static const AutonomyState AT_DESTINATION = AutonomyState._(4, _omitEnumNames ? '' : 'AT_DESTINATION');
  static const AutonomyState DRIVING = AutonomyState._(5, _omitEnumNames ? '' : 'DRIVING');
  static const AutonomyState SEARCHING = AutonomyState._(6, _omitEnumNames ? '' : 'SEARCHING');
  static const AutonomyState NO_SOLUTION = AutonomyState._(7, _omitEnumNames ? '' : 'NO_SOLUTION');
  static const AutonomyState ABORTING = AutonomyState._(8, _omitEnumNames ? '' : 'ABORTING');

  static const $core.List<AutonomyState> values = <AutonomyState> [
    AUTONOMY_STATE_UNDEFINED,
    PATHING,
    APPROACHING,
    AT_DESTINATION,
    DRIVING,
    SEARCHING,
    NO_SOLUTION,
    ABORTING,
  ];

  static final $core.Map<$core.int, AutonomyState> _byValue = $pb.ProtobufEnum.initByValue(values);
  static AutonomyState? valueOf($core.int value) => _byValue[value];

  const AutonomyState._($core.int v, $core.String n) : super(v, n);
}

class AutonomyTask extends $pb.ProtobufEnum {
  static const AutonomyTask AUTONOMY_TASK_UNDEFINED = AutonomyTask._(0, _omitEnumNames ? '' : 'AUTONOMY_TASK_UNDEFINED');
  static const AutonomyTask GPS_ONLY = AutonomyTask._(1, _omitEnumNames ? '' : 'GPS_ONLY');
  static const AutonomyTask VISUAL_MARKER = AutonomyTask._(2, _omitEnumNames ? '' : 'VISUAL_MARKER');
  static const AutonomyTask BETWEEN_GATES = AutonomyTask._(3, _omitEnumNames ? '' : 'BETWEEN_GATES');

  static const $core.List<AutonomyTask> values = <AutonomyTask> [
    AUTONOMY_TASK_UNDEFINED,
    GPS_ONLY,
    VISUAL_MARKER,
    BETWEEN_GATES,
  ];

  static final $core.Map<$core.int, AutonomyTask> _byValue = $pb.ProtobufEnum.initByValue(values);
  static AutonomyTask? valueOf($core.int value) => _byValue[value];

  const AutonomyTask._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
