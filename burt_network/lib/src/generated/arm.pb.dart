// This is a generated file - do not edit.
//
// Generated from arm.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'geometry.pb.dart' as $2;
import 'motor.pb.dart' as $0;
import 'utils.pbenum.dart' as $3;
import 'version.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class JointAngleData extends $pb.GeneratedMessage {
  factory JointAngleData({
    $core.double? swivelSingle,
    $core.double? shoulderSingle,
    $core.double? elbowSingle,
    $core.double? rollSingle,
    $core.double? wristPitchSingle,
    $core.double? swivelMulti,
    $core.double? shoulderMulti,
    $core.double? elbowMulti,
    $core.double? rollMulti,
    $core.double? wristPitchMulti,
  }) {
    final result = create();
    if (swivelSingle != null) result.swivelSingle = swivelSingle;
    if (shoulderSingle != null) result.shoulderSingle = shoulderSingle;
    if (elbowSingle != null) result.elbowSingle = elbowSingle;
    if (rollSingle != null) result.rollSingle = rollSingle;
    if (wristPitchSingle != null) result.wristPitchSingle = wristPitchSingle;
    if (swivelMulti != null) result.swivelMulti = swivelMulti;
    if (shoulderMulti != null) result.shoulderMulti = shoulderMulti;
    if (elbowMulti != null) result.elbowMulti = elbowMulti;
    if (rollMulti != null) result.rollMulti = rollMulti;
    if (wristPitchMulti != null) result.wristPitchMulti = wristPitchMulti;
    return result;
  }

  JointAngleData._();

  factory JointAngleData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory JointAngleData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'JointAngleData',
      createEmptyInstance: create)
    ..aD(1, _omitFieldNames ? '' : 'swivelSingle',
        fieldType: $pb.PbFieldType.OF)
    ..aD(2, _omitFieldNames ? '' : 'shoulderSingle',
        fieldType: $pb.PbFieldType.OF)
    ..aD(3, _omitFieldNames ? '' : 'elbowSingle', fieldType: $pb.PbFieldType.OF)
    ..aD(4, _omitFieldNames ? '' : 'rollSingle', fieldType: $pb.PbFieldType.OF)
    ..aD(5, _omitFieldNames ? '' : 'wristPitchSingle',
        fieldType: $pb.PbFieldType.OF)
    ..aD(6, _omitFieldNames ? '' : 'swivelMulti', fieldType: $pb.PbFieldType.OF)
    ..aD(7, _omitFieldNames ? '' : 'shoulderMulti',
        fieldType: $pb.PbFieldType.OF)
    ..aD(8, _omitFieldNames ? '' : 'elbowMulti', fieldType: $pb.PbFieldType.OF)
    ..aD(9, _omitFieldNames ? '' : 'rollMulti', fieldType: $pb.PbFieldType.OF)
    ..aD(10, _omitFieldNames ? '' : 'wristPitchMulti',
        fieldType: $pb.PbFieldType.OF)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JointAngleData clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JointAngleData copyWith(void Function(JointAngleData) updates) =>
      super.copyWith((message) => updates(message as JointAngleData))
          as JointAngleData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JointAngleData create() => JointAngleData._();
  @$core.override
  JointAngleData createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static JointAngleData getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<JointAngleData>(create);
  static JointAngleData? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get swivelSingle => $_getN(0);
  @$pb.TagNumber(1)
  set swivelSingle($core.double value) => $_setFloat(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSwivelSingle() => $_has(0);
  @$pb.TagNumber(1)
  void clearSwivelSingle() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get shoulderSingle => $_getN(1);
  @$pb.TagNumber(2)
  set shoulderSingle($core.double value) => $_setFloat(1, value);
  @$pb.TagNumber(2)
  $core.bool hasShoulderSingle() => $_has(1);
  @$pb.TagNumber(2)
  void clearShoulderSingle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get elbowSingle => $_getN(2);
  @$pb.TagNumber(3)
  set elbowSingle($core.double value) => $_setFloat(2, value);
  @$pb.TagNumber(3)
  $core.bool hasElbowSingle() => $_has(2);
  @$pb.TagNumber(3)
  void clearElbowSingle() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get rollSingle => $_getN(3);
  @$pb.TagNumber(4)
  set rollSingle($core.double value) => $_setFloat(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRollSingle() => $_has(3);
  @$pb.TagNumber(4)
  void clearRollSingle() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get wristPitchSingle => $_getN(4);
  @$pb.TagNumber(5)
  set wristPitchSingle($core.double value) => $_setFloat(4, value);
  @$pb.TagNumber(5)
  $core.bool hasWristPitchSingle() => $_has(4);
  @$pb.TagNumber(5)
  void clearWristPitchSingle() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get swivelMulti => $_getN(5);
  @$pb.TagNumber(6)
  set swivelMulti($core.double value) => $_setFloat(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSwivelMulti() => $_has(5);
  @$pb.TagNumber(6)
  void clearSwivelMulti() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get shoulderMulti => $_getN(6);
  @$pb.TagNumber(7)
  set shoulderMulti($core.double value) => $_setFloat(6, value);
  @$pb.TagNumber(7)
  $core.bool hasShoulderMulti() => $_has(6);
  @$pb.TagNumber(7)
  void clearShoulderMulti() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get elbowMulti => $_getN(7);
  @$pb.TagNumber(8)
  set elbowMulti($core.double value) => $_setFloat(7, value);
  @$pb.TagNumber(8)
  $core.bool hasElbowMulti() => $_has(7);
  @$pb.TagNumber(8)
  void clearElbowMulti() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.double get rollMulti => $_getN(8);
  @$pb.TagNumber(9)
  set rollMulti($core.double value) => $_setFloat(8, value);
  @$pb.TagNumber(9)
  $core.bool hasRollMulti() => $_has(8);
  @$pb.TagNumber(9)
  void clearRollMulti() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.double get wristPitchMulti => $_getN(9);
  @$pb.TagNumber(10)
  set wristPitchMulti($core.double value) => $_setFloat(9, value);
  @$pb.TagNumber(10)
  $core.bool hasWristPitchMulti() => $_has(9);
  @$pb.TagNumber(10)
  void clearWristPitchMulti() => $_clearField(10);
}

class WristData extends $pb.GeneratedMessage {
  factory WristData({
    $core.double? pitchAngle,
    $core.double? rollAngle,
    $0.MotorData? motorA,
    $0.MotorData? motorB,
    $3.BoolState? isMoving,
    $3.BoolState? isCalibrated,
    $1.Version? version,
  }) {
    final result = create();
    if (pitchAngle != null) result.pitchAngle = pitchAngle;
    if (rollAngle != null) result.rollAngle = rollAngle;
    if (motorA != null) result.motorA = motorA;
    if (motorB != null) result.motorB = motorB;
    if (isMoving != null) result.isMoving = isMoving;
    if (isCalibrated != null) result.isCalibrated = isCalibrated;
    if (version != null) result.version = version;
    return result;
  }

  WristData._();

  factory WristData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WristData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WristData',
      createEmptyInstance: create)
    ..aD(1, _omitFieldNames ? '' : 'pitchAngle', fieldType: $pb.PbFieldType.OF)
    ..aD(2, _omitFieldNames ? '' : 'rollAngle', fieldType: $pb.PbFieldType.OF)
    ..aOM<$0.MotorData>(3, _omitFieldNames ? '' : 'motorA',
        protoName: 'motorA', subBuilder: $0.MotorData.create)
    ..aOM<$0.MotorData>(4, _omitFieldNames ? '' : 'motorB',
        protoName: 'motorB', subBuilder: $0.MotorData.create)
    ..aE<$3.BoolState>(5, _omitFieldNames ? '' : 'isMoving',
        enumValues: $3.BoolState.values)
    ..aE<$3.BoolState>(6, _omitFieldNames ? '' : 'isCalibrated',
        enumValues: $3.BoolState.values)
    ..aOM<$1.Version>(7, _omitFieldNames ? '' : 'version',
        subBuilder: $1.Version.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WristData clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WristData copyWith(void Function(WristData) updates) =>
      super.copyWith((message) => updates(message as WristData)) as WristData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WristData create() => WristData._();
  @$core.override
  WristData createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static WristData getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WristData>(create);
  static WristData? _defaultInstance;

  /// Virtual joint state (what the subsystem thinks pitch/roll are).
  @$pb.TagNumber(1)
  $core.double get pitchAngle => $_getN(0);
  @$pb.TagNumber(1)
  set pitchAngle($core.double value) => $_setFloat(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPitchAngle() => $_has(0);
  @$pb.TagNumber(1)
  void clearPitchAngle() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get rollAngle => $_getN(1);
  @$pb.TagNumber(2)
  set rollAngle($core.double value) => $_setFloat(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRollAngle() => $_has(1);
  @$pb.TagNumber(2)
  void clearRollAngle() => $_clearField(2);

  @$pb.TagNumber(3)
  $0.MotorData get motorA => $_getN(2);
  @$pb.TagNumber(3)
  set motorA($0.MotorData value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasMotorA() => $_has(2);
  @$pb.TagNumber(3)
  void clearMotorA() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.MotorData ensureMotorA() => $_ensure(2);

  @$pb.TagNumber(4)
  $0.MotorData get motorB => $_getN(3);
  @$pb.TagNumber(4)
  set motorB($0.MotorData value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasMotorB() => $_has(3);
  @$pb.TagNumber(4)
  void clearMotorB() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.MotorData ensureMotorB() => $_ensure(3);

  /// Overall health/status flags
  @$pb.TagNumber(5)
  $3.BoolState get isMoving => $_getN(4);
  @$pb.TagNumber(5)
  set isMoving($3.BoolState value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasIsMoving() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsMoving() => $_clearField(5);

  @$pb.TagNumber(6)
  $3.BoolState get isCalibrated => $_getN(5);
  @$pb.TagNumber(6)
  set isCalibrated($3.BoolState value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasIsCalibrated() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsCalibrated() => $_clearField(6);

  @$pb.TagNumber(7)
  $1.Version get version => $_getN(6);
  @$pb.TagNumber(7)
  set version($1.Version value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasVersion() => $_has(6);
  @$pb.TagNumber(7)
  void clearVersion() => $_clearField(7);
  @$pb.TagNumber(7)
  $1.Version ensureVersion() => $_ensure(6);
}

class ArmData extends $pb.GeneratedMessage {
  factory ArmData({
    $2.Coordinates? currentPosition,
    $2.Coordinates? targetPosition,
    $0.MotorData? base,
    $0.MotorData? shoulder,
    $0.MotorData? elbow,
    $1.Version? version,
    $core.double? ussDistance,
    $0.MotorData? lift,
    $0.MotorData? rotate,
    $0.MotorData? pinch,
    $core.int? servoAngle,
    $3.BoolState? laserState,
    $0.MotorData? roll,
    JointAngleData? jointAngles,
    WristData? wrist,
    $3.BoolState? usingIk,
    $2.Orientation? currentOrientation,
    $2.Orientation? targetOrientation,
  }) {
    final result = create();
    if (currentPosition != null) result.currentPosition = currentPosition;
    if (targetPosition != null) result.targetPosition = targetPosition;
    if (base != null) result.base = base;
    if (shoulder != null) result.shoulder = shoulder;
    if (elbow != null) result.elbow = elbow;
    if (version != null) result.version = version;
    if (ussDistance != null) result.ussDistance = ussDistance;
    if (lift != null) result.lift = lift;
    if (rotate != null) result.rotate = rotate;
    if (pinch != null) result.pinch = pinch;
    if (servoAngle != null) result.servoAngle = servoAngle;
    if (laserState != null) result.laserState = laserState;
    if (roll != null) result.roll = roll;
    if (jointAngles != null) result.jointAngles = jointAngles;
    if (wrist != null) result.wrist = wrist;
    if (usingIk != null) result.usingIk = usingIk;
    if (currentOrientation != null)
      result.currentOrientation = currentOrientation;
    if (targetOrientation != null) result.targetOrientation = targetOrientation;
    return result;
  }

  ArmData._();

  factory ArmData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ArmData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ArmData',
      createEmptyInstance: create)
    ..aOM<$2.Coordinates>(1, _omitFieldNames ? '' : 'currentPosition',
        subBuilder: $2.Coordinates.create)
    ..aOM<$2.Coordinates>(2, _omitFieldNames ? '' : 'targetPosition',
        subBuilder: $2.Coordinates.create)
    ..aOM<$0.MotorData>(3, _omitFieldNames ? '' : 'base',
        subBuilder: $0.MotorData.create)
    ..aOM<$0.MotorData>(4, _omitFieldNames ? '' : 'shoulder',
        subBuilder: $0.MotorData.create)
    ..aOM<$0.MotorData>(5, _omitFieldNames ? '' : 'elbow',
        subBuilder: $0.MotorData.create)
    ..aOM<$1.Version>(6, _omitFieldNames ? '' : 'version',
        subBuilder: $1.Version.create)
    ..aD(7, _omitFieldNames ? '' : 'ussDistance', fieldType: $pb.PbFieldType.OF)
    ..aOM<$0.MotorData>(8, _omitFieldNames ? '' : 'lift',
        subBuilder: $0.MotorData.create)
    ..aOM<$0.MotorData>(9, _omitFieldNames ? '' : 'rotate',
        subBuilder: $0.MotorData.create)
    ..aOM<$0.MotorData>(10, _omitFieldNames ? '' : 'pinch',
        subBuilder: $0.MotorData.create)
    ..aI(11, _omitFieldNames ? '' : 'servoAngle')
    ..aE<$3.BoolState>(12, _omitFieldNames ? '' : 'laserState',
        enumValues: $3.BoolState.values)
    ..aOM<$0.MotorData>(13, _omitFieldNames ? '' : 'roll',
        subBuilder: $0.MotorData.create)
    ..aOM<JointAngleData>(14, _omitFieldNames ? '' : 'jointAngles',
        subBuilder: JointAngleData.create)
    ..aOM<WristData>(15, _omitFieldNames ? '' : 'wrist',
        subBuilder: WristData.create)
    ..aE<$3.BoolState>(16, _omitFieldNames ? '' : 'usingIk',
        enumValues: $3.BoolState.values)
    ..aOM<$2.Orientation>(17, _omitFieldNames ? '' : 'currentOrientation',
        subBuilder: $2.Orientation.create)
    ..aOM<$2.Orientation>(18, _omitFieldNames ? '' : 'targetOrientation',
        subBuilder: $2.Orientation.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ArmData clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ArmData copyWith(void Function(ArmData) updates) =>
      super.copyWith((message) => updates(message as ArmData)) as ArmData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ArmData create() => ArmData._();
  @$core.override
  ArmData createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ArmData getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ArmData>(create);
  static ArmData? _defaultInstance;

  /// Arm Commands
  @$pb.TagNumber(1)
  $2.Coordinates get currentPosition => $_getN(0);
  @$pb.TagNumber(1)
  set currentPosition($2.Coordinates value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCurrentPosition() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrentPosition() => $_clearField(1);
  @$pb.TagNumber(1)
  $2.Coordinates ensureCurrentPosition() => $_ensure(0);

  @$pb.TagNumber(2)
  $2.Coordinates get targetPosition => $_getN(1);
  @$pb.TagNumber(2)
  set targetPosition($2.Coordinates value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasTargetPosition() => $_has(1);
  @$pb.TagNumber(2)
  void clearTargetPosition() => $_clearField(2);
  @$pb.TagNumber(2)
  $2.Coordinates ensureTargetPosition() => $_ensure(1);

  @$pb.TagNumber(3)
  $0.MotorData get base => $_getN(2);
  @$pb.TagNumber(3)
  set base($0.MotorData value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasBase() => $_has(2);
  @$pb.TagNumber(3)
  void clearBase() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.MotorData ensureBase() => $_ensure(2);

  @$pb.TagNumber(4)
  $0.MotorData get shoulder => $_getN(3);
  @$pb.TagNumber(4)
  set shoulder($0.MotorData value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasShoulder() => $_has(3);
  @$pb.TagNumber(4)
  void clearShoulder() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.MotorData ensureShoulder() => $_ensure(3);

  @$pb.TagNumber(5)
  $0.MotorData get elbow => $_getN(4);
  @$pb.TagNumber(5)
  set elbow($0.MotorData value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasElbow() => $_has(4);
  @$pb.TagNumber(5)
  void clearElbow() => $_clearField(5);
  @$pb.TagNumber(5)
  $0.MotorData ensureElbow() => $_ensure(4);

  @$pb.TagNumber(6)
  $1.Version get version => $_getN(5);
  @$pb.TagNumber(6)
  set version($1.Version value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasVersion() => $_has(5);
  @$pb.TagNumber(6)
  void clearVersion() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Version ensureVersion() => $_ensure(5);

  /// USS data
  @$pb.TagNumber(7)
  $core.double get ussDistance => $_getN(6);
  @$pb.TagNumber(7)
  set ussDistance($core.double value) => $_setFloat(6, value);
  @$pb.TagNumber(7)
  $core.bool hasUssDistance() => $_has(6);
  @$pb.TagNumber(7)
  void clearUssDistance() => $_clearField(7);

  /// Gripper Commands
  @$pb.TagNumber(8)
  $0.MotorData get lift => $_getN(7);
  @$pb.TagNumber(8)
  set lift($0.MotorData value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasLift() => $_has(7);
  @$pb.TagNumber(8)
  void clearLift() => $_clearField(8);
  @$pb.TagNumber(8)
  $0.MotorData ensureLift() => $_ensure(7);

  @$pb.TagNumber(9)
  $0.MotorData get rotate => $_getN(8);
  @$pb.TagNumber(9)
  set rotate($0.MotorData value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasRotate() => $_has(8);
  @$pb.TagNumber(9)
  void clearRotate() => $_clearField(9);
  @$pb.TagNumber(9)
  $0.MotorData ensureRotate() => $_ensure(8);

  @$pb.TagNumber(10)
  $0.MotorData get pinch => $_getN(9);
  @$pb.TagNumber(10)
  set pinch($0.MotorData value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasPinch() => $_has(9);
  @$pb.TagNumber(10)
  void clearPinch() => $_clearField(10);
  @$pb.TagNumber(10)
  $0.MotorData ensurePinch() => $_ensure(9);

  @$pb.TagNumber(11)
  $core.int get servoAngle => $_getIZ(10);
  @$pb.TagNumber(11)
  set servoAngle($core.int value) => $_setSignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasServoAngle() => $_has(10);
  @$pb.TagNumber(11)
  void clearServoAngle() => $_clearField(11);

  @$pb.TagNumber(12)
  $3.BoolState get laserState => $_getN(11);
  @$pb.TagNumber(12)
  set laserState($3.BoolState value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasLaserState() => $_has(11);
  @$pb.TagNumber(12)
  void clearLaserState() => $_clearField(12);

  @$pb.TagNumber(13)
  $0.MotorData get roll => $_getN(12);
  @$pb.TagNumber(13)
  set roll($0.MotorData value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasRoll() => $_has(12);
  @$pb.TagNumber(13)
  void clearRoll() => $_clearField(13);
  @$pb.TagNumber(13)
  $0.MotorData ensureRoll() => $_ensure(12);

  @$pb.TagNumber(14)
  JointAngleData get jointAngles => $_getN(13);
  @$pb.TagNumber(14)
  set jointAngles(JointAngleData value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasJointAngles() => $_has(13);
  @$pb.TagNumber(14)
  void clearJointAngles() => $_clearField(14);
  @$pb.TagNumber(14)
  JointAngleData ensureJointAngles() => $_ensure(13);

  @$pb.TagNumber(15)
  WristData get wrist => $_getN(14);
  @$pb.TagNumber(15)
  set wrist(WristData value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasWrist() => $_has(14);
  @$pb.TagNumber(15)
  void clearWrist() => $_clearField(15);
  @$pb.TagNumber(15)
  WristData ensureWrist() => $_ensure(14);

  @$pb.TagNumber(16)
  $3.BoolState get usingIk => $_getN(15);
  @$pb.TagNumber(16)
  set usingIk($3.BoolState value) => $_setField(16, value);
  @$pb.TagNumber(16)
  $core.bool hasUsingIk() => $_has(15);
  @$pb.TagNumber(16)
  void clearUsingIk() => $_clearField(16);

  @$pb.TagNumber(17)
  $2.Orientation get currentOrientation => $_getN(16);
  @$pb.TagNumber(17)
  set currentOrientation($2.Orientation value) => $_setField(17, value);
  @$pb.TagNumber(17)
  $core.bool hasCurrentOrientation() => $_has(16);
  @$pb.TagNumber(17)
  void clearCurrentOrientation() => $_clearField(17);
  @$pb.TagNumber(17)
  $2.Orientation ensureCurrentOrientation() => $_ensure(16);

  @$pb.TagNumber(18)
  $2.Orientation get targetOrientation => $_getN(17);
  @$pb.TagNumber(18)
  set targetOrientation($2.Orientation value) => $_setField(18, value);
  @$pb.TagNumber(18)
  $core.bool hasTargetOrientation() => $_has(17);
  @$pb.TagNumber(18)
  void clearTargetOrientation() => $_clearField(18);
  @$pb.TagNumber(18)
  $2.Orientation ensureTargetOrientation() => $_ensure(17);
}

class WristCommand extends $pb.GeneratedMessage {
  factory WristCommand({
    $core.bool? stop,
    $core.bool? calibrate,
    $0.MotorCommand? pitch,
    $0.MotorCommand? roll,
    $1.Version? version,
  }) {
    final result = create();
    if (stop != null) result.stop = stop;
    if (calibrate != null) result.calibrate = calibrate;
    if (pitch != null) result.pitch = pitch;
    if (roll != null) result.roll = roll;
    if (version != null) result.version = version;
    return result;
  }

  WristCommand._();

  factory WristCommand.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WristCommand.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WristCommand',
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'stop')
    ..aOB(2, _omitFieldNames ? '' : 'calibrate')
    ..aOM<$0.MotorCommand>(3, _omitFieldNames ? '' : 'pitch',
        subBuilder: $0.MotorCommand.create)
    ..aOM<$0.MotorCommand>(4, _omitFieldNames ? '' : 'roll',
        subBuilder: $0.MotorCommand.create)
    ..aOM<$1.Version>(5, _omitFieldNames ? '' : 'version',
        subBuilder: $1.Version.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WristCommand clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WristCommand copyWith(void Function(WristCommand) updates) =>
      super.copyWith((message) => updates(message as WristCommand))
          as WristCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WristCommand create() => WristCommand._();
  @$core.override
  WristCommand createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static WristCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WristCommand>(create);
  static WristCommand? _defaultInstance;

  /// General commands for wrist
  @$pb.TagNumber(1)
  $core.bool get stop => $_getBF(0);
  @$pb.TagNumber(1)
  set stop($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStop() => $_has(0);
  @$pb.TagNumber(1)
  void clearStop() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get calibrate => $_getBF(1);
  @$pb.TagNumber(2)
  set calibrate($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCalibrate() => $_has(1);
  @$pb.TagNumber(2)
  void clearCalibrate() => $_clearField(2);

  /// Virtual joints (preferred): command the coupled wrist DOFs.
  /// Firmware may execute one axis at a time for mechanical safety.
  @$pb.TagNumber(3)
  $0.MotorCommand get pitch => $_getN(2);
  @$pb.TagNumber(3)
  set pitch($0.MotorCommand value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasPitch() => $_has(2);
  @$pb.TagNumber(3)
  void clearPitch() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.MotorCommand ensurePitch() => $_ensure(2);

  @$pb.TagNumber(4)
  $0.MotorCommand get roll => $_getN(3);
  @$pb.TagNumber(4)
  set roll($0.MotorCommand value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasRoll() => $_has(3);
  @$pb.TagNumber(4)
  void clearRoll() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.MotorCommand ensureRoll() => $_ensure(3);

  @$pb.TagNumber(5)
  $1.Version get version => $_getN(4);
  @$pb.TagNumber(5)
  set version($1.Version value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasVersion() => $_has(4);
  @$pb.TagNumber(5)
  void clearVersion() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Version ensureVersion() => $_ensure(4);
}

class ArmCommand extends $pb.GeneratedMessage {
  factory ArmCommand({
    $core.bool? stop,
    $core.bool? calibrate,
    $0.MotorCommand? swivel,
    $0.MotorCommand? shoulder,
    $0.MotorCommand? elbow,
    $0.MotorCommand? gripperLift,
    $core.double? ikX,
    $core.double? ikY,
    $core.double? ikZ,
    $core.bool? jab,
    $1.Version? version,
    $3.BoolState? startUss,
    $0.MotorCommand? lift,
    $0.MotorCommand? rotate,
    $0.MotorCommand? pinch,
    $core.bool? open,
    $core.bool? close,
    $core.bool? spin,
    $core.int? servoAngle,
    $3.BoolState? laserState,
    $0.MotorCommand? roll,
    WristCommand? wrist,
    $3.BoolState? usingIk,
    $core.double? ikPitch,
    $core.double? ikYaw,
    $2.Pose3d? pose,
  }) {
    final result = create();
    if (stop != null) result.stop = stop;
    if (calibrate != null) result.calibrate = calibrate;
    if (swivel != null) result.swivel = swivel;
    if (shoulder != null) result.shoulder = shoulder;
    if (elbow != null) result.elbow = elbow;
    if (gripperLift != null) result.gripperLift = gripperLift;
    if (ikX != null) result.ikX = ikX;
    if (ikY != null) result.ikY = ikY;
    if (ikZ != null) result.ikZ = ikZ;
    if (jab != null) result.jab = jab;
    if (version != null) result.version = version;
    if (startUss != null) result.startUss = startUss;
    if (lift != null) result.lift = lift;
    if (rotate != null) result.rotate = rotate;
    if (pinch != null) result.pinch = pinch;
    if (open != null) result.open = open;
    if (close != null) result.close = close;
    if (spin != null) result.spin = spin;
    if (servoAngle != null) result.servoAngle = servoAngle;
    if (laserState != null) result.laserState = laserState;
    if (roll != null) result.roll = roll;
    if (wrist != null) result.wrist = wrist;
    if (usingIk != null) result.usingIk = usingIk;
    if (ikPitch != null) result.ikPitch = ikPitch;
    if (ikYaw != null) result.ikYaw = ikYaw;
    if (pose != null) result.pose = pose;
    return result;
  }

  ArmCommand._();

  factory ArmCommand.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ArmCommand.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ArmCommand',
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'stop')
    ..aOB(2, _omitFieldNames ? '' : 'calibrate')
    ..aOM<$0.MotorCommand>(3, _omitFieldNames ? '' : 'swivel',
        subBuilder: $0.MotorCommand.create)
    ..aOM<$0.MotorCommand>(4, _omitFieldNames ? '' : 'shoulder',
        subBuilder: $0.MotorCommand.create)
    ..aOM<$0.MotorCommand>(5, _omitFieldNames ? '' : 'elbow',
        subBuilder: $0.MotorCommand.create)
    ..aOM<$0.MotorCommand>(6, _omitFieldNames ? '' : 'gripperLift',
        subBuilder: $0.MotorCommand.create)
    ..aD(7, _omitFieldNames ? '' : 'ikX', fieldType: $pb.PbFieldType.OF)
    ..aD(8, _omitFieldNames ? '' : 'ikY', fieldType: $pb.PbFieldType.OF)
    ..aD(9, _omitFieldNames ? '' : 'ikZ', fieldType: $pb.PbFieldType.OF)
    ..aOB(10, _omitFieldNames ? '' : 'jab')
    ..aOM<$1.Version>(11, _omitFieldNames ? '' : 'version',
        subBuilder: $1.Version.create)
    ..aE<$3.BoolState>(12, _omitFieldNames ? '' : 'startUss',
        enumValues: $3.BoolState.values)
    ..aOM<$0.MotorCommand>(13, _omitFieldNames ? '' : 'lift',
        subBuilder: $0.MotorCommand.create)
    ..aOM<$0.MotorCommand>(14, _omitFieldNames ? '' : 'rotate',
        subBuilder: $0.MotorCommand.create)
    ..aOM<$0.MotorCommand>(15, _omitFieldNames ? '' : 'pinch',
        subBuilder: $0.MotorCommand.create)
    ..aOB(16, _omitFieldNames ? '' : 'open')
    ..aOB(17, _omitFieldNames ? '' : 'close')
    ..aOB(18, _omitFieldNames ? '' : 'spin')
    ..aI(19, _omitFieldNames ? '' : 'servoAngle')
    ..aE<$3.BoolState>(20, _omitFieldNames ? '' : 'laserState',
        enumValues: $3.BoolState.values)
    ..aOM<$0.MotorCommand>(21, _omitFieldNames ? '' : 'roll',
        subBuilder: $0.MotorCommand.create)
    ..aOM<WristCommand>(22, _omitFieldNames ? '' : 'wrist',
        subBuilder: WristCommand.create)
    ..aE<$3.BoolState>(23, _omitFieldNames ? '' : 'usingIk',
        enumValues: $3.BoolState.values)
    ..aD(24, _omitFieldNames ? '' : 'ikPitch', fieldType: $pb.PbFieldType.OF)
    ..aD(25, _omitFieldNames ? '' : 'ikYaw', fieldType: $pb.PbFieldType.OF)
    ..aOM<$2.Pose3d>(26, _omitFieldNames ? '' : 'pose',
        subBuilder: $2.Pose3d.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ArmCommand clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ArmCommand copyWith(void Function(ArmCommand) updates) =>
      super.copyWith((message) => updates(message as ArmCommand)) as ArmCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ArmCommand create() => ArmCommand._();
  @$core.override
  ArmCommand createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ArmCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ArmCommand>(create);
  static ArmCommand? _defaultInstance;

  /// General commands for arm
  @$pb.TagNumber(1)
  $core.bool get stop => $_getBF(0);
  @$pb.TagNumber(1)
  set stop($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStop() => $_has(0);
  @$pb.TagNumber(1)
  void clearStop() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get calibrate => $_getBF(1);
  @$pb.TagNumber(2)
  set calibrate($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCalibrate() => $_has(1);
  @$pb.TagNumber(2)
  void clearCalibrate() => $_clearField(2);

  /// Move individual motors
  @$pb.TagNumber(3)
  $0.MotorCommand get swivel => $_getN(2);
  @$pb.TagNumber(3)
  set swivel($0.MotorCommand value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasSwivel() => $_has(2);
  @$pb.TagNumber(3)
  void clearSwivel() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.MotorCommand ensureSwivel() => $_ensure(2);

  @$pb.TagNumber(4)
  $0.MotorCommand get shoulder => $_getN(3);
  @$pb.TagNumber(4)
  set shoulder($0.MotorCommand value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasShoulder() => $_has(3);
  @$pb.TagNumber(4)
  void clearShoulder() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.MotorCommand ensureShoulder() => $_ensure(3);

  @$pb.TagNumber(5)
  $0.MotorCommand get elbow => $_getN(4);
  @$pb.TagNumber(5)
  set elbow($0.MotorCommand value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasElbow() => $_has(4);
  @$pb.TagNumber(5)
  void clearElbow() => $_clearField(5);
  @$pb.TagNumber(5)
  $0.MotorCommand ensureElbow() => $_ensure(4);

  @$pb.TagNumber(6)
  $0.MotorCommand get gripperLift => $_getN(5);
  @$pb.TagNumber(6)
  set gripperLift($0.MotorCommand value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasGripperLift() => $_has(5);
  @$pb.TagNumber(6)
  void clearGripperLift() => $_clearField(6);
  @$pb.TagNumber(6)
  $0.MotorCommand ensureGripperLift() => $_ensure(5);

  /// Can be removed in future versions
  @$pb.TagNumber(7)
  $core.double get ikX => $_getN(6);
  @$pb.TagNumber(7)
  set ikX($core.double value) => $_setFloat(6, value);
  @$pb.TagNumber(7)
  $core.bool hasIkX() => $_has(6);
  @$pb.TagNumber(7)
  void clearIkX() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get ikY => $_getN(7);
  @$pb.TagNumber(8)
  set ikY($core.double value) => $_setFloat(7, value);
  @$pb.TagNumber(8)
  $core.bool hasIkY() => $_has(7);
  @$pb.TagNumber(8)
  void clearIkY() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.double get ikZ => $_getN(8);
  @$pb.TagNumber(9)
  set ikZ($core.double value) => $_setFloat(8, value);
  @$pb.TagNumber(9)
  $core.bool hasIkZ() => $_has(8);
  @$pb.TagNumber(9)
  void clearIkZ() => $_clearField(9);

  /// Custom actions
  @$pb.TagNumber(10)
  $core.bool get jab => $_getBF(9);
  @$pb.TagNumber(10)
  set jab($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasJab() => $_has(9);
  @$pb.TagNumber(10)
  void clearJab() => $_clearField(10);

  @$pb.TagNumber(11)
  $1.Version get version => $_getN(10);
  @$pb.TagNumber(11)
  set version($1.Version value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasVersion() => $_has(10);
  @$pb.TagNumber(11)
  void clearVersion() => $_clearField(11);
  @$pb.TagNumber(11)
  $1.Version ensureVersion() => $_ensure(10);

  /// USS commands
  @$pb.TagNumber(12)
  $3.BoolState get startUss => $_getN(11);
  @$pb.TagNumber(12)
  set startUss($3.BoolState value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasStartUss() => $_has(11);
  @$pb.TagNumber(12)
  void clearStartUss() => $_clearField(12);

  /// Move individual motors
  @$pb.TagNumber(13)
  $0.MotorCommand get lift => $_getN(12);
  @$pb.TagNumber(13)
  set lift($0.MotorCommand value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasLift() => $_has(12);
  @$pb.TagNumber(13)
  void clearLift() => $_clearField(13);
  @$pb.TagNumber(13)
  $0.MotorCommand ensureLift() => $_ensure(12);

  @$pb.TagNumber(14)
  $0.MotorCommand get rotate => $_getN(13);
  @$pb.TagNumber(14)
  set rotate($0.MotorCommand value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasRotate() => $_has(13);
  @$pb.TagNumber(14)
  void clearRotate() => $_clearField(14);
  @$pb.TagNumber(14)
  $0.MotorCommand ensureRotate() => $_ensure(13);

  @$pb.TagNumber(15)
  $0.MotorCommand get pinch => $_getN(14);
  @$pb.TagNumber(15)
  set pinch($0.MotorCommand value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasPinch() => $_has(14);
  @$pb.TagNumber(15)
  void clearPinch() => $_clearField(15);
  @$pb.TagNumber(15)
  $0.MotorCommand ensurePinch() => $_ensure(14);

  /// Custom actions
  @$pb.TagNumber(16)
  $core.bool get open => $_getBF(15);
  @$pb.TagNumber(16)
  set open($core.bool value) => $_setBool(15, value);
  @$pb.TagNumber(16)
  $core.bool hasOpen() => $_has(15);
  @$pb.TagNumber(16)
  void clearOpen() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.bool get close => $_getBF(16);
  @$pb.TagNumber(17)
  set close($core.bool value) => $_setBool(16, value);
  @$pb.TagNumber(17)
  $core.bool hasClose() => $_has(16);
  @$pb.TagNumber(17)
  void clearClose() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.bool get spin => $_getBF(17);
  @$pb.TagNumber(18)
  set spin($core.bool value) => $_setBool(17, value);
  @$pb.TagNumber(18)
  $core.bool hasSpin() => $_has(17);
  @$pb.TagNumber(18)
  void clearSpin() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.int get servoAngle => $_getIZ(18);
  @$pb.TagNumber(19)
  set servoAngle($core.int value) => $_setSignedInt32(18, value);
  @$pb.TagNumber(19)
  $core.bool hasServoAngle() => $_has(18);
  @$pb.TagNumber(19)
  void clearServoAngle() => $_clearField(19);

  @$pb.TagNumber(20)
  $3.BoolState get laserState => $_getN(19);
  @$pb.TagNumber(20)
  set laserState($3.BoolState value) => $_setField(20, value);
  @$pb.TagNumber(20)
  $core.bool hasLaserState() => $_has(19);
  @$pb.TagNumber(20)
  void clearLaserState() => $_clearField(20);

  @$pb.TagNumber(21)
  $0.MotorCommand get roll => $_getN(20);
  @$pb.TagNumber(21)
  set roll($0.MotorCommand value) => $_setField(21, value);
  @$pb.TagNumber(21)
  $core.bool hasRoll() => $_has(20);
  @$pb.TagNumber(21)
  void clearRoll() => $_clearField(21);
  @$pb.TagNumber(21)
  $0.MotorCommand ensureRoll() => $_ensure(20);

  @$pb.TagNumber(22)
  WristCommand get wrist => $_getN(21);
  @$pb.TagNumber(22)
  set wrist(WristCommand value) => $_setField(22, value);
  @$pb.TagNumber(22)
  $core.bool hasWrist() => $_has(21);
  @$pb.TagNumber(22)
  void clearWrist() => $_clearField(22);
  @$pb.TagNumber(22)
  WristCommand ensureWrist() => $_ensure(21);

  @$pb.TagNumber(23)
  $3.BoolState get usingIk => $_getN(22);
  @$pb.TagNumber(23)
  set usingIk($3.BoolState value) => $_setField(23, value);
  @$pb.TagNumber(23)
  $core.bool hasUsingIk() => $_has(22);
  @$pb.TagNumber(23)
  void clearUsingIk() => $_clearField(23);

  @$pb.TagNumber(24)
  $core.double get ikPitch => $_getN(23);
  @$pb.TagNumber(24)
  set ikPitch($core.double value) => $_setFloat(23, value);
  @$pb.TagNumber(24)
  $core.bool hasIkPitch() => $_has(23);
  @$pb.TagNumber(24)
  void clearIkPitch() => $_clearField(24);

  @$pb.TagNumber(25)
  $core.double get ikYaw => $_getN(24);
  @$pb.TagNumber(25)
  set ikYaw($core.double value) => $_setFloat(24, value);
  @$pb.TagNumber(25)
  $core.bool hasIkYaw() => $_has(24);
  @$pb.TagNumber(25)
  void clearIkYaw() => $_clearField(25);

  @$pb.TagNumber(26)
  $2.Pose3d get pose => $_getN(25);
  @$pb.TagNumber(26)
  set pose($2.Pose3d value) => $_setField(26, value);
  @$pb.TagNumber(26)
  $core.bool hasPose() => $_has(25);
  @$pb.TagNumber(26)
  void clearPose() => $_clearField(26);
  @$pb.TagNumber(26)
  $2.Pose3d ensurePose() => $_ensure(25);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
