//
//  Generated code. Do not modify.
//  source: status.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'status.pbenum.dart';

export 'status.pbenum.dart';

class UpdateSetting extends $pb.GeneratedMessage {
  factory UpdateSetting() => create();
  UpdateSetting._() : super();
  factory UpdateSetting.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateSetting.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateSetting', createEmptyInstance: create)
    ..e<RoverStatus>(1, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: RoverStatus.DISCONNECTED, valueOf: RoverStatus.valueOf, enumValues: RoverStatus.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateSetting clone() => UpdateSetting()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateSetting copyWith(void Function(UpdateSetting) updates) => super.copyWith((message) => updates(message as UpdateSetting)) as UpdateSetting;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateSetting create() => UpdateSetting._();
  UpdateSetting createEmptyInstance() => create();
  static $pb.PbList<UpdateSetting> createRepeated() => $pb.PbList<UpdateSetting>();
  @$core.pragma('dart2js:noInline')
  static UpdateSetting getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateSetting>(create);
  static UpdateSetting? _defaultInstance;

  @$pb.TagNumber(1)
  RoverStatus get status => $_getN(0);
  @$pb.TagNumber(1)
  set status(RoverStatus v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
