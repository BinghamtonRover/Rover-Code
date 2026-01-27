// This is a generated file - do not edit.
//
// Generated from status.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'status.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'status.pbenum.dart';

/// / Update a sensitive setting, such as the rover's status.
/// /
/// / This message must be triggered manually and the recipient (usually the subsystems Pi)
/// / must respond with the exact same message to confirm its receipt.
class UpdateSetting extends $pb.GeneratedMessage {
  factory UpdateSetting({
    RoverStatus? status,
  }) {
    final result = create();
    if (status != null) result.status = status;
    return result;
  }

  UpdateSetting._();

  factory UpdateSetting.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateSetting.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateSetting',
      createEmptyInstance: create)
    ..aE<RoverStatus>(1, _omitFieldNames ? '' : 'status',
        enumValues: RoverStatus.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateSetting clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateSetting copyWith(void Function(UpdateSetting) updates) =>
      super.copyWith((message) => updates(message as UpdateSetting))
          as UpdateSetting;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateSetting create() => UpdateSetting._();
  @$core.override
  UpdateSetting createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateSetting getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateSetting>(create);
  static UpdateSetting? _defaultInstance;

  @$pb.TagNumber(1)
  RoverStatus get status => $_getN(0);
  @$pb.TagNumber(1)
  set status(RoverStatus value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
