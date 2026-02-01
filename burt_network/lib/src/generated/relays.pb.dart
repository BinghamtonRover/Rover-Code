// This is a generated file - do not edit.
//
// Generated from relays.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'utils.pbenum.dart' as $1;
import 'version.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class RelaysCommand extends $pb.GeneratedMessage {
  factory RelaysCommand({
    $0.Version? version,
    $1.BoolState? backLeftMotor,
    $1.BoolState? backRightMotor,
    $1.BoolState? frontLeftMotor,
    $1.BoolState? frontRightMotor,
    $1.BoolState? leftDampeningMotor,
    $1.BoolState? rightDampeningMotor,
    $1.BoolState? arm,
    $1.BoolState? science,
    $1.BoolState? drive,
    $1.BoolState? bypass,
  }) {
    final result = create();
    if (version != null) result.version = version;
    if (backLeftMotor != null) result.backLeftMotor = backLeftMotor;
    if (backRightMotor != null) result.backRightMotor = backRightMotor;
    if (frontLeftMotor != null) result.frontLeftMotor = frontLeftMotor;
    if (frontRightMotor != null) result.frontRightMotor = frontRightMotor;
    if (leftDampeningMotor != null)
      result.leftDampeningMotor = leftDampeningMotor;
    if (rightDampeningMotor != null)
      result.rightDampeningMotor = rightDampeningMotor;
    if (arm != null) result.arm = arm;
    if (science != null) result.science = science;
    if (drive != null) result.drive = drive;
    if (bypass != null) result.bypass = bypass;
    return result;
  }

  RelaysCommand._();

  factory RelaysCommand.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RelaysCommand.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RelaysCommand',
      createEmptyInstance: create)
    ..aOM<$0.Version>(1, _omitFieldNames ? '' : 'version',
        subBuilder: $0.Version.create)
    ..aE<$1.BoolState>(2, _omitFieldNames ? '' : 'backLeftMotor',
        enumValues: $1.BoolState.values)
    ..aE<$1.BoolState>(3, _omitFieldNames ? '' : 'backRightMotor',
        enumValues: $1.BoolState.values)
    ..aE<$1.BoolState>(4, _omitFieldNames ? '' : 'frontLeftMotor',
        enumValues: $1.BoolState.values)
    ..aE<$1.BoolState>(5, _omitFieldNames ? '' : 'frontRightMotor',
        enumValues: $1.BoolState.values)
    ..aE<$1.BoolState>(6, _omitFieldNames ? '' : 'leftDampeningMotor',
        enumValues: $1.BoolState.values)
    ..aE<$1.BoolState>(7, _omitFieldNames ? '' : 'rightDampeningMotor',
        enumValues: $1.BoolState.values)
    ..aE<$1.BoolState>(8, _omitFieldNames ? '' : 'arm',
        enumValues: $1.BoolState.values)
    ..aE<$1.BoolState>(9, _omitFieldNames ? '' : 'science',
        enumValues: $1.BoolState.values)
    ..aE<$1.BoolState>(10, _omitFieldNames ? '' : 'drive',
        enumValues: $1.BoolState.values)
    ..aE<$1.BoolState>(11, _omitFieldNames ? '' : 'bypass',
        enumValues: $1.BoolState.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RelaysCommand clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RelaysCommand copyWith(void Function(RelaysCommand) updates) =>
      super.copyWith((message) => updates(message as RelaysCommand))
          as RelaysCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RelaysCommand create() => RelaysCommand._();
  @$core.override
  RelaysCommand createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RelaysCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RelaysCommand>(create);
  static RelaysCommand? _defaultInstance;

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

  /// Turn the following devices on or off
  @$pb.TagNumber(2)
  $1.BoolState get backLeftMotor => $_getN(1);
  @$pb.TagNumber(2)
  set backLeftMotor($1.BoolState value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasBackLeftMotor() => $_has(1);
  @$pb.TagNumber(2)
  void clearBackLeftMotor() => $_clearField(2);

  @$pb.TagNumber(3)
  $1.BoolState get backRightMotor => $_getN(2);
  @$pb.TagNumber(3)
  set backRightMotor($1.BoolState value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasBackRightMotor() => $_has(2);
  @$pb.TagNumber(3)
  void clearBackRightMotor() => $_clearField(3);

  @$pb.TagNumber(4)
  $1.BoolState get frontLeftMotor => $_getN(3);
  @$pb.TagNumber(4)
  set frontLeftMotor($1.BoolState value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasFrontLeftMotor() => $_has(3);
  @$pb.TagNumber(4)
  void clearFrontLeftMotor() => $_clearField(4);

  @$pb.TagNumber(5)
  $1.BoolState get frontRightMotor => $_getN(4);
  @$pb.TagNumber(5)
  set frontRightMotor($1.BoolState value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasFrontRightMotor() => $_has(4);
  @$pb.TagNumber(5)
  void clearFrontRightMotor() => $_clearField(5);

  @$pb.TagNumber(6)
  $1.BoolState get leftDampeningMotor => $_getN(5);
  @$pb.TagNumber(6)
  set leftDampeningMotor($1.BoolState value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasLeftDampeningMotor() => $_has(5);
  @$pb.TagNumber(6)
  void clearLeftDampeningMotor() => $_clearField(6);

  @$pb.TagNumber(7)
  $1.BoolState get rightDampeningMotor => $_getN(6);
  @$pb.TagNumber(7)
  set rightDampeningMotor($1.BoolState value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasRightDampeningMotor() => $_has(6);
  @$pb.TagNumber(7)
  void clearRightDampeningMotor() => $_clearField(7);

  @$pb.TagNumber(8)
  $1.BoolState get arm => $_getN(7);
  @$pb.TagNumber(8)
  set arm($1.BoolState value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasArm() => $_has(7);
  @$pb.TagNumber(8)
  void clearArm() => $_clearField(8);

  @$pb.TagNumber(9)
  $1.BoolState get science => $_getN(8);
  @$pb.TagNumber(9)
  set science($1.BoolState value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasScience() => $_has(8);
  @$pb.TagNumber(9)
  void clearScience() => $_clearField(9);

  @$pb.TagNumber(10)
  $1.BoolState get drive => $_getN(9);
  @$pb.TagNumber(10)
  set drive($1.BoolState value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasDrive() => $_has(9);
  @$pb.TagNumber(10)
  void clearDrive() => $_clearField(10);

  /// Special commands
  @$pb.TagNumber(11)
  $1.BoolState get bypass => $_getN(10);
  @$pb.TagNumber(11)
  set bypass($1.BoolState value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasBypass() => $_has(10);
  @$pb.TagNumber(11)
  void clearBypass() => $_clearField(11);
}

class RelaysData extends $pb.GeneratedMessage {
  factory RelaysData({
    $0.Version? version,
    $1.BoolState? backLeftMotor,
    $1.BoolState? backRightMotor,
    $1.BoolState? frontLeftMotor,
    $1.BoolState? frontRightMotor,
    $1.BoolState? leftDampeningMotor,
    $1.BoolState? rightDampeningMotor,
    $1.BoolState? arm,
    $1.BoolState? science,
    $1.BoolState? drive,
    $1.BoolState? bypass,
    $1.BoolState? mechanicalOverride,
    $core.double? batteryVoltage,
  }) {
    final result = create();
    if (version != null) result.version = version;
    if (backLeftMotor != null) result.backLeftMotor = backLeftMotor;
    if (backRightMotor != null) result.backRightMotor = backRightMotor;
    if (frontLeftMotor != null) result.frontLeftMotor = frontLeftMotor;
    if (frontRightMotor != null) result.frontRightMotor = frontRightMotor;
    if (leftDampeningMotor != null)
      result.leftDampeningMotor = leftDampeningMotor;
    if (rightDampeningMotor != null)
      result.rightDampeningMotor = rightDampeningMotor;
    if (arm != null) result.arm = arm;
    if (science != null) result.science = science;
    if (drive != null) result.drive = drive;
    if (bypass != null) result.bypass = bypass;
    if (mechanicalOverride != null)
      result.mechanicalOverride = mechanicalOverride;
    if (batteryVoltage != null) result.batteryVoltage = batteryVoltage;
    return result;
  }

  RelaysData._();

  factory RelaysData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RelaysData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RelaysData',
      createEmptyInstance: create)
    ..aOM<$0.Version>(1, _omitFieldNames ? '' : 'version',
        subBuilder: $0.Version.create)
    ..aE<$1.BoolState>(2, _omitFieldNames ? '' : 'backLeftMotor',
        enumValues: $1.BoolState.values)
    ..aE<$1.BoolState>(3, _omitFieldNames ? '' : 'backRightMotor',
        enumValues: $1.BoolState.values)
    ..aE<$1.BoolState>(4, _omitFieldNames ? '' : 'frontLeftMotor',
        enumValues: $1.BoolState.values)
    ..aE<$1.BoolState>(5, _omitFieldNames ? '' : 'frontRightMotor',
        enumValues: $1.BoolState.values)
    ..aE<$1.BoolState>(6, _omitFieldNames ? '' : 'leftDampeningMotor',
        enumValues: $1.BoolState.values)
    ..aE<$1.BoolState>(7, _omitFieldNames ? '' : 'rightDampeningMotor',
        enumValues: $1.BoolState.values)
    ..aE<$1.BoolState>(8, _omitFieldNames ? '' : 'arm',
        enumValues: $1.BoolState.values)
    ..aE<$1.BoolState>(9, _omitFieldNames ? '' : 'science',
        enumValues: $1.BoolState.values)
    ..aE<$1.BoolState>(10, _omitFieldNames ? '' : 'drive',
        enumValues: $1.BoolState.values)
    ..aE<$1.BoolState>(11, _omitFieldNames ? '' : 'bypass',
        enumValues: $1.BoolState.values)
    ..aE<$1.BoolState>(12, _omitFieldNames ? '' : 'mechanicalOverride',
        enumValues: $1.BoolState.values)
    ..aD(13, _omitFieldNames ? '' : 'batteryVoltage',
        fieldType: $pb.PbFieldType.OF)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RelaysData clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RelaysData copyWith(void Function(RelaysData) updates) =>
      super.copyWith((message) => updates(message as RelaysData)) as RelaysData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RelaysData create() => RelaysData._();
  @$core.override
  RelaysData createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RelaysData getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RelaysData>(create);
  static RelaysData? _defaultInstance;

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

  /// Whether the following devices are on or off
  @$pb.TagNumber(2)
  $1.BoolState get backLeftMotor => $_getN(1);
  @$pb.TagNumber(2)
  set backLeftMotor($1.BoolState value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasBackLeftMotor() => $_has(1);
  @$pb.TagNumber(2)
  void clearBackLeftMotor() => $_clearField(2);

  @$pb.TagNumber(3)
  $1.BoolState get backRightMotor => $_getN(2);
  @$pb.TagNumber(3)
  set backRightMotor($1.BoolState value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasBackRightMotor() => $_has(2);
  @$pb.TagNumber(3)
  void clearBackRightMotor() => $_clearField(3);

  @$pb.TagNumber(4)
  $1.BoolState get frontLeftMotor => $_getN(3);
  @$pb.TagNumber(4)
  set frontLeftMotor($1.BoolState value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasFrontLeftMotor() => $_has(3);
  @$pb.TagNumber(4)
  void clearFrontLeftMotor() => $_clearField(4);

  @$pb.TagNumber(5)
  $1.BoolState get frontRightMotor => $_getN(4);
  @$pb.TagNumber(5)
  set frontRightMotor($1.BoolState value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasFrontRightMotor() => $_has(4);
  @$pb.TagNumber(5)
  void clearFrontRightMotor() => $_clearField(5);

  @$pb.TagNumber(6)
  $1.BoolState get leftDampeningMotor => $_getN(5);
  @$pb.TagNumber(6)
  set leftDampeningMotor($1.BoolState value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasLeftDampeningMotor() => $_has(5);
  @$pb.TagNumber(6)
  void clearLeftDampeningMotor() => $_clearField(6);

  @$pb.TagNumber(7)
  $1.BoolState get rightDampeningMotor => $_getN(6);
  @$pb.TagNumber(7)
  set rightDampeningMotor($1.BoolState value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasRightDampeningMotor() => $_has(6);
  @$pb.TagNumber(7)
  void clearRightDampeningMotor() => $_clearField(7);

  @$pb.TagNumber(8)
  $1.BoolState get arm => $_getN(7);
  @$pb.TagNumber(8)
  set arm($1.BoolState value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasArm() => $_has(7);
  @$pb.TagNumber(8)
  void clearArm() => $_clearField(8);

  @$pb.TagNumber(9)
  $1.BoolState get science => $_getN(8);
  @$pb.TagNumber(9)
  set science($1.BoolState value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasScience() => $_has(8);
  @$pb.TagNumber(9)
  void clearScience() => $_clearField(9);

  @$pb.TagNumber(10)
  $1.BoolState get drive => $_getN(9);
  @$pb.TagNumber(10)
  set drive($1.BoolState value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasDrive() => $_has(9);
  @$pb.TagNumber(10)
  void clearDrive() => $_clearField(10);

  @$pb.TagNumber(11)
  $1.BoolState get bypass => $_getN(10);
  @$pb.TagNumber(11)
  set bypass($1.BoolState value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasBypass() => $_has(10);
  @$pb.TagNumber(11)
  void clearBypass() => $_clearField(11);

  @$pb.TagNumber(12)
  $1.BoolState get mechanicalOverride => $_getN(11);
  @$pb.TagNumber(12)
  set mechanicalOverride($1.BoolState value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasMechanicalOverride() => $_has(11);
  @$pb.TagNumber(12)
  void clearMechanicalOverride() => $_clearField(12);

  /// Special data
  @$pb.TagNumber(13)
  $core.double get batteryVoltage => $_getN(12);
  @$pb.TagNumber(13)
  set batteryVoltage($core.double value) => $_setFloat(12, value);
  @$pb.TagNumber(13)
  $core.bool hasBatteryVoltage() => $_has(12);
  @$pb.TagNumber(13)
  void clearBatteryVoltage() => $_clearField(13);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
