//
//  Generated code. Do not modify.
//  source: utils.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use boolStateDescriptor instead')
const BoolState$json = {
  '1': 'BoolState',
  '2': [
    {'1': 'BOOL_UNDEFINED', '2': 0},
    {'1': 'ON', '2': 1},
    {'1': 'OFF', '2': 2},
    {'1': 'YES', '2': 1},
    {'1': 'NO', '2': 2},
    {'1': 'OPEN', '2': 1},
    {'1': 'CLOSE', '2': 2},
  ],
  '3': {'2': true},
};

/// Descriptor for `BoolState`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List boolStateDescriptor = $convert.base64Decode(
    'CglCb29sU3RhdGUSEgoOQk9PTF9VTkRFRklORUQQABIGCgJPThABEgcKA09GRhACEgcKA1lFUx'
    'ABEgYKAk5PEAISCAoET1BFThABEgkKBUNMT1NFEAIaAhAB');

