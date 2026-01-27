// This is a generated file - do not edit.
//
// Generated from autonomy.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'autonomy.pbenum.dart';
import 'gps.pb.dart' as $0;
import 'version.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'autonomy.pbenum.dart';

class AutonomyData extends $pb.GeneratedMessage {
  factory AutonomyData({
    AutonomyState? state,
    $0.GpsCoordinates? destination,
    $core.Iterable<$0.GpsCoordinates>? obstacles,
    $core.Iterable<$0.GpsCoordinates>? path,
    AutonomyTask? task,
    $core.bool? crash,
    $1.Version? version,
  }) {
    final result = create();
    if (state != null) result.state = state;
    if (destination != null) result.destination = destination;
    if (obstacles != null) result.obstacles.addAll(obstacles);
    if (path != null) result.path.addAll(path);
    if (task != null) result.task = task;
    if (crash != null) result.crash = crash;
    if (version != null) result.version = version;
    return result;
  }

  AutonomyData._();

  factory AutonomyData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AutonomyData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AutonomyData',
      createEmptyInstance: create)
    ..aE<AutonomyState>(1, _omitFieldNames ? '' : 'state',
        enumValues: AutonomyState.values)
    ..aOM<$0.GpsCoordinates>(2, _omitFieldNames ? '' : 'destination',
        subBuilder: $0.GpsCoordinates.create)
    ..pPM<$0.GpsCoordinates>(3, _omitFieldNames ? '' : 'obstacles',
        subBuilder: $0.GpsCoordinates.create)
    ..pPM<$0.GpsCoordinates>(4, _omitFieldNames ? '' : 'path',
        subBuilder: $0.GpsCoordinates.create)
    ..aE<AutonomyTask>(5, _omitFieldNames ? '' : 'task',
        enumValues: AutonomyTask.values)
    ..aOB(6, _omitFieldNames ? '' : 'crash')
    ..aOM<$1.Version>(7, _omitFieldNames ? '' : 'version',
        subBuilder: $1.Version.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AutonomyData clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AutonomyData copyWith(void Function(AutonomyData) updates) =>
      super.copyWith((message) => updates(message as AutonomyData))
          as AutonomyData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AutonomyData create() => AutonomyData._();
  @$core.override
  AutonomyData createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AutonomyData getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AutonomyData>(create);
  static AutonomyData? _defaultInstance;

  @$pb.TagNumber(1)
  AutonomyState get state => $_getN(0);
  @$pb.TagNumber(1)
  set state(AutonomyState value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasState() => $_has(0);
  @$pb.TagNumber(1)
  void clearState() => $_clearField(1);

  @$pb.TagNumber(2)
  $0.GpsCoordinates get destination => $_getN(1);
  @$pb.TagNumber(2)
  set destination($0.GpsCoordinates value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasDestination() => $_has(1);
  @$pb.TagNumber(2)
  void clearDestination() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.GpsCoordinates ensureDestination() => $_ensure(1);

  @$pb.TagNumber(3)
  $pb.PbList<$0.GpsCoordinates> get obstacles => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<$0.GpsCoordinates> get path => $_getList(3);

  @$pb.TagNumber(5)
  AutonomyTask get task => $_getN(4);
  @$pb.TagNumber(5)
  set task(AutonomyTask value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasTask() => $_has(4);
  @$pb.TagNumber(5)
  void clearTask() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get crash => $_getBF(5);
  @$pb.TagNumber(6)
  set crash($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCrash() => $_has(5);
  @$pb.TagNumber(6)
  void clearCrash() => $_clearField(6);

  @$pb.TagNumber(7)
  $1.Version get version => $_getN(6);
  @$pb.TagNumber(7)
  set version($1.Version value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasVersion() => $_has(6);
  @$pb.TagNumber(7)
  void clearVersion() => $_clearField(7);
  @$pb.TagNumber(7)
  $1.Version ensureVersion() => $_ensure(6);
}

class AutonomyCommand extends $pb.GeneratedMessage {
  factory AutonomyCommand({
    $0.GpsCoordinates? destination,
    AutonomyTask? task,
    $core.int? arucoId,
    $core.bool? abort,
    $1.Version? version,
  }) {
    final result = create();
    if (destination != null) result.destination = destination;
    if (task != null) result.task = task;
    if (arucoId != null) result.arucoId = arucoId;
    if (abort != null) result.abort = abort;
    if (version != null) result.version = version;
    return result;
  }

  AutonomyCommand._();

  factory AutonomyCommand.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AutonomyCommand.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AutonomyCommand',
      createEmptyInstance: create)
    ..aOM<$0.GpsCoordinates>(1, _omitFieldNames ? '' : 'destination',
        subBuilder: $0.GpsCoordinates.create)
    ..aE<AutonomyTask>(2, _omitFieldNames ? '' : 'task',
        enumValues: AutonomyTask.values)
    ..aI(3, _omitFieldNames ? '' : 'arucoId')
    ..aOB(4, _omitFieldNames ? '' : 'abort')
    ..aOM<$1.Version>(5, _omitFieldNames ? '' : 'version',
        subBuilder: $1.Version.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AutonomyCommand clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AutonomyCommand copyWith(void Function(AutonomyCommand) updates) =>
      super.copyWith((message) => updates(message as AutonomyCommand))
          as AutonomyCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AutonomyCommand create() => AutonomyCommand._();
  @$core.override
  AutonomyCommand createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AutonomyCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AutonomyCommand>(create);
  static AutonomyCommand? _defaultInstance;

  @$pb.TagNumber(1)
  $0.GpsCoordinates get destination => $_getN(0);
  @$pb.TagNumber(1)
  set destination($0.GpsCoordinates value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasDestination() => $_has(0);
  @$pb.TagNumber(1)
  void clearDestination() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.GpsCoordinates ensureDestination() => $_ensure(0);

  @$pb.TagNumber(2)
  AutonomyTask get task => $_getN(1);
  @$pb.TagNumber(2)
  set task(AutonomyTask value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasTask() => $_has(1);
  @$pb.TagNumber(2)
  void clearTask() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get arucoId => $_getIZ(2);
  @$pb.TagNumber(3)
  set arucoId($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasArucoId() => $_has(2);
  @$pb.TagNumber(3)
  void clearArucoId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get abort => $_getBF(3);
  @$pb.TagNumber(4)
  set abort($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAbort() => $_has(3);
  @$pb.TagNumber(4)
  void clearAbort() => $_clearField(4);

  @$pb.TagNumber(5)
  $1.Version get version => $_getN(4);
  @$pb.TagNumber(5)
  set version($1.Version value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasVersion() => $_has(4);
  @$pb.TagNumber(5)
  void clearVersion() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Version ensureVersion() => $_ensure(4);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
