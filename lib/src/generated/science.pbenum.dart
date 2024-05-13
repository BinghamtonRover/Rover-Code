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

/// / The state of a servo. If undefined, don't open or close.
class ServoState extends $pb.ProtobufEnum {
  static const ServoState SERVO_STATE_UNDEFINED = ServoState._(0, _omitEnumNames ? '' : 'SERVO_STATE_UNDEFINED');
  static const ServoState SERVO_OPEN = ServoState._(1, _omitEnumNames ? '' : 'SERVO_OPEN');
  static const ServoState SERVO_CLOSE = ServoState._(2, _omitEnumNames ? '' : 'SERVO_CLOSE');

  static const $core.List<ServoState> values = <ServoState> [
    SERVO_STATE_UNDEFINED,
    SERVO_OPEN,
    SERVO_CLOSE,
  ];

  static final $core.Map<$core.int, ServoState> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ServoState? valueOf($core.int value) => _byValue[value];

  const ServoState._($core.int v, $core.String n) : super(v, n);
}

/// / The state of a pump. If undefined: don't do anything. If fill: turn on, wait, then turn off.
class PumpState extends $pb.ProtobufEnum {
  static const PumpState PUMP_STATE_UNDEFINED = PumpState._(0, _omitEnumNames ? '' : 'PUMP_STATE_UNDEFINED');
  static const PumpState PUMP_ON = PumpState._(1, _omitEnumNames ? '' : 'PUMP_ON');
  static const PumpState PUMP_OFF = PumpState._(2, _omitEnumNames ? '' : 'PUMP_OFF');
  static const PumpState FILL = PumpState._(3, _omitEnumNames ? '' : 'FILL');

  static const $core.List<PumpState> values = <PumpState> [
    PUMP_STATE_UNDEFINED,
    PUMP_ON,
    PUMP_OFF,
    FILL,
  ];

  static final $core.Map<$core.int, PumpState> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PumpState? valueOf($core.int value) => _byValue[value];

  const PumpState._($core.int v, $core.String n) : super(v, n);
}

/// / The state of the science subsystem. If not COLLECT_DATA, don't stream data at all.
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

/// / A command for the carousel and funnel to follow.
class CarouselCommand extends $pb.ProtobufEnum {
  static const CarouselCommand CAROUSEL_COMMAND_UNDEFINED = CarouselCommand._(0, _omitEnumNames ? '' : 'CAROUSEL_COMMAND_UNDEFINED');
  static const CarouselCommand NEXT_TUBE = CarouselCommand._(1, _omitEnumNames ? '' : 'NEXT_TUBE');
  static const CarouselCommand PREV_TUBE = CarouselCommand._(2, _omitEnumNames ? '' : 'PREV_TUBE');
  static const CarouselCommand NEXT_SECTION = CarouselCommand._(3, _omitEnumNames ? '' : 'NEXT_SECTION');
  static const CarouselCommand PREV_SECTION = CarouselCommand._(4, _omitEnumNames ? '' : 'PREV_SECTION');
  static const CarouselCommand FILL_TUBE = CarouselCommand._(5, _omitEnumNames ? '' : 'FILL_TUBE');
  static const CarouselCommand FILL_SECTION = CarouselCommand._(6, _omitEnumNames ? '' : 'FILL_SECTION');

  static const $core.List<CarouselCommand> values = <CarouselCommand> [
    CAROUSEL_COMMAND_UNDEFINED,
    NEXT_TUBE,
    PREV_TUBE,
    NEXT_SECTION,
    PREV_SECTION,
    FILL_TUBE,
    FILL_SECTION,
  ];

  static final $core.Map<$core.int, CarouselCommand> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CarouselCommand? valueOf($core.int value) => _byValue[value];

  const CarouselCommand._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
