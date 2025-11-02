// This is a generated file - do not edit.
//
// Generated from arm.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

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
  }) {
    final result = create();
    if (currentPosition != null) result.currentPosition = currentPosition;
    if (targetPosition != null) result.targetPosition = targetPosition;
    if (base != null) result.base = base;
    if (shoulder != null) result.shoulder = shoulder;
    if (elbow != null) result.elbow = elbow;
    if (version != null) result.version = version;
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
  static $pb.PbList<ArmData> createRepeated() => $pb.PbList<ArmData>();
  @$core.pragma('dart2js:noInline')
  static ArmData getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ArmData>(create);
  static ArmData? _defaultInstance;

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
  static $pb.PbList<ArmCommand> createRepeated() => $pb.PbList<ArmCommand>();
  @$core.pragma('dart2js:noInline')
  static ArmCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ArmCommand>(create);
  static ArmCommand? _defaultInstance;

  /// General commands
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
}

class GripperData extends $pb.GeneratedMessage {
  factory GripperData({
    $1.MotorData? lift,
    $1.MotorData? rotate,
    $1.MotorData? pinch,
    $2.Version? version,
    $core.int? servoAngle,
    $3.BoolState? laserState,
  }) {
    final result = create();
    if (lift != null) result.lift = lift;
    if (rotate != null) result.rotate = rotate;
    if (pinch != null) result.pinch = pinch;
    if (version != null) result.version = version;
    if (servoAngle != null) result.servoAngle = servoAngle;
    if (laserState != null) result.laserState = laserState;
    return result;
  }

  GripperData._();

  factory GripperData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GripperData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GripperData',
      createEmptyInstance: create)
    ..aOM<$1.MotorData>(1, _omitFieldNames ? '' : 'lift',
        subBuilder: $1.MotorData.create)
    ..aOM<$1.MotorData>(2, _omitFieldNames ? '' : 'rotate',
        subBuilder: $1.MotorData.create)
    ..aOM<$1.MotorData>(3, _omitFieldNames ? '' : 'pinch',
        subBuilder: $1.MotorData.create)
    ..aOM<$2.Version>(4, _omitFieldNames ? '' : 'version',
        subBuilder: $2.Version.create)
    ..aI(5, _omitFieldNames ? '' : 'servoAngle', protoName: 'servoAngle')
    ..aE<$3.BoolState>(6, _omitFieldNames ? '' : 'laserState',
        protoName: 'laserState', enumValues: $3.BoolState.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GripperData clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GripperData copyWith(void Function(GripperData) updates) =>
      super.copyWith((message) => updates(message as GripperData))
          as GripperData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GripperData create() => GripperData._();
  @$core.override
  GripperData createEmptyInstance() => create();
  static $pb.PbList<GripperData> createRepeated() => $pb.PbList<GripperData>();
  @$core.pragma('dart2js:noInline')
  static GripperData getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GripperData>(create);
  static GripperData? _defaultInstance;

  @$pb.TagNumber(1)
  $1.MotorData get lift => $_getN(0);
  @$pb.TagNumber(1)
  set lift($1.MotorData value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasLift() => $_has(0);
  @$pb.TagNumber(1)
  void clearLift() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.MotorData ensureLift() => $_ensure(0);

  @$pb.TagNumber(2)
  $1.MotorData get rotate => $_getN(1);
  @$pb.TagNumber(2)
  set rotate($1.MotorData value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasRotate() => $_has(1);
  @$pb.TagNumber(2)
  void clearRotate() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.MotorData ensureRotate() => $_ensure(1);

  @$pb.TagNumber(3)
  $1.MotorData get pinch => $_getN(2);
  @$pb.TagNumber(3)
  set pinch($1.MotorData value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasPinch() => $_has(2);
  @$pb.TagNumber(3)
  void clearPinch() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.MotorData ensurePinch() => $_ensure(2);

  @$pb.TagNumber(4)
  $2.Version get version => $_getN(3);
  @$pb.TagNumber(4)
  set version($2.Version value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasVersion() => $_has(3);
  @$pb.TagNumber(4)
  void clearVersion() => $_clearField(4);
  @$pb.TagNumber(4)
  $2.Version ensureVersion() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.int get servoAngle => $_getIZ(4);
  @$pb.TagNumber(5)
  set servoAngle($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasServoAngle() => $_has(4);
  @$pb.TagNumber(5)
  void clearServoAngle() => $_clearField(5);

  @$pb.TagNumber(6)
  $3.BoolState get laserState => $_getN(5);
  @$pb.TagNumber(6)
  set laserState($3.BoolState value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasLaserState() => $_has(5);
  @$pb.TagNumber(6)
  void clearLaserState() => $_clearField(6);
}

class GripperCommand extends $pb.GeneratedMessage {
  factory GripperCommand({
    $core.bool? stop,
    $core.bool? calibrate,
    $1.MotorCommand? lift,
    $1.MotorCommand? rotate,
    $1.MotorCommand? pinch,
    $core.bool? open,
    $core.bool? close,
    $core.bool? spin,
    $2.Version? version,
    $core.int? servoAngle,
    $3.BoolState? laserState,
  }) {
    final result = create();
    if (stop != null) result.stop = stop;
    if (calibrate != null) result.calibrate = calibrate;
    if (lift != null) result.lift = lift;
    if (rotate != null) result.rotate = rotate;
    if (pinch != null) result.pinch = pinch;
    if (open != null) result.open = open;
    if (close != null) result.close = close;
    if (spin != null) result.spin = spin;
    if (version != null) result.version = version;
    if (servoAngle != null) result.servoAngle = servoAngle;
    if (laserState != null) result.laserState = laserState;
    return result;
  }

  GripperCommand._();

  factory GripperCommand.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GripperCommand.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GripperCommand',
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'stop')
    ..aOB(2, _omitFieldNames ? '' : 'calibrate')
    ..aOM<$1.MotorCommand>(3, _omitFieldNames ? '' : 'lift',
        subBuilder: $1.MotorCommand.create)
    ..aOM<$1.MotorCommand>(4, _omitFieldNames ? '' : 'rotate',
        subBuilder: $1.MotorCommand.create)
    ..aOM<$1.MotorCommand>(5, _omitFieldNames ? '' : 'pinch',
        subBuilder: $1.MotorCommand.create)
    ..aOB(6, _omitFieldNames ? '' : 'open')
    ..aOB(7, _omitFieldNames ? '' : 'close')
    ..aOB(8, _omitFieldNames ? '' : 'spin')
    ..aOM<$2.Version>(9, _omitFieldNames ? '' : 'version',
        subBuilder: $2.Version.create)
    ..aI(10, _omitFieldNames ? '' : 'servoAngle', protoName: 'servoAngle')
    ..aE<$3.BoolState>(11, _omitFieldNames ? '' : 'laserState',
        protoName: 'laserState', enumValues: $3.BoolState.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GripperCommand clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GripperCommand copyWith(void Function(GripperCommand) updates) =>
      super.copyWith((message) => updates(message as GripperCommand))
          as GripperCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GripperCommand create() => GripperCommand._();
  @$core.override
  GripperCommand createEmptyInstance() => create();
  static $pb.PbList<GripperCommand> createRepeated() =>
      $pb.PbList<GripperCommand>();
  @$core.pragma('dart2js:noInline')
  static GripperCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GripperCommand>(create);
  static GripperCommand? _defaultInstance;

  /// General commands
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
  $1.MotorCommand get lift => $_getN(2);
  @$pb.TagNumber(3)
  set lift($1.MotorCommand value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasLift() => $_has(2);
  @$pb.TagNumber(3)
  void clearLift() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.MotorCommand ensureLift() => $_ensure(2);

  @$pb.TagNumber(4)
  $1.MotorCommand get rotate => $_getN(3);
  @$pb.TagNumber(4)
  set rotate($1.MotorCommand value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasRotate() => $_has(3);
  @$pb.TagNumber(4)
  void clearRotate() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.MotorCommand ensureRotate() => $_ensure(3);

  @$pb.TagNumber(5)
  $1.MotorCommand get pinch => $_getN(4);
  @$pb.TagNumber(5)
  set pinch($1.MotorCommand value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasPinch() => $_has(4);
  @$pb.TagNumber(5)
  void clearPinch() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.MotorCommand ensurePinch() => $_ensure(4);

  /// Custom actions
  @$pb.TagNumber(6)
  $core.bool get open => $_getBF(5);
  @$pb.TagNumber(6)
  set open($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasOpen() => $_has(5);
  @$pb.TagNumber(6)
  void clearOpen() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get close => $_getBF(6);
  @$pb.TagNumber(7)
  set close($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasClose() => $_has(6);
  @$pb.TagNumber(7)
  void clearClose() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.bool get spin => $_getBF(7);
  @$pb.TagNumber(8)
  set spin($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasSpin() => $_has(7);
  @$pb.TagNumber(8)
  void clearSpin() => $_clearField(8);

  @$pb.TagNumber(9)
  $2.Version get version => $_getN(8);
  @$pb.TagNumber(9)
  set version($2.Version value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasVersion() => $_has(8);
  @$pb.TagNumber(9)
  void clearVersion() => $_clearField(9);
  @$pb.TagNumber(9)
  $2.Version ensureVersion() => $_ensure(8);

  @$pb.TagNumber(10)
  $core.int get servoAngle => $_getIZ(9);
  @$pb.TagNumber(10)
  set servoAngle($core.int value) => $_setSignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasServoAngle() => $_has(9);
  @$pb.TagNumber(10)
  void clearServoAngle() => $_clearField(10);

  @$pb.TagNumber(11)
  $3.BoolState get laserState => $_getN(10);
  @$pb.TagNumber(11)
  set laserState($3.BoolState value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasLaserState() => $_has(10);
  @$pb.TagNumber(11)
  void clearLaserState() => $_clearField(11);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
