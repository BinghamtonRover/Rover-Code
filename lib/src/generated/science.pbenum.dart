//
//  Generated code. Do not modify.
//  source: science.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class PumpState extends $pb.ProtobufEnum {
  static const PumpState PUMP_STATE_UNDEFINED = PumpState._(0, _omitEnumNames ? '' : 'PUMP_STATE_UNDEFINED');
  static const PumpState PUMP_ON = PumpState._(1, _omitEnumNames ? '' : 'PUMP_ON');
  static const PumpState PUMP_OFF = PumpState._(2, _omitEnumNames ? '' : 'PUMP_OFF');

  static const $core.List<PumpState> values = <PumpState> [
    PUMP_STATE_UNDEFINED,
    PUMP_ON,
    PUMP_OFF,
  ];

  static final $core.Map<$core.int, PumpState> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PumpState? valueOf($core.int value) => _byValue[value];

  const PumpState._($core.int v, $core.String n) : super(v, n);
}

class DirtReleaseState extends $pb.ProtobufEnum {
  static const DirtReleaseState DIRT_RELEASE_STATE_UNDEFINED = DirtReleaseState._(0, _omitEnumNames ? '' : 'DIRT_RELEASE_STATE_UNDEFINED');
  static const DirtReleaseState OPEN_DIRT = DirtReleaseState._(1, _omitEnumNames ? '' : 'OPEN_DIRT');
  static const DirtReleaseState CLOSE_DIRT = DirtReleaseState._(2, _omitEnumNames ? '' : 'CLOSE_DIRT');

  static const $core.List<DirtReleaseState> values = <DirtReleaseState> [
    DIRT_RELEASE_STATE_UNDEFINED,
    OPEN_DIRT,
    CLOSE_DIRT,
  ];

  static final $core.Map<$core.int, DirtReleaseState> _byValue = $pb.ProtobufEnum.initByValue(values);
  static DirtReleaseState? valueOf($core.int value) => _byValue[value];

  const DirtReleaseState._($core.int v, $core.String n) : super(v, n);
}

class ScienceState extends $pb.ProtobufEnum {
  static const ScienceState SCIENCE_STATE_UNDEFINED = ScienceState._(0, _omitEnumNames ? '' : 'SCIENCE_STATE_UNDEFINED');
  static const ScienceState COLLECT_DATA = ScienceState._(1, _omitEnumNames ? '' : 'COLLECT_DATA');
  static const ScienceState STOP_COLLECTING = ScienceState._(2, _omitEnumNames ? '' : 'STOP_COLLECTING');

  static const $core.List<ScienceState> values = <ScienceState> [
    SCIENCE_STATE_UNDEFINED,
    COLLECT_DATA,
    STOP_COLLECTING,
  ];

  static final $core.Map<$core.int, ScienceState> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ScienceState? valueOf($core.int value) => _byValue[value];

  const ScienceState._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
