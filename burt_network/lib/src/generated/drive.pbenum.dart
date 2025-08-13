// This is a generated file - do not edit.
//
// Generated from drive.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ProtoColor extends $pb.ProtobufEnum {
  static const ProtoColor PROTO_COLOR_UNDEFINED =
      ProtoColor._(0, _omitEnumNames ? '' : 'PROTO_COLOR_UNDEFINED');
  static const ProtoColor RED = ProtoColor._(1, _omitEnumNames ? '' : 'RED');
  static const ProtoColor GREEN =
      ProtoColor._(2, _omitEnumNames ? '' : 'GREEN');
  static const ProtoColor BLUE = ProtoColor._(3, _omitEnumNames ? '' : 'BLUE');
  static const ProtoColor UNLIT =
      ProtoColor._(4, _omitEnumNames ? '' : 'UNLIT');

  static const $core.List<ProtoColor> values = <ProtoColor>[
    PROTO_COLOR_UNDEFINED,
    RED,
    GREEN,
    BLUE,
    UNLIT,
  ];

  static final $core.List<ProtoColor?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static ProtoColor? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ProtoColor._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
