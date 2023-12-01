//
//  Generated code. Do not modify.
//  source: logs.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use burtLogLevelDescriptor instead')
const BurtLogLevel$json = {
  '1': 'BurtLogLevel',
  '2': [
    {'1': 'BURT_LOG_LEVEL_UNDEFINED', '2': 0},
    {'1': 'critical', '2': 1},
    {'1': 'error', '2': 2},
    {'1': 'warning', '2': 3},
    {'1': 'info', '2': 4},
    {'1': 'debug', '2': 5},
    {'1': 'trace', '2': 6},
  ],
};

/// Descriptor for `BurtLogLevel`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List burtLogLevelDescriptor = $convert.base64Decode(
    'CgxCdXJ0TG9nTGV2ZWwSHAoYQlVSVF9MT0dfTEVWRUxfVU5ERUZJTkVEEAASDAoIY3JpdGljYW'
    'wQARIJCgVlcnJvchACEgsKB3dhcm5pbmcQAxIICgRpbmZvEAQSCQoFZGVidWcQBRIJCgV0cmFj'
    'ZRAG');

@$core.Deprecated('Use burtErrorDescriptor instead')
const BurtError$json = {
  '1': 'BurtError',
  '2': [
    {'1': 'burt_error_undefined', '2': 0},
    {'1': 'burt_error_unknown', '2': 1},
    {'1': 'can_init_error', '2': 2},
    {'1': 'can_write_error', '2': 3},
    {'1': 'can_read_error', '2': 4},
    {'1': 'can_buffer_full', '2': 5},
    {'1': 'can_misc_error', '2': 6},
    {'1': 'imu_init_error', '2': 7},
    {'1': 'imu_not_responding', '2': 8},
    {'1': 'imu_invalid_orientation', '2': 9},
    {'1': 'imu_misc_error', '2': 10},
    {'1': 'gps_init_error', '2': 11},
    {'1': 'gps_not_responding', '2': 12},
    {'1': 'gps_no_fix', '2': 13},
    {'1': 'gps_misc_error', '2': 14},
  ],
};

/// Descriptor for `BurtError`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List burtErrorDescriptor = $convert.base64Decode(
    'CglCdXJ0RXJyb3ISGAoUYnVydF9lcnJvcl91bmRlZmluZWQQABIWChJidXJ0X2Vycm9yX3Vua2'
    '5vd24QARISCg5jYW5faW5pdF9lcnJvchACEhMKD2Nhbl93cml0ZV9lcnJvchADEhIKDmNhbl9y'
    'ZWFkX2Vycm9yEAQSEwoPY2FuX2J1ZmZlcl9mdWxsEAUSEgoOY2FuX21pc2NfZXJyb3IQBhISCg'
    '5pbXVfaW5pdF9lcnJvchAHEhYKEmltdV9ub3RfcmVzcG9uZGluZxAIEhsKF2ltdV9pbnZhbGlk'
    'X29yaWVudGF0aW9uEAkSEgoOaW11X21pc2NfZXJyb3IQChISCg5ncHNfaW5pdF9lcnJvchALEh'
    'YKEmdwc19ub3RfcmVzcG9uZGluZxAMEg4KCmdwc19ub19maXgQDRISCg5ncHNfbWlzY19lcnJv'
    'chAO');

@$core.Deprecated('Use burtLogDescriptor instead')
const BurtLog$json = {
  '1': 'BurtLog',
  '2': [
    {'1': 'level', '3': 1, '4': 1, '5': 14, '6': '.BurtLogLevel', '10': 'level'},
    {'1': 'title', '3': 3, '4': 1, '5': 9, '10': 'title'},
    {'1': 'body', '3': 2, '4': 1, '5': 9, '10': 'body'},
  ],
};

/// Descriptor for `BurtLog`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List burtLogDescriptor = $convert.base64Decode(
    'CgdCdXJ0TG9nEiMKBWxldmVsGAEgASgOMg0uQnVydExvZ0xldmVsUgVsZXZlbBIUCgV0aXRsZR'
    'gDIAEoCVIFdGl0bGUSEgoEYm9keRgCIAEoCVIEYm9keQ==');

