// This is a generated file - do not edit.
//
// Generated from utils.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

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
