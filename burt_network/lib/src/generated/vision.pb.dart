// This is a generated file - do not edit.
//
// Generated from vision.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'geometry.pb.dart' as $0;
import 'vision.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'vision.pbenum.dart';

class PnpResult extends $pb.GeneratedMessage {
  factory PnpResult({
    $0.Pose3d? cameraToTarget,
    $core.double? reprojectionError,
  }) {
    final result = create();
    if (cameraToTarget != null) result.cameraToTarget = cameraToTarget;
    if (reprojectionError != null) result.reprojectionError = reprojectionError;
    return result;
  }

  PnpResult._();

  factory PnpResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PnpResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PnpResult',
      createEmptyInstance: create)
    ..aOM<$0.Pose3d>(1, _omitFieldNames ? '' : 'cameraToTarget',
        protoName: 'cameraToTarget', subBuilder: $0.Pose3d.create)
    ..aD(2, _omitFieldNames ? '' : 'reprojectionError',
        protoName: 'reprojectionError')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PnpResult clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PnpResult copyWith(void Function(PnpResult) updates) =>
      super.copyWith((message) => updates(message as PnpResult)) as PnpResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PnpResult create() => PnpResult._();
  @$core.override
  PnpResult createEmptyInstance() => create();
  static $pb.PbList<PnpResult> createRepeated() => $pb.PbList<PnpResult>();
  @$core.pragma('dart2js:noInline')
  static PnpResult getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PnpResult>(create);
  static PnpResult? _defaultInstance;

  @$pb.TagNumber(1)
  $0.Pose3d get cameraToTarget => $_getN(0);
  @$pb.TagNumber(1)
  set cameraToTarget($0.Pose3d value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCameraToTarget() => $_has(0);
  @$pb.TagNumber(1)
  void clearCameraToTarget() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.Pose3d ensureCameraToTarget() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get reprojectionError => $_getN(1);
  @$pb.TagNumber(2)
  set reprojectionError($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReprojectionError() => $_has(1);
  @$pb.TagNumber(2)
  void clearReprojectionError() => $_clearField(2);
}

class DetectedObject extends $pb.GeneratedMessage {
  factory DetectedObject({
    DetectedObjectType? objectType,
    $core.int? arucoTagId,
    $core.double? xPosition,
    $core.double? relativeSize,
    $core.int? centerX,
    $core.int? centerY,
    $core.double? yaw,
    $core.double? pitch,
    PnpResult? bestPnpResult,
    PnpResult? alternatePnpResult,
  }) {
    final result = create();
    if (objectType != null) result.objectType = objectType;
    if (arucoTagId != null) result.arucoTagId = arucoTagId;
    if (xPosition != null) result.xPosition = xPosition;
    if (relativeSize != null) result.relativeSize = relativeSize;
    if (centerX != null) result.centerX = centerX;
    if (centerY != null) result.centerY = centerY;
    if (yaw != null) result.yaw = yaw;
    if (pitch != null) result.pitch = pitch;
    if (bestPnpResult != null) result.bestPnpResult = bestPnpResult;
    if (alternatePnpResult != null)
      result.alternatePnpResult = alternatePnpResult;
    return result;
  }

  DetectedObject._();

  factory DetectedObject.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DetectedObject.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DetectedObject',
      createEmptyInstance: create)
    ..aE<DetectedObjectType>(1, _omitFieldNames ? '' : 'objectType',
        protoName: 'objectType', enumValues: DetectedObjectType.values)
    ..aI(2, _omitFieldNames ? '' : 'arucoTagId', protoName: 'arucoTagId')
    ..aD(4, _omitFieldNames ? '' : 'xPosition',
        protoName: 'xPosition', fieldType: $pb.PbFieldType.OF)
    ..aD(5, _omitFieldNames ? '' : 'relativeSize',
        protoName: 'relativeSize', fieldType: $pb.PbFieldType.OF)
    ..aI(6, _omitFieldNames ? '' : 'centerX', protoName: 'centerX')
    ..aI(7, _omitFieldNames ? '' : 'centerY', protoName: 'centerY')
    ..aD(8, _omitFieldNames ? '' : 'yaw', fieldType: $pb.PbFieldType.OF)
    ..aD(9, _omitFieldNames ? '' : 'pitch', fieldType: $pb.PbFieldType.OF)
    ..aOM<PnpResult>(10, _omitFieldNames ? '' : 'bestPnpResult',
        protoName: 'bestPnpResult', subBuilder: PnpResult.create)
    ..aOM<PnpResult>(11, _omitFieldNames ? '' : 'alternatePnpResult',
        protoName: 'alternatePnpResult', subBuilder: PnpResult.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DetectedObject clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DetectedObject copyWith(void Function(DetectedObject) updates) =>
      super.copyWith((message) => updates(message as DetectedObject))
          as DetectedObject;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DetectedObject create() => DetectedObject._();
  @$core.override
  DetectedObject createEmptyInstance() => create();
  static $pb.PbList<DetectedObject> createRepeated() =>
      $pb.PbList<DetectedObject>();
  @$core.pragma('dart2js:noInline')
  static DetectedObject getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DetectedObject>(create);
  static DetectedObject? _defaultInstance;

  /// What was detected
  @$pb.TagNumber(1)
  DetectedObjectType get objectType => $_getN(0);
  @$pb.TagNumber(1)
  set objectType(DetectedObjectType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasObjectType() => $_has(0);
  @$pb.TagNumber(1)
  void clearObjectType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get arucoTagId => $_getIZ(1);
  @$pb.TagNumber(2)
  set arucoTagId($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasArucoTagId() => $_has(1);
  @$pb.TagNumber(2)
  void clearArucoTagId() => $_clearField(2);

  /// Where it was detected
  @$pb.TagNumber(4)
  $core.double get xPosition => $_getN(2);
  @$pb.TagNumber(4)
  set xPosition($core.double value) => $_setFloat(2, value);
  @$pb.TagNumber(4)
  $core.bool hasXPosition() => $_has(2);
  @$pb.TagNumber(4)
  void clearXPosition() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get relativeSize => $_getN(3);
  @$pb.TagNumber(5)
  set relativeSize($core.double value) => $_setFloat(3, value);
  @$pb.TagNumber(5)
  $core.bool hasRelativeSize() => $_has(3);
  @$pb.TagNumber(5)
  void clearRelativeSize() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get centerX => $_getIZ(4);
  @$pb.TagNumber(6)
  set centerX($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(6)
  $core.bool hasCenterX() => $_has(4);
  @$pb.TagNumber(6)
  void clearCenterX() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get centerY => $_getIZ(5);
  @$pb.TagNumber(7)
  set centerY($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(7)
  $core.bool hasCenterY() => $_has(5);
  @$pb.TagNumber(7)
  void clearCenterY() => $_clearField(7);

  /// Experimental: Use pinhole camera model to find the object's position
  @$pb.TagNumber(8)
  $core.double get yaw => $_getN(6);
  @$pb.TagNumber(8)
  set yaw($core.double value) => $_setFloat(6, value);
  @$pb.TagNumber(8)
  $core.bool hasYaw() => $_has(6);
  @$pb.TagNumber(8)
  void clearYaw() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.double get pitch => $_getN(7);
  @$pb.TagNumber(9)
  set pitch($core.double value) => $_setFloat(7, value);
  @$pb.TagNumber(9)
  $core.bool hasPitch() => $_has(7);
  @$pb.TagNumber(9)
  void clearPitch() => $_clearField(9);

  /// Experimental: Use PnP to determine the 3D pose
  @$pb.TagNumber(10)
  PnpResult get bestPnpResult => $_getN(8);
  @$pb.TagNumber(10)
  set bestPnpResult(PnpResult value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasBestPnpResult() => $_has(8);
  @$pb.TagNumber(10)
  void clearBestPnpResult() => $_clearField(10);
  @$pb.TagNumber(10)
  PnpResult ensureBestPnpResult() => $_ensure(8);

  @$pb.TagNumber(11)
  PnpResult get alternatePnpResult => $_getN(9);
  @$pb.TagNumber(11)
  set alternatePnpResult(PnpResult value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasAlternatePnpResult() => $_has(9);
  @$pb.TagNumber(11)
  void clearAlternatePnpResult() => $_clearField(11);
  @$pb.TagNumber(11)
  PnpResult ensureAlternatePnpResult() => $_ensure(9);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
