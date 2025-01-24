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
import 'video.pbenum.dart' as $7;
import 'vision.pbenum.dart';

export 'vision.pbenum.dart';

class PnpResult extends $pb.GeneratedMessage {
  factory PnpResult({
    $1.Pose3d? pose,
    $core.double? error,
  }) {
    final $result = create();
    if (pose != null) {
      $result.pose = pose;
    }
    if (error != null) {
      $result.error = error;
    }
    return $result;
  }
  PnpResult._() : super();
  factory PnpResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PnpResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PnpResult', createEmptyInstance: create)
    ..aOM<$1.Pose3d>(1, _omitFieldNames ? '' : 'pose', subBuilder: $1.Pose3d.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'error', $pb.PbFieldType.OD)
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
  $1.Pose3d get pose => $_getN(0);
  @$pb.TagNumber(1)
  set pose($1.Pose3d v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPose() => $_has(0);
  @$pb.TagNumber(1)
  void clearPose() => clearField(1);
  @$pb.TagNumber(1)
  $1.Pose3d ensurePose() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get error => $_getN(1);
  @$pb.TagNumber(2)
  set error($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => clearField(2);
}

class DetectedObject extends $pb.GeneratedMessage {
  factory DetectedObject({
    DetectedObjectType? objectType,
    $core.int? arucoTagId,
    $7.CameraName? camera,
    $core.double? xPosition,
    $core.double? relativeSize,
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
    if (camera != null) {
      $result.camera = camera;
    }
    if (xPosition != null) {
      $result.xPosition = xPosition;
    }
    if (relativeSize != null) {
      $result.relativeSize = relativeSize;
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
    ..e<$7.CameraName>(3, _omitFieldNames ? '' : 'camera', $pb.PbFieldType.OE, defaultOrMaker: $7.CameraName.CAMERA_NAME_UNDEFINED, valueOf: $7.CameraName.valueOf, enumValues: $7.CameraName.values)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'xPosition', $pb.PbFieldType.OF, protoName: 'xPosition')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'relativeSize', $pb.PbFieldType.OF, protoName: 'relativeSize')
    ..a<$core.double>(6, _omitFieldNames ? '' : 'yaw', $pb.PbFieldType.OF)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'pitch', $pb.PbFieldType.OF)
    ..aOM<PnpResult>(8, _omitFieldNames ? '' : 'bestPnpResult', protoName: 'bestPnpResult', subBuilder: PnpResult.create)
    ..aOM<PnpResult>(9, _omitFieldNames ? '' : 'alternatePnpResult', protoName: 'alternatePnpResult', subBuilder: PnpResult.create)
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

  @$pb.TagNumber(3)
  $7.CameraName get camera => $_getN(2);
  @$pb.TagNumber(3)
  set camera($7.CameraName v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasCamera() => $_has(2);
  @$pb.TagNumber(3)
  void clearCamera() => clearField(3);

  /// Where it was detected
  @$pb.TagNumber(4)
  $core.double get xPosition => $_getN(3);
  @$pb.TagNumber(4)
  set xPosition($core.double v) { $_setFloat(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasXPosition() => $_has(3);
  @$pb.TagNumber(4)
  void clearXPosition() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get relativeSize => $_getN(4);
  @$pb.TagNumber(5)
  set relativeSize($core.double v) { $_setFloat(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasRelativeSize() => $_has(4);
  @$pb.TagNumber(5)
  void clearRelativeSize() => clearField(5);

  /// Experimental: Use pinhole model to find the object's position
  @$pb.TagNumber(6)
  $core.double get yaw => $_getN(5);
  @$pb.TagNumber(6)
  set yaw($core.double v) { $_setFloat(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasYaw() => $_has(5);
  @$pb.TagNumber(6)
  void clearYaw() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get pitch => $_getN(6);
  @$pb.TagNumber(7)
  set pitch($core.double v) { $_setFloat(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasPitch() => $_has(6);
  @$pb.TagNumber(7)
  void clearPitch() => clearField(7);

  /// Experimental: Use PnP to determine the 3D pose
  @$pb.TagNumber(8)
  PnpResult get bestPnpResult => $_getN(7);
  @$pb.TagNumber(8)
  set bestPnpResult(PnpResult v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasBestPnpResult() => $_has(7);
  @$pb.TagNumber(8)
  void clearBestPnpResult() => clearField(8);
  @$pb.TagNumber(8)
  PnpResult ensureBestPnpResult() => $_ensure(7);

  @$pb.TagNumber(9)
  PnpResult get alternatePnpResult => $_getN(8);
  @$pb.TagNumber(9)
  set alternatePnpResult(PnpResult v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasAlternatePnpResult() => $_has(8);
  @$pb.TagNumber(9)
  void clearAlternatePnpResult() => clearField(9);
  @$pb.TagNumber(9)
  PnpResult ensureAlternatePnpResult() => $_ensure(8);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
