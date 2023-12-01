//
//  Generated code. Do not modify.
//  source: logs.proto
//
// @dart = 2.12

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

  const BurtLogLevel._($core.int v, $core.String n) : super(v, n);
}

class BurtError extends $pb.ProtobufEnum {
  static const BurtError burt_error_undefined = BurtError._(0, _omitEnumNames ? '' : 'burt_error_undefined');
  static const BurtError burt_error_unknown = BurtError._(1, _omitEnumNames ? '' : 'burt_error_unknown');
  static const BurtError can_init_error = BurtError._(2, _omitEnumNames ? '' : 'can_init_error');
  static const BurtError can_write_error = BurtError._(3, _omitEnumNames ? '' : 'can_write_error');
  static const BurtError can_read_error = BurtError._(4, _omitEnumNames ? '' : 'can_read_error');
  static const BurtError can_buffer_full = BurtError._(5, _omitEnumNames ? '' : 'can_buffer_full');
  static const BurtError can_misc_error = BurtError._(6, _omitEnumNames ? '' : 'can_misc_error');
  static const BurtError imu_init_error = BurtError._(7, _omitEnumNames ? '' : 'imu_init_error');
  static const BurtError imu_not_responding = BurtError._(8, _omitEnumNames ? '' : 'imu_not_responding');
  static const BurtError imu_invalid_orientation = BurtError._(9, _omitEnumNames ? '' : 'imu_invalid_orientation');
  static const BurtError imu_misc_error = BurtError._(10, _omitEnumNames ? '' : 'imu_misc_error');
  static const BurtError gps_init_error = BurtError._(11, _omitEnumNames ? '' : 'gps_init_error');
  static const BurtError gps_not_responding = BurtError._(12, _omitEnumNames ? '' : 'gps_not_responding');
  static const BurtError gps_no_fix = BurtError._(13, _omitEnumNames ? '' : 'gps_no_fix');
  static const BurtError gps_misc_error = BurtError._(14, _omitEnumNames ? '' : 'gps_misc_error');

  static const $core.List<BurtError> values = <BurtError> [
    burt_error_undefined,
    burt_error_unknown,
    can_init_error,
    can_write_error,
    can_read_error,
    can_buffer_full,
    can_misc_error,
    imu_init_error,
    imu_not_responding,
    imu_invalid_orientation,
    imu_misc_error,
    gps_init_error,
    gps_not_responding,
    gps_no_fix,
    gps_misc_error,
  ];

  static final $core.Map<$core.int, BurtError> _byValue = $pb.ProtobufEnum.initByValue(values);
  static BurtError? valueOf($core.int value) => _byValue[value];

  const BurtError._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
