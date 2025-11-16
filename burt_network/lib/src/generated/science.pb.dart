//
//  Generated code. Do not modify.
//  source: science.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'science.pbenum.dart';
import 'version.pb.dart' as $1;

export 'science.pbenum.dart';

class ScienceCommand extends $pb.GeneratedMessage {
  factory ScienceCommand() => create();
  ScienceCommand._() : super();
  factory ScienceCommand.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ScienceCommand.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ScienceCommand', createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'carouselMotor', $pb.PbFieldType.OF)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'scoopMotor', $pb.PbFieldType.OF)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'subsurfaceMotor', $pb.PbFieldType.OF)
    ..e<PumpState>(4, _omitFieldNames ? '' : 'pumps', $pb.PbFieldType.OE, defaultOrMaker: PumpState.PUMP_STATE_UNDEFINED, valueOf: PumpState.valueOf, enumValues: PumpState.values)
    ..e<ServoState>(5, _omitFieldNames ? '' : 'funnel', $pb.PbFieldType.OE, defaultOrMaker: ServoState.SERVO_STATE_UNDEFINED, valueOf: ServoState.valueOf, enumValues: ServoState.values)
    ..e<ServoState>(6, _omitFieldNames ? '' : 'scoop', $pb.PbFieldType.OE, defaultOrMaker: ServoState.SERVO_STATE_UNDEFINED, valueOf: ServoState.valueOf, enumValues: ServoState.values)
    ..e<CarouselCommand>(7, _omitFieldNames ? '' : 'carousel', $pb.PbFieldType.OE, defaultOrMaker: CarouselCommand.CAROUSEL_COMMAND_UNDEFINED, valueOf: CarouselCommand.valueOf, enumValues: CarouselCommand.values)
    ..aOB(8, _omitFieldNames ? '' : 'calibrate')
    ..aOB(9, _omitFieldNames ? '' : 'stop')
    ..a<$core.int>(10, _omitFieldNames ? '' : 'sample', $pb.PbFieldType.O3)
    ..e<ScienceState>(11, _omitFieldNames ? '' : 'state', $pb.PbFieldType.OE, defaultOrMaker: ScienceState.SCIENCE_STATE_UNDEFINED, valueOf: ScienceState.valueOf, enumValues: ScienceState.values)
    ..aOM<$1.Version>(12, _omitFieldNames ? '' : 'version', subBuilder: $1.Version.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ScienceCommand clone() => ScienceCommand()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ScienceCommand copyWith(void Function(ScienceCommand) updates) => super.copyWith((message) => updates(message as ScienceCommand)) as ScienceCommand;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ScienceCommand create() => ScienceCommand._();
  ScienceCommand createEmptyInstance() => create();
  static $pb.PbList<ScienceCommand> createRepeated() => $pb.PbList<ScienceCommand>();
  @$core.pragma('dart2js:noInline')
  static ScienceCommand getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ScienceCommand>(create);
  static ScienceCommand? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get carouselMotor => $_getN(0);
  @$pb.TagNumber(1)
  set carouselMotor($core.double v) { $_setFloat(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCarouselMotor() => $_has(0);
  @$pb.TagNumber(1)
  void clearCarouselMotor() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get scoopMotor => $_getN(1);
  @$pb.TagNumber(2)
  set scoopMotor($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasScoopMotor() => $_has(1);
  @$pb.TagNumber(2)
  void clearScoopMotor() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get subsurfaceMotor => $_getN(2);
  @$pb.TagNumber(3)
  set subsurfaceMotor($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSubsurfaceMotor() => $_has(2);
  @$pb.TagNumber(3)
  void clearSubsurfaceMotor() => clearField(3);

  @$pb.TagNumber(4)
  PumpState get pumps => $_getN(3);
  @$pb.TagNumber(4)
  set pumps(PumpState v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasPumps() => $_has(3);
  @$pb.TagNumber(4)
  void clearPumps() => clearField(4);

  @$pb.TagNumber(5)
  ServoState get funnel => $_getN(4);
  @$pb.TagNumber(5)
  set funnel(ServoState v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasFunnel() => $_has(4);
  @$pb.TagNumber(5)
  void clearFunnel() => clearField(5);

  @$pb.TagNumber(6)
  ServoState get scoop => $_getN(5);
  @$pb.TagNumber(6)
  set scoop(ServoState v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasScoop() => $_has(5);
  @$pb.TagNumber(6)
  void clearScoop() => clearField(6);

  @$pb.TagNumber(7)
  CarouselCommand get carousel => $_getN(6);
  @$pb.TagNumber(7)
  set carousel(CarouselCommand v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasCarousel() => $_has(6);
  @$pb.TagNumber(7)
  void clearCarousel() => clearField(7);

  @$pb.TagNumber(8)
  $core.bool get calibrate => $_getBF(7);
  @$pb.TagNumber(8)
  set calibrate($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasCalibrate() => $_has(7);
  @$pb.TagNumber(8)
  void clearCalibrate() => clearField(8);

  @$pb.TagNumber(9)
  $core.bool get stop => $_getBF(8);
  @$pb.TagNumber(9)
  set stop($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasStop() => $_has(8);
  @$pb.TagNumber(9)
  void clearStop() => clearField(9);

  @$pb.TagNumber(10)
  $core.int get sample => $_getIZ(9);
  @$pb.TagNumber(10)
  set sample($core.int v) { $_setSignedInt32(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasSample() => $_has(9);
  @$pb.TagNumber(10)
  void clearSample() => clearField(10);

  @$pb.TagNumber(11)
  ScienceState get state => $_getN(10);
  @$pb.TagNumber(11)
  set state(ScienceState v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasState() => $_has(10);
  @$pb.TagNumber(11)
  void clearState() => clearField(11);

  @$pb.TagNumber(12)
  $1.Version get version => $_getN(11);
  @$pb.TagNumber(12)
  set version($1.Version v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasVersion() => $_has(11);
  @$pb.TagNumber(12)
  void clearVersion() => clearField(12);
  @$pb.TagNumber(12)
  $1.Version ensureVersion() => $_ensure(11);
}

class ScienceData extends $pb.GeneratedMessage {
  factory ScienceData() => create();
  ScienceData._() : super();
  factory ScienceData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ScienceData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ScienceData', createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'sample', $pb.PbFieldType.O3)
    ..e<ScienceState>(2, _omitFieldNames ? '' : 'state', $pb.PbFieldType.OE, defaultOrMaker: ScienceState.SCIENCE_STATE_UNDEFINED, valueOf: ScienceState.valueOf, enumValues: ScienceState.values)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'co2', $pb.PbFieldType.OF)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'humidity', $pb.PbFieldType.OF)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'temperature', $pb.PbFieldType.OF)
    ..aOM<$1.Version>(6, _omitFieldNames ? '' : 'version', subBuilder: $1.Version.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ScienceData clone() => ScienceData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ScienceData copyWith(void Function(ScienceData) updates) => super.copyWith((message) => updates(message as ScienceData)) as ScienceData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ScienceData create() => ScienceData._();
  ScienceData createEmptyInstance() => create();
  static $pb.PbList<ScienceData> createRepeated() => $pb.PbList<ScienceData>();
  @$core.pragma('dart2js:noInline')
  static ScienceData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ScienceData>(create);
  static ScienceData? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get sample => $_getIZ(0);
  @$pb.TagNumber(1)
  set sample($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSample() => $_has(0);
  @$pb.TagNumber(1)
  void clearSample() => clearField(1);

  @$pb.TagNumber(2)
  ScienceState get state => $_getN(1);
  @$pb.TagNumber(2)
  set state(ScienceState v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasState() => $_has(1);
  @$pb.TagNumber(2)
  void clearState() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get co2 => $_getN(2);
  @$pb.TagNumber(3)
  set co2($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCo2() => $_has(2);
  @$pb.TagNumber(3)
  void clearCo2() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get humidity => $_getN(3);
  @$pb.TagNumber(4)
  set humidity($core.double v) { $_setFloat(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasHumidity() => $_has(3);
  @$pb.TagNumber(4)
  void clearHumidity() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get temperature => $_getN(4);
  @$pb.TagNumber(5)
  set temperature($core.double v) { $_setFloat(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTemperature() => $_has(4);
  @$pb.TagNumber(5)
  void clearTemperature() => clearField(5);

  @$pb.TagNumber(6)
  $1.Version get version => $_getN(5);
  @$pb.TagNumber(6)
  set version($1.Version v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasVersion() => $_has(5);
  @$pb.TagNumber(6)
  void clearVersion() => clearField(6);
  @$pb.TagNumber(6)
  $1.Version ensureVersion() => $_ensure(5);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
