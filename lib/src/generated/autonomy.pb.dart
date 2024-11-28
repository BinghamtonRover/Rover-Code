//
//  Generated code. Do not modify.
//  source: autonomy.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'autonomy.pbenum.dart';
import 'gps.pb.dart' as $3;
import 'version.pb.dart' as $2;

export 'autonomy.pbenum.dart';

class AutonomyData extends $pb.GeneratedMessage {
  factory AutonomyData({
    AutonomyState? state,
    $3.GpsCoordinates? destination,
    $core.Iterable<$3.GpsCoordinates>? obstacles,
    $core.Iterable<$3.GpsCoordinates>? path,
    AutonomyTask? task,
    $core.bool? crash,
    $2.Version? version,
  }) {
    final $result = create();
    if (state != null) {
      $result.state = state;
    }
    if (destination != null) {
      $result.destination = destination;
    }
    if (obstacles != null) {
      $result.obstacles.addAll(obstacles);
    }
    if (path != null) {
      $result.path.addAll(path);
    }
    if (task != null) {
      $result.task = task;
    }
    if (crash != null) {
      $result.crash = crash;
    }
    if (version != null) {
      $result.version = version;
    }
    return $result;
  }
  AutonomyData._() : super();
  factory AutonomyData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AutonomyData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AutonomyData', createEmptyInstance: create)
    ..e<AutonomyState>(1, _omitFieldNames ? '' : 'state', $pb.PbFieldType.OE, defaultOrMaker: AutonomyState.AUTONOMY_STATE_UNDEFINED, valueOf: AutonomyState.valueOf, enumValues: AutonomyState.values)
    ..aOM<$3.GpsCoordinates>(2, _omitFieldNames ? '' : 'destination', subBuilder: $3.GpsCoordinates.create)
    ..pc<$3.GpsCoordinates>(3, _omitFieldNames ? '' : 'obstacles', $pb.PbFieldType.PM, subBuilder: $3.GpsCoordinates.create)
    ..pc<$3.GpsCoordinates>(4, _omitFieldNames ? '' : 'path', $pb.PbFieldType.PM, subBuilder: $3.GpsCoordinates.create)
    ..e<AutonomyTask>(5, _omitFieldNames ? '' : 'task', $pb.PbFieldType.OE, defaultOrMaker: AutonomyTask.AUTONOMY_TASK_UNDEFINED, valueOf: AutonomyTask.valueOf, enumValues: AutonomyTask.values)
    ..aOB(6, _omitFieldNames ? '' : 'crash')
    ..aOM<$2.Version>(7, _omitFieldNames ? '' : 'version', subBuilder: $2.Version.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AutonomyData clone() => AutonomyData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AutonomyData copyWith(void Function(AutonomyData) updates) => super.copyWith((message) => updates(message as AutonomyData)) as AutonomyData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AutonomyData create() => AutonomyData._();
  AutonomyData createEmptyInstance() => create();
  static $pb.PbList<AutonomyData> createRepeated() => $pb.PbList<AutonomyData>();
  @$core.pragma('dart2js:noInline')
  static AutonomyData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AutonomyData>(create);
  static AutonomyData? _defaultInstance;

  @$pb.TagNumber(1)
  AutonomyState get state => $_getN(0);
  @$pb.TagNumber(1)
  set state(AutonomyState v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasState() => $_has(0);
  @$pb.TagNumber(1)
  void clearState() => clearField(1);

  @$pb.TagNumber(2)
  $3.GpsCoordinates get destination => $_getN(1);
  @$pb.TagNumber(2)
  set destination($3.GpsCoordinates v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasDestination() => $_has(1);
  @$pb.TagNumber(2)
  void clearDestination() => clearField(2);
  @$pb.TagNumber(2)
  $3.GpsCoordinates ensureDestination() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.List<$3.GpsCoordinates> get obstacles => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<$3.GpsCoordinates> get path => $_getList(3);

  @$pb.TagNumber(5)
  AutonomyTask get task => $_getN(4);
  @$pb.TagNumber(5)
  set task(AutonomyTask v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasTask() => $_has(4);
  @$pb.TagNumber(5)
  void clearTask() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get crash => $_getBF(5);
  @$pb.TagNumber(6)
  set crash($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCrash() => $_has(5);
  @$pb.TagNumber(6)
  void clearCrash() => clearField(6);

  @$pb.TagNumber(7)
  $2.Version get version => $_getN(6);
  @$pb.TagNumber(7)
  set version($2.Version v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasVersion() => $_has(6);
  @$pb.TagNumber(7)
  void clearVersion() => clearField(7);
  @$pb.TagNumber(7)
  $2.Version ensureVersion() => $_ensure(6);
}

class AutonomyCommand extends $pb.GeneratedMessage {
  factory AutonomyCommand({
    $3.GpsCoordinates? destination,
    AutonomyTask? task,
    $core.int? arucoId,
    $core.bool? abort,
    $2.Version? version,
  }) {
    final $result = create();
    if (destination != null) {
      $result.destination = destination;
    }
    if (task != null) {
      $result.task = task;
    }
    if (arucoId != null) {
      $result.arucoId = arucoId;
    }
    if (abort != null) {
      $result.abort = abort;
    }
    if (version != null) {
      $result.version = version;
    }
    return $result;
  }
  AutonomyCommand._() : super();
  factory AutonomyCommand.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AutonomyCommand.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AutonomyCommand', createEmptyInstance: create)
    ..aOM<$3.GpsCoordinates>(1, _omitFieldNames ? '' : 'destination', subBuilder: $3.GpsCoordinates.create)
    ..e<AutonomyTask>(2, _omitFieldNames ? '' : 'task', $pb.PbFieldType.OE, defaultOrMaker: AutonomyTask.AUTONOMY_TASK_UNDEFINED, valueOf: AutonomyTask.valueOf, enumValues: AutonomyTask.values)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'arucoId', $pb.PbFieldType.O3)
    ..aOB(4, _omitFieldNames ? '' : 'abort')
    ..aOM<$2.Version>(5, _omitFieldNames ? '' : 'version', subBuilder: $2.Version.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AutonomyCommand clone() => AutonomyCommand()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AutonomyCommand copyWith(void Function(AutonomyCommand) updates) => super.copyWith((message) => updates(message as AutonomyCommand)) as AutonomyCommand;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AutonomyCommand create() => AutonomyCommand._();
  AutonomyCommand createEmptyInstance() => create();
  static $pb.PbList<AutonomyCommand> createRepeated() => $pb.PbList<AutonomyCommand>();
  @$core.pragma('dart2js:noInline')
  static AutonomyCommand getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AutonomyCommand>(create);
  static AutonomyCommand? _defaultInstance;

  @$pb.TagNumber(1)
  $3.GpsCoordinates get destination => $_getN(0);
  @$pb.TagNumber(1)
  set destination($3.GpsCoordinates v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasDestination() => $_has(0);
  @$pb.TagNumber(1)
  void clearDestination() => clearField(1);
  @$pb.TagNumber(1)
  $3.GpsCoordinates ensureDestination() => $_ensure(0);

  @$pb.TagNumber(2)
  AutonomyTask get task => $_getN(1);
  @$pb.TagNumber(2)
  set task(AutonomyTask v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasTask() => $_has(1);
  @$pb.TagNumber(2)
  void clearTask() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get arucoId => $_getIZ(2);
  @$pb.TagNumber(3)
  set arucoId($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasArucoId() => $_has(2);
  @$pb.TagNumber(3)
  void clearArucoId() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get abort => $_getBF(3);
  @$pb.TagNumber(4)
  set abort($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAbort() => $_has(3);
  @$pb.TagNumber(4)
  void clearAbort() => clearField(4);

  @$pb.TagNumber(5)
  $2.Version get version => $_getN(4);
  @$pb.TagNumber(5)
  set version($2.Version v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasVersion() => $_has(4);
  @$pb.TagNumber(5)
  void clearVersion() => clearField(5);
  @$pb.TagNumber(5)
  $2.Version ensureVersion() => $_ensure(4);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
