//
//  Generated code. Do not modify.
//  source: lidar.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'version.pb.dart' as $2;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

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

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LidarCartesianPoint clone() => LidarCartesianPoint()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
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
  void clearX() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get y => $_getN(1);
  @$pb.TagNumber(2)
  set y($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasY() => $_has(1);
  @$pb.TagNumber(2)
  void clearY() => $_clearField(2);
}

class LidarPolarPoint extends $pb.GeneratedMessage {
  factory LidarPolarPoint({
    $core.double? angle,
    $core.double? distance,
  }) {
    final $result = create();
    if (angle != null) {
      $result.angle = angle;
    }
    if (distance != null) {
      $result.distance = distance;
    }
    return $result;
  }
  LidarPolarPoint._() : super();
  factory LidarPolarPoint.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LidarPolarPoint.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LidarPolarPoint', createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'angle', $pb.PbFieldType.OF)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'distance', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LidarPolarPoint clone() => LidarPolarPoint()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LidarPolarPoint copyWith(void Function(LidarPolarPoint) updates) => super.copyWith((message) => updates(message as LidarPolarPoint)) as LidarPolarPoint;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LidarPolarPoint create() => LidarPolarPoint._();
  LidarPolarPoint createEmptyInstance() => create();
  static $pb.PbList<LidarPolarPoint> createRepeated() => $pb.PbList<LidarPolarPoint>();
  @$core.pragma('dart2js:noInline')
  static LidarPolarPoint getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LidarPolarPoint>(create);
  static LidarPolarPoint? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get angle => $_getN(0);
  @$pb.TagNumber(1)
  set angle($core.double v) { $_setFloat(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAngle() => $_has(0);
  @$pb.TagNumber(1)
  void clearAngle() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get distance => $_getN(1);
  @$pb.TagNumber(2)
  set distance($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDistance() => $_has(1);
  @$pb.TagNumber(2)
  void clearDistance() => $_clearField(2);
}

class LidarPointCloud extends $pb.GeneratedMessage {
  factory LidarPointCloud({
    $core.Iterable<LidarCartesianPoint>? cartesian,
    $core.Iterable<LidarPolarPoint>? polar,
    $2.Version? version,
  }) {
    final $result = create();
    if (cartesian != null) {
      $result.cartesian.addAll(cartesian);
    }
    if (polar != null) {
      $result.polar.addAll(polar);
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
    ..pc<LidarCartesianPoint>(1, _omitFieldNames ? '' : 'cartesian', $pb.PbFieldType.PM, subBuilder: LidarCartesianPoint.create)
    ..pc<LidarPolarPoint>(2, _omitFieldNames ? '' : 'polar', $pb.PbFieldType.PM, subBuilder: LidarPolarPoint.create)
    ..aOM<$2.Version>(3, _omitFieldNames ? '' : 'version', subBuilder: $2.Version.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LidarPointCloud clone() => LidarPointCloud()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
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
  $pb.PbList<LidarCartesianPoint> get cartesian => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<LidarPolarPoint> get polar => $_getList(1);

  @$pb.TagNumber(3)
  $2.Version get version => $_getN(2);
  @$pb.TagNumber(3)
  set version($2.Version v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearVersion() => $_clearField(3);
  @$pb.TagNumber(3)
  $2.Version ensureVersion() => $_ensure(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
