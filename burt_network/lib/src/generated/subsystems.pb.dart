// This is a generated file - do not edit.
//
// Generated from subsystems.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'core.pbenum.dart' as $1;
import 'utils.pbenum.dart' as $2;
import 'version.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class SubsystemsCommand extends $pb.GeneratedMessage {
  factory SubsystemsCommand({
    $core.bool? zeroIMU,
    $0.Version? version,
  }) {
    final result = create();
    if (zeroIMU != null) result.zeroIMU = zeroIMU;
    if (version != null) result.version = version;
    return result;
  }

  SubsystemsCommand._();

  factory SubsystemsCommand.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubsystemsCommand.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubsystemsCommand',
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'zeroIMU', protoName: 'zeroIMU')
    ..aOM<$0.Version>(2, _omitFieldNames ? '' : 'version',
        subBuilder: $0.Version.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubsystemsCommand clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubsystemsCommand copyWith(void Function(SubsystemsCommand) updates) =>
      super.copyWith((message) => updates(message as SubsystemsCommand))
          as SubsystemsCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubsystemsCommand create() => SubsystemsCommand._();
  @$core.override
  SubsystemsCommand createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SubsystemsCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubsystemsCommand>(create);
  static SubsystemsCommand? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get zeroIMU => $_getBF(0);
  @$pb.TagNumber(1)
  set zeroIMU($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasZeroIMU() => $_has(0);
  @$pb.TagNumber(1)
  void clearZeroIMU() => $_clearField(1);

  @$pb.TagNumber(2)
  $0.Version get version => $_getN(1);
  @$pb.TagNumber(2)
  set version($0.Version value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearVersion() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.Version ensureVersion() => $_ensure(1);
}

class SubsystemsData extends $pb.GeneratedMessage {
  factory SubsystemsData({
    $0.Version? version,
    $core.Iterable<$1.Device>? connectedDevices,
    $2.BoolState? gpsConnected,
    $2.BoolState? imuConnected,
  }) {
    final result = create();
    if (version != null) result.version = version;
    if (connectedDevices != null)
      result.connectedDevices.addAll(connectedDevices);
    if (gpsConnected != null) result.gpsConnected = gpsConnected;
    if (imuConnected != null) result.imuConnected = imuConnected;
    return result;
  }

  SubsystemsData._();

  factory SubsystemsData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubsystemsData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubsystemsData',
      createEmptyInstance: create)
    ..aOM<$0.Version>(1, _omitFieldNames ? '' : 'version',
        subBuilder: $0.Version.create)
    ..pc<$1.Device>(
        2, _omitFieldNames ? '' : 'connectedDevices', $pb.PbFieldType.KE,
        protoName: 'connectedDevices',
        valueOf: $1.Device.valueOf,
        enumValues: $1.Device.values,
        defaultEnumValue: $1.Device.DEVICE_UNDEFINED)
    ..aE<$2.BoolState>(3, _omitFieldNames ? '' : 'gpsConnected',
        protoName: 'gpsConnected', enumValues: $2.BoolState.values)
    ..aE<$2.BoolState>(4, _omitFieldNames ? '' : 'imuConnected',
        protoName: 'imuConnected', enumValues: $2.BoolState.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubsystemsData clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubsystemsData copyWith(void Function(SubsystemsData) updates) =>
      super.copyWith((message) => updates(message as SubsystemsData))
          as SubsystemsData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubsystemsData create() => SubsystemsData._();
  @$core.override
  SubsystemsData createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SubsystemsData getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubsystemsData>(create);
  static SubsystemsData? _defaultInstance;

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

  @$pb.TagNumber(2)
  $pb.PbList<$1.Device> get connectedDevices => $_getList(1);

  @$pb.TagNumber(3)
  $2.BoolState get gpsConnected => $_getN(2);
  @$pb.TagNumber(3)
  set gpsConnected($2.BoolState value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasGpsConnected() => $_has(2);
  @$pb.TagNumber(3)
  void clearGpsConnected() => $_clearField(3);

  @$pb.TagNumber(4)
  $2.BoolState get imuConnected => $_getN(3);
  @$pb.TagNumber(4)
  set imuConnected($2.BoolState value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasImuConnected() => $_has(3);
  @$pb.TagNumber(4)
  void clearImuConnected() => $_clearField(4);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
