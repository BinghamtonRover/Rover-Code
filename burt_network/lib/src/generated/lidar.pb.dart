// This is a generated file - do not edit.
//
// Generated from lidar.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'version.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class LidarCartesianPoint extends $pb.GeneratedMessage {
  factory LidarCartesianPoint({
    $core.double? x,
    $core.double? y,
  }) {
    final result = create();
    if (x != null) result.x = x;
    if (y != null) result.y = y;
    return result;
  }

  LidarCartesianPoint._();

  factory LidarCartesianPoint.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LidarCartesianPoint.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LidarCartesianPoint',
      createEmptyInstance: create)
    ..aD(1, _omitFieldNames ? '' : 'x', fieldType: $pb.PbFieldType.OF)
    ..aD(2, _omitFieldNames ? '' : 'y', fieldType: $pb.PbFieldType.OF)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LidarCartesianPoint clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LidarCartesianPoint copyWith(void Function(LidarCartesianPoint) updates) =>
      super.copyWith((message) => updates(message as LidarCartesianPoint))
          as LidarCartesianPoint;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LidarCartesianPoint create() => LidarCartesianPoint._();
  @$core.override
  LidarCartesianPoint createEmptyInstance() => create();
  static $pb.PbList<LidarCartesianPoint> createRepeated() =>
      $pb.PbList<LidarCartesianPoint>();
  @$core.pragma('dart2js:noInline')
  static LidarCartesianPoint getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LidarCartesianPoint>(create);
  static LidarCartesianPoint? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get x => $_getN(0);
  @$pb.TagNumber(1)
  set x($core.double value) => $_setFloat(0, value);
  @$pb.TagNumber(1)
  $core.bool hasX() => $_has(0);
  @$pb.TagNumber(1)
  void clearX() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get y => $_getN(1);
  @$pb.TagNumber(2)
  set y($core.double value) => $_setFloat(1, value);
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
    final result = create();
    if (angle != null) result.angle = angle;
    if (distance != null) result.distance = distance;
    return result;
  }

  LidarPolarPoint._();

  factory LidarPolarPoint.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LidarPolarPoint.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LidarPolarPoint',
      createEmptyInstance: create)
    ..aD(1, _omitFieldNames ? '' : 'angle', fieldType: $pb.PbFieldType.OF)
    ..aD(2, _omitFieldNames ? '' : 'distance', fieldType: $pb.PbFieldType.OF)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LidarPolarPoint clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LidarPolarPoint copyWith(void Function(LidarPolarPoint) updates) =>
      super.copyWith((message) => updates(message as LidarPolarPoint))
          as LidarPolarPoint;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LidarPolarPoint create() => LidarPolarPoint._();
  @$core.override
  LidarPolarPoint createEmptyInstance() => create();
  static $pb.PbList<LidarPolarPoint> createRepeated() =>
      $pb.PbList<LidarPolarPoint>();
  @$core.pragma('dart2js:noInline')
  static LidarPolarPoint getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LidarPolarPoint>(create);
  static LidarPolarPoint? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get angle => $_getN(0);
  @$pb.TagNumber(1)
  set angle($core.double value) => $_setFloat(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAngle() => $_has(0);
  @$pb.TagNumber(1)
  void clearAngle() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get distance => $_getN(1);
  @$pb.TagNumber(2)
  set distance($core.double value) => $_setFloat(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDistance() => $_has(1);
  @$pb.TagNumber(2)
  void clearDistance() => $_clearField(2);
}

class LidarPointCloud extends $pb.GeneratedMessage {
  factory LidarPointCloud({
    $core.Iterable<LidarCartesianPoint>? cartesian,
    $core.Iterable<LidarPolarPoint>? polar,
    $0.Version? version,
  }) {
    final result = create();
    if (cartesian != null) result.cartesian.addAll(cartesian);
    if (polar != null) result.polar.addAll(polar);
    if (version != null) result.version = version;
    return result;
  }

  LidarPointCloud._();

  factory LidarPointCloud.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LidarPointCloud.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LidarPointCloud',
      createEmptyInstance: create)
    ..pPM<LidarCartesianPoint>(1, _omitFieldNames ? '' : 'cartesian',
        subBuilder: LidarCartesianPoint.create)
    ..pPM<LidarPolarPoint>(2, _omitFieldNames ? '' : 'polar',
        subBuilder: LidarPolarPoint.create)
    ..aOM<$0.Version>(3, _omitFieldNames ? '' : 'version',
        subBuilder: $0.Version.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LidarPointCloud clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LidarPointCloud copyWith(void Function(LidarPointCloud) updates) =>
      super.copyWith((message) => updates(message as LidarPointCloud))
          as LidarPointCloud;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LidarPointCloud create() => LidarPointCloud._();
  @$core.override
  LidarPointCloud createEmptyInstance() => create();
  static $pb.PbList<LidarPointCloud> createRepeated() =>
      $pb.PbList<LidarPointCloud>();
  @$core.pragma('dart2js:noInline')
  static LidarPointCloud getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LidarPointCloud>(create);
  static LidarPointCloud? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<LidarCartesianPoint> get cartesian => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<LidarPolarPoint> get polar => $_getList(1);

  @$pb.TagNumber(3)
  $0.Version get version => $_getN(2);
  @$pb.TagNumber(3)
  set version($0.Version value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearVersion() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.Version ensureVersion() => $_ensure(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
