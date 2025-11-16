//
//  Generated code. Do not modify.
//  source: relays.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'utils.pbenum.dart' as $4;

class RelaysCommand extends $pb.GeneratedMessage {
  factory RelaysCommand({
    $4.BoolState? backLeftMotor,
    $4.BoolState? backRightMotor,
    $4.BoolState? frontLeftMotor,
    $4.BoolState? frontRightMotor,
    $4.BoolState? arm,
    $4.BoolState? science,
    $4.BoolState? drive,
    $4.BoolState? bypass,
  }) {
    final $result = create();
    if (backLeftMotor != null) {
      $result.backLeftMotor = backLeftMotor;
    }
    if (backRightMotor != null) {
      $result.backRightMotor = backRightMotor;
    }
    if (frontLeftMotor != null) {
      $result.frontLeftMotor = frontLeftMotor;
    }
    if (frontRightMotor != null) {
      $result.frontRightMotor = frontRightMotor;
    }
    if (arm != null) {
      $result.arm = arm;
    }
    if (science != null) {
      $result.science = science;
    }
    if (drive != null) {
      $result.drive = drive;
    }
    if (bypass != null) {
      $result.bypass = bypass;
    }
    return $result;
  }
  RelaysCommand._() : super();
  factory RelaysCommand.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RelaysCommand.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RelaysCommand', createEmptyInstance: create)
    ..e<$4.BoolState>(1, _omitFieldNames ? '' : 'backLeftMotor', $pb.PbFieldType.OE, protoName: 'backLeftMotor', defaultOrMaker: $4.BoolState.BOOL_UNDEFINED, valueOf: $4.BoolState.valueOf, enumValues: $4.BoolState.values)
    ..e<$4.BoolState>(2, _omitFieldNames ? '' : 'backRightMotor', $pb.PbFieldType.OE, protoName: 'backRightMotor', defaultOrMaker: $4.BoolState.BOOL_UNDEFINED, valueOf: $4.BoolState.valueOf, enumValues: $4.BoolState.values)
    ..e<$4.BoolState>(3, _omitFieldNames ? '' : 'frontLeftMotor', $pb.PbFieldType.OE, protoName: 'frontLeftMotor', defaultOrMaker: $4.BoolState.BOOL_UNDEFINED, valueOf: $4.BoolState.valueOf, enumValues: $4.BoolState.values)
    ..e<$4.BoolState>(4, _omitFieldNames ? '' : 'frontRightMotor', $pb.PbFieldType.OE, protoName: 'frontRightMotor', defaultOrMaker: $4.BoolState.BOOL_UNDEFINED, valueOf: $4.BoolState.valueOf, enumValues: $4.BoolState.values)
    ..e<$4.BoolState>(5, _omitFieldNames ? '' : 'arm', $pb.PbFieldType.OE, defaultOrMaker: $4.BoolState.BOOL_UNDEFINED, valueOf: $4.BoolState.valueOf, enumValues: $4.BoolState.values)
    ..e<$4.BoolState>(6, _omitFieldNames ? '' : 'science', $pb.PbFieldType.OE, defaultOrMaker: $4.BoolState.BOOL_UNDEFINED, valueOf: $4.BoolState.valueOf, enumValues: $4.BoolState.values)
    ..e<$4.BoolState>(7, _omitFieldNames ? '' : 'drive', $pb.PbFieldType.OE, defaultOrMaker: $4.BoolState.BOOL_UNDEFINED, valueOf: $4.BoolState.valueOf, enumValues: $4.BoolState.values)
    ..e<$4.BoolState>(8, _omitFieldNames ? '' : 'bypass', $pb.PbFieldType.OE, defaultOrMaker: $4.BoolState.BOOL_UNDEFINED, valueOf: $4.BoolState.valueOf, enumValues: $4.BoolState.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RelaysCommand clone() => RelaysCommand()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RelaysCommand copyWith(void Function(RelaysCommand) updates) => super.copyWith((message) => updates(message as RelaysCommand)) as RelaysCommand;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RelaysCommand create() => RelaysCommand._();
  RelaysCommand createEmptyInstance() => create();
  static $pb.PbList<RelaysCommand> createRepeated() => $pb.PbList<RelaysCommand>();
  @$core.pragma('dart2js:noInline')
  static RelaysCommand getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RelaysCommand>(create);
  static RelaysCommand? _defaultInstance;

  /// Turn the following devices on or off
  @$pb.TagNumber(1)
  $4.BoolState get backLeftMotor => $_getN(0);
  @$pb.TagNumber(1)
  set backLeftMotor($4.BoolState v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasBackLeftMotor() => $_has(0);
  @$pb.TagNumber(1)
  void clearBackLeftMotor() => clearField(1);

  @$pb.TagNumber(2)
  $4.BoolState get backRightMotor => $_getN(1);
  @$pb.TagNumber(2)
  set backRightMotor($4.BoolState v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasBackRightMotor() => $_has(1);
  @$pb.TagNumber(2)
  void clearBackRightMotor() => clearField(2);

  @$pb.TagNumber(3)
  $4.BoolState get frontLeftMotor => $_getN(2);
  @$pb.TagNumber(3)
  set frontLeftMotor($4.BoolState v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasFrontLeftMotor() => $_has(2);
  @$pb.TagNumber(3)
  void clearFrontLeftMotor() => clearField(3);

  @$pb.TagNumber(4)
  $4.BoolState get frontRightMotor => $_getN(3);
  @$pb.TagNumber(4)
  set frontRightMotor($4.BoolState v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasFrontRightMotor() => $_has(3);
  @$pb.TagNumber(4)
  void clearFrontRightMotor() => clearField(4);

  @$pb.TagNumber(5)
  $4.BoolState get arm => $_getN(4);
  @$pb.TagNumber(5)
  set arm($4.BoolState v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasArm() => $_has(4);
  @$pb.TagNumber(5)
  void clearArm() => clearField(5);

  @$pb.TagNumber(6)
  $4.BoolState get science => $_getN(5);
  @$pb.TagNumber(6)
  set science($4.BoolState v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasScience() => $_has(5);
  @$pb.TagNumber(6)
  void clearScience() => clearField(6);

  @$pb.TagNumber(7)
  $4.BoolState get drive => $_getN(6);
  @$pb.TagNumber(7)
  set drive($4.BoolState v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasDrive() => $_has(6);
  @$pb.TagNumber(7)
  void clearDrive() => clearField(7);

  /// Special commands
  @$pb.TagNumber(8)
  $4.BoolState get bypass => $_getN(7);
  @$pb.TagNumber(8)
  set bypass($4.BoolState v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasBypass() => $_has(7);
  @$pb.TagNumber(8)
  void clearBypass() => clearField(8);
}

class RelaysData extends $pb.GeneratedMessage {
  factory RelaysData({
    $4.BoolState? backLeftMotor,
    $4.BoolState? backRightMotor,
    $4.BoolState? frontLeftMotor,
    $4.BoolState? frontRightMotor,
    $4.BoolState? arm,
    $4.BoolState? science,
    $4.BoolState? drive,
    $4.BoolState? bypass,
    $4.BoolState? mechanicalOverride,
  }) {
    final $result = create();
    if (backLeftMotor != null) {
      $result.backLeftMotor = backLeftMotor;
    }
    if (backRightMotor != null) {
      $result.backRightMotor = backRightMotor;
    }
    if (frontLeftMotor != null) {
      $result.frontLeftMotor = frontLeftMotor;
    }
    if (frontRightMotor != null) {
      $result.frontRightMotor = frontRightMotor;
    }
    if (arm != null) {
      $result.arm = arm;
    }
    if (science != null) {
      $result.science = science;
    }
    if (drive != null) {
      $result.drive = drive;
    }
    if (bypass != null) {
      $result.bypass = bypass;
    }
    if (mechanicalOverride != null) {
      $result.mechanicalOverride = mechanicalOverride;
    }
    return $result;
  }
  RelaysData._() : super();
  factory RelaysData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RelaysData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RelaysData', createEmptyInstance: create)
    ..e<$4.BoolState>(1, _omitFieldNames ? '' : 'backLeftMotor', $pb.PbFieldType.OE, protoName: 'backLeftMotor', defaultOrMaker: $4.BoolState.BOOL_UNDEFINED, valueOf: $4.BoolState.valueOf, enumValues: $4.BoolState.values)
    ..e<$4.BoolState>(2, _omitFieldNames ? '' : 'backRightMotor', $pb.PbFieldType.OE, protoName: 'backRightMotor', defaultOrMaker: $4.BoolState.BOOL_UNDEFINED, valueOf: $4.BoolState.valueOf, enumValues: $4.BoolState.values)
    ..e<$4.BoolState>(3, _omitFieldNames ? '' : 'frontLeftMotor', $pb.PbFieldType.OE, protoName: 'frontLeftMotor', defaultOrMaker: $4.BoolState.BOOL_UNDEFINED, valueOf: $4.BoolState.valueOf, enumValues: $4.BoolState.values)
    ..e<$4.BoolState>(4, _omitFieldNames ? '' : 'frontRightMotor', $pb.PbFieldType.OE, protoName: 'frontRightMotor', defaultOrMaker: $4.BoolState.BOOL_UNDEFINED, valueOf: $4.BoolState.valueOf, enumValues: $4.BoolState.values)
    ..e<$4.BoolState>(5, _omitFieldNames ? '' : 'arm', $pb.PbFieldType.OE, defaultOrMaker: $4.BoolState.BOOL_UNDEFINED, valueOf: $4.BoolState.valueOf, enumValues: $4.BoolState.values)
    ..e<$4.BoolState>(6, _omitFieldNames ? '' : 'science', $pb.PbFieldType.OE, defaultOrMaker: $4.BoolState.BOOL_UNDEFINED, valueOf: $4.BoolState.valueOf, enumValues: $4.BoolState.values)
    ..e<$4.BoolState>(7, _omitFieldNames ? '' : 'drive', $pb.PbFieldType.OE, defaultOrMaker: $4.BoolState.BOOL_UNDEFINED, valueOf: $4.BoolState.valueOf, enumValues: $4.BoolState.values)
    ..e<$4.BoolState>(8, _omitFieldNames ? '' : 'bypass', $pb.PbFieldType.OE, defaultOrMaker: $4.BoolState.BOOL_UNDEFINED, valueOf: $4.BoolState.valueOf, enumValues: $4.BoolState.values)
    ..e<$4.BoolState>(9, _omitFieldNames ? '' : 'mechanicalOverride', $pb.PbFieldType.OE, protoName: 'mechanicalOverride', defaultOrMaker: $4.BoolState.BOOL_UNDEFINED, valueOf: $4.BoolState.valueOf, enumValues: $4.BoolState.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RelaysData clone() => RelaysData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RelaysData copyWith(void Function(RelaysData) updates) => super.copyWith((message) => updates(message as RelaysData)) as RelaysData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RelaysData create() => RelaysData._();
  RelaysData createEmptyInstance() => create();
  static $pb.PbList<RelaysData> createRepeated() => $pb.PbList<RelaysData>();
  @$core.pragma('dart2js:noInline')
  static RelaysData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RelaysData>(create);
  static RelaysData? _defaultInstance;

  /// Whether the following devices are on or off
  @$pb.TagNumber(1)
  $4.BoolState get backLeftMotor => $_getN(0);
  @$pb.TagNumber(1)
  set backLeftMotor($4.BoolState v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasBackLeftMotor() => $_has(0);
  @$pb.TagNumber(1)
  void clearBackLeftMotor() => clearField(1);

  @$pb.TagNumber(2)
  $4.BoolState get backRightMotor => $_getN(1);
  @$pb.TagNumber(2)
  set backRightMotor($4.BoolState v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasBackRightMotor() => $_has(1);
  @$pb.TagNumber(2)
  void clearBackRightMotor() => clearField(2);

  @$pb.TagNumber(3)
  $4.BoolState get frontLeftMotor => $_getN(2);
  @$pb.TagNumber(3)
  set frontLeftMotor($4.BoolState v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasFrontLeftMotor() => $_has(2);
  @$pb.TagNumber(3)
  void clearFrontLeftMotor() => clearField(3);

  @$pb.TagNumber(4)
  $4.BoolState get frontRightMotor => $_getN(3);
  @$pb.TagNumber(4)
  set frontRightMotor($4.BoolState v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasFrontRightMotor() => $_has(3);
  @$pb.TagNumber(4)
  void clearFrontRightMotor() => clearField(4);

  @$pb.TagNumber(5)
  $4.BoolState get arm => $_getN(4);
  @$pb.TagNumber(5)
  set arm($4.BoolState v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasArm() => $_has(4);
  @$pb.TagNumber(5)
  void clearArm() => clearField(5);

  @$pb.TagNumber(6)
  $4.BoolState get science => $_getN(5);
  @$pb.TagNumber(6)
  set science($4.BoolState v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasScience() => $_has(5);
  @$pb.TagNumber(6)
  void clearScience() => clearField(6);

  @$pb.TagNumber(7)
  $4.BoolState get drive => $_getN(6);
  @$pb.TagNumber(7)
  set drive($4.BoolState v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasDrive() => $_has(6);
  @$pb.TagNumber(7)
  void clearDrive() => clearField(7);

  /// Special data
  @$pb.TagNumber(8)
  $4.BoolState get bypass => $_getN(7);
  @$pb.TagNumber(8)
  set bypass($4.BoolState v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasBypass() => $_has(7);
  @$pb.TagNumber(8)
  void clearBypass() => clearField(8);

  @$pb.TagNumber(9)
  $4.BoolState get mechanicalOverride => $_getN(8);
  @$pb.TagNumber(9)
  set mechanicalOverride($4.BoolState v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasMechanicalOverride() => $_has(8);
  @$pb.TagNumber(9)
  void clearMechanicalOverride() => clearField(9);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
