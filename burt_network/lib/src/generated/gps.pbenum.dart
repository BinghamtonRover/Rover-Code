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

class RTKMode extends $pb.ProtobufEnum {
  static const RTKMode RTK_NONE =
      RTKMode._(0, _omitEnumNames ? '' : 'RTK_NONE');
  static const RTKMode RTK_FLOAT =
      RTKMode._(1, _omitEnumNames ? '' : 'RTK_FLOAT');
  static const RTKMode RTK_FIXED =
      RTKMode._(2, _omitEnumNames ? '' : 'RTK_FIXED');

  static const $core.List<RTKMode> values = <RTKMode>[
    RTK_NONE,
    RTK_FLOAT,
    RTK_FIXED,
  ];

  static final $core.List<RTKMode?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static RTKMode? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const RTKMode._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
