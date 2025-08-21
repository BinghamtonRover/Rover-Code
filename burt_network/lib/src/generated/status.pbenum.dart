// This is a generated file - do not edit.
//
// Generated from status.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// / Changes the way the rover listens to incoming commands.
/// /
/// / - When IDLE, all subsystems will ignore all commands
/// / - When MANUAL, all subsystems will accept all commands
/// / - When AUTONOMOUS, the rover will ignore commands from the dashboard
class RoverStatus extends $pb.ProtobufEnum {
  static const RoverStatus DISCONNECTED =
      RoverStatus._(0, _omitEnumNames ? '' : 'DISCONNECTED');
  static const RoverStatus IDLE =
      RoverStatus._(1, _omitEnumNames ? '' : 'IDLE');
  static const RoverStatus MANUAL =
      RoverStatus._(2, _omitEnumNames ? '' : 'MANUAL');
  static const RoverStatus AUTONOMOUS =
      RoverStatus._(3, _omitEnumNames ? '' : 'AUTONOMOUS');
  static const RoverStatus POWER_OFF =
      RoverStatus._(4, _omitEnumNames ? '' : 'POWER_OFF');
  static const RoverStatus RESTART =
      RoverStatus._(5, _omitEnumNames ? '' : 'RESTART');

  static const $core.List<RoverStatus> values = <RoverStatus>[
    DISCONNECTED,
    IDLE,
    MANUAL,
    AUTONOMOUS,
    POWER_OFF,
    RESTART,
  ];

  static final $core.List<RoverStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 5);
  static RoverStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const RoverStatus._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
