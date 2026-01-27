// This is a generated file - do not edit.
//
// Generated from science.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'science.pbenum.dart';
import 'version.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'science.pbenum.dart';

/// / A command to the science subsystem.
class ScienceCommand extends $pb.GeneratedMessage {
  factory ScienceCommand({
    $core.double? carouselMotor,
    $core.double? scoopMotor,
    $core.double? subsurfaceMotor,
    PumpState? pumps,
    ServoState? funnel,
    ServoState? scoop,
    CarouselCommand? carousel,
    $core.bool? calibrate,
    $core.bool? stop,
    $core.int? sample,
    ScienceState? state,
    $0.Version? version,
  }) {
    final result = create();
    if (carouselMotor != null) result.carouselMotor = carouselMotor;
    if (scoopMotor != null) result.scoopMotor = scoopMotor;
    if (subsurfaceMotor != null) result.subsurfaceMotor = subsurfaceMotor;
    if (pumps != null) result.pumps = pumps;
    if (funnel != null) result.funnel = funnel;
    if (scoop != null) result.scoop = scoop;
    if (carousel != null) result.carousel = carousel;
    if (calibrate != null) result.calibrate = calibrate;
    if (stop != null) result.stop = stop;
    if (sample != null) result.sample = sample;
    if (state != null) result.state = state;
    if (version != null) result.version = version;
    return result;
  }

  ScienceCommand._();

  factory ScienceCommand.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ScienceCommand.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ScienceCommand',
      createEmptyInstance: create)
    ..aD(1, _omitFieldNames ? '' : 'carouselMotor',
        fieldType: $pb.PbFieldType.OF)
    ..aD(2, _omitFieldNames ? '' : 'scoopMotor', fieldType: $pb.PbFieldType.OF)
    ..aD(3, _omitFieldNames ? '' : 'subsurfaceMotor',
        fieldType: $pb.PbFieldType.OF)
    ..aE<PumpState>(4, _omitFieldNames ? '' : 'pumps',
        enumValues: PumpState.values)
    ..aE<ServoState>(5, _omitFieldNames ? '' : 'funnel',
        enumValues: ServoState.values)
    ..aE<ServoState>(6, _omitFieldNames ? '' : 'scoop',
        enumValues: ServoState.values)
    ..aE<CarouselCommand>(7, _omitFieldNames ? '' : 'carousel',
        enumValues: CarouselCommand.values)
    ..aOB(8, _omitFieldNames ? '' : 'calibrate')
    ..aOB(9, _omitFieldNames ? '' : 'stop')
    ..aI(10, _omitFieldNames ? '' : 'sample')
    ..aE<ScienceState>(11, _omitFieldNames ? '' : 'state',
        enumValues: ScienceState.values)
    ..aOM<$0.Version>(12, _omitFieldNames ? '' : 'version',
        subBuilder: $0.Version.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScienceCommand clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScienceCommand copyWith(void Function(ScienceCommand) updates) =>
      super.copyWith((message) => updates(message as ScienceCommand))
          as ScienceCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ScienceCommand create() => ScienceCommand._();
  @$core.override
  ScienceCommand createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ScienceCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ScienceCommand>(create);
  static ScienceCommand? _defaultInstance;

  /// Individual control over each motor. Indicates steps to move
  @$pb.TagNumber(1)
  $core.double get carouselMotor => $_getN(0);
  @$pb.TagNumber(1)
  set carouselMotor($core.double value) => $_setFloat(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCarouselMotor() => $_has(0);
  @$pb.TagNumber(1)
  void clearCarouselMotor() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get scoopMotor => $_getN(1);
  @$pb.TagNumber(2)
  set scoopMotor($core.double value) => $_setFloat(1, value);
  @$pb.TagNumber(2)
  $core.bool hasScoopMotor() => $_has(1);
  @$pb.TagNumber(2)
  void clearScoopMotor() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get subsurfaceMotor => $_getN(2);
  @$pb.TagNumber(3)
  set subsurfaceMotor($core.double value) => $_setFloat(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSubsurfaceMotor() => $_has(2);
  @$pb.TagNumber(3)
  void clearSubsurfaceMotor() => $_clearField(3);

  /// Control over other hardware
  @$pb.TagNumber(4)
  PumpState get pumps => $_getN(3);
  @$pb.TagNumber(4)
  set pumps(PumpState value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasPumps() => $_has(3);
  @$pb.TagNumber(4)
  void clearPumps() => $_clearField(4);

  @$pb.TagNumber(5)
  ServoState get funnel => $_getN(4);
  @$pb.TagNumber(5)
  set funnel(ServoState value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasFunnel() => $_has(4);
  @$pb.TagNumber(5)
  void clearFunnel() => $_clearField(5);

  @$pb.TagNumber(6)
  ServoState get scoop => $_getN(5);
  @$pb.TagNumber(6)
  set scoop(ServoState value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasScoop() => $_has(5);
  @$pb.TagNumber(6)
  void clearScoop() => $_clearField(6);

  @$pb.TagNumber(7)
  CarouselCommand get carousel => $_getN(6);
  @$pb.TagNumber(7)
  set carousel(CarouselCommand value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasCarousel() => $_has(6);
  @$pb.TagNumber(7)
  void clearCarousel() => $_clearField(7);

  /// High level commands
  @$pb.TagNumber(8)
  $core.bool get calibrate => $_getBF(7);
  @$pb.TagNumber(8)
  set calibrate($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasCalibrate() => $_has(7);
  @$pb.TagNumber(8)
  void clearCalibrate() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.bool get stop => $_getBF(8);
  @$pb.TagNumber(9)
  set stop($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasStop() => $_has(8);
  @$pb.TagNumber(9)
  void clearStop() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get sample => $_getIZ(9);
  @$pb.TagNumber(10)
  set sample($core.int value) => $_setSignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasSample() => $_has(9);
  @$pb.TagNumber(10)
  void clearSample() => $_clearField(10);

  @$pb.TagNumber(11)
  ScienceState get state => $_getN(10);
  @$pb.TagNumber(11)
  set state(ScienceState value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasState() => $_has(10);
  @$pb.TagNumber(11)
  void clearState() => $_clearField(11);

  @$pb.TagNumber(12)
  $0.Version get version => $_getN(11);
  @$pb.TagNumber(12)
  set version($0.Version value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasVersion() => $_has(11);
  @$pb.TagNumber(12)
  void clearVersion() => $_clearField(12);
  @$pb.TagNumber(12)
  $0.Version ensureVersion() => $_ensure(11);
}

/// / Data coming from the science subsystem.
class ScienceData extends $pb.GeneratedMessage {
  factory ScienceData({
    $core.int? sample,
    ScienceState? state,
    $core.double? co2,
    $core.double? humidity,
    $core.double? temperature,
    $0.Version? version,
  }) {
    final result = create();
    if (sample != null) result.sample = sample;
    if (state != null) result.state = state;
    if (co2 != null) result.co2 = co2;
    if (humidity != null) result.humidity = humidity;
    if (temperature != null) result.temperature = temperature;
    if (version != null) result.version = version;
    return result;
  }

  ScienceData._();

  factory ScienceData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ScienceData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ScienceData',
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'sample')
    ..aE<ScienceState>(2, _omitFieldNames ? '' : 'state',
        enumValues: ScienceState.values)
    ..aD(3, _omitFieldNames ? '' : 'co2', fieldType: $pb.PbFieldType.OF)
    ..aD(4, _omitFieldNames ? '' : 'humidity', fieldType: $pb.PbFieldType.OF)
    ..aD(5, _omitFieldNames ? '' : 'temperature', fieldType: $pb.PbFieldType.OF)
    ..aOM<$0.Version>(6, _omitFieldNames ? '' : 'version',
        subBuilder: $0.Version.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScienceData clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScienceData copyWith(void Function(ScienceData) updates) =>
      super.copyWith((message) => updates(message as ScienceData))
          as ScienceData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ScienceData create() => ScienceData._();
  @$core.override
  ScienceData createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ScienceData getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ScienceData>(create);
  static ScienceData? _defaultInstance;

  /// High-level data
  @$pb.TagNumber(1)
  $core.int get sample => $_getIZ(0);
  @$pb.TagNumber(1)
  set sample($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSample() => $_has(0);
  @$pb.TagNumber(1)
  void clearSample() => $_clearField(1);

  @$pb.TagNumber(2)
  ScienceState get state => $_getN(1);
  @$pb.TagNumber(2)
  set state(ScienceState value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasState() => $_has(1);
  @$pb.TagNumber(2)
  void clearState() => $_clearField(2);

  /// Sensor data
  @$pb.TagNumber(3)
  $core.double get co2 => $_getN(2);
  @$pb.TagNumber(3)
  set co2($core.double value) => $_setFloat(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCo2() => $_has(2);
  @$pb.TagNumber(3)
  void clearCo2() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get humidity => $_getN(3);
  @$pb.TagNumber(4)
  set humidity($core.double value) => $_setFloat(3, value);
  @$pb.TagNumber(4)
  $core.bool hasHumidity() => $_has(3);
  @$pb.TagNumber(4)
  void clearHumidity() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get temperature => $_getN(4);
  @$pb.TagNumber(5)
  set temperature($core.double value) => $_setFloat(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTemperature() => $_has(4);
  @$pb.TagNumber(5)
  void clearTemperature() => $_clearField(5);

  @$pb.TagNumber(6)
  $0.Version get version => $_getN(5);
  @$pb.TagNumber(6)
  set version($0.Version value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasVersion() => $_has(5);
  @$pb.TagNumber(6)
  void clearVersion() => $_clearField(6);
  @$pb.TagNumber(6)
  $0.Version ensureVersion() => $_ensure(5);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
