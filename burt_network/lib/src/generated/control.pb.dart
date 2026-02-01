// This is a generated file - do not edit.
//
// Generated from control.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'drive.pb.dart' as $1;
import 'relays.pb.dart' as $2;
import 'version.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class ControlCommand extends $pb.GeneratedMessage {
  factory ControlCommand({
    $0.Version? version,
    $1.DriveCommand? drive,
    $2.RelaysCommand? relays,
  }) {
    final result = create();
    if (version != null) result.version = version;
    if (drive != null) result.drive = drive;
    if (relays != null) result.relays = relays;
    return result;
  }

  ControlCommand._();

  factory ControlCommand.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ControlCommand.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ControlCommand',
      createEmptyInstance: create)
    ..aOM<$0.Version>(1, _omitFieldNames ? '' : 'version',
        subBuilder: $0.Version.create)
    ..aOM<$1.DriveCommand>(2, _omitFieldNames ? '' : 'drive',
        subBuilder: $1.DriveCommand.create)
    ..aOM<$2.RelaysCommand>(3, _omitFieldNames ? '' : 'relays',
        subBuilder: $2.RelaysCommand.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ControlCommand clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ControlCommand copyWith(void Function(ControlCommand) updates) =>
      super.copyWith((message) => updates(message as ControlCommand))
          as ControlCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ControlCommand create() => ControlCommand._();
  @$core.override
  ControlCommand createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ControlCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ControlCommand>(create);
  static ControlCommand? _defaultInstance;

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
  $1.DriveCommand get drive => $_getN(1);
  @$pb.TagNumber(2)
  set drive($1.DriveCommand value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasDrive() => $_has(1);
  @$pb.TagNumber(2)
  void clearDrive() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.DriveCommand ensureDrive() => $_ensure(1);

  @$pb.TagNumber(3)
  $2.RelaysCommand get relays => $_getN(2);
  @$pb.TagNumber(3)
  set relays($2.RelaysCommand value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasRelays() => $_has(2);
  @$pb.TagNumber(3)
  void clearRelays() => $_clearField(3);
  @$pb.TagNumber(3)
  $2.RelaysCommand ensureRelays() => $_ensure(2);
}

class ControlData extends $pb.GeneratedMessage {
  factory ControlData({
    $0.Version? version,
    $1.DriveData? drive,
    $2.RelaysData? relays,
  }) {
    final result = create();
    if (version != null) result.version = version;
    if (drive != null) result.drive = drive;
    if (relays != null) result.relays = relays;
    return result;
  }

  ControlData._();

  factory ControlData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ControlData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ControlData',
      createEmptyInstance: create)
    ..aOM<$0.Version>(1, _omitFieldNames ? '' : 'version',
        subBuilder: $0.Version.create)
    ..aOM<$1.DriveData>(2, _omitFieldNames ? '' : 'drive',
        subBuilder: $1.DriveData.create)
    ..aOM<$2.RelaysData>(3, _omitFieldNames ? '' : 'relays',
        subBuilder: $2.RelaysData.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ControlData clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ControlData copyWith(void Function(ControlData) updates) =>
      super.copyWith((message) => updates(message as ControlData))
          as ControlData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ControlData create() => ControlData._();
  @$core.override
  ControlData createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ControlData getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ControlData>(create);
  static ControlData? _defaultInstance;

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
  $1.DriveData get drive => $_getN(1);
  @$pb.TagNumber(2)
  set drive($1.DriveData value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasDrive() => $_has(1);
  @$pb.TagNumber(2)
  void clearDrive() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.DriveData ensureDrive() => $_ensure(1);

  @$pb.TagNumber(3)
  $2.RelaysData get relays => $_getN(2);
  @$pb.TagNumber(3)
  set relays($2.RelaysData value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasRelays() => $_has(2);
  @$pb.TagNumber(3)
  void clearRelays() => $_clearField(3);
  @$pb.TagNumber(3)
  $2.RelaysData ensureRelays() => $_ensure(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
