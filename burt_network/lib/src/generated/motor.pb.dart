//
//  Generated code. Do not modify.
//  source: motor.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'motor.pbenum.dart';
import 'utils.pbenum.dart' as $0;

export 'motor.pbenum.dart';

class MotorData extends $pb.GeneratedMessage {
  factory MotorData({
    $0.BoolState? isMoving,
    $0.BoolState? isLimitSwitchPressed,
    MotorDirection? direction,
    $core.int? currentStep,
    $core.int? targetStep,
    $core.double? currentAngle,
    $core.double? targetAngle,
  }) {
    final $result = create();
    if (isMoving != null) {
      $result.isMoving = isMoving;
    }
    if (isLimitSwitchPressed != null) {
      $result.isLimitSwitchPressed = isLimitSwitchPressed;
    }
    if (direction != null) {
      $result.direction = direction;
    }
    if (currentStep != null) {
      $result.currentStep = currentStep;
    }
    if (targetStep != null) {
      $result.targetStep = targetStep;
    }
    if (currentAngle != null) {
      $result.currentAngle = currentAngle;
    }
    if (targetAngle != null) {
      $result.targetAngle = targetAngle;
    }
    return $result;
  }
  MotorData._() : super();
  factory MotorData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MotorData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MotorData', createEmptyInstance: create)
    ..e<$0.BoolState>(1, _omitFieldNames ? '' : 'isMoving', $pb.PbFieldType.OE, defaultOrMaker: $0.BoolState.BOOL_UNDEFINED, valueOf: $0.BoolState.valueOf, enumValues: $0.BoolState.values)
    ..e<$0.BoolState>(2, _omitFieldNames ? '' : 'isLimitSwitchPressed', $pb.PbFieldType.OE, defaultOrMaker: $0.BoolState.BOOL_UNDEFINED, valueOf: $0.BoolState.valueOf, enumValues: $0.BoolState.values)
    ..e<MotorDirection>(3, _omitFieldNames ? '' : 'direction', $pb.PbFieldType.OE, defaultOrMaker: MotorDirection.MOTOR_DIRECTION_UNDEFINED, valueOf: MotorDirection.valueOf, enumValues: MotorDirection.values)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'currentStep', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'targetStep', $pb.PbFieldType.O3)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'currentAngle', $pb.PbFieldType.OF)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'targetAngle', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MotorData clone() => MotorData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MotorData copyWith(void Function(MotorData) updates) => super.copyWith((message) => updates(message as MotorData)) as MotorData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MotorData create() => MotorData._();
  MotorData createEmptyInstance() => create();
  static $pb.PbList<MotorData> createRepeated() => $pb.PbList<MotorData>();
  @$core.pragma('dart2js:noInline')
  static MotorData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MotorData>(create);
  static MotorData? _defaultInstance;

  @$pb.TagNumber(1)
  $0.BoolState get isMoving => $_getN(0);
  @$pb.TagNumber(1)
  set isMoving($0.BoolState v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasIsMoving() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsMoving() => clearField(1);

  @$pb.TagNumber(2)
  $0.BoolState get isLimitSwitchPressed => $_getN(1);
  @$pb.TagNumber(2)
  set isLimitSwitchPressed($0.BoolState v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasIsLimitSwitchPressed() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsLimitSwitchPressed() => clearField(2);

  @$pb.TagNumber(3)
  MotorDirection get direction => $_getN(2);
  @$pb.TagNumber(3)
  set direction(MotorDirection v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasDirection() => $_has(2);
  @$pb.TagNumber(3)
  void clearDirection() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get currentStep => $_getIZ(3);
  @$pb.TagNumber(4)
  set currentStep($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCurrentStep() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrentStep() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get targetStep => $_getIZ(4);
  @$pb.TagNumber(5)
  set targetStep($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTargetStep() => $_has(4);
  @$pb.TagNumber(5)
  void clearTargetStep() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get currentAngle => $_getN(5);
  @$pb.TagNumber(6)
  set currentAngle($core.double v) { $_setFloat(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCurrentAngle() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrentAngle() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get targetAngle => $_getN(6);
  @$pb.TagNumber(7)
  set targetAngle($core.double v) { $_setFloat(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTargetAngle() => $_has(6);
  @$pb.TagNumber(7)
  void clearTargetAngle() => clearField(7);
}

class MotorCommand extends $pb.GeneratedMessage {
  factory MotorCommand({
    $core.int? moveSteps,
    $core.double? moveRadians,
    $core.double? angle,
  }) {
    final $result = create();
    if (moveSteps != null) {
      $result.moveSteps = moveSteps;
    }
    if (moveRadians != null) {
      $result.moveRadians = moveRadians;
    }
    if (angle != null) {
      $result.angle = angle;
    }
    return $result;
  }
  MotorCommand._() : super();
  factory MotorCommand.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MotorCommand.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MotorCommand', createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'moveSteps', $pb.PbFieldType.O3)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'moveRadians', $pb.PbFieldType.OF)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'angle', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MotorCommand clone() => MotorCommand()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MotorCommand copyWith(void Function(MotorCommand) updates) => super.copyWith((message) => updates(message as MotorCommand)) as MotorCommand;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MotorCommand create() => MotorCommand._();
  MotorCommand createEmptyInstance() => create();
  static $pb.PbList<MotorCommand> createRepeated() => $pb.PbList<MotorCommand>();
  @$core.pragma('dart2js:noInline')
  static MotorCommand getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MotorCommand>(create);
  static MotorCommand? _defaultInstance;

  /// Debug control: Move by individual steps
  @$pb.TagNumber(1)
  $core.int get moveSteps => $_getIZ(0);
  @$pb.TagNumber(1)
  set moveSteps($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMoveSteps() => $_has(0);
  @$pb.TagNumber(1)
  void clearMoveSteps() => clearField(1);

  /// Precise control: Move by radians
  @$pb.TagNumber(2)
  $core.double get moveRadians => $_getN(1);
  @$pb.TagNumber(2)
  set moveRadians($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMoveRadians() => $_has(1);
  @$pb.TagNumber(2)
  void clearMoveRadians() => clearField(2);

  /// / An angle to go to. Useful in IK.
  @$pb.TagNumber(3)
  $core.double get angle => $_getN(2);
  @$pb.TagNumber(3)
  set angle($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAngle() => $_has(2);
  @$pb.TagNumber(3)
  void clearAngle() => clearField(3);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
