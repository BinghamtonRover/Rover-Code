// This is a generated file - do not edit.
//
// Generated from gps.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'geometry.pb.dart' as $0;
import 'gps.pbenum.dart';
import 'version.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'gps.pbenum.dart';

class GpsCoordinates extends $pb.GeneratedMessage {
  factory GpsCoordinates({
    $core.double? latitude,
    $core.double? longitude,
    $core.double? altitude,
    RTKMode? rtkMode,
  }) {
    final result = create();
    if (latitude != null) result.latitude = latitude;
    if (longitude != null) result.longitude = longitude;
    if (altitude != null) result.altitude = altitude;
    if (rtkMode != null) result.rtkMode = rtkMode;
    return result;
  }

  GpsCoordinates._();

  factory GpsCoordinates.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GpsCoordinates.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GpsCoordinates',
      createEmptyInstance: create)
    ..aD(1, _omitFieldNames ? '' : 'latitude')
    ..aD(2, _omitFieldNames ? '' : 'longitude')
    ..aD(3, _omitFieldNames ? '' : 'altitude')
    ..aE<RTKMode>(4, _omitFieldNames ? '' : 'rtkMode',
        protoName: 'rtkMode', enumValues: RTKMode.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GpsCoordinates clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GpsCoordinates copyWith(void Function(GpsCoordinates) updates) =>
      super.copyWith((message) => updates(message as GpsCoordinates))
          as GpsCoordinates;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GpsCoordinates create() => GpsCoordinates._();
  @$core.override
  GpsCoordinates createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GpsCoordinates getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GpsCoordinates>(create);
  static GpsCoordinates? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get latitude => $_getN(0);
  @$pb.TagNumber(1)
  set latitude($core.double value) => $_setDouble(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLatitude() => $_has(0);
  @$pb.TagNumber(1)
  void clearLatitude() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get longitude => $_getN(1);
  @$pb.TagNumber(2)
  set longitude($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLongitude() => $_has(1);
  @$pb.TagNumber(2)
  void clearLongitude() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get altitude => $_getN(2);
  @$pb.TagNumber(3)
  set altitude($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAltitude() => $_has(2);
  @$pb.TagNumber(3)
  void clearAltitude() => $_clearField(3);

  @$pb.TagNumber(4)
  RTKMode get rtkMode => $_getN(3);
  @$pb.TagNumber(4)
  set rtkMode(RTKMode value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasRtkMode() => $_has(3);
  @$pb.TagNumber(4)
  void clearRtkMode() => $_clearField(4);
}

class RoverPosition extends $pb.GeneratedMessage {
  factory RoverPosition({
    GpsCoordinates? gps,
    $0.Orientation? orientation,
    $1.Version? version,
    $core.List<$core.int>? rtkMessage,
  }) {
    final result = create();
    if (gps != null) result.gps = gps;
    if (orientation != null) result.orientation = orientation;
    if (version != null) result.version = version;
    if (rtkMessage != null) result.rtkMessage = rtkMessage;
    return result;
  }

  RoverPosition._();

  factory RoverPosition.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RoverPosition.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RoverPosition',
      createEmptyInstance: create)
    ..aOM<GpsCoordinates>(1, _omitFieldNames ? '' : 'gps',
        subBuilder: GpsCoordinates.create)
    ..aOM<$0.Orientation>(2, _omitFieldNames ? '' : 'orientation',
        subBuilder: $0.Orientation.create)
    ..aOM<$1.Version>(3, _omitFieldNames ? '' : 'version',
        subBuilder: $1.Version.create)
    ..a<$core.List<$core.int>>(
        4, _omitFieldNames ? '' : 'rtkMessage', $pb.PbFieldType.OY,
        protoName: 'rtkMessage')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RoverPosition clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RoverPosition copyWith(void Function(RoverPosition) updates) =>
      super.copyWith((message) => updates(message as RoverPosition))
          as RoverPosition;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RoverPosition create() => RoverPosition._();
  @$core.override
  RoverPosition createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RoverPosition getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RoverPosition>(create);
  static RoverPosition? _defaultInstance;

  @$pb.TagNumber(1)
  GpsCoordinates get gps => $_getN(0);
  @$pb.TagNumber(1)
  set gps(GpsCoordinates value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasGps() => $_has(0);
  @$pb.TagNumber(1)
  void clearGps() => $_clearField(1);
  @$pb.TagNumber(1)
  GpsCoordinates ensureGps() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.Orientation get orientation => $_getN(1);
  @$pb.TagNumber(2)
  set orientation($0.Orientation value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasOrientation() => $_has(1);
  @$pb.TagNumber(2)
  void clearOrientation() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.Orientation ensureOrientation() => $_ensure(1);

  @$pb.TagNumber(3)
  $1.Version get version => $_getN(2);
  @$pb.TagNumber(3)
  set version($1.Version value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearVersion() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.Version ensureVersion() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.List<$core.int> get rtkMessage => $_getN(3);
  @$pb.TagNumber(4)
  set rtkMessage($core.List<$core.int> value) => $_setBytes(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRtkMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearRtkMessage() => $_clearField(4);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
