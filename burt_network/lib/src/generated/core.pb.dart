// This is a generated file - do not edit.
//
// Generated from core.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'core.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'core.pbenum.dart';

/// Used for a simple handshake between devices.
class Connect extends $pb.GeneratedMessage {
  factory Connect({
    Device? sender,
    Device? receiver,
  }) {
    final result = create();
    if (sender != null) result.sender = sender;
    if (receiver != null) result.receiver = receiver;
    return result;
  }

  Connect._();

  factory Connect.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Connect.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Connect',
      createEmptyInstance: create)
    ..aE<Device>(1, _omitFieldNames ? '' : 'sender', enumValues: Device.values)
    ..aE<Device>(2, _omitFieldNames ? '' : 'receiver',
        enumValues: Device.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Connect clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Connect copyWith(void Function(Connect) updates) =>
      super.copyWith((message) => updates(message as Connect)) as Connect;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Connect create() => Connect._();
  @$core.override
  Connect createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Connect getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Connect>(create);
  static Connect? _defaultInstance;

  @$pb.TagNumber(1)
  Device get sender => $_getN(0);
  @$pb.TagNumber(1)
  set sender(Device value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSender() => $_has(0);
  @$pb.TagNumber(1)
  void clearSender() => $_clearField(1);

  @$pb.TagNumber(2)
  Device get receiver => $_getN(1);
  @$pb.TagNumber(2)
  set receiver(Device value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasReceiver() => $_has(1);
  @$pb.TagNumber(2)
  void clearReceiver() => $_clearField(2);
}

/// Notifies the recipient that the sender will no longer be connected.
class Disconnect extends $pb.GeneratedMessage {
  factory Disconnect({
    Device? sender,
  }) {
    final result = create();
    if (sender != null) result.sender = sender;
    return result;
  }

  Disconnect._();

  factory Disconnect.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Disconnect.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Disconnect',
      createEmptyInstance: create)
    ..aE<Device>(1, _omitFieldNames ? '' : 'sender', enumValues: Device.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Disconnect clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Disconnect copyWith(void Function(Disconnect) updates) =>
      super.copyWith((message) => updates(message as Disconnect)) as Disconnect;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Disconnect create() => Disconnect._();
  @$core.override
  Disconnect createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Disconnect getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Disconnect>(create);
  static Disconnect? _defaultInstance;

  @$pb.TagNumber(1)
  Device get sender => $_getN(0);
  @$pb.TagNumber(1)
  set sender(Device value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSender() => $_has(0);
  @$pb.TagNumber(1)
  void clearSender() => $_clearField(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
