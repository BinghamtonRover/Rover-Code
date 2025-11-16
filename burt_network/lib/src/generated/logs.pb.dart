// This is a generated file - do not edit.
//
// Generated from logs.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'core.pbenum.dart' as $0;
import 'logs.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'logs.pbenum.dart';

class BurtLog extends $pb.GeneratedMessage {
  factory BurtLog({
    BurtLogLevel? level,
    $core.String? title,
    $core.String? body,
    $0.Device? device,
  }) {
    final result = create();
    if (level != null) result.level = level;
    if (title != null) result.title = title;
    if (body != null) result.body = body;
    if (device != null) result.device = device;
    return result;
  }

  BurtLog._();

  factory BurtLog.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BurtLog.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BurtLog',
      createEmptyInstance: create)
    ..aE<BurtLogLevel>(1, _omitFieldNames ? '' : 'level',
        enumValues: BurtLogLevel.values)
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'body')
    ..aE<$0.Device>(4, _omitFieldNames ? '' : 'device',
        enumValues: $0.Device.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BurtLog clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BurtLog copyWith(void Function(BurtLog) updates) =>
      super.copyWith((message) => updates(message as BurtLog)) as BurtLog;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BurtLog create() => BurtLog._();
  @$core.override
  BurtLog createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BurtLog getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BurtLog>(create);
  static BurtLog? _defaultInstance;

  @$pb.TagNumber(1)
  BurtLogLevel get level => $_getN(0);
  @$pb.TagNumber(1)
  set level(BurtLogLevel value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasLevel() => $_has(0);
  @$pb.TagNumber(1)
  void clearLevel() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get body => $_getSZ(2);
  @$pb.TagNumber(3)
  set body($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBody() => $_has(2);
  @$pb.TagNumber(3)
  void clearBody() => $_clearField(3);

  @$pb.TagNumber(4)
  $0.Device get device => $_getN(3);
  @$pb.TagNumber(4)
  set device($0.Device value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasDevice() => $_has(3);
  @$pb.TagNumber(4)
  void clearDevice() => $_clearField(4);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
