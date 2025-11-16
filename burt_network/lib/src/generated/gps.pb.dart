//
//  Generated code. Do not modify.
//  source: gps.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'geometry.pb.dart' as $0;
import 'gps.pbenum.dart';
import 'version.pb.dart' as $1;

export 'gps.pbenum.dart';

class GpsCoordinates extends $pb.GeneratedMessage {
  factory GpsCoordinates({
    $core.double? latitude,
    $core.double? longitude,
    $core.double? altitude,
    RTKMode? rtkMode,
  }) {
    final $result = create();
    if (latitude != null) {
      $result.latitude = latitude;
    }
    if (longitude != null) {
      $result.longitude = longitude;
    }
    if (altitude != null) {
      $result.altitude = altitude;
    }
    if (rtkMode != null) {
      $result.rtkMode = rtkMode;
    }
    return $result;
  }
  GpsCoordinates._() : super();
  factory GpsCoordinates.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GpsCoordinates.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GpsCoordinates', createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'latitude', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'longitude', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'altitude', $pb.PbFieldType.OD)
    ..e<RTKMode>(4, _omitFieldNames ? '' : 'rtkMode', $pb.PbFieldType.OE, protoName: 'rtkMode', defaultOrMaker: RTKMode.RTK_NONE, valueOf: RTKMode.valueOf, enumValues: RTKMode.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GpsCoordinates clone() => GpsCoordinates()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GpsCoordinates copyWith(void Function(GpsCoordinates) updates) => super.copyWith((message) => updates(message as GpsCoordinates)) as GpsCoordinates;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GpsCoordinates create() => GpsCoordinates._();
  GpsCoordinates createEmptyInstance() => create();
  static $pb.PbList<GpsCoordinates> createRepeated() => $pb.PbList<GpsCoordinates>();
  @$core.pragma('dart2js:noInline')
  static GpsCoordinates getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GpsCoordinates>(create);
  static GpsCoordinates? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get latitude => $_getN(0);
  @$pb.TagNumber(1)
  set latitude($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLatitude() => $_has(0);
  @$pb.TagNumber(1)
  void clearLatitude() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get longitude => $_getN(1);
  @$pb.TagNumber(2)
  set longitude($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLongitude() => $_has(1);
  @$pb.TagNumber(2)
  void clearLongitude() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get altitude => $_getN(2);
  @$pb.TagNumber(3)
  set altitude($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAltitude() => $_has(2);
  @$pb.TagNumber(3)
  void clearAltitude() => clearField(3);

  @$pb.TagNumber(4)
  RTKMode get rtkMode => $_getN(3);
  @$pb.TagNumber(4)
  set rtkMode(RTKMode v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasRtkMode() => $_has(3);
  @$pb.TagNumber(4)
  void clearRtkMode() => clearField(4);
}

class RoverPosition extends $pb.GeneratedMessage {
  factory RoverPosition({
    GpsCoordinates? gps,
    $0.Orientation? orientation,
    $1.Version? version,
    $core.List<$core.int>? rtkMessage,
  }) {
    final $result = create();
    if (gps != null) {
      $result.gps = gps;
    }
    if (orientation != null) {
      $result.orientation = orientation;
    }
    if (version != null) {
      $result.version = version;
    }
    if (rtkMessage != null) {
      $result.rtkMessage = rtkMessage;
    }
    return $result;
  }
  RoverPosition._() : super();
  factory RoverPosition.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RoverPosition.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RoverPosition', createEmptyInstance: create)
    ..aOM<GpsCoordinates>(1, _omitFieldNames ? '' : 'gps', subBuilder: GpsCoordinates.create)
    ..aOM<$0.Orientation>(2, _omitFieldNames ? '' : 'orientation', subBuilder: $0.Orientation.create)
    ..aOM<$1.Version>(3, _omitFieldNames ? '' : 'version', subBuilder: $1.Version.create)
    ..a<$core.List<$core.int>>(4, _omitFieldNames ? '' : 'rtkMessage', $pb.PbFieldType.OY, protoName: 'rtkMessage')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RoverPosition clone() => RoverPosition()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RoverPosition copyWith(void Function(RoverPosition) updates) => super.copyWith((message) => updates(message as RoverPosition)) as RoverPosition;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RoverPosition create() => RoverPosition._();
  RoverPosition createEmptyInstance() => create();
  static $pb.PbList<RoverPosition> createRepeated() => $pb.PbList<RoverPosition>();
  @$core.pragma('dart2js:noInline')
  static RoverPosition getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RoverPosition>(create);
  static RoverPosition? _defaultInstance;

  @$pb.TagNumber(1)
  GpsCoordinates get gps => $_getN(0);
  @$pb.TagNumber(1)
  set gps(GpsCoordinates v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGps() => $_has(0);
  @$pb.TagNumber(1)
  void clearGps() => clearField(1);
  @$pb.TagNumber(1)
  GpsCoordinates ensureGps() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.Orientation get orientation => $_getN(1);
  @$pb.TagNumber(2)
  set orientation($0.Orientation v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasOrientation() => $_has(1);
  @$pb.TagNumber(2)
  void clearOrientation() => clearField(2);
  @$pb.TagNumber(2)
  $0.Orientation ensureOrientation() => $_ensure(1);

  @$pb.TagNumber(3)
  $1.Version get version => $_getN(2);
  @$pb.TagNumber(3)
  set version($1.Version v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearVersion() => clearField(3);
  @$pb.TagNumber(3)
  $1.Version ensureVersion() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.List<$core.int> get rtkMessage => $_getN(3);
  @$pb.TagNumber(4)
  set rtkMessage($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRtkMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearRtkMessage() => clearField(4);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
