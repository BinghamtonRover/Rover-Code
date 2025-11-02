// This is a generated file - do not edit.
//
// Generated from video.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'version.pb.dart' as $0;
import 'video.pbenum.dart';
import 'vision.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'video.pbenum.dart';

/// / Details about a specific camera.
class CameraDetails extends $pb.GeneratedMessage {
  factory CameraDetails({
    CameraName? name,
    $core.int? resolutionWidth,
    $core.int? resolutionHeight,
    $core.int? quality,
    $core.int? fps,
    CameraStatus? status,
    $core.bool? autofocus,
    $core.int? zoom,
    $core.int? pan,
    $core.int? tilt,
    $core.int? focus,
    $core.double? diagonalFov,
    $core.double? horizontalFov,
    $core.double? verticalFov,
    $core.int? streamWidth,
    $core.int? streamHeight,
    $core.int? rotationQuarters,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (resolutionWidth != null) result.resolutionWidth = resolutionWidth;
    if (resolutionHeight != null) result.resolutionHeight = resolutionHeight;
    if (quality != null) result.quality = quality;
    if (fps != null) result.fps = fps;
    if (status != null) result.status = status;
    if (autofocus != null) result.autofocus = autofocus;
    if (zoom != null) result.zoom = zoom;
    if (pan != null) result.pan = pan;
    if (tilt != null) result.tilt = tilt;
    if (focus != null) result.focus = focus;
    if (diagonalFov != null) result.diagonalFov = diagonalFov;
    if (horizontalFov != null) result.horizontalFov = horizontalFov;
    if (verticalFov != null) result.verticalFov = verticalFov;
    if (streamWidth != null) result.streamWidth = streamWidth;
    if (streamHeight != null) result.streamHeight = streamHeight;
    if (rotationQuarters != null) result.rotationQuarters = rotationQuarters;
    return result;
  }

  CameraDetails._();

  factory CameraDetails.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CameraDetails.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CameraDetails',
      createEmptyInstance: create)
    ..aE<CameraName>(1, _omitFieldNames ? '' : 'name',
        enumValues: CameraName.values)
    ..aI(2, _omitFieldNames ? '' : 'resolutionWidth')
    ..aI(3, _omitFieldNames ? '' : 'resolutionHeight')
    ..aI(4, _omitFieldNames ? '' : 'quality')
    ..aI(5, _omitFieldNames ? '' : 'fps')
    ..aE<CameraStatus>(6, _omitFieldNames ? '' : 'status',
        enumValues: CameraStatus.values)
    ..aOB(7, _omitFieldNames ? '' : 'autofocus')
    ..aI(8, _omitFieldNames ? '' : 'zoom')
    ..aI(9, _omitFieldNames ? '' : 'pan')
    ..aI(10, _omitFieldNames ? '' : 'tilt')
    ..aI(11, _omitFieldNames ? '' : 'focus')
    ..aD(12, _omitFieldNames ? '' : 'diagonalFov',
        fieldType: $pb.PbFieldType.OF)
    ..aD(13, _omitFieldNames ? '' : 'horizontalFov',
        fieldType: $pb.PbFieldType.OF)
    ..aD(14, _omitFieldNames ? '' : 'verticalFov',
        fieldType: $pb.PbFieldType.OF)
    ..aI(15, _omitFieldNames ? '' : 'streamWidth')
    ..aI(16, _omitFieldNames ? '' : 'streamHeight')
    ..aI(17, _omitFieldNames ? '' : 'rotationQuarters',
        protoName: 'rotationQuarters')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CameraDetails clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CameraDetails copyWith(void Function(CameraDetails) updates) =>
      super.copyWith((message) => updates(message as CameraDetails))
          as CameraDetails;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CameraDetails create() => CameraDetails._();
  @$core.override
  CameraDetails createEmptyInstance() => create();
  static $pb.PbList<CameraDetails> createRepeated() =>
      $pb.PbList<CameraDetails>();
  @$core.pragma('dart2js:noInline')
  static CameraDetails getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CameraDetails>(create);
  static CameraDetails? _defaultInstance;

  /// / The name of the camera.
  @$pb.TagNumber(1)
  CameraName get name => $_getN(0);
  @$pb.TagNumber(1)
  set name(CameraName value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  /// / The width and height of the image frame.
  @$pb.TagNumber(2)
  $core.int get resolutionWidth => $_getIZ(1);
  @$pb.TagNumber(2)
  set resolutionWidth($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasResolutionWidth() => $_has(1);
  @$pb.TagNumber(2)
  void clearResolutionWidth() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get resolutionHeight => $_getIZ(2);
  @$pb.TagNumber(3)
  set resolutionHeight($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasResolutionHeight() => $_has(2);
  @$pb.TagNumber(3)
  void clearResolutionHeight() => $_clearField(3);

  /// / The quality of the frame, as a percentage. Used for JPG compression.
  @$pb.TagNumber(4)
  $core.int get quality => $_getIZ(3);
  @$pb.TagNumber(4)
  set quality($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasQuality() => $_has(3);
  @$pb.TagNumber(4)
  void clearQuality() => $_clearField(4);

  /// / The amount of frames per second. Eg, 60 FPS or 24 FPS.
  @$pb.TagNumber(5)
  $core.int get fps => $_getIZ(4);
  @$pb.TagNumber(5)
  set fps($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFps() => $_has(4);
  @$pb.TagNumber(5)
  void clearFps() => $_clearField(5);

  /// / The status of this camera.
  @$pb.TagNumber(6)
  CameraStatus get status => $_getN(5);
  @$pb.TagNumber(6)
  set status(CameraStatus value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get autofocus => $_getBF(6);
  @$pb.TagNumber(7)
  set autofocus($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAutofocus() => $_has(6);
  @$pb.TagNumber(7)
  void clearAutofocus() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get zoom => $_getIZ(7);
  @$pb.TagNumber(8)
  set zoom($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasZoom() => $_has(7);
  @$pb.TagNumber(8)
  void clearZoom() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get pan => $_getIZ(8);
  @$pb.TagNumber(9)
  set pan($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasPan() => $_has(8);
  @$pb.TagNumber(9)
  void clearPan() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get tilt => $_getIZ(9);
  @$pb.TagNumber(10)
  set tilt($core.int value) => $_setSignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasTilt() => $_has(9);
  @$pb.TagNumber(10)
  void clearTilt() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get focus => $_getIZ(10);
  @$pb.TagNumber(11)
  set focus($core.int value) => $_setSignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasFocus() => $_has(10);
  @$pb.TagNumber(11)
  void clearFocus() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.double get diagonalFov => $_getN(11);
  @$pb.TagNumber(12)
  set diagonalFov($core.double value) => $_setFloat(11, value);
  @$pb.TagNumber(12)
  $core.bool hasDiagonalFov() => $_has(11);
  @$pb.TagNumber(12)
  void clearDiagonalFov() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.double get horizontalFov => $_getN(12);
  @$pb.TagNumber(13)
  set horizontalFov($core.double value) => $_setFloat(12, value);
  @$pb.TagNumber(13)
  $core.bool hasHorizontalFov() => $_has(12);
  @$pb.TagNumber(13)
  void clearHorizontalFov() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.double get verticalFov => $_getN(13);
  @$pb.TagNumber(14)
  set verticalFov($core.double value) => $_setFloat(13, value);
  @$pb.TagNumber(14)
  $core.bool hasVerticalFov() => $_has(13);
  @$pb.TagNumber(14)
  void clearVerticalFov() => $_clearField(14);

  /// / The width of the image data streamed
  @$pb.TagNumber(15)
  $core.int get streamWidth => $_getIZ(14);
  @$pb.TagNumber(15)
  set streamWidth($core.int value) => $_setSignedInt32(14, value);
  @$pb.TagNumber(15)
  $core.bool hasStreamWidth() => $_has(14);
  @$pb.TagNumber(15)
  void clearStreamWidth() => $_clearField(15);

  /// / The height of the image data streamed
  @$pb.TagNumber(16)
  $core.int get streamHeight => $_getIZ(15);
  @$pb.TagNumber(16)
  set streamHeight($core.int value) => $_setSignedInt32(15, value);
  @$pb.TagNumber(16)
  $core.bool hasStreamHeight() => $_has(15);
  @$pb.TagNumber(16)
  void clearStreamHeight() => $_clearField(16);

  /// / Number of 90 degrees rotation increments
  @$pb.TagNumber(17)
  $core.int get rotationQuarters => $_getIZ(16);
  @$pb.TagNumber(17)
  set rotationQuarters($core.int value) => $_setSignedInt32(16, value);
  @$pb.TagNumber(17)
  $core.bool hasRotationQuarters() => $_has(16);
  @$pb.TagNumber(17)
  void clearRotationQuarters() => $_clearField(17);
}

/// / Reports data about a camera.
class VideoData extends $pb.GeneratedMessage {
  factory VideoData({
    $core.String? id,
    CameraDetails? details,
    $core.List<$core.int>? frame,
    $0.Version? version,
    $core.String? imagePath,
    $core.Iterable<$1.DetectedObject>? detectedObjects,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (details != null) result.details = details;
    if (frame != null) result.frame = frame;
    if (version != null) result.version = version;
    if (imagePath != null) result.imagePath = imagePath;
    if (detectedObjects != null) result.detectedObjects.addAll(detectedObjects);
    return result;
  }

  VideoData._();

  factory VideoData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VideoData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VideoData',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOM<CameraDetails>(2, _omitFieldNames ? '' : 'details',
        subBuilder: CameraDetails.create)
    ..a<$core.List<$core.int>>(
        3, _omitFieldNames ? '' : 'frame', $pb.PbFieldType.OY)
    ..aOM<$0.Version>(4, _omitFieldNames ? '' : 'version',
        subBuilder: $0.Version.create)
    ..aOS(5, _omitFieldNames ? '' : 'imagePath', protoName: 'imagePath')
    ..pPM<$1.DetectedObject>(6, _omitFieldNames ? '' : 'detectedObjects',
        protoName: 'detectedObjects', subBuilder: $1.DetectedObject.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VideoData clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VideoData copyWith(void Function(VideoData) updates) =>
      super.copyWith((message) => updates(message as VideoData)) as VideoData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VideoData create() => VideoData._();
  @$core.override
  VideoData createEmptyInstance() => create();
  static $pb.PbList<VideoData> createRepeated() => $pb.PbList<VideoData>();
  @$core.pragma('dart2js:noInline')
  static VideoData getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VideoData>(create);
  static VideoData? _defaultInstance;

  /// / The unique ID of this camera.
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  /// / The details for this camera.
  @$pb.TagNumber(2)
  CameraDetails get details => $_getN(1);
  @$pb.TagNumber(2)
  set details(CameraDetails value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasDetails() => $_has(1);
  @$pb.TagNumber(2)
  void clearDetails() => $_clearField(2);
  @$pb.TagNumber(2)
  CameraDetails ensureDetails() => $_ensure(1);

  /// / The latest frame from this camera.
  @$pb.TagNumber(3)
  $core.List<$core.int> get frame => $_getN(2);
  @$pb.TagNumber(3)
  set frame($core.List<$core.int> value) => $_setBytes(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFrame() => $_has(2);
  @$pb.TagNumber(3)
  void clearFrame() => $_clearField(3);

  /// / The version of this video data.
  @$pb.TagNumber(4)
  $0.Version get version => $_getN(3);
  @$pb.TagNumber(4)
  set version($0.Version value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasVersion() => $_has(3);
  @$pb.TagNumber(4)
  void clearVersion() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.Version ensureVersion() => $_ensure(3);

  /// / The path that a high-quality screenshot was saved to.
  @$pb.TagNumber(5)
  $core.String get imagePath => $_getSZ(4);
  @$pb.TagNumber(5)
  set imagePath($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasImagePath() => $_has(4);
  @$pb.TagNumber(5)
  void clearImagePath() => $_clearField(5);

  /// / Any objects that were detected in the frame.
  @$pb.TagNumber(6)
  $pb.PbList<$1.DetectedObject> get detectedObjects => $_getList(5);
}

/// / Make changes to a camera feed.
class VideoCommand extends $pb.GeneratedMessage {
  factory VideoCommand({
    $core.String? id,
    CameraDetails? details,
    $0.Version? version,
    $core.bool? takeSnapshot,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (details != null) result.details = details;
    if (version != null) result.version = version;
    if (takeSnapshot != null) result.takeSnapshot = takeSnapshot;
    return result;
  }

  VideoCommand._();

  factory VideoCommand.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VideoCommand.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VideoCommand',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOM<CameraDetails>(2, _omitFieldNames ? '' : 'details',
        subBuilder: CameraDetails.create)
    ..aOM<$0.Version>(3, _omitFieldNames ? '' : 'version',
        subBuilder: $0.Version.create)
    ..aOB(4, _omitFieldNames ? '' : 'takeSnapshot', protoName: 'takeSnapshot')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VideoCommand clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VideoCommand copyWith(void Function(VideoCommand) updates) =>
      super.copyWith((message) => updates(message as VideoCommand))
          as VideoCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VideoCommand create() => VideoCommand._();
  @$core.override
  VideoCommand createEmptyInstance() => create();
  static $pb.PbList<VideoCommand> createRepeated() =>
      $pb.PbList<VideoCommand>();
  @$core.pragma('dart2js:noInline')
  static VideoCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VideoCommand>(create);
  static VideoCommand? _defaultInstance;

  /// / The unique ID of the camera to change.
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  /// / The new details for this camera.
  /// /
  /// / If changing [CameraDetails.status], you cannot set it to [CameraStatus.DISCONNECTED].
  @$pb.TagNumber(2)
  CameraDetails get details => $_getN(1);
  @$pb.TagNumber(2)
  set details(CameraDetails value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasDetails() => $_has(1);
  @$pb.TagNumber(2)
  void clearDetails() => $_clearField(2);
  @$pb.TagNumber(2)
  CameraDetails ensureDetails() => $_ensure(1);

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

  @$pb.TagNumber(4)
  $core.bool get takeSnapshot => $_getBF(3);
  @$pb.TagNumber(4)
  set takeSnapshot($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTakeSnapshot() => $_has(3);
  @$pb.TagNumber(4)
  void clearTakeSnapshot() => $_clearField(4);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
