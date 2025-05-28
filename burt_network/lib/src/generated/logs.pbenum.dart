// This is a generated file - do not edit.
//
// Generated from logs.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class BurtLogLevel extends $pb.ProtobufEnum {
  static const BurtLogLevel BURT_LOG_LEVEL_UNDEFINED =
      BurtLogLevel._(0, _omitEnumNames ? '' : 'BURT_LOG_LEVEL_UNDEFINED');
  static const BurtLogLevel critical =
      BurtLogLevel._(1, _omitEnumNames ? '' : 'critical');
  static const BurtLogLevel error =
      BurtLogLevel._(2, _omitEnumNames ? '' : 'error');
  static const BurtLogLevel warning =
      BurtLogLevel._(3, _omitEnumNames ? '' : 'warning');
  static const BurtLogLevel info =
      BurtLogLevel._(4, _omitEnumNames ? '' : 'info');
  static const BurtLogLevel debug =
      BurtLogLevel._(5, _omitEnumNames ? '' : 'debug');
  static const BurtLogLevel trace =
      BurtLogLevel._(6, _omitEnumNames ? '' : 'trace');

  static const $core.List<BurtLogLevel> values = <BurtLogLevel>[
    BURT_LOG_LEVEL_UNDEFINED,
    critical,
    error,
    warning,
    info,
    debug,
    trace,
  ];

  static final $core.List<BurtLogLevel?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 6);
  static BurtLogLevel? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const BurtLogLevel._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
