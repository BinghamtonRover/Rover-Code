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

import 'geometry.pb.dart' as $0;
import 'motor.pb.dart' as $1;
import 'utils.pbenum.dart' as $3;
import 'version.pb.dart' as $2;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class ArmData extends $pb.GeneratedMessage {
  factory ArmData({
    $0.Coordinates? currentPosition,
    $0.Coordinates? targetPosition,
    $1.MotorData? base,
    $1.MotorData? shoulder,
    $1.MotorData? elbow,
    $2.Version? version,
    $core.double? uSSDistance,
    $1.MotorData? lift,
    $1.MotorData? rotate,
    $1.MotorData? pinch,
    $core.int? servoAngle,
    $3.BoolState? laserState,
  }) {
    final result = create();
    if (currentPosition != null) result.currentPosition = currentPosition;
    if (targetPosition != null) result.targetPosition = targetPosition;
    if (base != null) result.base = base;
    if (shoulder != null) result.shoulder = shoulder;
    if (elbow != null) result.elbow = elbow;
    if (version != null) result.version = version;
    if (uSSDistance != null) result.uSSDistance = uSSDistance;
    if (lift != null) result.lift = lift;
    if (rotate != null) result.rotate = rotate;
    if (pinch != null) result.pinch = pinch;
    if (servoAngle != null) result.servoAngle = servoAngle;
    if (laserState != null) result.laserState = laserState;
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
    ..aOM<$0.Coordinates>(1, _omitFieldNames ? '' : 'currentPosition',
        protoName: 'currentPosition', subBuilder: $0.Coordinates.create)
    ..aOM<$0.Coordinates>(2, _omitFieldNames ? '' : 'targetPosition',
        protoName: 'targetPosition', subBuilder: $0.Coordinates.create)
    ..aOM<$1.MotorData>(3, _omitFieldNames ? '' : 'base',
        subBuilder: $1.MotorData.create)
    ..aOM<$1.MotorData>(4, _omitFieldNames ? '' : 'shoulder',
        subBuilder: $1.MotorData.create)
    ..aOM<$1.MotorData>(5, _omitFieldNames ? '' : 'elbow',
        subBuilder: $1.MotorData.create)
    ..aOM<$2.Version>(6, _omitFieldNames ? '' : 'version',
        subBuilder: $2.Version.create)
    ..aD(7, _omitFieldNames ? '' : 'USSDistance',
        protoName: 'USS_distance', fieldType: $pb.PbFieldType.OF)
    ..aOM<$1.MotorData>(8, _omitFieldNames ? '' : 'lift',
        subBuilder: $1.MotorData.create)
    ..aOM<$1.MotorData>(9, _omitFieldNames ? '' : 'rotate',
        subBuilder: $1.MotorData.create)
    ..aOM<$1.MotorData>(10, _omitFieldNames ? '' : 'pinch',
        subBuilder: $1.MotorData.create)
    ..aI(11, _omitFieldNames ? '' : 'servoAngle', protoName: 'servoAngle')
    ..aE<$3.BoolState>(12, _omitFieldNames ? '' : 'laserState',
        protoName: 'laserState', enumValues: $3.BoolState.values)
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
  $0.Coordinates get currentPosition => $_getN(0);
  @$pb.TagNumber(1)
  set currentPosition($0.Coordinates value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCurrentPosition() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrentPosition() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.Coordinates ensureCurrentPosition() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.Coordinates get targetPosition => $_getN(1);
  @$pb.TagNumber(2)
  set targetPosition($0.Coordinates value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasTargetPosition() => $_has(1);
  @$pb.TagNumber(2)
  void clearTargetPosition() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.Coordinates ensureTargetPosition() => $_ensure(1);

  @$pb.TagNumber(3)
  $1.MotorData get base => $_getN(2);
  @$pb.TagNumber(3)
  set base($1.MotorData value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasBase() => $_has(2);
  @$pb.TagNumber(3)
  void clearBase() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.MotorData ensureBase() => $_ensure(2);

  @$pb.TagNumber(4)
  $1.MotorData get shoulder => $_getN(3);
  @$pb.TagNumber(4)
  set shoulder($1.MotorData value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasShoulder() => $_has(3);
  @$pb.TagNumber(4)
  void clearShoulder() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.MotorData ensureShoulder() => $_ensure(3);

  @$pb.TagNumber(5)
  $1.MotorData get elbow => $_getN(4);
  @$pb.TagNumber(5)
  set elbow($1.MotorData value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasElbow() => $_has(4);
  @$pb.TagNumber(5)
  void clearElbow() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.MotorData ensureElbow() => $_ensure(4);

  @$pb.TagNumber(6)
  $2.Version get version => $_getN(5);
  @$pb.TagNumber(6)
  set version($2.Version value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasVersion() => $_has(5);
  @$pb.TagNumber(6)
  void clearVersion() => $_clearField(6);
  @$pb.TagNumber(6)
  $2.Version ensureVersion() => $_ensure(5);

  /// USS data
  @$pb.TagNumber(7)
  $core.double get uSSDistance => $_getN(6);
  @$pb.TagNumber(7)
  set uSSDistance($core.double value) => $_setFloat(6, value);
  @$pb.TagNumber(7)
  $core.bool hasUSSDistance() => $_has(6);
  @$pb.TagNumber(7)
  void clearUSSDistance() => $_clearField(7);

  /// Gripper Commands
  @$pb.TagNumber(8)
  $1.MotorData get lift => $_getN(7);
  @$pb.TagNumber(8)
  set lift($1.MotorData value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasLift() => $_has(7);
  @$pb.TagNumber(8)
  void clearLift() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.MotorData ensureLift() => $_ensure(7);

  @$pb.TagNumber(9)
  $1.MotorData get rotate => $_getN(8);
  @$pb.TagNumber(9)
  set rotate($1.MotorData value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasRotate() => $_has(8);
  @$pb.TagNumber(9)
  void clearRotate() => $_clearField(9);
  @$pb.TagNumber(9)
  $1.MotorData ensureRotate() => $_ensure(8);

  @$pb.TagNumber(10)
  $1.MotorData get pinch => $_getN(9);
  @$pb.TagNumber(10)
  set pinch($1.MotorData value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasPinch() => $_has(9);
  @$pb.TagNumber(10)
  void clearPinch() => $_clearField(10);
  @$pb.TagNumber(10)
  $1.MotorData ensurePinch() => $_ensure(9);

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
}

class ArmCommand extends $pb.GeneratedMessage {
  factory ArmCommand({
    $core.bool? stop,
    $core.bool? calibrate,
    $1.MotorCommand? swivel,
    $1.MotorCommand? shoulder,
    $1.MotorCommand? elbow,
    $1.MotorCommand? gripperLift,
    $core.double? ikX,
    $core.double? ikY,
    $core.double? ikZ,
    $core.bool? jab,
    $2.Version? version,
    $3.BoolState? startUSS,
    $1.MotorCommand? lift,
    $1.MotorCommand? rotate,
    $1.MotorCommand? pinch,
    $core.bool? open,
    $core.bool? close,
    $core.bool? spin,
    $core.int? servoAngle,
    $3.BoolState? laserState,
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
    if (startUSS != null) result.startUSS = startUSS;
    if (lift != null) result.lift = lift;
    if (rotate != null) result.rotate = rotate;
    if (pinch != null) result.pinch = pinch;
    if (open != null) result.open = open;
    if (close != null) result.close = close;
    if (spin != null) result.spin = spin;
    if (servoAngle != null) result.servoAngle = servoAngle;
    if (laserState != null) result.laserState = laserState;
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
    ..aOM<$1.MotorCommand>(3, _omitFieldNames ? '' : 'swivel',
        subBuilder: $1.MotorCommand.create)
    ..aOM<$1.MotorCommand>(4, _omitFieldNames ? '' : 'shoulder',
        subBuilder: $1.MotorCommand.create)
    ..aOM<$1.MotorCommand>(5, _omitFieldNames ? '' : 'elbow',
        subBuilder: $1.MotorCommand.create)
    ..aOM<$1.MotorCommand>(6, _omitFieldNames ? '' : 'gripperLift',
        subBuilder: $1.MotorCommand.create)
    ..aD(7, _omitFieldNames ? '' : 'ikX', fieldType: $pb.PbFieldType.OF)
    ..aD(8, _omitFieldNames ? '' : 'ikY', fieldType: $pb.PbFieldType.OF)
    ..aD(9, _omitFieldNames ? '' : 'ikZ', fieldType: $pb.PbFieldType.OF)
    ..aOB(10, _omitFieldNames ? '' : 'jab')
    ..aOM<$2.Version>(11, _omitFieldNames ? '' : 'version',
        subBuilder: $2.Version.create)
    ..aE<$3.BoolState>(12, _omitFieldNames ? '' : 'startUSS',
        protoName: 'start_USS', enumValues: $3.BoolState.values)
    ..aOM<$1.MotorCommand>(13, _omitFieldNames ? '' : 'lift',
        subBuilder: $1.MotorCommand.create)
    ..aOM<$1.MotorCommand>(14, _omitFieldNames ? '' : 'rotate',
        subBuilder: $1.MotorCommand.create)
    ..aOM<$1.MotorCommand>(15, _omitFieldNames ? '' : 'pinch',
        subBuilder: $1.MotorCommand.create)
    ..aOB(16, _omitFieldNames ? '' : 'open')
    ..aOB(17, _omitFieldNames ? '' : 'close')
    ..aOB(18, _omitFieldNames ? '' : 'spin')
    ..aI(19, _omitFieldNames ? '' : 'servoAngle', protoName: 'servoAngle')
    ..aE<$3.BoolState>(20, _omitFieldNames ? '' : 'laserState',
        protoName: 'laserState', enumValues: $3.BoolState.values)
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
  $1.MotorCommand get swivel => $_getN(2);
  @$pb.TagNumber(3)
  set swivel($1.MotorCommand value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasSwivel() => $_has(2);
  @$pb.TagNumber(3)
  void clearSwivel() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.MotorCommand ensureSwivel() => $_ensure(2);

  @$pb.TagNumber(4)
  $1.MotorCommand get shoulder => $_getN(3);
  @$pb.TagNumber(4)
  set shoulder($1.MotorCommand value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasShoulder() => $_has(3);
  @$pb.TagNumber(4)
  void clearShoulder() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.MotorCommand ensureShoulder() => $_ensure(3);

  @$pb.TagNumber(5)
  $1.MotorCommand get elbow => $_getN(4);
  @$pb.TagNumber(5)
  set elbow($1.MotorCommand value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasElbow() => $_has(4);
  @$pb.TagNumber(5)
  void clearElbow() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.MotorCommand ensureElbow() => $_ensure(4);

  /// Needed for IK: If the wrist-lift moves, we need to re-calculate IK to keep the end-effector
  /// stationary. See /Arm/src/ik/README.md in the Arm-Firmware repository.
  @$pb.TagNumber(6)
  $1.MotorCommand get gripperLift => $_getN(5);
  @$pb.TagNumber(6)
  set gripperLift($1.MotorCommand value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasGripperLift() => $_has(5);
  @$pb.TagNumber(6)
  void clearGripperLift() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.MotorCommand ensureGripperLift() => $_ensure(5);

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
  $2.Version get version => $_getN(10);
  @$pb.TagNumber(11)
  set version($2.Version value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasVersion() => $_has(10);
  @$pb.TagNumber(11)
  void clearVersion() => $_clearField(11);
  @$pb.TagNumber(11)
  $2.Version ensureVersion() => $_ensure(10);

  /// USS commands
  @$pb.TagNumber(12)
  $3.BoolState get startUSS => $_getN(11);
  @$pb.TagNumber(12)
  set startUSS($3.BoolState value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasStartUSS() => $_has(11);
  @$pb.TagNumber(12)
  void clearStartUSS() => $_clearField(12);

  /// Move individual motors
  @$pb.TagNumber(13)
  $1.MotorCommand get lift => $_getN(12);
  @$pb.TagNumber(13)
  set lift($1.MotorCommand value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasLift() => $_has(12);
  @$pb.TagNumber(13)
  void clearLift() => $_clearField(13);
  @$pb.TagNumber(13)
  $1.MotorCommand ensureLift() => $_ensure(12);

  @$pb.TagNumber(14)
  $1.MotorCommand get rotate => $_getN(13);
  @$pb.TagNumber(14)
  set rotate($1.MotorCommand value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasRotate() => $_has(13);
  @$pb.TagNumber(14)
  void clearRotate() => $_clearField(14);
  @$pb.TagNumber(14)
  $1.MotorCommand ensureRotate() => $_ensure(13);

  @$pb.TagNumber(15)
  $1.MotorCommand get pinch => $_getN(14);
  @$pb.TagNumber(15)
  set pinch($1.MotorCommand value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasPinch() => $_has(14);
  @$pb.TagNumber(15)
  void clearPinch() => $_clearField(15);
  @$pb.TagNumber(15)
  $1.MotorCommand ensurePinch() => $_ensure(14);

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
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
