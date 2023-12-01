//
//  Generated code. Do not modify.
//  source: electrical.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'core.pbenum.dart' as $1;

class ElectricalCommand extends $pb.GeneratedMessage {
  factory ElectricalCommand({
    $1.RoverStatus? status,
  }) {
    final $result = create();
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  ElectricalCommand._() : super();
  factory ElectricalCommand.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ElectricalCommand.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ElectricalCommand', createEmptyInstance: create)
    ..e<$1.RoverStatus>(10, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: $1.RoverStatus.DISCONNECTED, valueOf: $1.RoverStatus.valueOf, enumValues: $1.RoverStatus.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ElectricalCommand clone() => ElectricalCommand()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ElectricalCommand copyWith(void Function(ElectricalCommand) updates) => super.copyWith((message) => updates(message as ElectricalCommand)) as ElectricalCommand;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ElectricalCommand create() => ElectricalCommand._();
  ElectricalCommand createEmptyInstance() => create();
  static $pb.PbList<ElectricalCommand> createRepeated() => $pb.PbList<ElectricalCommand>();
  @$core.pragma('dart2js:noInline')
  static ElectricalCommand getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ElectricalCommand>(create);
  static ElectricalCommand? _defaultInstance;

  @$pb.TagNumber(10)
  $1.RoverStatus get status => $_getN(0);
  @$pb.TagNumber(10)
  set status($1.RoverStatus v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(10)
  void clearStatus() => clearField(10);
}

class PowerSourceStatus extends $pb.GeneratedMessage {
  factory PowerSourceStatus({
    $core.double? current,
    $core.double? voltage,
    $core.double? temperature,
  }) {
    final $result = create();
    if (current != null) {
      $result.current = current;
    }
    if (voltage != null) {
      $result.voltage = voltage;
    }
    if (temperature != null) {
      $result.temperature = temperature;
    }
    return $result;
  }
  PowerSourceStatus._() : super();
  factory PowerSourceStatus.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PowerSourceStatus.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PowerSourceStatus', createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'current', $pb.PbFieldType.OF)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'voltage', $pb.PbFieldType.OF)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'temperature', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PowerSourceStatus clone() => PowerSourceStatus()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PowerSourceStatus copyWith(void Function(PowerSourceStatus) updates) => super.copyWith((message) => updates(message as PowerSourceStatus)) as PowerSourceStatus;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PowerSourceStatus create() => PowerSourceStatus._();
  PowerSourceStatus createEmptyInstance() => create();
  static $pb.PbList<PowerSourceStatus> createRepeated() => $pb.PbList<PowerSourceStatus>();
  @$core.pragma('dart2js:noInline')
  static PowerSourceStatus getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PowerSourceStatus>(create);
  static PowerSourceStatus? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get current => $_getN(0);
  @$pb.TagNumber(1)
  set current($core.double v) { $_setFloat(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCurrent() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrent() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get voltage => $_getN(1);
  @$pb.TagNumber(2)
  set voltage($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasVoltage() => $_has(1);
  @$pb.TagNumber(2)
  void clearVoltage() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get temperature => $_getN(2);
  @$pb.TagNumber(3)
  set temperature($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTemperature() => $_has(2);
  @$pb.TagNumber(3)
  void clearTemperature() => clearField(3);
}

class ElectricalData extends $pb.GeneratedMessage {
  factory ElectricalData({
    $core.double? v5Current,
    $core.double? v5Voltage,
    $core.double? v5Temperature,
    $core.double? v12Current,
    $core.double? v12Voltage,
    $core.double? v12Temperature,
    $core.double? batteryCurrent,
    $core.double? batteryVoltage,
    $core.double? batteryTemperature,
  }) {
    final $result = create();
    if (v5Current != null) {
      $result.v5Current = v5Current;
    }
    if (v5Voltage != null) {
      $result.v5Voltage = v5Voltage;
    }
    if (v5Temperature != null) {
      $result.v5Temperature = v5Temperature;
    }
    if (v12Current != null) {
      $result.v12Current = v12Current;
    }
    if (v12Voltage != null) {
      $result.v12Voltage = v12Voltage;
    }
    if (v12Temperature != null) {
      $result.v12Temperature = v12Temperature;
    }
    if (batteryCurrent != null) {
      $result.batteryCurrent = batteryCurrent;
    }
    if (batteryVoltage != null) {
      $result.batteryVoltage = batteryVoltage;
    }
    if (batteryTemperature != null) {
      $result.batteryTemperature = batteryTemperature;
    }
    return $result;
  }
  ElectricalData._() : super();
  factory ElectricalData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ElectricalData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ElectricalData', createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'v5Current', $pb.PbFieldType.OF)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'v5Voltage', $pb.PbFieldType.OF)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'v5Temperature', $pb.PbFieldType.OF)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'v12Current', $pb.PbFieldType.OF)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'v12Voltage', $pb.PbFieldType.OF)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'v12Temperature', $pb.PbFieldType.OF)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'batteryCurrent', $pb.PbFieldType.OF)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'batteryVoltage', $pb.PbFieldType.OF)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'batteryTemperature', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ElectricalData clone() => ElectricalData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ElectricalData copyWith(void Function(ElectricalData) updates) => super.copyWith((message) => updates(message as ElectricalData)) as ElectricalData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ElectricalData create() => ElectricalData._();
  ElectricalData createEmptyInstance() => create();
  static $pb.PbList<ElectricalData> createRepeated() => $pb.PbList<ElectricalData>();
  @$core.pragma('dart2js:noInline')
  static ElectricalData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ElectricalData>(create);
  static ElectricalData? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get v5Current => $_getN(0);
  @$pb.TagNumber(1)
  set v5Current($core.double v) { $_setFloat(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasV5Current() => $_has(0);
  @$pb.TagNumber(1)
  void clearV5Current() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get v5Voltage => $_getN(1);
  @$pb.TagNumber(2)
  set v5Voltage($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasV5Voltage() => $_has(1);
  @$pb.TagNumber(2)
  void clearV5Voltage() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get v5Temperature => $_getN(2);
  @$pb.TagNumber(3)
  set v5Temperature($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasV5Temperature() => $_has(2);
  @$pb.TagNumber(3)
  void clearV5Temperature() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get v12Current => $_getN(3);
  @$pb.TagNumber(4)
  set v12Current($core.double v) { $_setFloat(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasV12Current() => $_has(3);
  @$pb.TagNumber(4)
  void clearV12Current() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get v12Voltage => $_getN(4);
  @$pb.TagNumber(5)
  set v12Voltage($core.double v) { $_setFloat(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasV12Voltage() => $_has(4);
  @$pb.TagNumber(5)
  void clearV12Voltage() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get v12Temperature => $_getN(5);
  @$pb.TagNumber(6)
  set v12Temperature($core.double v) { $_setFloat(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasV12Temperature() => $_has(5);
  @$pb.TagNumber(6)
  void clearV12Temperature() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get batteryCurrent => $_getN(6);
  @$pb.TagNumber(7)
  set batteryCurrent($core.double v) { $_setFloat(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasBatteryCurrent() => $_has(6);
  @$pb.TagNumber(7)
  void clearBatteryCurrent() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get batteryVoltage => $_getN(7);
  @$pb.TagNumber(8)
  set batteryVoltage($core.double v) { $_setFloat(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasBatteryVoltage() => $_has(7);
  @$pb.TagNumber(8)
  void clearBatteryVoltage() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get batteryTemperature => $_getN(8);
  @$pb.TagNumber(9)
  set batteryTemperature($core.double v) { $_setFloat(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasBatteryTemperature() => $_has(8);
  @$pb.TagNumber(9)
  void clearBatteryTemperature() => clearField(9);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
