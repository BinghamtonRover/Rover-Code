//
//  Generated code. Do not modify.
//  source: status.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

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
