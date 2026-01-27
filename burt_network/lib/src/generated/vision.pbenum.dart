// This is a generated file - do not edit.
//
// Generated from vision.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class DetectedObjectType extends $pb.ProtobufEnum {
  static const DetectedObjectType DETECTION_TYPE_UNDEFINED =
      DetectedObjectType._(0, _omitEnumNames ? '' : 'DETECTION_TYPE_UNDEFINED');
  static const DetectedObjectType ARUCO =
      DetectedObjectType._(1, _omitEnumNames ? '' : 'ARUCO');
  static const DetectedObjectType HAMMER =
      DetectedObjectType._(2, _omitEnumNames ? '' : 'HAMMER');
  static const DetectedObjectType BOTTLE =
      DetectedObjectType._(3, _omitEnumNames ? '' : 'BOTTLE');

  static const $core.List<DetectedObjectType> values = <DetectedObjectType>[
    DETECTION_TYPE_UNDEFINED,
    ARUCO,
    HAMMER,
    BOTTLE,
  ];

  static final $core.List<DetectedObjectType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static DetectedObjectType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const DetectedObjectType._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
