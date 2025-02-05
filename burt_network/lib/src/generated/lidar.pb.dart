//
//  Generated code. Do not modify.
//  source: lidar.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'version.pb.dart' as $3;

class LidarCartesianPoint extends $pb.GeneratedMessage {
  factory LidarCartesianPoint({
    $core.double? x,
    $core.double? y,
  }) {
    final $result = create();
    if (x != null) {
      $result.x = x;
    }
    if (y != null) {
      $result.y = y;
    }
    return $result;
  }
  LidarCartesianPoint._() : super();
  factory LidarCartesianPoint.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LidarCartesianPoint.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LidarCartesianPoint', createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'x', $pb.PbFieldType.OF)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'y', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LidarCartesianPoint clone() => LidarCartesianPoint()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LidarCartesianPoint copyWith(void Function(LidarCartesianPoint) updates) => super.copyWith((message) => updates(message as LidarCartesianPoint)) as LidarCartesianPoint;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LidarCartesianPoint create() => LidarCartesianPoint._();
  LidarCartesianPoint createEmptyInstance() => create();
  static $pb.PbList<LidarCartesianPoint> createRepeated() => $pb.PbList<LidarCartesianPoint>();
  @$core.pragma('dart2js:noInline')
  static LidarCartesianPoint getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LidarCartesianPoint>(create);
  static LidarCartesianPoint? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get x => $_getN(0);
  @$pb.TagNumber(1)
  set x($core.double v) { $_setFloat(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasX() => $_has(0);
  @$pb.TagNumber(1)
  void clearX() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get y => $_getN(1);
  @$pb.TagNumber(2)
  set y($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasY() => $_has(1);
  @$pb.TagNumber(2)
  void clearY() => clearField(2);
}

class LidarPointCloud extends $pb.GeneratedMessage {
  factory LidarPointCloud({
    $core.Iterable<LidarCartesianPoint>? data,
    $3.Version? version,
  }) {
    final $result = create();
    if (data != null) {
      $result.data.addAll(data);
    }
    if (version != null) {
      $result.version = version;
    }
    return $result;
  }
  LidarPointCloud._() : super();
  factory LidarPointCloud.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LidarPointCloud.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LidarPointCloud', createEmptyInstance: create)
    ..pc<LidarCartesianPoint>(1, _omitFieldNames ? '' : 'data', $pb.PbFieldType.PM, subBuilder: LidarCartesianPoint.create)
    ..aOM<$3.Version>(2, _omitFieldNames ? '' : 'version', subBuilder: $3.Version.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LidarPointCloud clone() => LidarPointCloud()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LidarPointCloud copyWith(void Function(LidarPointCloud) updates) => super.copyWith((message) => updates(message as LidarPointCloud)) as LidarPointCloud;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LidarPointCloud create() => LidarPointCloud._();
  LidarPointCloud createEmptyInstance() => create();
  static $pb.PbList<LidarPointCloud> createRepeated() => $pb.PbList<LidarPointCloud>();
  @$core.pragma('dart2js:noInline')
  static LidarPointCloud getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LidarPointCloud>(create);
  static LidarPointCloud? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<LidarCartesianPoint> get data => $_getList(0);

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


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
