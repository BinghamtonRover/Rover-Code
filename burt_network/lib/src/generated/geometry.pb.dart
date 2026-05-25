// This is a generated file - do not edit.
//
// Generated from geometry.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class Translation3d extends $pb.GeneratedMessage {
  factory Translation3d({
    $core.double? x,
    $core.double? y,
    $core.double? z,
  }) {
    final result = create();
    if (x != null) result.x = x;
    if (y != null) result.y = y;
    if (z != null) result.z = z;
    return result;
  }

  Translation3d._();

  factory Translation3d.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Translation3d.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Translation3d',
      createEmptyInstance: create)
    ..aD(1, _omitFieldNames ? '' : 'x', fieldType: $pb.PbFieldType.OF)
    ..aD(2, _omitFieldNames ? '' : 'y', fieldType: $pb.PbFieldType.OF)
    ..aD(3, _omitFieldNames ? '' : 'z', fieldType: $pb.PbFieldType.OF)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Translation3d clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Translation3d copyWith(void Function(Translation3d) updates) =>
      super.copyWith((message) => updates(message as Translation3d))
          as Translation3d;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Translation3d create() => Translation3d._();
  @$core.override
  Translation3d createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Translation3d getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Translation3d>(create);
  static Translation3d? _defaultInstance;

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

  @$pb.TagNumber(3)
  $core.double get z => $_getN(2);
  @$pb.TagNumber(3)
  set z($core.double value) => $_setFloat(2, value);
  @$pb.TagNumber(3)
  $core.bool hasZ() => $_has(2);
  @$pb.TagNumber(3)
  void clearZ() => $_clearField(3);
}

class Rotation3d extends $pb.GeneratedMessage {
  factory Rotation3d({
    $core.double? pitch,
    $core.double? roll,
    $core.double? yaw,
  }) {
    final result = create();
    if (pitch != null) result.pitch = pitch;
    if (roll != null) result.roll = roll;
    if (yaw != null) result.yaw = yaw;
    return result;
  }

  Rotation3d._();

  factory Rotation3d.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Rotation3d.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Rotation3d',
      createEmptyInstance: create)
    ..aD(1, _omitFieldNames ? '' : 'pitch', fieldType: $pb.PbFieldType.OF)
    ..aD(2, _omitFieldNames ? '' : 'roll', fieldType: $pb.PbFieldType.OF)
    ..aD(3, _omitFieldNames ? '' : 'yaw', fieldType: $pb.PbFieldType.OF)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Rotation3d clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Rotation3d copyWith(void Function(Rotation3d) updates) =>
      super.copyWith((message) => updates(message as Rotation3d)) as Rotation3d;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Rotation3d create() => Rotation3d._();
  @$core.override
  Rotation3d createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Rotation3d getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Rotation3d>(create);
  static Rotation3d? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get pitch => $_getN(0);
  @$pb.TagNumber(1)
  set pitch($core.double value) => $_setFloat(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPitch() => $_has(0);
  @$pb.TagNumber(1)
  void clearPitch() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get roll => $_getN(1);
  @$pb.TagNumber(2)
  set roll($core.double value) => $_setFloat(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRoll() => $_has(1);
  @$pb.TagNumber(2)
  void clearRoll() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get yaw => $_getN(2);
  @$pb.TagNumber(3)
  set yaw($core.double value) => $_setFloat(2, value);
  @$pb.TagNumber(3)
  $core.bool hasYaw() => $_has(2);
  @$pb.TagNumber(3)
  void clearYaw() => $_clearField(3);
}

class Pose3d extends $pb.GeneratedMessage {
  factory Pose3d({
    Translation3d? translation,
    Rotation3d? rotation,
  }) {
    final result = create();
    if (translation != null) result.translation = translation;
    if (rotation != null) result.rotation = rotation;
    return result;
  }

  Pose3d._();

  factory Pose3d.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Pose3d.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Pose3d',
      createEmptyInstance: create)
    ..aOM<Translation3d>(1, _omitFieldNames ? '' : 'translation',
        subBuilder: Translation3d.create)
    ..aOM<Rotation3d>(2, _omitFieldNames ? '' : 'rotation',
        subBuilder: Rotation3d.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Pose3d clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Pose3d copyWith(void Function(Pose3d) updates) =>
      super.copyWith((message) => updates(message as Pose3d)) as Pose3d;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Pose3d create() => Pose3d._();
  @$core.override
  Pose3d createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Pose3d getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Pose3d>(create);
  static Pose3d? _defaultInstance;

  @$pb.TagNumber(1)
  Translation3d get translation => $_getN(0);
  @$pb.TagNumber(1)
  set translation(Translation3d value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTranslation() => $_has(0);
  @$pb.TagNumber(1)
  void clearTranslation() => $_clearField(1);
  @$pb.TagNumber(1)
  Translation3d ensureTranslation() => $_ensure(0);

  @$pb.TagNumber(2)
  Rotation3d get rotation => $_getN(1);
  @$pb.TagNumber(2)
  set rotation(Rotation3d value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasRotation() => $_has(1);
  @$pb.TagNumber(2)
  void clearRotation() => $_clearField(2);
  @$pb.TagNumber(2)
  Rotation3d ensureRotation() => $_ensure(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
