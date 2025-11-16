//
//  Generated code. Do not modify.
//  source: logs.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class BurtLogLevel extends $pb.ProtobufEnum {
  static const BurtLogLevel BURT_LOG_LEVEL_UNDEFINED = BurtLogLevel._(0, _omitEnumNames ? '' : 'BURT_LOG_LEVEL_UNDEFINED');
  static const BurtLogLevel critical = BurtLogLevel._(1, _omitEnumNames ? '' : 'critical');
  static const BurtLogLevel error = BurtLogLevel._(2, _omitEnumNames ? '' : 'error');
  static const BurtLogLevel warning = BurtLogLevel._(3, _omitEnumNames ? '' : 'warning');
  static const BurtLogLevel info = BurtLogLevel._(4, _omitEnumNames ? '' : 'info');
  static const BurtLogLevel debug = BurtLogLevel._(5, _omitEnumNames ? '' : 'debug');
  static const BurtLogLevel trace = BurtLogLevel._(6, _omitEnumNames ? '' : 'trace');

  static const $core.List<BurtLogLevel> values = <BurtLogLevel> [
    BURT_LOG_LEVEL_UNDEFINED,
    critical,
    error,
    warning,
    info,
    debug,
    trace,
  ];

  static final $core.Map<$core.int, BurtLogLevel> _byValue = $pb.ProtobufEnum.initByValue(values);
  static BurtLogLevel? valueOf($core.int value) => _byValue[value];

  const BurtLogLevel._(super.v, super.n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
