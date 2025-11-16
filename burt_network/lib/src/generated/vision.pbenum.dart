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

class DetectedObjectType extends $pb.ProtobufEnum {
  static const DetectedObjectType DETECTION_TYPE_UNDEFINED = DetectedObjectType._(0, _omitEnumNames ? '' : 'DETECTION_TYPE_UNDEFINED');
  static const DetectedObjectType ARUCO = DetectedObjectType._(1, _omitEnumNames ? '' : 'ARUCO');
  static const DetectedObjectType HAMMER = DetectedObjectType._(2, _omitEnumNames ? '' : 'HAMMER');
  static const DetectedObjectType BOTTLE = DetectedObjectType._(3, _omitEnumNames ? '' : 'BOTTLE');

  static const $core.List<DetectedObjectType> values = <DetectedObjectType> [
    DETECTION_TYPE_UNDEFINED,
    ARUCO,
    HAMMER,
    BOTTLE,
  ];

  static final $core.Map<$core.int, DetectedObjectType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static DetectedObjectType? valueOf($core.int value) => _byValue[value];

  const DetectedObjectType._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
