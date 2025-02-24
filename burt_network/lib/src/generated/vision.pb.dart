//
//  Generated code. Do not modify.
//  source: vision.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'geometry.pb.dart' as $1;
import 'vision.pbenum.dart';

export 'vision.pbenum.dart';

class PnpResult extends $pb.GeneratedMessage {
  factory PnpResult({
    $1.Pose3d? cameraToTarget,
    $core.double? reprojectionError,
  }) {
    final $result = create();
    if (cameraToTarget != null) {
      $result.cameraToTarget = cameraToTarget;
    }
    if (reprojectionError != null) {
      $result.reprojectionError = reprojectionError;
    }
    return $result;
  }
  PnpResult._() : super();
  factory PnpResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PnpResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PnpResult', createEmptyInstance: create)
    ..aOM<$1.Pose3d>(1, _omitFieldNames ? '' : 'cameraToTarget', protoName: 'cameraToTarget', subBuilder: $1.Pose3d.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'reprojectionError', $pb.PbFieldType.OD, protoName: 'reprojectionError')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PnpResult clone() => PnpResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PnpResult copyWith(void Function(PnpResult) updates) => super.copyWith((message) => updates(message as PnpResult)) as PnpResult;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PnpResult create() => PnpResult._();
  PnpResult createEmptyInstance() => create();
  static $pb.PbList<PnpResult> createRepeated() => $pb.PbList<PnpResult>();
  @$core.pragma('dart2js:noInline')
  static PnpResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PnpResult>(create);
  static PnpResult? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Pose3d get cameraToTarget => $_getN(0);
  @$pb.TagNumber(1)
  set cameraToTarget($1.Pose3d v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCameraToTarget() => $_has(0);
  @$pb.TagNumber(1)
  void clearCameraToTarget() => clearField(1);
  @$pb.TagNumber(1)
  $1.Pose3d ensureCameraToTarget() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get reprojectionError => $_getN(1);
  @$pb.TagNumber(2)
  set reprojectionError($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReprojectionError() => $_has(1);
  @$pb.TagNumber(2)
  void clearReprojectionError() => clearField(2);
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
    final $result = create();
    if (objectType != null) {
      $result.objectType = objectType;
    }
    if (arucoTagId != null) {
      $result.arucoTagId = arucoTagId;
    }
    if (xPosition != null) {
      $result.xPosition = xPosition;
    }
    if (relativeSize != null) {
      $result.relativeSize = relativeSize;
    }
    if (centerX != null) {
      $result.centerX = centerX;
    }
    if (centerY != null) {
      $result.centerY = centerY;
    }
    if (yaw != null) {
      $result.yaw = yaw;
    }
    if (pitch != null) {
      $result.pitch = pitch;
    }
    if (bestPnpResult != null) {
      $result.bestPnpResult = bestPnpResult;
    }
    if (alternatePnpResult != null) {
      $result.alternatePnpResult = alternatePnpResult;
    }
    return $result;
  }
  DetectedObject._() : super();
  factory DetectedObject.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DetectedObject.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DetectedObject', createEmptyInstance: create)
    ..e<DetectedObjectType>(1, _omitFieldNames ? '' : 'objectType', $pb.PbFieldType.OE, protoName: 'objectType', defaultOrMaker: DetectedObjectType.DETECTION_TYPE_UNDEFINED, valueOf: DetectedObjectType.valueOf, enumValues: DetectedObjectType.values)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'arucoTagId', $pb.PbFieldType.O3, protoName: 'arucoTagId')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'xPosition', $pb.PbFieldType.OF, protoName: 'xPosition')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'relativeSize', $pb.PbFieldType.OF, protoName: 'relativeSize')
    ..a<$core.int>(6, _omitFieldNames ? '' : 'centerX', $pb.PbFieldType.O3, protoName: 'centerX')
    ..a<$core.int>(7, _omitFieldNames ? '' : 'centerY', $pb.PbFieldType.O3, protoName: 'centerY')
    ..a<$core.double>(8, _omitFieldNames ? '' : 'yaw', $pb.PbFieldType.OF)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'pitch', $pb.PbFieldType.OF)
    ..aOM<PnpResult>(10, _omitFieldNames ? '' : 'bestPnpResult', protoName: 'bestPnpResult', subBuilder: PnpResult.create)
    ..aOM<PnpResult>(11, _omitFieldNames ? '' : 'alternatePnpResult', protoName: 'alternatePnpResult', subBuilder: PnpResult.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DetectedObject clone() => DetectedObject()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DetectedObject copyWith(void Function(DetectedObject) updates) => super.copyWith((message) => updates(message as DetectedObject)) as DetectedObject;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DetectedObject create() => DetectedObject._();
  DetectedObject createEmptyInstance() => create();
  static $pb.PbList<DetectedObject> createRepeated() => $pb.PbList<DetectedObject>();
  @$core.pragma('dart2js:noInline')
  static DetectedObject getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DetectedObject>(create);
  static DetectedObject? _defaultInstance;

  /// What was detected
  @$pb.TagNumber(1)
  DetectedObjectType get objectType => $_getN(0);
  @$pb.TagNumber(1)
  set objectType(DetectedObjectType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasObjectType() => $_has(0);
  @$pb.TagNumber(1)
  void clearObjectType() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get arucoTagId => $_getIZ(1);
  @$pb.TagNumber(2)
  set arucoTagId($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasArucoTagId() => $_has(1);
  @$pb.TagNumber(2)
  void clearArucoTagId() => clearField(2);

  /// Where it was detected
  @$pb.TagNumber(4)
  $core.double get xPosition => $_getN(2);
  @$pb.TagNumber(4)
  set xPosition($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasXPosition() => $_has(2);
  @$pb.TagNumber(4)
  void clearXPosition() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get relativeSize => $_getN(3);
  @$pb.TagNumber(5)
  set relativeSize($core.double v) { $_setFloat(3, v); }
  @$pb.TagNumber(5)
  $core.bool hasRelativeSize() => $_has(3);
  @$pb.TagNumber(5)
  void clearRelativeSize() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get centerX => $_getIZ(4);
  @$pb.TagNumber(6)
  set centerX($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(6)
  $core.bool hasCenterX() => $_has(4);
  @$pb.TagNumber(6)
  void clearCenterX() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get centerY => $_getIZ(5);
  @$pb.TagNumber(7)
  set centerY($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(7)
  $core.bool hasCenterY() => $_has(5);
  @$pb.TagNumber(7)
  void clearCenterY() => clearField(7);

  /// Experimental: Use pinhole camera model to find the object's position
  @$pb.TagNumber(8)
  $core.double get yaw => $_getN(6);
  @$pb.TagNumber(8)
  set yaw($core.double v) { $_setFloat(6, v); }
  @$pb.TagNumber(8)
  $core.bool hasYaw() => $_has(6);
  @$pb.TagNumber(8)
  void clearYaw() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get pitch => $_getN(7);
  @$pb.TagNumber(9)
  set pitch($core.double v) { $_setFloat(7, v); }
  @$pb.TagNumber(9)
  $core.bool hasPitch() => $_has(7);
  @$pb.TagNumber(9)
  void clearPitch() => clearField(9);

  /// Experimental: Use PnP to determine the 3D pose
  @$pb.TagNumber(10)
  PnpResult get bestPnpResult => $_getN(8);
  @$pb.TagNumber(10)
  set bestPnpResult(PnpResult v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasBestPnpResult() => $_has(8);
  @$pb.TagNumber(10)
  void clearBestPnpResult() => clearField(10);
  @$pb.TagNumber(10)
  PnpResult ensureBestPnpResult() => $_ensure(8);

  @$pb.TagNumber(11)
  PnpResult get alternatePnpResult => $_getN(9);
  @$pb.TagNumber(11)
  set alternatePnpResult(PnpResult v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasAlternatePnpResult() => $_has(9);
  @$pb.TagNumber(11)
  void clearAlternatePnpResult() => clearField(11);
  @$pb.TagNumber(11)
  PnpResult ensureAlternatePnpResult() => $_ensure(9);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
