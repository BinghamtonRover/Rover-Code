//
//  Generated code. Do not modify.
//  source: logs.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
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

@$core.Deprecated('Use burtLogDescriptor instead')
const BurtLog$json = {
  '1': 'BurtLog',
  '2': [
    {'1': 'level', '3': 1, '4': 1, '5': 14, '6': '.BurtLogLevel', '10': 'level'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'body', '3': 3, '4': 1, '5': 9, '10': 'body'},
    {'1': 'device', '3': 4, '4': 1, '5': 14, '6': '.Device', '10': 'device'},
  ],
};

/// Descriptor for `BurtLog`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List burtLogDescriptor = $convert.base64Decode(
    'CgdCdXJ0TG9nEiMKBWxldmVsGAEgASgOMg0uQnVydExvZ0xldmVsUgVsZXZlbBIUCgV0aXRsZR'
    'gCIAEoCVIFdGl0bGUSEgoEYm9keRgDIAEoCVIEYm9keRIfCgZkZXZpY2UYBCABKA4yBy5EZXZp'
    'Y2VSBmRldmljZQ==');

