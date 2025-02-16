//
//  Generated code. Do not modify.
//  source: subsystems.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'core.pbenum.dart' as $6;
import 'utils.pbenum.dart' as $0;
import 'version.pb.dart' as $3;

class SubsystemsCommand extends $pb.GeneratedMessage {
  factory SubsystemsCommand({
    $core.bool? zeroIMU,
    $3.Version? version,
  }) {
    final $result = create();
    if (zeroIMU != null) {
      $result.zeroIMU = zeroIMU;
    }
    if (version != null) {
      $result.version = version;
    }
    return $result;
  }
  SubsystemsCommand._() : super();
  factory SubsystemsCommand.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubsystemsCommand.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SubsystemsCommand', createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'zeroIMU', protoName: 'zeroIMU')
    ..aOM<$3.Version>(2, _omitFieldNames ? '' : 'version', subBuilder: $3.Version.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubsystemsCommand clone() => SubsystemsCommand()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubsystemsCommand copyWith(void Function(SubsystemsCommand) updates) => super.copyWith((message) => updates(message as SubsystemsCommand)) as SubsystemsCommand;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubsystemsCommand create() => SubsystemsCommand._();
  SubsystemsCommand createEmptyInstance() => create();
  static $pb.PbList<SubsystemsCommand> createRepeated() => $pb.PbList<SubsystemsCommand>();
  @$core.pragma('dart2js:noInline')
  static SubsystemsCommand getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubsystemsCommand>(create);
  static SubsystemsCommand? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get zeroIMU => $_getBF(0);
  @$pb.TagNumber(1)
  set zeroIMU($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasZeroIMU() => $_has(0);
  @$pb.TagNumber(1)
  void clearZeroIMU() => clearField(1);

  @$pb.TagNumber(2)
  $3.Version get version => $_getN(1);
  @$pb.TagNumber(2)
  set version($3.Version v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearVersion() => clearField(2);
  @$pb.TagNumber(2)
  $3.Version ensureVersion() => $_ensure(1);
}

class SubsystemsData extends $pb.GeneratedMessage {
  factory SubsystemsData({
    $3.Version? version,
    $core.Iterable<$6.Device>? connectedDevices,
    $0.BoolState? gpsConnected,
    $0.BoolState? imuConnected,
  }) {
    final $result = create();
    if (version != null) {
      $result.version = version;
    }
    if (connectedDevices != null) {
      $result.connectedDevices.addAll(connectedDevices);
    }
    if (gpsConnected != null) {
      $result.gpsConnected = gpsConnected;
    }
    if (imuConnected != null) {
      $result.imuConnected = imuConnected;
    }
    return $result;
  }
  SubsystemsData._() : super();
  factory SubsystemsData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubsystemsData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SubsystemsData', createEmptyInstance: create)
    ..aOM<$3.Version>(1, _omitFieldNames ? '' : 'version', subBuilder: $3.Version.create)
    ..pc<$6.Device>(2, _omitFieldNames ? '' : 'connectedDevices', $pb.PbFieldType.KE, protoName: 'connectedDevices', valueOf: $6.Device.valueOf, enumValues: $6.Device.values, defaultEnumValue: $6.Device.DEVICE_UNDEFINED)
    ..e<$0.BoolState>(3, _omitFieldNames ? '' : 'gpsConnected', $pb.PbFieldType.OE, protoName: 'gpsConnected', defaultOrMaker: $0.BoolState.BOOL_UNDEFINED, valueOf: $0.BoolState.valueOf, enumValues: $0.BoolState.values)
    ..e<$0.BoolState>(4, _omitFieldNames ? '' : 'imuConnected', $pb.PbFieldType.OE, protoName: 'imuConnected', defaultOrMaker: $0.BoolState.BOOL_UNDEFINED, valueOf: $0.BoolState.valueOf, enumValues: $0.BoolState.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubsystemsData clone() => SubsystemsData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubsystemsData copyWith(void Function(SubsystemsData) updates) => super.copyWith((message) => updates(message as SubsystemsData)) as SubsystemsData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubsystemsData create() => SubsystemsData._();
  SubsystemsData createEmptyInstance() => create();
  static $pb.PbList<SubsystemsData> createRepeated() => $pb.PbList<SubsystemsData>();
  @$core.pragma('dart2js:noInline')
  static SubsystemsData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubsystemsData>(create);
  static SubsystemsData? _defaultInstance;

  @$pb.TagNumber(1)
  $3.Version get version => $_getN(0);
  @$pb.TagNumber(1)
  set version($3.Version v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersion() => clearField(1);
  @$pb.TagNumber(1)
  $3.Version ensureVersion() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<$6.Device> get connectedDevices => $_getList(1);

  @$pb.TagNumber(3)
  $0.BoolState get gpsConnected => $_getN(2);
  @$pb.TagNumber(3)
  set gpsConnected($0.BoolState v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasGpsConnected() => $_has(2);
  @$pb.TagNumber(3)
  void clearGpsConnected() => clearField(3);

  @$pb.TagNumber(4)
  $0.BoolState get imuConnected => $_getN(3);
  @$pb.TagNumber(4)
  set imuConnected($0.BoolState v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasImuConnected() => $_has(3);
  @$pb.TagNumber(4)
  void clearImuConnected() => clearField(4);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
