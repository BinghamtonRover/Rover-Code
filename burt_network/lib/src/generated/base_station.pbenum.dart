// This is a generated file - do not edit.
//
// Generated from base_station.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// / How the antenna is being controller.
class AntennaControlMode extends $pb.ProtobufEnum {
  static const AntennaControlMode ANTENNA_CONTROL_MODE_UNDEFINED =
      AntennaControlMode._(
          0, _omitEnumNames ? '' : 'ANTENNA_CONTROL_MODE_UNDEFINED');

  /// / The antenna should automatically move to track the rover's position.
  static const AntennaControlMode TRACK_ROVER =
      AntennaControlMode._(1, _omitEnumNames ? '' : 'TRACK_ROVER');

  /// / The antenna should only move when controlled manually by the operator.
  static const AntennaControlMode MANUAL_CONTROL =
      AntennaControlMode._(2, _omitEnumNames ? '' : 'MANUAL_CONTROL');

  static const $core.List<AntennaControlMode> values = <AntennaControlMode>[
    ANTENNA_CONTROL_MODE_UNDEFINED,
    TRACK_ROVER,
    MANUAL_CONTROL,
  ];

  static final $core.List<AntennaControlMode?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static AntennaControlMode? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const AntennaControlMode._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
