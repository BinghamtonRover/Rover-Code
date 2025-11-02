// This is a generated file - do not edit.
//
// Generated from relays.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'utils.pbenum.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class RelaysCommand extends $pb.GeneratedMessage {
  factory RelaysCommand({
    $0.BoolState? backLeftMotor,
    $0.BoolState? backRightMotor,
    $0.BoolState? frontLeftMotor,
    $0.BoolState? frontRightMotor,
    $0.BoolState? arm,
    $0.BoolState? science,
    $0.BoolState? drive,
    $0.BoolState? bypass,
  }) {
    final result = create();
    if (backLeftMotor != null) result.backLeftMotor = backLeftMotor;
    if (backRightMotor != null) result.backRightMotor = backRightMotor;
    if (frontLeftMotor != null) result.frontLeftMotor = frontLeftMotor;
    if (frontRightMotor != null) result.frontRightMotor = frontRightMotor;
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
    ..aE<$0.BoolState>(1, _omitFieldNames ? '' : 'backLeftMotor',
        protoName: 'backLeftMotor', enumValues: $0.BoolState.values)
    ..aE<$0.BoolState>(2, _omitFieldNames ? '' : 'backRightMotor',
        protoName: 'backRightMotor', enumValues: $0.BoolState.values)
    ..aE<$0.BoolState>(3, _omitFieldNames ? '' : 'frontLeftMotor',
        protoName: 'frontLeftMotor', enumValues: $0.BoolState.values)
    ..aE<$0.BoolState>(4, _omitFieldNames ? '' : 'frontRightMotor',
        protoName: 'frontRightMotor', enumValues: $0.BoolState.values)
    ..aE<$0.BoolState>(5, _omitFieldNames ? '' : 'arm',
        enumValues: $0.BoolState.values)
    ..aE<$0.BoolState>(6, _omitFieldNames ? '' : 'science',
        enumValues: $0.BoolState.values)
    ..aE<$0.BoolState>(7, _omitFieldNames ? '' : 'drive',
        enumValues: $0.BoolState.values)
    ..aE<$0.BoolState>(8, _omitFieldNames ? '' : 'bypass',
        enumValues: $0.BoolState.values)
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
  static $pb.PbList<RelaysCommand> createRepeated() =>
      $pb.PbList<RelaysCommand>();
  @$core.pragma('dart2js:noInline')
  static RelaysCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RelaysCommand>(create);
  static RelaysCommand? _defaultInstance;

  /// Turn the following devices on or off
  @$pb.TagNumber(1)
  $0.BoolState get backLeftMotor => $_getN(0);
  @$pb.TagNumber(1)
  set backLeftMotor($0.BoolState value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasBackLeftMotor() => $_has(0);
  @$pb.TagNumber(1)
  void clearBackLeftMotor() => $_clearField(1);

  @$pb.TagNumber(2)
  $0.BoolState get backRightMotor => $_getN(1);
  @$pb.TagNumber(2)
  set backRightMotor($0.BoolState value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasBackRightMotor() => $_has(1);
  @$pb.TagNumber(2)
  void clearBackRightMotor() => $_clearField(2);

  @$pb.TagNumber(3)
  $0.BoolState get frontLeftMotor => $_getN(2);
  @$pb.TagNumber(3)
  set frontLeftMotor($0.BoolState value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasFrontLeftMotor() => $_has(2);
  @$pb.TagNumber(3)
  void clearFrontLeftMotor() => $_clearField(3);

  @$pb.TagNumber(4)
  $0.BoolState get frontRightMotor => $_getN(3);
  @$pb.TagNumber(4)
  set frontRightMotor($0.BoolState value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasFrontRightMotor() => $_has(3);
  @$pb.TagNumber(4)
  void clearFrontRightMotor() => $_clearField(4);

  @$pb.TagNumber(5)
  $0.BoolState get arm => $_getN(4);
  @$pb.TagNumber(5)
  set arm($0.BoolState value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasArm() => $_has(4);
  @$pb.TagNumber(5)
  void clearArm() => $_clearField(5);

  @$pb.TagNumber(6)
  $0.BoolState get science => $_getN(5);
  @$pb.TagNumber(6)
  set science($0.BoolState value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasScience() => $_has(5);
  @$pb.TagNumber(6)
  void clearScience() => $_clearField(6);

  @$pb.TagNumber(7)
  $0.BoolState get drive => $_getN(6);
  @$pb.TagNumber(7)
  set drive($0.BoolState value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasDrive() => $_has(6);
  @$pb.TagNumber(7)
  void clearDrive() => $_clearField(7);

  /// Special commands
  @$pb.TagNumber(8)
  $0.BoolState get bypass => $_getN(7);
  @$pb.TagNumber(8)
  set bypass($0.BoolState value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasBypass() => $_has(7);
  @$pb.TagNumber(8)
  void clearBypass() => $_clearField(8);
}

class RelaysData extends $pb.GeneratedMessage {
  factory RelaysData({
    $0.BoolState? backLeftMotor,
    $0.BoolState? backRightMotor,
    $0.BoolState? frontLeftMotor,
    $0.BoolState? frontRightMotor,
    $0.BoolState? arm,
    $0.BoolState? science,
    $0.BoolState? drive,
    $0.BoolState? bypass,
    $0.BoolState? mechanicalOverride,
  }) {
    final result = create();
    if (backLeftMotor != null) result.backLeftMotor = backLeftMotor;
    if (backRightMotor != null) result.backRightMotor = backRightMotor;
    if (frontLeftMotor != null) result.frontLeftMotor = frontLeftMotor;
    if (frontRightMotor != null) result.frontRightMotor = frontRightMotor;
    if (arm != null) result.arm = arm;
    if (science != null) result.science = science;
    if (drive != null) result.drive = drive;
    if (bypass != null) result.bypass = bypass;
    if (mechanicalOverride != null)
      result.mechanicalOverride = mechanicalOverride;
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
    ..aE<$0.BoolState>(1, _omitFieldNames ? '' : 'backLeftMotor',
        protoName: 'backLeftMotor', enumValues: $0.BoolState.values)
    ..aE<$0.BoolState>(2, _omitFieldNames ? '' : 'backRightMotor',
        protoName: 'backRightMotor', enumValues: $0.BoolState.values)
    ..aE<$0.BoolState>(3, _omitFieldNames ? '' : 'frontLeftMotor',
        protoName: 'frontLeftMotor', enumValues: $0.BoolState.values)
    ..aE<$0.BoolState>(4, _omitFieldNames ? '' : 'frontRightMotor',
        protoName: 'frontRightMotor', enumValues: $0.BoolState.values)
    ..aE<$0.BoolState>(5, _omitFieldNames ? '' : 'arm',
        enumValues: $0.BoolState.values)
    ..aE<$0.BoolState>(6, _omitFieldNames ? '' : 'science',
        enumValues: $0.BoolState.values)
    ..aE<$0.BoolState>(7, _omitFieldNames ? '' : 'drive',
        enumValues: $0.BoolState.values)
    ..aE<$0.BoolState>(8, _omitFieldNames ? '' : 'bypass',
        enumValues: $0.BoolState.values)
    ..aE<$0.BoolState>(9, _omitFieldNames ? '' : 'mechanicalOverride',
        protoName: 'mechanicalOverride', enumValues: $0.BoolState.values)
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
  static $pb.PbList<RelaysData> createRepeated() => $pb.PbList<RelaysData>();
  @$core.pragma('dart2js:noInline')
  static RelaysData getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RelaysData>(create);
  static RelaysData? _defaultInstance;

  /// Whether the following devices are on or off
  @$pb.TagNumber(1)
  $0.BoolState get backLeftMotor => $_getN(0);
  @$pb.TagNumber(1)
  set backLeftMotor($0.BoolState value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasBackLeftMotor() => $_has(0);
  @$pb.TagNumber(1)
  void clearBackLeftMotor() => $_clearField(1);

  @$pb.TagNumber(2)
  $0.BoolState get backRightMotor => $_getN(1);
  @$pb.TagNumber(2)
  set backRightMotor($0.BoolState value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasBackRightMotor() => $_has(1);
  @$pb.TagNumber(2)
  void clearBackRightMotor() => $_clearField(2);

  @$pb.TagNumber(3)
  $0.BoolState get frontLeftMotor => $_getN(2);
  @$pb.TagNumber(3)
  set frontLeftMotor($0.BoolState value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasFrontLeftMotor() => $_has(2);
  @$pb.TagNumber(3)
  void clearFrontLeftMotor() => $_clearField(3);

  @$pb.TagNumber(4)
  $0.BoolState get frontRightMotor => $_getN(3);
  @$pb.TagNumber(4)
  set frontRightMotor($0.BoolState value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasFrontRightMotor() => $_has(3);
  @$pb.TagNumber(4)
  void clearFrontRightMotor() => $_clearField(4);

  @$pb.TagNumber(5)
  $0.BoolState get arm => $_getN(4);
  @$pb.TagNumber(5)
  set arm($0.BoolState value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasArm() => $_has(4);
  @$pb.TagNumber(5)
  void clearArm() => $_clearField(5);

  @$pb.TagNumber(6)
  $0.BoolState get science => $_getN(5);
  @$pb.TagNumber(6)
  set science($0.BoolState value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasScience() => $_has(5);
  @$pb.TagNumber(6)
  void clearScience() => $_clearField(6);

  @$pb.TagNumber(7)
  $0.BoolState get drive => $_getN(6);
  @$pb.TagNumber(7)
  set drive($0.BoolState value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasDrive() => $_has(6);
  @$pb.TagNumber(7)
  void clearDrive() => $_clearField(7);

  /// Special data
  @$pb.TagNumber(8)
  $0.BoolState get bypass => $_getN(7);
  @$pb.TagNumber(8)
  set bypass($0.BoolState value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasBypass() => $_has(7);
  @$pb.TagNumber(8)
  void clearBypass() => $_clearField(8);

  @$pb.TagNumber(9)
  $0.BoolState get mechanicalOverride => $_getN(8);
  @$pb.TagNumber(9)
  set mechanicalOverride($0.BoolState value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasMechanicalOverride() => $_has(8);
  @$pb.TagNumber(9)
  void clearMechanicalOverride() => $_clearField(9);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
