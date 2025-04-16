//
//  Generated code. Do not modify.
//  source: base_station.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// / How the antenna is being controller.
class AntennaControlMode extends $pb.ProtobufEnum {
  static const AntennaControlMode ANTENNA_CONTROL_MODE_UNDEFINED = AntennaControlMode._(0, _omitEnumNames ? '' : 'ANTENNA_CONTROL_MODE_UNDEFINED');
  static const AntennaControlMode TRACK_ROVER = AntennaControlMode._(1, _omitEnumNames ? '' : 'TRACK_ROVER');
  static const AntennaControlMode MANUAL_CONTROL = AntennaControlMode._(2, _omitEnumNames ? '' : 'MANUAL_CONTROL');

  static const $core.List<AntennaControlMode> values = <AntennaControlMode> [
    ANTENNA_CONTROL_MODE_UNDEFINED,
    TRACK_ROVER,
    MANUAL_CONTROL,
  ];

  static final $core.Map<$core.int, AntennaControlMode> _byValue = $pb.ProtobufEnum.initByValue(values);
  static AntennaControlMode? valueOf($core.int value) => _byValue[value];

  const AntennaControlMode._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
