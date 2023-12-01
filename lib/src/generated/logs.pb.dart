//
//  Generated code. Do not modify.
//  source: logs.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'logs.pbenum.dart';

export 'logs.pbenum.dart';

class BurtLog extends $pb.GeneratedMessage {
  factory BurtLog({
    BurtLogLevel? level,
    $core.String? body,
    $core.String? title,
  }) {
    final $result = create();
    if (level != null) {
      $result.level = level;
    }
    if (body != null) {
      $result.body = body;
    }
    if (title != null) {
      $result.title = title;
    }
    return $result;
  }
  BurtLog._() : super();
  factory BurtLog.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BurtLog.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BurtLog', createEmptyInstance: create)
    ..e<BurtLogLevel>(1, _omitFieldNames ? '' : 'level', $pb.PbFieldType.OE, defaultOrMaker: BurtLogLevel.BURT_LOG_LEVEL_UNDEFINED, valueOf: BurtLogLevel.valueOf, enumValues: BurtLogLevel.values)
    ..aOS(2, _omitFieldNames ? '' : 'body')
    ..aOS(3, _omitFieldNames ? '' : 'title')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BurtLog clone() => BurtLog()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BurtLog copyWith(void Function(BurtLog) updates) => super.copyWith((message) => updates(message as BurtLog)) as BurtLog;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BurtLog create() => BurtLog._();
  BurtLog createEmptyInstance() => create();
  static $pb.PbList<BurtLog> createRepeated() => $pb.PbList<BurtLog>();
  @$core.pragma('dart2js:noInline')
  static BurtLog getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BurtLog>(create);
  static BurtLog? _defaultInstance;

  @$pb.TagNumber(1)
  BurtLogLevel get level => $_getN(0);
  @$pb.TagNumber(1)
  set level(BurtLogLevel v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasLevel() => $_has(0);
  @$pb.TagNumber(1)
  void clearLevel() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get body => $_getSZ(1);
  @$pb.TagNumber(2)
  set body($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBody() => $_has(1);
  @$pb.TagNumber(2)
  void clearBody() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get title => $_getSZ(2);
  @$pb.TagNumber(3)
  set title($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTitle() => $_has(2);
  @$pb.TagNumber(3)
  void clearTitle() => clearField(3);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
