//
//  Generated code. Do not modify.
//  source: arm.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'geometry.pb.dart' as $1;
import 'motor.pb.dart' as $2;
import 'utils.pbenum.dart' as $0;
import 'version.pb.dart' as $3;

class ArmData extends $pb.GeneratedMessage {
  factory ArmData({
    $1.Coordinates? currentPosition,
    $1.Coordinates? targetPosition,
    $2.MotorData? base,
    $2.MotorData? shoulder,
    $2.MotorData? elbow,
    $3.Version? version,
  }) {
    final $result = create();
    if (currentPosition != null) {
      $result.currentPosition = currentPosition;
    }
    if (targetPosition != null) {
      $result.targetPosition = targetPosition;
    }
    if (base != null) {
      $result.base = base;
    }
    if (shoulder != null) {
      $result.shoulder = shoulder;
    }
    if (elbow != null) {
      $result.elbow = elbow;
    }
    if (version != null) {
      $result.version = version;
    }
    return $result;
  }
  ArmData._() : super();
  factory ArmData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ArmData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ArmData', createEmptyInstance: create)
    ..aOM<$1.Coordinates>(1, _omitFieldNames ? '' : 'currentPosition', protoName: 'currentPosition', subBuilder: $1.Coordinates.create)
    ..aOM<$1.Coordinates>(2, _omitFieldNames ? '' : 'targetPosition', protoName: 'targetPosition', subBuilder: $1.Coordinates.create)
    ..aOM<$2.MotorData>(3, _omitFieldNames ? '' : 'base', subBuilder: $2.MotorData.create)
    ..aOM<$2.MotorData>(4, _omitFieldNames ? '' : 'shoulder', subBuilder: $2.MotorData.create)
    ..aOM<$2.MotorData>(5, _omitFieldNames ? '' : 'elbow', subBuilder: $2.MotorData.create)
    ..aOM<$3.Version>(6, _omitFieldNames ? '' : 'version', subBuilder: $3.Version.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ArmData clone() => ArmData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ArmData copyWith(void Function(ArmData) updates) => super.copyWith((message) => updates(message as ArmData)) as ArmData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ArmData create() => ArmData._();
  ArmData createEmptyInstance() => create();
  static $pb.PbList<ArmData> createRepeated() => $pb.PbList<ArmData>();
  @$core.pragma('dart2js:noInline')
  static ArmData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ArmData>(create);
  static ArmData? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Coordinates get currentPosition => $_getN(0);
  @$pb.TagNumber(1)
  set currentPosition($1.Coordinates v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCurrentPosition() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrentPosition() => clearField(1);
  @$pb.TagNumber(1)
  $1.Coordinates ensureCurrentPosition() => $_ensure(0);

  @$pb.TagNumber(2)
  $1.Coordinates get targetPosition => $_getN(1);
  @$pb.TagNumber(2)
  set targetPosition($1.Coordinates v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasTargetPosition() => $_has(1);
  @$pb.TagNumber(2)
  void clearTargetPosition() => clearField(2);
  @$pb.TagNumber(2)
  $1.Coordinates ensureTargetPosition() => $_ensure(1);

  @$pb.TagNumber(3)
  $2.MotorData get base => $_getN(2);
  @$pb.TagNumber(3)
  set base($2.MotorData v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasBase() => $_has(2);
  @$pb.TagNumber(3)
  void clearBase() => clearField(3);
  @$pb.TagNumber(3)
  $2.MotorData ensureBase() => $_ensure(2);

  @$pb.TagNumber(4)
  $2.MotorData get shoulder => $_getN(3);
  @$pb.TagNumber(4)
  set shoulder($2.MotorData v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasShoulder() => $_has(3);
  @$pb.TagNumber(4)
  void clearShoulder() => clearField(4);
  @$pb.TagNumber(4)
  $2.MotorData ensureShoulder() => $_ensure(3);

  @$pb.TagNumber(5)
  $2.MotorData get elbow => $_getN(4);
  @$pb.TagNumber(5)
  set elbow($2.MotorData v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasElbow() => $_has(4);
  @$pb.TagNumber(5)
  void clearElbow() => clearField(5);
  @$pb.TagNumber(5)
  $2.MotorData ensureElbow() => $_ensure(4);

  @$pb.TagNumber(6)
  $3.Version get version => $_getN(5);
  @$pb.TagNumber(6)
  set version($3.Version v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasVersion() => $_has(5);
  @$pb.TagNumber(6)
  void clearVersion() => clearField(6);
  @$pb.TagNumber(6)
  $3.Version ensureVersion() => $_ensure(5);
}

class ArmCommand extends $pb.GeneratedMessage {
  factory ArmCommand({
    $core.bool? stop,
    $core.bool? calibrate,
    $2.MotorCommand? swivel,
    $2.MotorCommand? shoulder,
    $2.MotorCommand? elbow,
    $2.MotorCommand? gripperLift,
    $core.double? ikX,
    $core.double? ikY,
    $core.double? ikZ,
    $core.bool? jab,
    $3.Version? version,
  }) {
    final $result = create();
    if (stop != null) {
      $result.stop = stop;
    }
    if (calibrate != null) {
      $result.calibrate = calibrate;
    }
    if (swivel != null) {
      $result.swivel = swivel;
    }
    if (shoulder != null) {
      $result.shoulder = shoulder;
    }
    if (elbow != null) {
      $result.elbow = elbow;
    }
    if (gripperLift != null) {
      $result.gripperLift = gripperLift;
    }
    if (ikX != null) {
      $result.ikX = ikX;
    }
    if (ikY != null) {
      $result.ikY = ikY;
    }
    if (ikZ != null) {
      $result.ikZ = ikZ;
    }
    if (jab != null) {
      $result.jab = jab;
    }
    if (version != null) {
      $result.version = version;
    }
    return $result;
  }
  ArmCommand._() : super();
  factory ArmCommand.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ArmCommand.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ArmCommand', createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'stop')
    ..aOB(2, _omitFieldNames ? '' : 'calibrate')
    ..aOM<$2.MotorCommand>(3, _omitFieldNames ? '' : 'swivel', subBuilder: $2.MotorCommand.create)
    ..aOM<$2.MotorCommand>(4, _omitFieldNames ? '' : 'shoulder', subBuilder: $2.MotorCommand.create)
    ..aOM<$2.MotorCommand>(5, _omitFieldNames ? '' : 'elbow', subBuilder: $2.MotorCommand.create)
    ..aOM<$2.MotorCommand>(6, _omitFieldNames ? '' : 'gripperLift', subBuilder: $2.MotorCommand.create)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'ikX', $pb.PbFieldType.OF)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'ikY', $pb.PbFieldType.OF)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'ikZ', $pb.PbFieldType.OF)
    ..aOB(10, _omitFieldNames ? '' : 'jab')
    ..aOM<$3.Version>(11, _omitFieldNames ? '' : 'version', subBuilder: $3.Version.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ArmCommand clone() => ArmCommand()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ArmCommand copyWith(void Function(ArmCommand) updates) => super.copyWith((message) => updates(message as ArmCommand)) as ArmCommand;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ArmCommand create() => ArmCommand._();
  ArmCommand createEmptyInstance() => create();
  static $pb.PbList<ArmCommand> createRepeated() => $pb.PbList<ArmCommand>();
  @$core.pragma('dart2js:noInline')
  static ArmCommand getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ArmCommand>(create);
  static ArmCommand? _defaultInstance;

  /// General commands
  @$pb.TagNumber(1)
  $core.bool get stop => $_getBF(0);
  @$pb.TagNumber(1)
  set stop($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStop() => $_has(0);
  @$pb.TagNumber(1)
  void clearStop() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get calibrate => $_getBF(1);
  @$pb.TagNumber(2)
  set calibrate($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCalibrate() => $_has(1);
  @$pb.TagNumber(2)
  void clearCalibrate() => clearField(2);

  /// Move individual motors
  @$pb.TagNumber(3)
  $2.MotorCommand get swivel => $_getN(2);
  @$pb.TagNumber(3)
  set swivel($2.MotorCommand v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasSwivel() => $_has(2);
  @$pb.TagNumber(3)
  void clearSwivel() => clearField(3);
  @$pb.TagNumber(3)
  $2.MotorCommand ensureSwivel() => $_ensure(2);

  @$pb.TagNumber(4)
  $2.MotorCommand get shoulder => $_getN(3);
  @$pb.TagNumber(4)
  set shoulder($2.MotorCommand v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasShoulder() => $_has(3);
  @$pb.TagNumber(4)
  void clearShoulder() => clearField(4);
  @$pb.TagNumber(4)
  $2.MotorCommand ensureShoulder() => $_ensure(3);

  @$pb.TagNumber(5)
  $2.MotorCommand get elbow => $_getN(4);
  @$pb.TagNumber(5)
  set elbow($2.MotorCommand v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasElbow() => $_has(4);
  @$pb.TagNumber(5)
  void clearElbow() => clearField(5);
  @$pb.TagNumber(5)
  $2.MotorCommand ensureElbow() => $_ensure(4);

  /// Needed for IK: If the wrist-lift moves, we need to re-calculate IK to keep the end-effector
  /// stationary. See /Arm/src/ik/README.md in the Arm-Firmware repository.
  @$pb.TagNumber(6)
  $2.MotorCommand get gripperLift => $_getN(5);
  @$pb.TagNumber(6)
  set gripperLift($2.MotorCommand v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasGripperLift() => $_has(5);
  @$pb.TagNumber(6)
  void clearGripperLift() => clearField(6);
  @$pb.TagNumber(6)
  $2.MotorCommand ensureGripperLift() => $_ensure(5);

  /// Can be removed in future versions
  @$pb.TagNumber(7)
  $core.double get ikX => $_getN(6);
  @$pb.TagNumber(7)
  set ikX($core.double v) { $_setFloat(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasIkX() => $_has(6);
  @$pb.TagNumber(7)
  void clearIkX() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get ikY => $_getN(7);
  @$pb.TagNumber(8)
  set ikY($core.double v) { $_setFloat(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasIkY() => $_has(7);
  @$pb.TagNumber(8)
  void clearIkY() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get ikZ => $_getN(8);
  @$pb.TagNumber(9)
  set ikZ($core.double v) { $_setFloat(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasIkZ() => $_has(8);
  @$pb.TagNumber(9)
  void clearIkZ() => clearField(9);

  /// Custom actions
  @$pb.TagNumber(10)
  $core.bool get jab => $_getBF(9);
  @$pb.TagNumber(10)
  set jab($core.bool v) { $_setBool(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasJab() => $_has(9);
  @$pb.TagNumber(10)
  void clearJab() => clearField(10);

  @$pb.TagNumber(11)
  $3.Version get version => $_getN(10);
  @$pb.TagNumber(11)
  set version($3.Version v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasVersion() => $_has(10);
  @$pb.TagNumber(11)
  void clearVersion() => clearField(11);
  @$pb.TagNumber(11)
  $3.Version ensureVersion() => $_ensure(10);
}

class GripperData extends $pb.GeneratedMessage {
  factory GripperData({
    $2.MotorData? lift,
    $2.MotorData? rotate,
    $2.MotorData? pinch,
    $3.Version? version,
    $core.int? servoAngle,
    $0.BoolState? laserState,
  }) {
    final $result = create();
    if (lift != null) {
      $result.lift = lift;
    }
    if (rotate != null) {
      $result.rotate = rotate;
    }
    if (pinch != null) {
      $result.pinch = pinch;
    }
    if (version != null) {
      $result.version = version;
    }
    if (servoAngle != null) {
      $result.servoAngle = servoAngle;
    }
    if (laserState != null) {
      $result.laserState = laserState;
    }
    return $result;
  }
  GripperData._() : super();
  factory GripperData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GripperData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GripperData', createEmptyInstance: create)
    ..aOM<$2.MotorData>(1, _omitFieldNames ? '' : 'lift', subBuilder: $2.MotorData.create)
    ..aOM<$2.MotorData>(2, _omitFieldNames ? '' : 'rotate', subBuilder: $2.MotorData.create)
    ..aOM<$2.MotorData>(3, _omitFieldNames ? '' : 'pinch', subBuilder: $2.MotorData.create)
    ..aOM<$3.Version>(4, _omitFieldNames ? '' : 'version', subBuilder: $3.Version.create)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'servoAngle', $pb.PbFieldType.O3, protoName: 'servoAngle')
    ..e<$0.BoolState>(6, _omitFieldNames ? '' : 'laserState', $pb.PbFieldType.OE, protoName: 'laserState', defaultOrMaker: $0.BoolState.BOOL_UNDEFINED, valueOf: $0.BoolState.valueOf, enumValues: $0.BoolState.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GripperData clone() => GripperData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GripperData copyWith(void Function(GripperData) updates) => super.copyWith((message) => updates(message as GripperData)) as GripperData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GripperData create() => GripperData._();
  GripperData createEmptyInstance() => create();
  static $pb.PbList<GripperData> createRepeated() => $pb.PbList<GripperData>();
  @$core.pragma('dart2js:noInline')
  static GripperData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GripperData>(create);
  static GripperData? _defaultInstance;

  @$pb.TagNumber(1)
  $2.MotorData get lift => $_getN(0);
  @$pb.TagNumber(1)
  set lift($2.MotorData v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasLift() => $_has(0);
  @$pb.TagNumber(1)
  void clearLift() => clearField(1);
  @$pb.TagNumber(1)
  $2.MotorData ensureLift() => $_ensure(0);

  @$pb.TagNumber(2)
  $2.MotorData get rotate => $_getN(1);
  @$pb.TagNumber(2)
  set rotate($2.MotorData v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasRotate() => $_has(1);
  @$pb.TagNumber(2)
  void clearRotate() => clearField(2);
  @$pb.TagNumber(2)
  $2.MotorData ensureRotate() => $_ensure(1);

  @$pb.TagNumber(3)
  $2.MotorData get pinch => $_getN(2);
  @$pb.TagNumber(3)
  set pinch($2.MotorData v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasPinch() => $_has(2);
  @$pb.TagNumber(3)
  void clearPinch() => clearField(3);
  @$pb.TagNumber(3)
  $2.MotorData ensurePinch() => $_ensure(2);

  @$pb.TagNumber(4)
  $3.Version get version => $_getN(3);
  @$pb.TagNumber(4)
  set version($3.Version v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasVersion() => $_has(3);
  @$pb.TagNumber(4)
  void clearVersion() => clearField(4);
  @$pb.TagNumber(4)
  $3.Version ensureVersion() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.int get servoAngle => $_getIZ(4);
  @$pb.TagNumber(5)
  set servoAngle($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasServoAngle() => $_has(4);
  @$pb.TagNumber(5)
  void clearServoAngle() => clearField(5);

  @$pb.TagNumber(6)
  $0.BoolState get laserState => $_getN(5);
  @$pb.TagNumber(6)
  set laserState($0.BoolState v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasLaserState() => $_has(5);
  @$pb.TagNumber(6)
  void clearLaserState() => clearField(6);
}

class GripperCommand extends $pb.GeneratedMessage {
  factory GripperCommand({
    $core.bool? stop,
    $core.bool? calibrate,
    $2.MotorCommand? lift,
    $2.MotorCommand? rotate,
    $2.MotorCommand? pinch,
    $core.bool? open,
    $core.bool? close,
    $core.bool? spin,
    $3.Version? version,
    $core.int? servoAngle,
    $0.BoolState? laserState,
  }) {
    final $result = create();
    if (stop != null) {
      $result.stop = stop;
    }
    if (calibrate != null) {
      $result.calibrate = calibrate;
    }
    if (lift != null) {
      $result.lift = lift;
    }
    if (rotate != null) {
      $result.rotate = rotate;
    }
    if (pinch != null) {
      $result.pinch = pinch;
    }
    if (open != null) {
      $result.open = open;
    }
    if (close != null) {
      $result.close = close;
    }
    if (spin != null) {
      $result.spin = spin;
    }
    if (version != null) {
      $result.version = version;
    }
    if (servoAngle != null) {
      $result.servoAngle = servoAngle;
    }
    if (laserState != null) {
      $result.laserState = laserState;
    }
    return $result;
  }
  GripperCommand._() : super();
  factory GripperCommand.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GripperCommand.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GripperCommand', createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'stop')
    ..aOB(2, _omitFieldNames ? '' : 'calibrate')
    ..aOM<$2.MotorCommand>(3, _omitFieldNames ? '' : 'lift', subBuilder: $2.MotorCommand.create)
    ..aOM<$2.MotorCommand>(4, _omitFieldNames ? '' : 'rotate', subBuilder: $2.MotorCommand.create)
    ..aOM<$2.MotorCommand>(5, _omitFieldNames ? '' : 'pinch', subBuilder: $2.MotorCommand.create)
    ..aOB(6, _omitFieldNames ? '' : 'open')
    ..aOB(7, _omitFieldNames ? '' : 'close')
    ..aOB(8, _omitFieldNames ? '' : 'spin')
    ..aOM<$3.Version>(9, _omitFieldNames ? '' : 'version', subBuilder: $3.Version.create)
    ..a<$core.int>(10, _omitFieldNames ? '' : 'servoAngle', $pb.PbFieldType.O3, protoName: 'servoAngle')
    ..e<$0.BoolState>(11, _omitFieldNames ? '' : 'laserState', $pb.PbFieldType.OE, protoName: 'laserState', defaultOrMaker: $0.BoolState.BOOL_UNDEFINED, valueOf: $0.BoolState.valueOf, enumValues: $0.BoolState.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GripperCommand clone() => GripperCommand()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GripperCommand copyWith(void Function(GripperCommand) updates) => super.copyWith((message) => updates(message as GripperCommand)) as GripperCommand;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GripperCommand create() => GripperCommand._();
  GripperCommand createEmptyInstance() => create();
  static $pb.PbList<GripperCommand> createRepeated() => $pb.PbList<GripperCommand>();
  @$core.pragma('dart2js:noInline')
  static GripperCommand getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GripperCommand>(create);
  static GripperCommand? _defaultInstance;

  /// General commands
  @$pb.TagNumber(1)
  $core.bool get stop => $_getBF(0);
  @$pb.TagNumber(1)
  set stop($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStop() => $_has(0);
  @$pb.TagNumber(1)
  void clearStop() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get calibrate => $_getBF(1);
  @$pb.TagNumber(2)
  set calibrate($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCalibrate() => $_has(1);
  @$pb.TagNumber(2)
  void clearCalibrate() => clearField(2);

  /// Move individual motors
  @$pb.TagNumber(3)
  $2.MotorCommand get lift => $_getN(2);
  @$pb.TagNumber(3)
  set lift($2.MotorCommand v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasLift() => $_has(2);
  @$pb.TagNumber(3)
  void clearLift() => clearField(3);
  @$pb.TagNumber(3)
  $2.MotorCommand ensureLift() => $_ensure(2);

  @$pb.TagNumber(4)
  $2.MotorCommand get rotate => $_getN(3);
  @$pb.TagNumber(4)
  set rotate($2.MotorCommand v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasRotate() => $_has(3);
  @$pb.TagNumber(4)
  void clearRotate() => clearField(4);
  @$pb.TagNumber(4)
  $2.MotorCommand ensureRotate() => $_ensure(3);

  @$pb.TagNumber(5)
  $2.MotorCommand get pinch => $_getN(4);
  @$pb.TagNumber(5)
  set pinch($2.MotorCommand v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasPinch() => $_has(4);
  @$pb.TagNumber(5)
  void clearPinch() => clearField(5);
  @$pb.TagNumber(5)
  $2.MotorCommand ensurePinch() => $_ensure(4);

  /// Custom actions
  @$pb.TagNumber(6)
  $core.bool get open => $_getBF(5);
  @$pb.TagNumber(6)
  set open($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasOpen() => $_has(5);
  @$pb.TagNumber(6)
  void clearOpen() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get close => $_getBF(6);
  @$pb.TagNumber(7)
  set close($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasClose() => $_has(6);
  @$pb.TagNumber(7)
  void clearClose() => clearField(7);

  @$pb.TagNumber(8)
  $core.bool get spin => $_getBF(7);
  @$pb.TagNumber(8)
  set spin($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasSpin() => $_has(7);
  @$pb.TagNumber(8)
  void clearSpin() => clearField(8);

  @$pb.TagNumber(9)
  $3.Version get version => $_getN(8);
  @$pb.TagNumber(9)
  set version($3.Version v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasVersion() => $_has(8);
  @$pb.TagNumber(9)
  void clearVersion() => clearField(9);
  @$pb.TagNumber(9)
  $3.Version ensureVersion() => $_ensure(8);

  @$pb.TagNumber(10)
  $core.int get servoAngle => $_getIZ(9);
  @$pb.TagNumber(10)
  set servoAngle($core.int v) { $_setSignedInt32(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasServoAngle() => $_has(9);
  @$pb.TagNumber(10)
  void clearServoAngle() => clearField(10);

  @$pb.TagNumber(11)
  $0.BoolState get laserState => $_getN(10);
  @$pb.TagNumber(11)
  set laserState($0.BoolState v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasLaserState() => $_has(10);
  @$pb.TagNumber(11)
  void clearLaserState() => clearField(11);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
