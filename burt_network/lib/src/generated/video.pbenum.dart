// This is a generated file - do not edit.
//
// Generated from video.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class CameraStatus extends $pb.ProtobufEnum {
  static const CameraStatus CAMERA_STATUS_UNDEFINED =
      CameraStatus._(0, _omitEnumNames ? '' : 'CAMERA_STATUS_UNDEFINED');
  static const CameraStatus CAMERA_DISCONNECTED =
      CameraStatus._(1, _omitEnumNames ? '' : 'CAMERA_DISCONNECTED');
  static const CameraStatus CAMERA_ENABLED =
      CameraStatus._(2, _omitEnumNames ? '' : 'CAMERA_ENABLED');
  static const CameraStatus CAMERA_DISABLED =
      CameraStatus._(3, _omitEnumNames ? '' : 'CAMERA_DISABLED');
  static const CameraStatus CAMERA_NOT_RESPONDING =
      CameraStatus._(4, _omitEnumNames ? '' : 'CAMERA_NOT_RESPONDING');
  static const CameraStatus CAMERA_LOADING =
      CameraStatus._(5, _omitEnumNames ? '' : 'CAMERA_LOADING');
  static const CameraStatus FRAME_TOO_LARGE =
      CameraStatus._(6, _omitEnumNames ? '' : 'FRAME_TOO_LARGE');
  static const CameraStatus CAMERA_HAS_NO_NAME =
      CameraStatus._(7, _omitEnumNames ? '' : 'CAMERA_HAS_NO_NAME');

  static const $core.List<CameraStatus> values = <CameraStatus>[
    CAMERA_STATUS_UNDEFINED,
    CAMERA_DISCONNECTED,
    CAMERA_ENABLED,
    CAMERA_DISABLED,
    CAMERA_NOT_RESPONDING,
    CAMERA_LOADING,
    FRAME_TOO_LARGE,
    CAMERA_HAS_NO_NAME,
  ];

  static final $core.List<CameraStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 7);
  static CameraStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const CameraStatus._(super.value, super.name);
}

class CameraName extends $pb.ProtobufEnum {
  static const CameraName CAMERA_NAME_UNDEFINED =
      CameraName._(0, _omitEnumNames ? '' : 'CAMERA_NAME_UNDEFINED');
  static const CameraName ROVER_FRONT =
      CameraName._(1, _omitEnumNames ? '' : 'ROVER_FRONT');
  static const CameraName ROVER_REAR =
      CameraName._(2, _omitEnumNames ? '' : 'ROVER_REAR');
  static const CameraName AUTONOMY_DEPTH =
      CameraName._(3, _omitEnumNames ? '' : 'AUTONOMY_DEPTH');
  static const CameraName SUBSYSTEM1 =
      CameraName._(4, _omitEnumNames ? '' : 'SUBSYSTEM1');
  static const CameraName SUBSYSTEM2 =
      CameraName._(5, _omitEnumNames ? '' : 'SUBSYSTEM2');
  static const CameraName SUBSYSTEM3 =
      CameraName._(6, _omitEnumNames ? '' : 'SUBSYSTEM3');
  static const CameraName BOTTOM_LEFT =
      CameraName._(7, _omitEnumNames ? '' : 'BOTTOM_LEFT');
  static const CameraName BOTTOM_RIGHT =
      CameraName._(8, _omitEnumNames ? '' : 'BOTTOM_RIGHT');

  static const $core.List<CameraName> values = <CameraName>[
    CAMERA_NAME_UNDEFINED,
    ROVER_FRONT,
    ROVER_REAR,
    AUTONOMY_DEPTH,
    SUBSYSTEM1,
    SUBSYSTEM2,
    SUBSYSTEM3,
    BOTTOM_LEFT,
    BOTTOM_RIGHT,
  ];

  static final $core.List<CameraName?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 8);
  static CameraName? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const CameraName._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
