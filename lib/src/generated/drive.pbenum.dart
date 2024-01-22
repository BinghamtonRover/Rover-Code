//
//  Generated code. Do not modify.
//  source: drive.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class DriveDirection extends $pb.ProtobufEnum {
  static const DriveDirection DRIVE_DIRECTION_UNDEFINED = DriveDirection._(0, _omitEnumNames ? '' : 'DRIVE_DIRECTION_UNDEFINED');
  static const DriveDirection DRIVE_DIRECTION_FORWARD = DriveDirection._(1, _omitEnumNames ? '' : 'DRIVE_DIRECTION_FORWARD');
  static const DriveDirection DRIVE_DIRECTION_LEFT = DriveDirection._(2, _omitEnumNames ? '' : 'DRIVE_DIRECTION_LEFT');
  static const DriveDirection DRIVE_DIRECTION_RIGHT = DriveDirection._(3, _omitEnumNames ? '' : 'DRIVE_DIRECTION_RIGHT');
  static const DriveDirection DRIVE_DIRECTION_STOP = DriveDirection._(4, _omitEnumNames ? '' : 'DRIVE_DIRECTION_STOP');

  static const $core.List<DriveDirection> values = <DriveDirection> [
    DRIVE_DIRECTION_UNDEFINED,
    DRIVE_DIRECTION_FORWARD,
    DRIVE_DIRECTION_LEFT,
    DRIVE_DIRECTION_RIGHT,
    DRIVE_DIRECTION_STOP,
  ];

  static final $core.Map<$core.int, DriveDirection> _byValue = $pb.ProtobufEnum.initByValue(values);
  static DriveDirection? valueOf($core.int value) => _byValue[value];

  const DriveDirection._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
