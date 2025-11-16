// This is a generated file - do not edit.
//
// Generated from drive.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'drive.pbenum.dart';
import 'status.pbenum.dart' as $1;
import 'utils.pbenum.dart' as $2;
import 'version.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'drive.pbenum.dart';

class DriveCommand extends $pb.GeneratedMessage {
  factory DriveCommand({
    $core.double? throttle,
    $core.double? left,
    $core.double? right,
    $core.bool? setLeft,
    $core.bool? setRight,
    $core.bool? setThrottle,
    $core.double? frontSwivel,
    $core.double? frontTilt,
    $core.double? rearSwivel,
    $core.double? rearTilt,
    $1.RoverStatus? status,
    $0.Version? version,
    ProtoColor? color,
    $2.BoolState? blink,
  }) {
    final result = create();
    if (throttle != null) result.throttle = throttle;
    if (left != null) result.left = left;
    if (right != null) result.right = right;
    if (setLeft != null) result.setLeft = setLeft;
    if (setRight != null) result.setRight = setRight;
    if (setThrottle != null) result.setThrottle = setThrottle;
    if (frontSwivel != null) result.frontSwivel = frontSwivel;
    if (frontTilt != null) result.frontTilt = frontTilt;
    if (rearSwivel != null) result.rearSwivel = rearSwivel;
    if (rearTilt != null) result.rearTilt = rearTilt;
    if (status != null) result.status = status;
    if (version != null) result.version = version;
    if (color != null) result.color = color;
    if (blink != null) result.blink = blink;
    return result;
  }

  DriveCommand._();

  factory DriveCommand.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DriveCommand.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DriveCommand',
      createEmptyInstance: create)
    ..aD(1, _omitFieldNames ? '' : 'throttle', fieldType: $pb.PbFieldType.OF)
    ..aD(2, _omitFieldNames ? '' : 'left', fieldType: $pb.PbFieldType.OF)
    ..aD(3, _omitFieldNames ? '' : 'right', fieldType: $pb.PbFieldType.OF)
    ..aOB(4, _omitFieldNames ? '' : 'setLeft')
    ..aOB(5, _omitFieldNames ? '' : 'setRight')
    ..aOB(6, _omitFieldNames ? '' : 'setThrottle')
    ..aD(7, _omitFieldNames ? '' : 'frontSwivel', fieldType: $pb.PbFieldType.OF)
    ..aD(8, _omitFieldNames ? '' : 'frontTilt', fieldType: $pb.PbFieldType.OF)
    ..aD(9, _omitFieldNames ? '' : 'rearSwivel', fieldType: $pb.PbFieldType.OF)
    ..aD(10, _omitFieldNames ? '' : 'rearTilt', fieldType: $pb.PbFieldType.OF)
    ..aE<$1.RoverStatus>(11, _omitFieldNames ? '' : 'status',
        enumValues: $1.RoverStatus.values)
    ..aOM<$0.Version>(12, _omitFieldNames ? '' : 'version',
        subBuilder: $0.Version.create)
    ..aE<ProtoColor>(13, _omitFieldNames ? '' : 'color',
        enumValues: ProtoColor.values)
    ..aE<$2.BoolState>(14, _omitFieldNames ? '' : 'blink',
        enumValues: $2.BoolState.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DriveCommand clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DriveCommand copyWith(void Function(DriveCommand) updates) =>
      super.copyWith((message) => updates(message as DriveCommand))
          as DriveCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DriveCommand create() => DriveCommand._();
  @$core.override
  DriveCommand createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DriveCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DriveCommand>(create);
  static DriveCommand? _defaultInstance;

  /// The max speed, as a percentage of the rover's possible speed.
  @$pb.TagNumber(1)
  $core.double get throttle => $_getN(0);
  @$pb.TagNumber(1)
  set throttle($core.double value) => $_setFloat(0, value);
  @$pb.TagNumber(1)
  $core.bool hasThrottle() => $_has(0);
  @$pb.TagNumber(1)
  void clearThrottle() => $_clearField(1);

  /// Speed of the left wheels, as a percentage of [throttle].
  @$pb.TagNumber(2)
  $core.double get left => $_getN(1);
  @$pb.TagNumber(2)
  set left($core.double value) => $_setFloat(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLeft() => $_has(1);
  @$pb.TagNumber(2)
  void clearLeft() => $_clearField(2);

  /// Speed of the right wheels, as a percentage of [throttle].
  @$pb.TagNumber(3)
  $core.double get right => $_getN(2);
  @$pb.TagNumber(3)
  set right($core.double value) => $_setFloat(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRight() => $_has(2);
  @$pb.TagNumber(3)
  void clearRight() => $_clearField(3);

  /// Indicates that [left] = 0 is valid, even though 0 usually means no value.
  @$pb.TagNumber(4)
  $core.bool get setLeft => $_getBF(3);
  @$pb.TagNumber(4)
  set setLeft($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSetLeft() => $_has(3);
  @$pb.TagNumber(4)
  void clearSetLeft() => $_clearField(4);

  /// Indicates that [right] = 0 is valid, even though 0 usually means no value.
  @$pb.TagNumber(5)
  $core.bool get setRight => $_getBF(4);
  @$pb.TagNumber(5)
  set setRight($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSetRight() => $_has(4);
  @$pb.TagNumber(5)
  void clearSetRight() => $_clearField(5);

  /// Indicates that [throttle] = 0 is valid, even though 0 usually means no value.
  @$pb.TagNumber(6)
  $core.bool get setThrottle => $_getBF(5);
  @$pb.TagNumber(6)
  set setThrottle($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSetThrottle() => $_has(5);
  @$pb.TagNumber(6)
  void clearSetThrottle() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get frontSwivel => $_getN(6);
  @$pb.TagNumber(7)
  set frontSwivel($core.double value) => $_setFloat(6, value);
  @$pb.TagNumber(7)
  $core.bool hasFrontSwivel() => $_has(6);
  @$pb.TagNumber(7)
  void clearFrontSwivel() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get frontTilt => $_getN(7);
  @$pb.TagNumber(8)
  set frontTilt($core.double value) => $_setFloat(7, value);
  @$pb.TagNumber(8)
  $core.bool hasFrontTilt() => $_has(7);
  @$pb.TagNumber(8)
  void clearFrontTilt() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.double get rearSwivel => $_getN(8);
  @$pb.TagNumber(9)
  set rearSwivel($core.double value) => $_setFloat(8, value);
  @$pb.TagNumber(9)
  $core.bool hasRearSwivel() => $_has(8);
  @$pb.TagNumber(9)
  void clearRearSwivel() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.double get rearTilt => $_getN(9);
  @$pb.TagNumber(10)
  set rearTilt($core.double value) => $_setFloat(9, value);
  @$pb.TagNumber(10)
  $core.bool hasRearTilt() => $_has(9);
  @$pb.TagNumber(10)
  void clearRearTilt() => $_clearField(10);

  @$pb.TagNumber(11)
  $1.RoverStatus get status => $_getN(10);
  @$pb.TagNumber(11)
  set status($1.RoverStatus value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasStatus() => $_has(10);
  @$pb.TagNumber(11)
  void clearStatus() => $_clearField(11);

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

  @$pb.TagNumber(13)
  ProtoColor get color => $_getN(12);
  @$pb.TagNumber(13)
  set color(ProtoColor value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasColor() => $_has(12);
  @$pb.TagNumber(13)
  void clearColor() => $_clearField(13);

  @$pb.TagNumber(14)
  $2.BoolState get blink => $_getN(13);
  @$pb.TagNumber(14)
  set blink($2.BoolState value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasBlink() => $_has(13);
  @$pb.TagNumber(14)
  void clearBlink() => $_clearField(14);
}

class DriveMotorData extends $pb.GeneratedMessage {
  factory DriveMotorData({
    $core.double? speed,
    $core.double? current,
    $core.int? temperature,
    MotorErrorCode? error,
  }) {
    final result = create();
    if (speed != null) result.speed = speed;
    if (current != null) result.current = current;
    if (temperature != null) result.temperature = temperature;
    if (error != null) result.error = error;
    return result;
  }

  DriveMotorData._();

  factory DriveMotorData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DriveMotorData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DriveMotorData',
      createEmptyInstance: create)
    ..aD(1, _omitFieldNames ? '' : 'speed', fieldType: $pb.PbFieldType.OF)
    ..aD(2, _omitFieldNames ? '' : 'current', fieldType: $pb.PbFieldType.OF)
    ..aI(3, _omitFieldNames ? '' : 'temperature')
    ..aE<MotorErrorCode>(4, _omitFieldNames ? '' : 'error',
        enumValues: MotorErrorCode.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DriveMotorData clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DriveMotorData copyWith(void Function(DriveMotorData) updates) =>
      super.copyWith((message) => updates(message as DriveMotorData))
          as DriveMotorData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DriveMotorData create() => DriveMotorData._();
  @$core.override
  DriveMotorData createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DriveMotorData getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DriveMotorData>(create);
  static DriveMotorData? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get speed => $_getN(0);
  @$pb.TagNumber(1)
  set speed($core.double value) => $_setFloat(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSpeed() => $_has(0);
  @$pb.TagNumber(1)
  void clearSpeed() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get current => $_getN(1);
  @$pb.TagNumber(2)
  set current($core.double value) => $_setFloat(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCurrent() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrent() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get temperature => $_getIZ(2);
  @$pb.TagNumber(3)
  set temperature($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTemperature() => $_has(2);
  @$pb.TagNumber(3)
  void clearTemperature() => $_clearField(3);

  @$pb.TagNumber(4)
  MotorErrorCode get error => $_getN(3);
  @$pb.TagNumber(4)
  set error(MotorErrorCode value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasError() => $_has(3);
  @$pb.TagNumber(4)
  void clearError() => $_clearField(4);
}

class DriveData extends $pb.GeneratedMessage {
  factory DriveData({
    $core.double? throttle,
    $core.double? left,
    $core.double? right,
    $core.bool? setLeft,
    $core.bool? setRight,
    $core.bool? setThrottle,
    $core.double? frontSwivel,
    $core.double? frontTilt,
    $core.double? rearSwivel,
    $core.double? rearTilt,
    $core.double? batteryVoltage,
    $core.double? batteryCurrent,
    $core.double? batteryTemperature,
    $0.Version? version,
    ProtoColor? color,
    $1.RoverStatus? status,
    DriveMotorData? frontLeftMotor,
    DriveMotorData? middleLeftMotor,
    DriveMotorData? backLeftMotor,
    DriveMotorData? frontRightMotor,
    DriveMotorData? middleRightMotor,
    DriveMotorData? backRightMotor,
  }) {
    final result = create();
    if (throttle != null) result.throttle = throttle;
    if (left != null) result.left = left;
    if (right != null) result.right = right;
    if (setLeft != null) result.setLeft = setLeft;
    if (setRight != null) result.setRight = setRight;
    if (setThrottle != null) result.setThrottle = setThrottle;
    if (frontSwivel != null) result.frontSwivel = frontSwivel;
    if (frontTilt != null) result.frontTilt = frontTilt;
    if (rearSwivel != null) result.rearSwivel = rearSwivel;
    if (rearTilt != null) result.rearTilt = rearTilt;
    if (batteryVoltage != null) result.batteryVoltage = batteryVoltage;
    if (batteryCurrent != null) result.batteryCurrent = batteryCurrent;
    if (batteryTemperature != null)
      result.batteryTemperature = batteryTemperature;
    if (version != null) result.version = version;
    if (color != null) result.color = color;
    if (status != null) result.status = status;
    if (frontLeftMotor != null) result.frontLeftMotor = frontLeftMotor;
    if (middleLeftMotor != null) result.middleLeftMotor = middleLeftMotor;
    if (backLeftMotor != null) result.backLeftMotor = backLeftMotor;
    if (frontRightMotor != null) result.frontRightMotor = frontRightMotor;
    if (middleRightMotor != null) result.middleRightMotor = middleRightMotor;
    if (backRightMotor != null) result.backRightMotor = backRightMotor;
    return result;
  }

  DriveData._();

  factory DriveData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DriveData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DriveData',
      createEmptyInstance: create)
    ..aD(1, _omitFieldNames ? '' : 'throttle', fieldType: $pb.PbFieldType.OF)
    ..aD(2, _omitFieldNames ? '' : 'left', fieldType: $pb.PbFieldType.OF)
    ..aD(3, _omitFieldNames ? '' : 'right', fieldType: $pb.PbFieldType.OF)
    ..aOB(4, _omitFieldNames ? '' : 'setLeft')
    ..aOB(5, _omitFieldNames ? '' : 'setRight')
    ..aOB(6, _omitFieldNames ? '' : 'setThrottle')
    ..aD(7, _omitFieldNames ? '' : 'frontSwivel', fieldType: $pb.PbFieldType.OF)
    ..aD(8, _omitFieldNames ? '' : 'frontTilt', fieldType: $pb.PbFieldType.OF)
    ..aD(9, _omitFieldNames ? '' : 'rearSwivel', fieldType: $pb.PbFieldType.OF)
    ..aD(10, _omitFieldNames ? '' : 'rearTilt', fieldType: $pb.PbFieldType.OF)
    ..aD(11, _omitFieldNames ? '' : 'batteryVoltage',
        fieldType: $pb.PbFieldType.OF)
    ..aD(12, _omitFieldNames ? '' : 'batteryCurrent',
        fieldType: $pb.PbFieldType.OF)
    ..aD(13, _omitFieldNames ? '' : 'batteryTemperature',
        fieldType: $pb.PbFieldType.OF)
    ..aOM<$0.Version>(14, _omitFieldNames ? '' : 'version',
        subBuilder: $0.Version.create)
    ..aE<ProtoColor>(21, _omitFieldNames ? '' : 'color',
        enumValues: ProtoColor.values)
    ..aE<$1.RoverStatus>(22, _omitFieldNames ? '' : 'status',
        enumValues: $1.RoverStatus.values)
    ..aOM<DriveMotorData>(23, _omitFieldNames ? '' : 'frontLeftMotor',
        subBuilder: DriveMotorData.create)
    ..aOM<DriveMotorData>(24, _omitFieldNames ? '' : 'middleLeftMotor',
        subBuilder: DriveMotorData.create)
    ..aOM<DriveMotorData>(25, _omitFieldNames ? '' : 'backLeftMotor',
        subBuilder: DriveMotorData.create)
    ..aOM<DriveMotorData>(26, _omitFieldNames ? '' : 'frontRightMotor',
        subBuilder: DriveMotorData.create)
    ..aOM<DriveMotorData>(27, _omitFieldNames ? '' : 'middleRightMotor',
        subBuilder: DriveMotorData.create)
    ..aOM<DriveMotorData>(28, _omitFieldNames ? '' : 'backRightMotor',
        subBuilder: DriveMotorData.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DriveData clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DriveData copyWith(void Function(DriveData) updates) =>
      super.copyWith((message) => updates(message as DriveData)) as DriveData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DriveData create() => DriveData._();
  @$core.override
  DriveData createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DriveData getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DriveData>(create);
  static DriveData? _defaultInstance;

  /// The max speed, as a percentage of the rover's possible speed.
  @$pb.TagNumber(1)
  $core.double get throttle => $_getN(0);
  @$pb.TagNumber(1)
  set throttle($core.double value) => $_setFloat(0, value);
  @$pb.TagNumber(1)
  $core.bool hasThrottle() => $_has(0);
  @$pb.TagNumber(1)
  void clearThrottle() => $_clearField(1);

  /// Speed of the left wheels, as a percentage of [throttle].
  @$pb.TagNumber(2)
  $core.double get left => $_getN(1);
  @$pb.TagNumber(2)
  set left($core.double value) => $_setFloat(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLeft() => $_has(1);
  @$pb.TagNumber(2)
  void clearLeft() => $_clearField(2);

  /// Speed of the right wheels, as a percentage of [throttle].
  @$pb.TagNumber(3)
  $core.double get right => $_getN(2);
  @$pb.TagNumber(3)
  set right($core.double value) => $_setFloat(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRight() => $_has(2);
  @$pb.TagNumber(3)
  void clearRight() => $_clearField(3);

  /// Indicates that [left] = 0 is valid, even though 0 usually means no value.
  @$pb.TagNumber(4)
  $core.bool get setLeft => $_getBF(3);
  @$pb.TagNumber(4)
  set setLeft($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSetLeft() => $_has(3);
  @$pb.TagNumber(4)
  void clearSetLeft() => $_clearField(4);

  /// Indicates that [right] = 0 is valid, even though 0 usually means no value.
  @$pb.TagNumber(5)
  $core.bool get setRight => $_getBF(4);
  @$pb.TagNumber(5)
  set setRight($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSetRight() => $_has(4);
  @$pb.TagNumber(5)
  void clearSetRight() => $_clearField(5);

  /// Indicates that [throttle] = 0 is valid, even though 0 usually means no value.
  @$pb.TagNumber(6)
  $core.bool get setThrottle => $_getBF(5);
  @$pb.TagNumber(6)
  set setThrottle($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSetThrottle() => $_has(5);
  @$pb.TagNumber(6)
  void clearSetThrottle() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get frontSwivel => $_getN(6);
  @$pb.TagNumber(7)
  set frontSwivel($core.double value) => $_setFloat(6, value);
  @$pb.TagNumber(7)
  $core.bool hasFrontSwivel() => $_has(6);
  @$pb.TagNumber(7)
  void clearFrontSwivel() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get frontTilt => $_getN(7);
  @$pb.TagNumber(8)
  set frontTilt($core.double value) => $_setFloat(7, value);
  @$pb.TagNumber(8)
  $core.bool hasFrontTilt() => $_has(7);
  @$pb.TagNumber(8)
  void clearFrontTilt() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.double get rearSwivel => $_getN(8);
  @$pb.TagNumber(9)
  set rearSwivel($core.double value) => $_setFloat(8, value);
  @$pb.TagNumber(9)
  $core.bool hasRearSwivel() => $_has(8);
  @$pb.TagNumber(9)
  void clearRearSwivel() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.double get rearTilt => $_getN(9);
  @$pb.TagNumber(10)
  set rearTilt($core.double value) => $_setFloat(9, value);
  @$pb.TagNumber(10)
  $core.bool hasRearTilt() => $_has(9);
  @$pb.TagNumber(10)
  void clearRearTilt() => $_clearField(10);

  /// Vitals for the whole rover
  @$pb.TagNumber(11)
  $core.double get batteryVoltage => $_getN(10);
  @$pb.TagNumber(11)
  set batteryVoltage($core.double value) => $_setFloat(10, value);
  @$pb.TagNumber(11)
  $core.bool hasBatteryVoltage() => $_has(10);
  @$pb.TagNumber(11)
  void clearBatteryVoltage() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.double get batteryCurrent => $_getN(11);
  @$pb.TagNumber(12)
  set batteryCurrent($core.double value) => $_setFloat(11, value);
  @$pb.TagNumber(12)
  $core.bool hasBatteryCurrent() => $_has(11);
  @$pb.TagNumber(12)
  void clearBatteryCurrent() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.double get batteryTemperature => $_getN(12);
  @$pb.TagNumber(13)
  set batteryTemperature($core.double value) => $_setFloat(12, value);
  @$pb.TagNumber(13)
  $core.bool hasBatteryTemperature() => $_has(12);
  @$pb.TagNumber(13)
  void clearBatteryTemperature() => $_clearField(13);

  @$pb.TagNumber(14)
  $0.Version get version => $_getN(13);
  @$pb.TagNumber(14)
  set version($0.Version value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasVersion() => $_has(13);
  @$pb.TagNumber(14)
  void clearVersion() => $_clearField(14);
  @$pb.TagNumber(14)
  $0.Version ensureVersion() => $_ensure(13);

  @$pb.TagNumber(21)
  ProtoColor get color => $_getN(14);
  @$pb.TagNumber(21)
  set color(ProtoColor value) => $_setField(21, value);
  @$pb.TagNumber(21)
  $core.bool hasColor() => $_has(14);
  @$pb.TagNumber(21)
  void clearColor() => $_clearField(21);

  @$pb.TagNumber(22)
  $1.RoverStatus get status => $_getN(15);
  @$pb.TagNumber(22)
  set status($1.RoverStatus value) => $_setField(22, value);
  @$pb.TagNumber(22)
  $core.bool hasStatus() => $_has(15);
  @$pb.TagNumber(22)
  void clearStatus() => $_clearField(22);

  /// Contains the DriveMotorData for each corresponding motor
  @$pb.TagNumber(23)
  DriveMotorData get frontLeftMotor => $_getN(16);
  @$pb.TagNumber(23)
  set frontLeftMotor(DriveMotorData value) => $_setField(23, value);
  @$pb.TagNumber(23)
  $core.bool hasFrontLeftMotor() => $_has(16);
  @$pb.TagNumber(23)
  void clearFrontLeftMotor() => $_clearField(23);
  @$pb.TagNumber(23)
  DriveMotorData ensureFrontLeftMotor() => $_ensure(16);

  @$pb.TagNumber(24)
  DriveMotorData get middleLeftMotor => $_getN(17);
  @$pb.TagNumber(24)
  set middleLeftMotor(DriveMotorData value) => $_setField(24, value);
  @$pb.TagNumber(24)
  $core.bool hasMiddleLeftMotor() => $_has(17);
  @$pb.TagNumber(24)
  void clearMiddleLeftMotor() => $_clearField(24);
  @$pb.TagNumber(24)
  DriveMotorData ensureMiddleLeftMotor() => $_ensure(17);

  @$pb.TagNumber(25)
  DriveMotorData get backLeftMotor => $_getN(18);
  @$pb.TagNumber(25)
  set backLeftMotor(DriveMotorData value) => $_setField(25, value);
  @$pb.TagNumber(25)
  $core.bool hasBackLeftMotor() => $_has(18);
  @$pb.TagNumber(25)
  void clearBackLeftMotor() => $_clearField(25);
  @$pb.TagNumber(25)
  DriveMotorData ensureBackLeftMotor() => $_ensure(18);

  @$pb.TagNumber(26)
  DriveMotorData get frontRightMotor => $_getN(19);
  @$pb.TagNumber(26)
  set frontRightMotor(DriveMotorData value) => $_setField(26, value);
  @$pb.TagNumber(26)
  $core.bool hasFrontRightMotor() => $_has(19);
  @$pb.TagNumber(26)
  void clearFrontRightMotor() => $_clearField(26);
  @$pb.TagNumber(26)
  DriveMotorData ensureFrontRightMotor() => $_ensure(19);

  @$pb.TagNumber(27)
  DriveMotorData get middleRightMotor => $_getN(20);
  @$pb.TagNumber(27)
  set middleRightMotor(DriveMotorData value) => $_setField(27, value);
  @$pb.TagNumber(27)
  $core.bool hasMiddleRightMotor() => $_has(20);
  @$pb.TagNumber(27)
  void clearMiddleRightMotor() => $_clearField(27);
  @$pb.TagNumber(27)
  DriveMotorData ensureMiddleRightMotor() => $_ensure(20);

  @$pb.TagNumber(28)
  DriveMotorData get backRightMotor => $_getN(21);
  @$pb.TagNumber(28)
  set backRightMotor(DriveMotorData value) => $_setField(28, value);
  @$pb.TagNumber(28)
  $core.bool hasBackRightMotor() => $_has(21);
  @$pb.TagNumber(28)
  void clearBackRightMotor() => $_clearField(28);
  @$pb.TagNumber(28)
  DriveMotorData ensureBackRightMotor() => $_ensure(21);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
