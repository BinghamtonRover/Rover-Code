//
//  Generated code. Do not modify.
//  source: arm.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'geometry.pb.dart' as $0;
import 'motor.pb.dart' as $5;
import 'utils.pbenum.dart' as $4;
import 'version.pb.dart' as $1;

class ArmData extends $pb.GeneratedMessage {
  factory ArmData() => create();
  ArmData._() : super();
  factory ArmData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ArmData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ArmData', createEmptyInstance: create)
    ..aOM<$0.Coordinates>(1, _omitFieldNames ? '' : 'currentPosition', protoName: 'currentPosition', subBuilder: $0.Coordinates.create)
    ..aOM<$0.Coordinates>(2, _omitFieldNames ? '' : 'targetPosition', protoName: 'targetPosition', subBuilder: $0.Coordinates.create)
    ..aOM<$5.MotorData>(3, _omitFieldNames ? '' : 'base', subBuilder: $5.MotorData.create)
    ..aOM<$5.MotorData>(4, _omitFieldNames ? '' : 'shoulder', subBuilder: $5.MotorData.create)
    ..aOM<$5.MotorData>(5, _omitFieldNames ? '' : 'elbow', subBuilder: $5.MotorData.create)
    ..aOM<$1.Version>(6, _omitFieldNames ? '' : 'version', subBuilder: $1.Version.create)
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
  $0.Coordinates get currentPosition => $_getN(0);
  @$pb.TagNumber(1)
  set currentPosition($0.Coordinates v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCurrentPosition() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrentPosition() => clearField(1);
  @$pb.TagNumber(1)
  $0.Coordinates ensureCurrentPosition() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.Coordinates get targetPosition => $_getN(1);
  @$pb.TagNumber(2)
  set targetPosition($0.Coordinates v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasTargetPosition() => $_has(1);
  @$pb.TagNumber(2)
  void clearTargetPosition() => clearField(2);
  @$pb.TagNumber(2)
  $0.Coordinates ensureTargetPosition() => $_ensure(1);

  @$pb.TagNumber(3)
  $5.MotorData get base => $_getN(2);
  @$pb.TagNumber(3)
  set base($5.MotorData v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasBase() => $_has(2);
  @$pb.TagNumber(3)
  void clearBase() => clearField(3);
  @$pb.TagNumber(3)
  $5.MotorData ensureBase() => $_ensure(2);

  @$pb.TagNumber(4)
  $5.MotorData get shoulder => $_getN(3);
  @$pb.TagNumber(4)
  set shoulder($5.MotorData v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasShoulder() => $_has(3);
  @$pb.TagNumber(4)
  void clearShoulder() => clearField(4);
  @$pb.TagNumber(4)
  $5.MotorData ensureShoulder() => $_ensure(3);

  @$pb.TagNumber(5)
  $5.MotorData get elbow => $_getN(4);
  @$pb.TagNumber(5)
  set elbow($5.MotorData v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasElbow() => $_has(4);
  @$pb.TagNumber(5)
  void clearElbow() => clearField(5);
  @$pb.TagNumber(5)
  $5.MotorData ensureElbow() => $_ensure(4);

  @$pb.TagNumber(6)
  $1.Version get version => $_getN(5);
  @$pb.TagNumber(6)
  set version($1.Version v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasVersion() => $_has(5);
  @$pb.TagNumber(6)
  void clearVersion() => clearField(6);
  @$pb.TagNumber(6)
  $1.Version ensureVersion() => $_ensure(5);
}

class ArmCommand extends $pb.GeneratedMessage {
  factory ArmCommand() => create();
  ArmCommand._() : super();
  factory ArmCommand.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ArmCommand.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ArmCommand', createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'stop')
    ..aOB(2, _omitFieldNames ? '' : 'calibrate')
    ..aOM<$5.MotorCommand>(3, _omitFieldNames ? '' : 'swivel', subBuilder: $5.MotorCommand.create)
    ..aOM<$5.MotorCommand>(4, _omitFieldNames ? '' : 'shoulder', subBuilder: $5.MotorCommand.create)
    ..aOM<$5.MotorCommand>(5, _omitFieldNames ? '' : 'elbow', subBuilder: $5.MotorCommand.create)
    ..aOM<$5.MotorCommand>(6, _omitFieldNames ? '' : 'gripperLift', subBuilder: $5.MotorCommand.create)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'ikX', $pb.PbFieldType.OF)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'ikY', $pb.PbFieldType.OF)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'ikZ', $pb.PbFieldType.OF)
    ..aOB(10, _omitFieldNames ? '' : 'jab')
    ..aOM<$1.Version>(11, _omitFieldNames ? '' : 'version', subBuilder: $1.Version.create)
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

  @$pb.TagNumber(3)
  $5.MotorCommand get swivel => $_getN(2);
  @$pb.TagNumber(3)
  set swivel($5.MotorCommand v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasSwivel() => $_has(2);
  @$pb.TagNumber(3)
  void clearSwivel() => clearField(3);
  @$pb.TagNumber(3)
  $5.MotorCommand ensureSwivel() => $_ensure(2);

  @$pb.TagNumber(4)
  $5.MotorCommand get shoulder => $_getN(3);
  @$pb.TagNumber(4)
  set shoulder($5.MotorCommand v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasShoulder() => $_has(3);
  @$pb.TagNumber(4)
  void clearShoulder() => clearField(4);
  @$pb.TagNumber(4)
  $5.MotorCommand ensureShoulder() => $_ensure(3);

  @$pb.TagNumber(5)
  $5.MotorCommand get elbow => $_getN(4);
  @$pb.TagNumber(5)
  set elbow($5.MotorCommand v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasElbow() => $_has(4);
  @$pb.TagNumber(5)
  void clearElbow() => clearField(5);
  @$pb.TagNumber(5)
  $5.MotorCommand ensureElbow() => $_ensure(4);

  @$pb.TagNumber(6)
  $5.MotorCommand get gripperLift => $_getN(5);
  @$pb.TagNumber(6)
  set gripperLift($5.MotorCommand v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasGripperLift() => $_has(5);
  @$pb.TagNumber(6)
  void clearGripperLift() => clearField(6);
  @$pb.TagNumber(6)
  $5.MotorCommand ensureGripperLift() => $_ensure(5);

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

  @$pb.TagNumber(10)
  $core.bool get jab => $_getBF(9);
  @$pb.TagNumber(10)
  set jab($core.bool v) { $_setBool(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasJab() => $_has(9);
  @$pb.TagNumber(10)
  void clearJab() => clearField(10);

  @$pb.TagNumber(11)
  $1.Version get version => $_getN(10);
  @$pb.TagNumber(11)
  set version($1.Version v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasVersion() => $_has(10);
  @$pb.TagNumber(11)
  void clearVersion() => clearField(11);
  @$pb.TagNumber(11)
  $1.Version ensureVersion() => $_ensure(10);
}

class GripperData extends $pb.GeneratedMessage {
  factory GripperData() => create();
  GripperData._() : super();
  factory GripperData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GripperData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GripperData', createEmptyInstance: create)
    ..aOM<$5.MotorData>(1, _omitFieldNames ? '' : 'lift', subBuilder: $5.MotorData.create)
    ..aOM<$5.MotorData>(2, _omitFieldNames ? '' : 'rotate', subBuilder: $5.MotorData.create)
    ..aOM<$5.MotorData>(3, _omitFieldNames ? '' : 'pinch', subBuilder: $5.MotorData.create)
    ..aOM<$1.Version>(4, _omitFieldNames ? '' : 'version', subBuilder: $1.Version.create)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'servoAngle', $pb.PbFieldType.O3, protoName: 'servoAngle')
    ..e<$4.BoolState>(6, _omitFieldNames ? '' : 'laserState', $pb.PbFieldType.OE, protoName: 'laserState', defaultOrMaker: $4.BoolState.BOOL_UNDEFINED, valueOf: $4.BoolState.valueOf, enumValues: $4.BoolState.values)
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
  $5.MotorData get lift => $_getN(0);
  @$pb.TagNumber(1)
  set lift($5.MotorData v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasLift() => $_has(0);
  @$pb.TagNumber(1)
  void clearLift() => clearField(1);
  @$pb.TagNumber(1)
  $5.MotorData ensureLift() => $_ensure(0);

  @$pb.TagNumber(2)
  $5.MotorData get rotate => $_getN(1);
  @$pb.TagNumber(2)
  set rotate($5.MotorData v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasRotate() => $_has(1);
  @$pb.TagNumber(2)
  void clearRotate() => clearField(2);
  @$pb.TagNumber(2)
  $5.MotorData ensureRotate() => $_ensure(1);

  @$pb.TagNumber(3)
  $5.MotorData get pinch => $_getN(2);
  @$pb.TagNumber(3)
  set pinch($5.MotorData v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasPinch() => $_has(2);
  @$pb.TagNumber(3)
  void clearPinch() => clearField(3);
  @$pb.TagNumber(3)
  $5.MotorData ensurePinch() => $_ensure(2);

  @$pb.TagNumber(4)
  $1.Version get version => $_getN(3);
  @$pb.TagNumber(4)
  set version($1.Version v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasVersion() => $_has(3);
  @$pb.TagNumber(4)
  void clearVersion() => clearField(4);
  @$pb.TagNumber(4)
  $1.Version ensureVersion() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.int get servoAngle => $_getIZ(4);
  @$pb.TagNumber(5)
  set servoAngle($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasServoAngle() => $_has(4);
  @$pb.TagNumber(5)
  void clearServoAngle() => clearField(5);

  @$pb.TagNumber(6)
  $4.BoolState get laserState => $_getN(5);
  @$pb.TagNumber(6)
  set laserState($4.BoolState v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasLaserState() => $_has(5);
  @$pb.TagNumber(6)
  void clearLaserState() => clearField(6);
}

class GripperCommand extends $pb.GeneratedMessage {
  factory GripperCommand() => create();
  GripperCommand._() : super();
  factory GripperCommand.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GripperCommand.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GripperCommand', createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'stop')
    ..aOB(2, _omitFieldNames ? '' : 'calibrate')
    ..aOM<$5.MotorCommand>(3, _omitFieldNames ? '' : 'lift', subBuilder: $5.MotorCommand.create)
    ..aOM<$5.MotorCommand>(4, _omitFieldNames ? '' : 'rotate', subBuilder: $5.MotorCommand.create)
    ..aOM<$5.MotorCommand>(5, _omitFieldNames ? '' : 'pinch', subBuilder: $5.MotorCommand.create)
    ..aOB(6, _omitFieldNames ? '' : 'open')
    ..aOB(7, _omitFieldNames ? '' : 'close')
    ..aOB(8, _omitFieldNames ? '' : 'spin')
    ..aOM<$1.Version>(9, _omitFieldNames ? '' : 'version', subBuilder: $1.Version.create)
    ..a<$core.int>(10, _omitFieldNames ? '' : 'servoAngle', $pb.PbFieldType.O3, protoName: 'servoAngle')
    ..e<$4.BoolState>(11, _omitFieldNames ? '' : 'laserState', $pb.PbFieldType.OE, protoName: 'laserState', defaultOrMaker: $4.BoolState.BOOL_UNDEFINED, valueOf: $4.BoolState.valueOf, enumValues: $4.BoolState.values)
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

  @$pb.TagNumber(3)
  $5.MotorCommand get lift => $_getN(2);
  @$pb.TagNumber(3)
  set lift($5.MotorCommand v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasLift() => $_has(2);
  @$pb.TagNumber(3)
  void clearLift() => clearField(3);
  @$pb.TagNumber(3)
  $5.MotorCommand ensureLift() => $_ensure(2);

  @$pb.TagNumber(4)
  $5.MotorCommand get rotate => $_getN(3);
  @$pb.TagNumber(4)
  set rotate($5.MotorCommand v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasRotate() => $_has(3);
  @$pb.TagNumber(4)
  void clearRotate() => clearField(4);
  @$pb.TagNumber(4)
  $5.MotorCommand ensureRotate() => $_ensure(3);

  @$pb.TagNumber(5)
  $5.MotorCommand get pinch => $_getN(4);
  @$pb.TagNumber(5)
  set pinch($5.MotorCommand v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasPinch() => $_has(4);
  @$pb.TagNumber(5)
  void clearPinch() => clearField(5);
  @$pb.TagNumber(5)
  $5.MotorCommand ensurePinch() => $_ensure(4);

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
  $1.Version get version => $_getN(8);
  @$pb.TagNumber(9)
  set version($1.Version v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasVersion() => $_has(8);
  @$pb.TagNumber(9)
  void clearVersion() => clearField(9);
  @$pb.TagNumber(9)
  $1.Version ensureVersion() => $_ensure(8);

  @$pb.TagNumber(10)
  $core.int get servoAngle => $_getIZ(9);
  @$pb.TagNumber(10)
  set servoAngle($core.int v) { $_setSignedInt32(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasServoAngle() => $_has(9);
  @$pb.TagNumber(10)
  void clearServoAngle() => clearField(10);

  @$pb.TagNumber(11)
  $4.BoolState get laserState => $_getN(10);
  @$pb.TagNumber(11)
  set laserState($4.BoolState v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasLaserState() => $_has(10);
  @$pb.TagNumber(11)
  void clearLaserState() => clearField(11);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
