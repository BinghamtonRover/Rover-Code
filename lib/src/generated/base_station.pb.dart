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

import 'base_station.pbenum.dart';
import 'gps.pb.dart' as $3;
import 'motor.pb.dart' as $1;
import 'version.pb.dart' as $2;

export 'base_station.pbenum.dart';

class AntennaFirmwareCommand extends $pb.GeneratedMessage {
  factory AntennaFirmwareCommand({
    $2.Version? version,
    $1.MotorCommand? swivel,
    $core.bool? stop,
    $core.bool? calibrate,
  }) {
    final $result = create();
    if (version != null) {
      $result.version = version;
    }
    if (swivel != null) {
      $result.swivel = swivel;
    }
    if (stop != null) {
      $result.stop = stop;
    }
    if (calibrate != null) {
      $result.calibrate = calibrate;
    }
    return $result;
  }
  AntennaFirmwareCommand._() : super();
  factory AntennaFirmwareCommand.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AntennaFirmwareCommand.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AntennaFirmwareCommand', createEmptyInstance: create)
    ..aOM<$2.Version>(1, _omitFieldNames ? '' : 'version', subBuilder: $2.Version.create)
    ..aOM<$1.MotorCommand>(2, _omitFieldNames ? '' : 'swivel', subBuilder: $1.MotorCommand.create)
    ..aOB(3, _omitFieldNames ? '' : 'stop')
    ..aOB(4, _omitFieldNames ? '' : 'calibrate')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AntennaFirmwareCommand clone() => AntennaFirmwareCommand()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AntennaFirmwareCommand copyWith(void Function(AntennaFirmwareCommand) updates) => super.copyWith((message) => updates(message as AntennaFirmwareCommand)) as AntennaFirmwareCommand;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AntennaFirmwareCommand create() => AntennaFirmwareCommand._();
  AntennaFirmwareCommand createEmptyInstance() => create();
  static $pb.PbList<AntennaFirmwareCommand> createRepeated() => $pb.PbList<AntennaFirmwareCommand>();
  @$core.pragma('dart2js:noInline')
  static AntennaFirmwareCommand getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AntennaFirmwareCommand>(create);
  static AntennaFirmwareCommand? _defaultInstance;

  @$pb.TagNumber(1)
  $2.Version get version => $_getN(0);
  @$pb.TagNumber(1)
  set version($2.Version v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersion() => clearField(1);
  @$pb.TagNumber(1)
  $2.Version ensureVersion() => $_ensure(0);

  @$pb.TagNumber(2)
  $1.MotorCommand get swivel => $_getN(1);
  @$pb.TagNumber(2)
  set swivel($1.MotorCommand v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasSwivel() => $_has(1);
  @$pb.TagNumber(2)
  void clearSwivel() => clearField(2);
  @$pb.TagNumber(2)
  $1.MotorCommand ensureSwivel() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.bool get stop => $_getBF(2);
  @$pb.TagNumber(3)
  set stop($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStop() => $_has(2);
  @$pb.TagNumber(3)
  void clearStop() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get calibrate => $_getBF(3);
  @$pb.TagNumber(4)
  set calibrate($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCalibrate() => $_has(3);
  @$pb.TagNumber(4)
  void clearCalibrate() => clearField(4);
}

class AntennaFirmwareData extends $pb.GeneratedMessage {
  factory AntennaFirmwareData({
    $2.Version? version,
    $1.MotorData? swivel,
  }) {
    final $result = create();
    if (version != null) {
      $result.version = version;
    }
    if (swivel != null) {
      $result.swivel = swivel;
    }
    return $result;
  }
  AntennaFirmwareData._() : super();
  factory AntennaFirmwareData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AntennaFirmwareData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AntennaFirmwareData', createEmptyInstance: create)
    ..aOM<$2.Version>(1, _omitFieldNames ? '' : 'version', subBuilder: $2.Version.create)
    ..aOM<$1.MotorData>(2, _omitFieldNames ? '' : 'swivel', subBuilder: $1.MotorData.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AntennaFirmwareData clone() => AntennaFirmwareData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AntennaFirmwareData copyWith(void Function(AntennaFirmwareData) updates) => super.copyWith((message) => updates(message as AntennaFirmwareData)) as AntennaFirmwareData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AntennaFirmwareData create() => AntennaFirmwareData._();
  AntennaFirmwareData createEmptyInstance() => create();
  static $pb.PbList<AntennaFirmwareData> createRepeated() => $pb.PbList<AntennaFirmwareData>();
  @$core.pragma('dart2js:noInline')
  static AntennaFirmwareData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AntennaFirmwareData>(create);
  static AntennaFirmwareData? _defaultInstance;

  @$pb.TagNumber(1)
  $2.Version get version => $_getN(0);
  @$pb.TagNumber(1)
  set version($2.Version v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersion() => clearField(1);
  @$pb.TagNumber(1)
  $2.Version ensureVersion() => $_ensure(0);

  @$pb.TagNumber(2)
  $1.MotorData get swivel => $_getN(1);
  @$pb.TagNumber(2)
  set swivel($1.MotorData v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasSwivel() => $_has(1);
  @$pb.TagNumber(2)
  void clearSwivel() => clearField(2);
  @$pb.TagNumber(2)
  $1.MotorData ensureSwivel() => $_ensure(1);
}

/// / Command to control the movement of the MARS antenna.
/// /
/// / This command has two modes: manual operation or rover tracking.
/// / - When tracking the rover, any GPS signals received by the rover or the base station's internal
/// /   GPS will cause it to re-calculate an orientation that ideally faces the rover. In this mode,
/// /   manual commands are ignored.
/// / - When in manual mode, all GPS data is ignored and the motor is only moved when the Dashboard
/// /   sends a command with a [manualCommand] payload.
/// /
/// / When tracking the rover, the Dashboard can override either the base station or rover's position
/// / for testing and debugging. When a new position override is received, the base station will:
/// / - calculate the antenna orientation as if the rover were at this position
/// / - send an [AntennaFirmwareCommand] for this position
/// / - immediately set the [mode] to [AntennaControlMode.MANUAL_CONTROL] to hold the position
class BaseStationCommand extends $pb.GeneratedMessage {
  factory BaseStationCommand({
    $2.Version? version,
    AntennaControlMode? mode,
    $3.GpsCoordinates? roverCoordinates,
    $3.GpsCoordinates? baseStationCoordinatesOverride,
    $3.GpsCoordinates? roverCoordinatesOverrideOverride,
    AntennaFirmwareCommand? manualCommand,
  }) {
    final $result = create();
    if (version != null) {
      $result.version = version;
    }
    if (mode != null) {
      $result.mode = mode;
    }
    if (roverCoordinates != null) {
      $result.roverCoordinates = roverCoordinates;
    }
    if (baseStationCoordinatesOverride != null) {
      $result.baseStationCoordinatesOverride = baseStationCoordinatesOverride;
    }
    if (roverCoordinatesOverrideOverride != null) {
      $result.roverCoordinatesOverrideOverride = roverCoordinatesOverrideOverride;
    }
    if (manualCommand != null) {
      $result.manualCommand = manualCommand;
    }
    return $result;
  }
  BaseStationCommand._() : super();
  factory BaseStationCommand.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BaseStationCommand.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BaseStationCommand', createEmptyInstance: create)
    ..aOM<$2.Version>(1, _omitFieldNames ? '' : 'version', subBuilder: $2.Version.create)
    ..e<AntennaControlMode>(2, _omitFieldNames ? '' : 'mode', $pb.PbFieldType.OE, defaultOrMaker: AntennaControlMode.ANTENNA_CONTROL_MODE_UNDEFINED, valueOf: AntennaControlMode.valueOf, enumValues: AntennaControlMode.values)
    ..aOM<$3.GpsCoordinates>(3, _omitFieldNames ? '' : 'roverCoordinates', protoName: 'roverCoordinates', subBuilder: $3.GpsCoordinates.create)
    ..aOM<$3.GpsCoordinates>(4, _omitFieldNames ? '' : 'baseStationCoordinatesOverride', protoName: 'baseStationCoordinatesOverride', subBuilder: $3.GpsCoordinates.create)
    ..aOM<$3.GpsCoordinates>(5, _omitFieldNames ? '' : 'roverCoordinatesOverrideOverride', protoName: 'roverCoordinatesOverrideOverride', subBuilder: $3.GpsCoordinates.create)
    ..aOM<AntennaFirmwareCommand>(6, _omitFieldNames ? '' : 'manualCommand', protoName: 'manualCommand', subBuilder: AntennaFirmwareCommand.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BaseStationCommand clone() => BaseStationCommand()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BaseStationCommand copyWith(void Function(BaseStationCommand) updates) => super.copyWith((message) => updates(message as BaseStationCommand)) as BaseStationCommand;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BaseStationCommand create() => BaseStationCommand._();
  BaseStationCommand createEmptyInstance() => create();
  static $pb.PbList<BaseStationCommand> createRepeated() => $pb.PbList<BaseStationCommand>();
  @$core.pragma('dart2js:noInline')
  static BaseStationCommand getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BaseStationCommand>(create);
  static BaseStationCommand? _defaultInstance;

  @$pb.TagNumber(1)
  $2.Version get version => $_getN(0);
  @$pb.TagNumber(1)
  set version($2.Version v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersion() => clearField(1);
  @$pb.TagNumber(1)
  $2.Version ensureVersion() => $_ensure(0);

  @$pb.TagNumber(2)
  AntennaControlMode get mode => $_getN(1);
  @$pb.TagNumber(2)
  set mode(AntennaControlMode v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasMode() => $_has(1);
  @$pb.TagNumber(2)
  void clearMode() => clearField(2);

  @$pb.TagNumber(3)
  $3.GpsCoordinates get roverCoordinates => $_getN(2);
  @$pb.TagNumber(3)
  set roverCoordinates($3.GpsCoordinates v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasRoverCoordinates() => $_has(2);
  @$pb.TagNumber(3)
  void clearRoverCoordinates() => clearField(3);
  @$pb.TagNumber(3)
  $3.GpsCoordinates ensureRoverCoordinates() => $_ensure(2);

  @$pb.TagNumber(4)
  $3.GpsCoordinates get baseStationCoordinatesOverride => $_getN(3);
  @$pb.TagNumber(4)
  set baseStationCoordinatesOverride($3.GpsCoordinates v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasBaseStationCoordinatesOverride() => $_has(3);
  @$pb.TagNumber(4)
  void clearBaseStationCoordinatesOverride() => clearField(4);
  @$pb.TagNumber(4)
  $3.GpsCoordinates ensureBaseStationCoordinatesOverride() => $_ensure(3);

  @$pb.TagNumber(5)
  $3.GpsCoordinates get roverCoordinatesOverrideOverride => $_getN(4);
  @$pb.TagNumber(5)
  set roverCoordinatesOverrideOverride($3.GpsCoordinates v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasRoverCoordinatesOverrideOverride() => $_has(4);
  @$pb.TagNumber(5)
  void clearRoverCoordinatesOverrideOverride() => clearField(5);
  @$pb.TagNumber(5)
  $3.GpsCoordinates ensureRoverCoordinatesOverrideOverride() => $_ensure(4);

  @$pb.TagNumber(6)
  AntennaFirmwareCommand get manualCommand => $_getN(5);
  @$pb.TagNumber(6)
  set manualCommand(AntennaFirmwareCommand v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasManualCommand() => $_has(5);
  @$pb.TagNumber(6)
  void clearManualCommand() => clearField(6);
  @$pb.TagNumber(6)
  AntennaFirmwareCommand ensureManualCommand() => $_ensure(5);
}

class BaseStationData extends $pb.GeneratedMessage {
  factory BaseStationData({
    $2.Version? version,
    AntennaControlMode? mode,
    AntennaFirmwareData? antenna,
    $3.GpsCoordinates? baseStationCoordinates,
  }) {
    final $result = create();
    if (version != null) {
      $result.version = version;
    }
    if (mode != null) {
      $result.mode = mode;
    }
    if (antenna != null) {
      $result.antenna = antenna;
    }
    if (baseStationCoordinates != null) {
      $result.baseStationCoordinates = baseStationCoordinates;
    }
    return $result;
  }
  BaseStationData._() : super();
  factory BaseStationData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BaseStationData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BaseStationData', createEmptyInstance: create)
    ..aOM<$2.Version>(1, _omitFieldNames ? '' : 'version', subBuilder: $2.Version.create)
    ..e<AntennaControlMode>(2, _omitFieldNames ? '' : 'mode', $pb.PbFieldType.OE, defaultOrMaker: AntennaControlMode.ANTENNA_CONTROL_MODE_UNDEFINED, valueOf: AntennaControlMode.valueOf, enumValues: AntennaControlMode.values)
    ..aOM<AntennaFirmwareData>(3, _omitFieldNames ? '' : 'antenna', subBuilder: AntennaFirmwareData.create)
    ..aOM<$3.GpsCoordinates>(4, _omitFieldNames ? '' : 'baseStationCoordinates', protoName: 'baseStationCoordinates', subBuilder: $3.GpsCoordinates.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BaseStationData clone() => BaseStationData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BaseStationData copyWith(void Function(BaseStationData) updates) => super.copyWith((message) => updates(message as BaseStationData)) as BaseStationData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BaseStationData create() => BaseStationData._();
  BaseStationData createEmptyInstance() => create();
  static $pb.PbList<BaseStationData> createRepeated() => $pb.PbList<BaseStationData>();
  @$core.pragma('dart2js:noInline')
  static BaseStationData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BaseStationData>(create);
  static BaseStationData? _defaultInstance;

  @$pb.TagNumber(1)
  $2.Version get version => $_getN(0);
  @$pb.TagNumber(1)
  set version($2.Version v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersion() => clearField(1);
  @$pb.TagNumber(1)
  $2.Version ensureVersion() => $_ensure(0);

  @$pb.TagNumber(2)
  AntennaControlMode get mode => $_getN(1);
  @$pb.TagNumber(2)
  set mode(AntennaControlMode v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasMode() => $_has(1);
  @$pb.TagNumber(2)
  void clearMode() => clearField(2);

  @$pb.TagNumber(3)
  AntennaFirmwareData get antenna => $_getN(2);
  @$pb.TagNumber(3)
  set antenna(AntennaFirmwareData v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasAntenna() => $_has(2);
  @$pb.TagNumber(3)
  void clearAntenna() => clearField(3);
  @$pb.TagNumber(3)
  AntennaFirmwareData ensureAntenna() => $_ensure(2);

  @$pb.TagNumber(4)
  $3.GpsCoordinates get baseStationCoordinates => $_getN(3);
  @$pb.TagNumber(4)
  set baseStationCoordinates($3.GpsCoordinates v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasBaseStationCoordinates() => $_has(3);
  @$pb.TagNumber(4)
  void clearBaseStationCoordinates() => clearField(4);
  @$pb.TagNumber(4)
  $3.GpsCoordinates ensureBaseStationCoordinates() => $_ensure(3);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
