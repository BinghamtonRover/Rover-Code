//
//  Generated code. Do not modify.
//  source: drive.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'drive.pbenum.dart';
import 'status.pbenum.dart' as $3;
import 'utils.pbenum.dart' as $4;
import 'version.pb.dart' as $1;

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
    $3.RoverStatus? status,
    $1.Version? version,
    ProtoColor? color,
    $4.BoolState? blink,
  }) {
    final $result = create();
    if (throttle != null) {
      $result.throttle = throttle;
    }
    if (left != null) {
      $result.left = left;
    }
    if (right != null) {
      $result.right = right;
    }
    if (setLeft != null) {
      $result.setLeft = setLeft;
    }
    if (setRight != null) {
      $result.setRight = setRight;
    }
    if (setThrottle != null) {
      $result.setThrottle = setThrottle;
    }
    if (frontSwivel != null) {
      $result.frontSwivel = frontSwivel;
    }
    if (frontTilt != null) {
      $result.frontTilt = frontTilt;
    }
    if (rearSwivel != null) {
      $result.rearSwivel = rearSwivel;
    }
    if (rearTilt != null) {
      $result.rearTilt = rearTilt;
    }
    if (status != null) {
      $result.status = status;
    }
    if (version != null) {
      $result.version = version;
    }
    if (color != null) {
      $result.color = color;
    }
    if (blink != null) {
      $result.blink = blink;
    }
    return $result;
  }
  DriveCommand._() : super();
  factory DriveCommand.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DriveCommand.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DriveCommand', createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'throttle', $pb.PbFieldType.OF)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'left', $pb.PbFieldType.OF)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'right', $pb.PbFieldType.OF)
    ..aOB(4, _omitFieldNames ? '' : 'setLeft')
    ..aOB(5, _omitFieldNames ? '' : 'setRight')
    ..aOB(6, _omitFieldNames ? '' : 'setThrottle')
    ..a<$core.double>(7, _omitFieldNames ? '' : 'frontSwivel', $pb.PbFieldType.OF)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'frontTilt', $pb.PbFieldType.OF)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'rearSwivel', $pb.PbFieldType.OF)
    ..a<$core.double>(10, _omitFieldNames ? '' : 'rearTilt', $pb.PbFieldType.OF)
    ..e<$3.RoverStatus>(11, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: $3.RoverStatus.DISCONNECTED, valueOf: $3.RoverStatus.valueOf, enumValues: $3.RoverStatus.values)
    ..aOM<$1.Version>(12, _omitFieldNames ? '' : 'version', subBuilder: $1.Version.create)
    ..e<ProtoColor>(13, _omitFieldNames ? '' : 'color', $pb.PbFieldType.OE, defaultOrMaker: ProtoColor.PROTO_COLOR_UNDEFINED, valueOf: ProtoColor.valueOf, enumValues: ProtoColor.values)
    ..e<$4.BoolState>(14, _omitFieldNames ? '' : 'blink', $pb.PbFieldType.OE, defaultOrMaker: $4.BoolState.BOOL_UNDEFINED, valueOf: $4.BoolState.valueOf, enumValues: $4.BoolState.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DriveCommand clone() => DriveCommand()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DriveCommand copyWith(void Function(DriveCommand) updates) => super.copyWith((message) => updates(message as DriveCommand)) as DriveCommand;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DriveCommand create() => DriveCommand._();
  DriveCommand createEmptyInstance() => create();
  static $pb.PbList<DriveCommand> createRepeated() => $pb.PbList<DriveCommand>();
  @$core.pragma('dart2js:noInline')
  static DriveCommand getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DriveCommand>(create);
  static DriveCommand? _defaultInstance;

  /// The max speed, as a percentage of the rover's possible speed.
  @$pb.TagNumber(1)
  $core.double get throttle => $_getN(0);
  @$pb.TagNumber(1)
  set throttle($core.double v) { $_setFloat(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasThrottle() => $_has(0);
  @$pb.TagNumber(1)
  void clearThrottle() => clearField(1);

  /// Speed of the left wheels, as a percentage of [throttle].
  @$pb.TagNumber(2)
  $core.double get left => $_getN(1);
  @$pb.TagNumber(2)
  set left($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLeft() => $_has(1);
  @$pb.TagNumber(2)
  void clearLeft() => clearField(2);

  /// Speed of the right wheels, as a percentage of [throttle].
  @$pb.TagNumber(3)
  $core.double get right => $_getN(2);
  @$pb.TagNumber(3)
  set right($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRight() => $_has(2);
  @$pb.TagNumber(3)
  void clearRight() => clearField(3);

  /// Indicates that [left] = 0 is valid, even though 0 usually means no value.
  @$pb.TagNumber(4)
  $core.bool get setLeft => $_getBF(3);
  @$pb.TagNumber(4)
  set setLeft($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSetLeft() => $_has(3);
  @$pb.TagNumber(4)
  void clearSetLeft() => clearField(4);

  /// Indicates that [right] = 0 is valid, even though 0 usually means no value.
  @$pb.TagNumber(5)
  $core.bool get setRight => $_getBF(4);
  @$pb.TagNumber(5)
  set setRight($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSetRight() => $_has(4);
  @$pb.TagNumber(5)
  void clearSetRight() => clearField(5);

  /// Indicates that [throttle] = 0 is valid, even though 0 usually means no value.
  @$pb.TagNumber(6)
  $core.bool get setThrottle => $_getBF(5);
  @$pb.TagNumber(6)
  set setThrottle($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSetThrottle() => $_has(5);
  @$pb.TagNumber(6)
  void clearSetThrottle() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get frontSwivel => $_getN(6);
  @$pb.TagNumber(7)
  set frontSwivel($core.double v) { $_setFloat(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasFrontSwivel() => $_has(6);
  @$pb.TagNumber(7)
  void clearFrontSwivel() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get frontTilt => $_getN(7);
  @$pb.TagNumber(8)
  set frontTilt($core.double v) { $_setFloat(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasFrontTilt() => $_has(7);
  @$pb.TagNumber(8)
  void clearFrontTilt() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get rearSwivel => $_getN(8);
  @$pb.TagNumber(9)
  set rearSwivel($core.double v) { $_setFloat(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasRearSwivel() => $_has(8);
  @$pb.TagNumber(9)
  void clearRearSwivel() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get rearTilt => $_getN(9);
  @$pb.TagNumber(10)
  set rearTilt($core.double v) { $_setFloat(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasRearTilt() => $_has(9);
  @$pb.TagNumber(10)
  void clearRearTilt() => clearField(10);

  @$pb.TagNumber(11)
  $3.RoverStatus get status => $_getN(10);
  @$pb.TagNumber(11)
  set status($3.RoverStatus v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasStatus() => $_has(10);
  @$pb.TagNumber(11)
  void clearStatus() => clearField(11);

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

  @$pb.TagNumber(13)
  ProtoColor get color => $_getN(12);
  @$pb.TagNumber(13)
  set color(ProtoColor v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasColor() => $_has(12);
  @$pb.TagNumber(13)
  void clearColor() => clearField(13);

  @$pb.TagNumber(14)
  $4.BoolState get blink => $_getN(13);
  @$pb.TagNumber(14)
  set blink($4.BoolState v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasBlink() => $_has(13);
  @$pb.TagNumber(14)
  void clearBlink() => clearField(14);
}

class DriveMotorData extends $pb.GeneratedMessage {
  factory DriveMotorData({
    $core.double? speed,
    $core.double? current,
    $core.int? temperature,
    MotorErrorCode? error,
  }) {
    final $result = create();
    if (speed != null) {
      $result.speed = speed;
    }
    if (current != null) {
      $result.current = current;
    }
    if (temperature != null) {
      $result.temperature = temperature;
    }
    if (error != null) {
      $result.error = error;
    }
    return $result;
  }
  DriveMotorData._() : super();
  factory DriveMotorData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DriveMotorData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DriveMotorData', createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'speed', $pb.PbFieldType.OF)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'current', $pb.PbFieldType.OF)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'temperature', $pb.PbFieldType.O3)
    ..e<MotorErrorCode>(4, _omitFieldNames ? '' : 'error', $pb.PbFieldType.OE, defaultOrMaker: MotorErrorCode.NO_FAULT, valueOf: MotorErrorCode.valueOf, enumValues: MotorErrorCode.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DriveMotorData clone() => DriveMotorData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DriveMotorData copyWith(void Function(DriveMotorData) updates) => super.copyWith((message) => updates(message as DriveMotorData)) as DriveMotorData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DriveMotorData create() => DriveMotorData._();
  DriveMotorData createEmptyInstance() => create();
  static $pb.PbList<DriveMotorData> createRepeated() => $pb.PbList<DriveMotorData>();
  @$core.pragma('dart2js:noInline')
  static DriveMotorData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DriveMotorData>(create);
  static DriveMotorData? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get speed => $_getN(0);
  @$pb.TagNumber(1)
  set speed($core.double v) { $_setFloat(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSpeed() => $_has(0);
  @$pb.TagNumber(1)
  void clearSpeed() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get current => $_getN(1);
  @$pb.TagNumber(2)
  set current($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCurrent() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrent() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get temperature => $_getIZ(2);
  @$pb.TagNumber(3)
  set temperature($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTemperature() => $_has(2);
  @$pb.TagNumber(3)
  void clearTemperature() => clearField(3);

  @$pb.TagNumber(4)
  MotorErrorCode get error => $_getN(3);
  @$pb.TagNumber(4)
  set error(MotorErrorCode v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasError() => $_has(3);
  @$pb.TagNumber(4)
  void clearError() => clearField(4);
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
    $1.Version? version,
    ProtoColor? color,
    $3.RoverStatus? status,
    DriveMotorData? frontLeftMotor,
    DriveMotorData? middleLeftMotor,
    DriveMotorData? backLeftMotor,
    DriveMotorData? frontRightMotor,
    DriveMotorData? middleRightMotor,
    DriveMotorData? backRightMotor,
  }) {
    final $result = create();
    if (throttle != null) {
      $result.throttle = throttle;
    }
    if (left != null) {
      $result.left = left;
    }
    if (right != null) {
      $result.right = right;
    }
    if (setLeft != null) {
      $result.setLeft = setLeft;
    }
    if (setRight != null) {
      $result.setRight = setRight;
    }
    if (setThrottle != null) {
      $result.setThrottle = setThrottle;
    }
    if (frontSwivel != null) {
      $result.frontSwivel = frontSwivel;
    }
    if (frontTilt != null) {
      $result.frontTilt = frontTilt;
    }
    if (rearSwivel != null) {
      $result.rearSwivel = rearSwivel;
    }
    if (rearTilt != null) {
      $result.rearTilt = rearTilt;
    }
    if (batteryVoltage != null) {
      $result.batteryVoltage = batteryVoltage;
    }
    if (batteryCurrent != null) {
      $result.batteryCurrent = batteryCurrent;
    }
    if (batteryTemperature != null) {
      $result.batteryTemperature = batteryTemperature;
    }
    if (version != null) {
      $result.version = version;
    }
    if (color != null) {
      $result.color = color;
    }
    if (status != null) {
      $result.status = status;
    }
    if (frontLeftMotor != null) {
      $result.frontLeftMotor = frontLeftMotor;
    }
    if (middleLeftMotor != null) {
      $result.middleLeftMotor = middleLeftMotor;
    }
    if (backLeftMotor != null) {
      $result.backLeftMotor = backLeftMotor;
    }
    if (frontRightMotor != null) {
      $result.frontRightMotor = frontRightMotor;
    }
    if (middleRightMotor != null) {
      $result.middleRightMotor = middleRightMotor;
    }
    if (backRightMotor != null) {
      $result.backRightMotor = backRightMotor;
    }
    return $result;
  }
  DriveData._() : super();
  factory DriveData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DriveData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DriveData', createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'throttle', $pb.PbFieldType.OF)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'left', $pb.PbFieldType.OF)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'right', $pb.PbFieldType.OF)
    ..aOB(4, _omitFieldNames ? '' : 'setLeft')
    ..aOB(5, _omitFieldNames ? '' : 'setRight')
    ..aOB(6, _omitFieldNames ? '' : 'setThrottle')
    ..a<$core.double>(7, _omitFieldNames ? '' : 'frontSwivel', $pb.PbFieldType.OF)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'frontTilt', $pb.PbFieldType.OF)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'rearSwivel', $pb.PbFieldType.OF)
    ..a<$core.double>(10, _omitFieldNames ? '' : 'rearTilt', $pb.PbFieldType.OF)
    ..a<$core.double>(11, _omitFieldNames ? '' : 'batteryVoltage', $pb.PbFieldType.OF)
    ..a<$core.double>(12, _omitFieldNames ? '' : 'batteryCurrent', $pb.PbFieldType.OF)
    ..a<$core.double>(13, _omitFieldNames ? '' : 'batteryTemperature', $pb.PbFieldType.OF)
    ..aOM<$1.Version>(14, _omitFieldNames ? '' : 'version', subBuilder: $1.Version.create)
    ..e<ProtoColor>(21, _omitFieldNames ? '' : 'color', $pb.PbFieldType.OE, defaultOrMaker: ProtoColor.PROTO_COLOR_UNDEFINED, valueOf: ProtoColor.valueOf, enumValues: ProtoColor.values)
    ..e<$3.RoverStatus>(22, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: $3.RoverStatus.DISCONNECTED, valueOf: $3.RoverStatus.valueOf, enumValues: $3.RoverStatus.values)
    ..aOM<DriveMotorData>(23, _omitFieldNames ? '' : 'frontLeftMotor', subBuilder: DriveMotorData.create)
    ..aOM<DriveMotorData>(24, _omitFieldNames ? '' : 'middleLeftMotor', subBuilder: DriveMotorData.create)
    ..aOM<DriveMotorData>(25, _omitFieldNames ? '' : 'backLeftMotor', subBuilder: DriveMotorData.create)
    ..aOM<DriveMotorData>(26, _omitFieldNames ? '' : 'frontRightMotor', subBuilder: DriveMotorData.create)
    ..aOM<DriveMotorData>(27, _omitFieldNames ? '' : 'middleRightMotor', subBuilder: DriveMotorData.create)
    ..aOM<DriveMotorData>(28, _omitFieldNames ? '' : 'backRightMotor', subBuilder: DriveMotorData.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DriveData clone() => DriveData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DriveData copyWith(void Function(DriveData) updates) => super.copyWith((message) => updates(message as DriveData)) as DriveData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DriveData create() => DriveData._();
  DriveData createEmptyInstance() => create();
  static $pb.PbList<DriveData> createRepeated() => $pb.PbList<DriveData>();
  @$core.pragma('dart2js:noInline')
  static DriveData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DriveData>(create);
  static DriveData? _defaultInstance;

  /// The max speed, as a percentage of the rover's possible speed.
  @$pb.TagNumber(1)
  $core.double get throttle => $_getN(0);
  @$pb.TagNumber(1)
  set throttle($core.double v) { $_setFloat(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasThrottle() => $_has(0);
  @$pb.TagNumber(1)
  void clearThrottle() => clearField(1);

  /// Speed of the left wheels, as a percentage of [throttle].
  @$pb.TagNumber(2)
  $core.double get left => $_getN(1);
  @$pb.TagNumber(2)
  set left($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLeft() => $_has(1);
  @$pb.TagNumber(2)
  void clearLeft() => clearField(2);

  /// Speed of the right wheels, as a percentage of [throttle].
  @$pb.TagNumber(3)
  $core.double get right => $_getN(2);
  @$pb.TagNumber(3)
  set right($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRight() => $_has(2);
  @$pb.TagNumber(3)
  void clearRight() => clearField(3);

  /// Indicates that [left] = 0 is valid, even though 0 usually means no value.
  @$pb.TagNumber(4)
  $core.bool get setLeft => $_getBF(3);
  @$pb.TagNumber(4)
  set setLeft($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSetLeft() => $_has(3);
  @$pb.TagNumber(4)
  void clearSetLeft() => clearField(4);

  /// Indicates that [right] = 0 is valid, even though 0 usually means no value.
  @$pb.TagNumber(5)
  $core.bool get setRight => $_getBF(4);
  @$pb.TagNumber(5)
  set setRight($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSetRight() => $_has(4);
  @$pb.TagNumber(5)
  void clearSetRight() => clearField(5);

  /// Indicates that [throttle] = 0 is valid, even though 0 usually means no value.
  @$pb.TagNumber(6)
  $core.bool get setThrottle => $_getBF(5);
  @$pb.TagNumber(6)
  set setThrottle($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSetThrottle() => $_has(5);
  @$pb.TagNumber(6)
  void clearSetThrottle() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get frontSwivel => $_getN(6);
  @$pb.TagNumber(7)
  set frontSwivel($core.double v) { $_setFloat(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasFrontSwivel() => $_has(6);
  @$pb.TagNumber(7)
  void clearFrontSwivel() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get frontTilt => $_getN(7);
  @$pb.TagNumber(8)
  set frontTilt($core.double v) { $_setFloat(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasFrontTilt() => $_has(7);
  @$pb.TagNumber(8)
  void clearFrontTilt() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get rearSwivel => $_getN(8);
  @$pb.TagNumber(9)
  set rearSwivel($core.double v) { $_setFloat(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasRearSwivel() => $_has(8);
  @$pb.TagNumber(9)
  void clearRearSwivel() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get rearTilt => $_getN(9);
  @$pb.TagNumber(10)
  set rearTilt($core.double v) { $_setFloat(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasRearTilt() => $_has(9);
  @$pb.TagNumber(10)
  void clearRearTilt() => clearField(10);

  /// Vitals for the whole rover
  @$pb.TagNumber(11)
  $core.double get batteryVoltage => $_getN(10);
  @$pb.TagNumber(11)
  set batteryVoltage($core.double v) { $_setFloat(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasBatteryVoltage() => $_has(10);
  @$pb.TagNumber(11)
  void clearBatteryVoltage() => clearField(11);

  @$pb.TagNumber(12)
  $core.double get batteryCurrent => $_getN(11);
  @$pb.TagNumber(12)
  set batteryCurrent($core.double v) { $_setFloat(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasBatteryCurrent() => $_has(11);
  @$pb.TagNumber(12)
  void clearBatteryCurrent() => clearField(12);

  @$pb.TagNumber(13)
  $core.double get batteryTemperature => $_getN(12);
  @$pb.TagNumber(13)
  set batteryTemperature($core.double v) { $_setFloat(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasBatteryTemperature() => $_has(12);
  @$pb.TagNumber(13)
  void clearBatteryTemperature() => clearField(13);

  @$pb.TagNumber(14)
  $1.Version get version => $_getN(13);
  @$pb.TagNumber(14)
  set version($1.Version v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasVersion() => $_has(13);
  @$pb.TagNumber(14)
  void clearVersion() => clearField(14);
  @$pb.TagNumber(14)
  $1.Version ensureVersion() => $_ensure(13);

  @$pb.TagNumber(21)
  ProtoColor get color => $_getN(14);
  @$pb.TagNumber(21)
  set color(ProtoColor v) { setField(21, v); }
  @$pb.TagNumber(21)
  $core.bool hasColor() => $_has(14);
  @$pb.TagNumber(21)
  void clearColor() => clearField(21);

  @$pb.TagNumber(22)
  $3.RoverStatus get status => $_getN(15);
  @$pb.TagNumber(22)
  set status($3.RoverStatus v) { setField(22, v); }
  @$pb.TagNumber(22)
  $core.bool hasStatus() => $_has(15);
  @$pb.TagNumber(22)
  void clearStatus() => clearField(22);

  /// Contains the DriveMotorData for each corresponding motor
  @$pb.TagNumber(23)
  DriveMotorData get frontLeftMotor => $_getN(16);
  @$pb.TagNumber(23)
  set frontLeftMotor(DriveMotorData v) { setField(23, v); }
  @$pb.TagNumber(23)
  $core.bool hasFrontLeftMotor() => $_has(16);
  @$pb.TagNumber(23)
  void clearFrontLeftMotor() => clearField(23);
  @$pb.TagNumber(23)
  DriveMotorData ensureFrontLeftMotor() => $_ensure(16);

  @$pb.TagNumber(24)
  DriveMotorData get middleLeftMotor => $_getN(17);
  @$pb.TagNumber(24)
  set middleLeftMotor(DriveMotorData v) { setField(24, v); }
  @$pb.TagNumber(24)
  $core.bool hasMiddleLeftMotor() => $_has(17);
  @$pb.TagNumber(24)
  void clearMiddleLeftMotor() => clearField(24);
  @$pb.TagNumber(24)
  DriveMotorData ensureMiddleLeftMotor() => $_ensure(17);

  @$pb.TagNumber(25)
  DriveMotorData get backLeftMotor => $_getN(18);
  @$pb.TagNumber(25)
  set backLeftMotor(DriveMotorData v) { setField(25, v); }
  @$pb.TagNumber(25)
  $core.bool hasBackLeftMotor() => $_has(18);
  @$pb.TagNumber(25)
  void clearBackLeftMotor() => clearField(25);
  @$pb.TagNumber(25)
  DriveMotorData ensureBackLeftMotor() => $_ensure(18);

  @$pb.TagNumber(26)
  DriveMotorData get frontRightMotor => $_getN(19);
  @$pb.TagNumber(26)
  set frontRightMotor(DriveMotorData v) { setField(26, v); }
  @$pb.TagNumber(26)
  $core.bool hasFrontRightMotor() => $_has(19);
  @$pb.TagNumber(26)
  void clearFrontRightMotor() => clearField(26);
  @$pb.TagNumber(26)
  DriveMotorData ensureFrontRightMotor() => $_ensure(19);

  @$pb.TagNumber(27)
  DriveMotorData get middleRightMotor => $_getN(20);
  @$pb.TagNumber(27)
  set middleRightMotor(DriveMotorData v) { setField(27, v); }
  @$pb.TagNumber(27)
  $core.bool hasMiddleRightMotor() => $_has(20);
  @$pb.TagNumber(27)
  void clearMiddleRightMotor() => clearField(27);
  @$pb.TagNumber(27)
  DriveMotorData ensureMiddleRightMotor() => $_ensure(20);

  @$pb.TagNumber(28)
  DriveMotorData get backRightMotor => $_getN(21);
  @$pb.TagNumber(28)
  set backRightMotor(DriveMotorData v) { setField(28, v); }
  @$pb.TagNumber(28)
  $core.bool hasBackRightMotor() => $_has(21);
  @$pb.TagNumber(28)
  void clearBackRightMotor() => clearField(28);
  @$pb.TagNumber(28)
  DriveMotorData ensureBackRightMotor() => $_ensure(21);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
