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

import 'base_station.pbenum.dart';
import 'gps.pb.dart' as $2;
import 'motor.pb.dart' as $1;
import 'utils.pbenum.dart' as $3;
import 'version.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'base_station.pbenum.dart';

class AntennaFirmwareCommand extends $pb.GeneratedMessage {
  factory AntennaFirmwareCommand({
    $0.Version? version,
    $1.MotorCommand? swivel,
    $core.bool? stop,
    $core.bool? calibrate,
  }) {
    final result = create();
    if (version != null) result.version = version;
    if (swivel != null) result.swivel = swivel;
    if (stop != null) result.stop = stop;
    if (calibrate != null) result.calibrate = calibrate;
    return result;
  }

  AntennaFirmwareCommand._();

  factory AntennaFirmwareCommand.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AntennaFirmwareCommand.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AntennaFirmwareCommand',
      createEmptyInstance: create)
    ..aOM<$0.Version>(1, _omitFieldNames ? '' : 'version',
        subBuilder: $0.Version.create)
    ..aOM<$1.MotorCommand>(2, _omitFieldNames ? '' : 'swivel',
        subBuilder: $1.MotorCommand.create)
    ..aOB(3, _omitFieldNames ? '' : 'stop')
    ..aOB(4, _omitFieldNames ? '' : 'calibrate')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AntennaFirmwareCommand clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AntennaFirmwareCommand copyWith(
          void Function(AntennaFirmwareCommand) updates) =>
      super.copyWith((message) => updates(message as AntennaFirmwareCommand))
          as AntennaFirmwareCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AntennaFirmwareCommand create() => AntennaFirmwareCommand._();
  @$core.override
  AntennaFirmwareCommand createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AntennaFirmwareCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AntennaFirmwareCommand>(create);
  static AntennaFirmwareCommand? _defaultInstance;

  @$pb.TagNumber(1)
  $0.Version get version => $_getN(0);
  @$pb.TagNumber(1)
  set version($0.Version value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersion() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.Version ensureVersion() => $_ensure(0);

  @$pb.TagNumber(2)
  $1.MotorCommand get swivel => $_getN(1);
  @$pb.TagNumber(2)
  set swivel($1.MotorCommand value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasSwivel() => $_has(1);
  @$pb.TagNumber(2)
  void clearSwivel() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.MotorCommand ensureSwivel() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.bool get stop => $_getBF(2);
  @$pb.TagNumber(3)
  set stop($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStop() => $_has(2);
  @$pb.TagNumber(3)
  void clearStop() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get calibrate => $_getBF(3);
  @$pb.TagNumber(4)
  set calibrate($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCalibrate() => $_has(3);
  @$pb.TagNumber(4)
  void clearCalibrate() => $_clearField(4);
}

class AntennaFirmwareData extends $pb.GeneratedMessage {
  factory AntennaFirmwareData({
    $0.Version? version,
    $1.MotorData? swivel,
  }) {
    final result = create();
    if (version != null) result.version = version;
    if (swivel != null) result.swivel = swivel;
    return result;
  }

  AntennaFirmwareData._();

  factory AntennaFirmwareData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AntennaFirmwareData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AntennaFirmwareData',
      createEmptyInstance: create)
    ..aOM<$0.Version>(1, _omitFieldNames ? '' : 'version',
        subBuilder: $0.Version.create)
    ..aOM<$1.MotorData>(2, _omitFieldNames ? '' : 'swivel',
        subBuilder: $1.MotorData.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AntennaFirmwareData clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AntennaFirmwareData copyWith(void Function(AntennaFirmwareData) updates) =>
      super.copyWith((message) => updates(message as AntennaFirmwareData))
          as AntennaFirmwareData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AntennaFirmwareData create() => AntennaFirmwareData._();
  @$core.override
  AntennaFirmwareData createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AntennaFirmwareData getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AntennaFirmwareData>(create);
  static AntennaFirmwareData? _defaultInstance;

  @$pb.TagNumber(1)
  $0.Version get version => $_getN(0);
  @$pb.TagNumber(1)
  set version($0.Version value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersion() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.Version ensureVersion() => $_ensure(0);

  @$pb.TagNumber(2)
  $1.MotorData get swivel => $_getN(1);
  @$pb.TagNumber(2)
  set swivel($1.MotorData value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasSwivel() => $_has(1);
  @$pb.TagNumber(2)
  void clearSwivel() => $_clearField(2);
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
    $0.Version? version,
    AntennaControlMode? mode,
    $2.GpsCoordinates? roverCoordinates,
    $2.GpsCoordinates? baseStationCoordinates,
    $2.GpsCoordinates? roverCoordinatesOverride,
    AntennaFirmwareCommand? manualCommand,
    $core.double? angleTolerance,
  }) {
    final result = create();
    if (version != null) result.version = version;
    if (mode != null) result.mode = mode;
    if (roverCoordinates != null) result.roverCoordinates = roverCoordinates;
    if (baseStationCoordinates != null)
      result.baseStationCoordinates = baseStationCoordinates;
    if (roverCoordinatesOverride != null)
      result.roverCoordinatesOverride = roverCoordinatesOverride;
    if (manualCommand != null) result.manualCommand = manualCommand;
    if (angleTolerance != null) result.angleTolerance = angleTolerance;
    return result;
  }

  BaseStationCommand._();

  factory BaseStationCommand.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BaseStationCommand.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BaseStationCommand',
      createEmptyInstance: create)
    ..aOM<$0.Version>(1, _omitFieldNames ? '' : 'version',
        subBuilder: $0.Version.create)
    ..aE<AntennaControlMode>(2, _omitFieldNames ? '' : 'mode',
        enumValues: AntennaControlMode.values)
    ..aOM<$2.GpsCoordinates>(3, _omitFieldNames ? '' : 'roverCoordinates',
        protoName: 'roverCoordinates', subBuilder: $2.GpsCoordinates.create)
    ..aOM<$2.GpsCoordinates>(4, _omitFieldNames ? '' : 'baseStationCoordinates',
        protoName: 'baseStationCoordinates',
        subBuilder: $2.GpsCoordinates.create)
    ..aOM<$2.GpsCoordinates>(
        5, _omitFieldNames ? '' : 'roverCoordinatesOverride',
        protoName: 'roverCoordinatesOverride',
        subBuilder: $2.GpsCoordinates.create)
    ..aOM<AntennaFirmwareCommand>(6, _omitFieldNames ? '' : 'manualCommand',
        protoName: 'manualCommand', subBuilder: AntennaFirmwareCommand.create)
    ..aD(7, _omitFieldNames ? '' : 'angleTolerance',
        protoName: 'angleTolerance', fieldType: $pb.PbFieldType.OF)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BaseStationCommand clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BaseStationCommand copyWith(void Function(BaseStationCommand) updates) =>
      super.copyWith((message) => updates(message as BaseStationCommand))
          as BaseStationCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BaseStationCommand create() => BaseStationCommand._();
  @$core.override
  BaseStationCommand createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BaseStationCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BaseStationCommand>(create);
  static BaseStationCommand? _defaultInstance;

  @$pb.TagNumber(1)
  $0.Version get version => $_getN(0);
  @$pb.TagNumber(1)
  set version($0.Version value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersion() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.Version ensureVersion() => $_ensure(0);

  @$pb.TagNumber(2)
  AntennaControlMode get mode => $_getN(1);
  @$pb.TagNumber(2)
  set mode(AntennaControlMode value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasMode() => $_has(1);
  @$pb.TagNumber(2)
  void clearMode() => $_clearField(2);

  @$pb.TagNumber(3)
  $2.GpsCoordinates get roverCoordinates => $_getN(2);
  @$pb.TagNumber(3)
  set roverCoordinates($2.GpsCoordinates value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasRoverCoordinates() => $_has(2);
  @$pb.TagNumber(3)
  void clearRoverCoordinates() => $_clearField(3);
  @$pb.TagNumber(3)
  $2.GpsCoordinates ensureRoverCoordinates() => $_ensure(2);

  @$pb.TagNumber(4)
  $2.GpsCoordinates get baseStationCoordinates => $_getN(3);
  @$pb.TagNumber(4)
  set baseStationCoordinates($2.GpsCoordinates value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasBaseStationCoordinates() => $_has(3);
  @$pb.TagNumber(4)
  void clearBaseStationCoordinates() => $_clearField(4);
  @$pb.TagNumber(4)
  $2.GpsCoordinates ensureBaseStationCoordinates() => $_ensure(3);

  @$pb.TagNumber(5)
  $2.GpsCoordinates get roverCoordinatesOverride => $_getN(4);
  @$pb.TagNumber(5)
  set roverCoordinatesOverride($2.GpsCoordinates value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasRoverCoordinatesOverride() => $_has(4);
  @$pb.TagNumber(5)
  void clearRoverCoordinatesOverride() => $_clearField(5);
  @$pb.TagNumber(5)
  $2.GpsCoordinates ensureRoverCoordinatesOverride() => $_ensure(4);

  @$pb.TagNumber(6)
  AntennaFirmwareCommand get manualCommand => $_getN(5);
  @$pb.TagNumber(6)
  set manualCommand(AntennaFirmwareCommand value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasManualCommand() => $_has(5);
  @$pb.TagNumber(6)
  void clearManualCommand() => $_clearField(6);
  @$pb.TagNumber(6)
  AntennaFirmwareCommand ensureManualCommand() => $_ensure(5);

  /// The angle tolerance for auto-tracking, in radians
  @$pb.TagNumber(7)
  $core.double get angleTolerance => $_getN(6);
  @$pb.TagNumber(7)
  set angleTolerance($core.double value) => $_setFloat(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAngleTolerance() => $_has(6);
  @$pb.TagNumber(7)
  void clearAngleTolerance() => $_clearField(7);
}

class BaseStationData extends $pb.GeneratedMessage {
  factory BaseStationData({
    $0.Version? version,
    AntennaControlMode? mode,
    AntennaFirmwareData? antenna,
    $2.GpsCoordinates? baseStationCoordinates,
    $3.BoolState? rtkConnected,
  }) {
    final result = create();
    if (version != null) result.version = version;
    if (mode != null) result.mode = mode;
    if (antenna != null) result.antenna = antenna;
    if (baseStationCoordinates != null)
      result.baseStationCoordinates = baseStationCoordinates;
    if (rtkConnected != null) result.rtkConnected = rtkConnected;
    return result;
  }

  BaseStationData._();

  factory BaseStationData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BaseStationData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BaseStationData',
      createEmptyInstance: create)
    ..aOM<$0.Version>(1, _omitFieldNames ? '' : 'version',
        subBuilder: $0.Version.create)
    ..aE<AntennaControlMode>(2, _omitFieldNames ? '' : 'mode',
        enumValues: AntennaControlMode.values)
    ..aOM<AntennaFirmwareData>(3, _omitFieldNames ? '' : 'antenna',
        subBuilder: AntennaFirmwareData.create)
    ..aOM<$2.GpsCoordinates>(4, _omitFieldNames ? '' : 'baseStationCoordinates',
        protoName: 'baseStationCoordinates',
        subBuilder: $2.GpsCoordinates.create)
    ..aE<$3.BoolState>(5, _omitFieldNames ? '' : 'rtkConnected',
        protoName: 'rtkConnected', enumValues: $3.BoolState.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BaseStationData clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BaseStationData copyWith(void Function(BaseStationData) updates) =>
      super.copyWith((message) => updates(message as BaseStationData))
          as BaseStationData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BaseStationData create() => BaseStationData._();
  @$core.override
  BaseStationData createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BaseStationData getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BaseStationData>(create);
  static BaseStationData? _defaultInstance;

  @$pb.TagNumber(1)
  $0.Version get version => $_getN(0);
  @$pb.TagNumber(1)
  set version($0.Version value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersion() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.Version ensureVersion() => $_ensure(0);

  @$pb.TagNumber(2)
  AntennaControlMode get mode => $_getN(1);
  @$pb.TagNumber(2)
  set mode(AntennaControlMode value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasMode() => $_has(1);
  @$pb.TagNumber(2)
  void clearMode() => $_clearField(2);

  @$pb.TagNumber(3)
  AntennaFirmwareData get antenna => $_getN(2);
  @$pb.TagNumber(3)
  set antenna(AntennaFirmwareData value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasAntenna() => $_has(2);
  @$pb.TagNumber(3)
  void clearAntenna() => $_clearField(3);
  @$pb.TagNumber(3)
  AntennaFirmwareData ensureAntenna() => $_ensure(2);

  @$pb.TagNumber(4)
  $2.GpsCoordinates get baseStationCoordinates => $_getN(3);
  @$pb.TagNumber(4)
  set baseStationCoordinates($2.GpsCoordinates value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasBaseStationCoordinates() => $_has(3);
  @$pb.TagNumber(4)
  void clearBaseStationCoordinates() => $_clearField(4);
  @$pb.TagNumber(4)
  $2.GpsCoordinates ensureBaseStationCoordinates() => $_ensure(3);

  /// Whether or not the RTK gps is open and being read
  @$pb.TagNumber(5)
  $3.BoolState get rtkConnected => $_getN(4);
  @$pb.TagNumber(5)
  set rtkConnected($3.BoolState value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasRtkConnected() => $_has(4);
  @$pb.TagNumber(5)
  void clearRtkConnected() => $_clearField(5);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
