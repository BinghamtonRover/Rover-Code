// This is a generated file - do not edit.
//
// Generated from motor.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'motor.pbenum.dart';
import 'utils.pbenum.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

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
    final result = create();
    if (isMoving != null) result.isMoving = isMoving;
    if (isLimitSwitchPressed != null)
      result.isLimitSwitchPressed = isLimitSwitchPressed;
    if (direction != null) result.direction = direction;
    if (currentStep != null) result.currentStep = currentStep;
    if (targetStep != null) result.targetStep = targetStep;
    if (currentAngle != null) result.currentAngle = currentAngle;
    if (targetAngle != null) result.targetAngle = targetAngle;
    return result;
  }

  MotorData._();

  factory MotorData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MotorData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MotorData',
      createEmptyInstance: create)
    ..aE<$0.BoolState>(1, _omitFieldNames ? '' : 'isMoving',
        enumValues: $0.BoolState.values)
    ..aE<$0.BoolState>(2, _omitFieldNames ? '' : 'isLimitSwitchPressed',
        enumValues: $0.BoolState.values)
    ..aE<MotorDirection>(3, _omitFieldNames ? '' : 'direction',
        enumValues: MotorDirection.values)
    ..aI(4, _omitFieldNames ? '' : 'currentStep')
    ..aI(5, _omitFieldNames ? '' : 'targetStep')
    ..aD(6, _omitFieldNames ? '' : 'currentAngle',
        fieldType: $pb.PbFieldType.OF)
    ..aD(7, _omitFieldNames ? '' : 'targetAngle', fieldType: $pb.PbFieldType.OF)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MotorData clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MotorData copyWith(void Function(MotorData) updates) =>
      super.copyWith((message) => updates(message as MotorData)) as MotorData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MotorData create() => MotorData._();
  @$core.override
  MotorData createEmptyInstance() => create();
  static $pb.PbList<MotorData> createRepeated() => $pb.PbList<MotorData>();
  @$core.pragma('dart2js:noInline')
  static MotorData getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MotorData>(create);
  static MotorData? _defaultInstance;

  @$pb.TagNumber(1)
  $0.BoolState get isMoving => $_getN(0);
  @$pb.TagNumber(1)
  set isMoving($0.BoolState value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasIsMoving() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsMoving() => $_clearField(1);

  @$pb.TagNumber(2)
  $0.BoolState get isLimitSwitchPressed => $_getN(1);
  @$pb.TagNumber(2)
  set isLimitSwitchPressed($0.BoolState value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasIsLimitSwitchPressed() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsLimitSwitchPressed() => $_clearField(2);

  @$pb.TagNumber(3)
  MotorDirection get direction => $_getN(2);
  @$pb.TagNumber(3)
  set direction(MotorDirection value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasDirection() => $_has(2);
  @$pb.TagNumber(3)
  void clearDirection() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get currentStep => $_getIZ(3);
  @$pb.TagNumber(4)
  set currentStep($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrentStep() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrentStep() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get targetStep => $_getIZ(4);
  @$pb.TagNumber(5)
  set targetStep($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTargetStep() => $_has(4);
  @$pb.TagNumber(5)
  void clearTargetStep() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get currentAngle => $_getN(5);
  @$pb.TagNumber(6)
  set currentAngle($core.double value) => $_setFloat(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCurrentAngle() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrentAngle() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get targetAngle => $_getN(6);
  @$pb.TagNumber(7)
  set targetAngle($core.double value) => $_setFloat(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTargetAngle() => $_has(6);
  @$pb.TagNumber(7)
  void clearTargetAngle() => $_clearField(7);
}

class MotorCommand extends $pb.GeneratedMessage {
  factory MotorCommand({
    $core.int? moveSteps,
    $core.double? moveRadians,
    $core.double? angle,
  }) {
    final result = create();
    if (moveSteps != null) result.moveSteps = moveSteps;
    if (moveRadians != null) result.moveRadians = moveRadians;
    if (angle != null) result.angle = angle;
    return result;
  }

  MotorCommand._();

  factory MotorCommand.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MotorCommand.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MotorCommand',
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'moveSteps')
    ..aD(2, _omitFieldNames ? '' : 'moveRadians', fieldType: $pb.PbFieldType.OF)
    ..aD(3, _omitFieldNames ? '' : 'angle', fieldType: $pb.PbFieldType.OF)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MotorCommand clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MotorCommand copyWith(void Function(MotorCommand) updates) =>
      super.copyWith((message) => updates(message as MotorCommand))
          as MotorCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MotorCommand create() => MotorCommand._();
  @$core.override
  MotorCommand createEmptyInstance() => create();
  static $pb.PbList<MotorCommand> createRepeated() =>
      $pb.PbList<MotorCommand>();
  @$core.pragma('dart2js:noInline')
  static MotorCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MotorCommand>(create);
  static MotorCommand? _defaultInstance;

  /// Debug control: Move by individual steps
  @$pb.TagNumber(1)
  $core.int get moveSteps => $_getIZ(0);
  @$pb.TagNumber(1)
  set moveSteps($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMoveSteps() => $_has(0);
  @$pb.TagNumber(1)
  void clearMoveSteps() => $_clearField(1);

  /// Precise control: Move by radians
  @$pb.TagNumber(2)
  $core.double get moveRadians => $_getN(1);
  @$pb.TagNumber(2)
  set moveRadians($core.double value) => $_setFloat(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMoveRadians() => $_has(1);
  @$pb.TagNumber(2)
  void clearMoveRadians() => $_clearField(2);

  /// / An angle to go to. Useful in IK.
  @$pb.TagNumber(3)
  $core.double get angle => $_getN(2);
  @$pb.TagNumber(3)
  set angle($core.double value) => $_setFloat(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAngle() => $_has(2);
  @$pb.TagNumber(3)
  void clearAngle() => $_clearField(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
