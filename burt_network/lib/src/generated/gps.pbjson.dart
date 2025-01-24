//
//  Generated code. Do not modify.
//  source: gps.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use rTKModeDescriptor instead')
const RTKMode$json = {
  '1': 'RTKMode',
  '2': [
    {'1': 'RTK_NONE', '2': 0},
    {'1': 'RTK_FLOAT', '2': 1},
    {'1': 'RTK_FIXED', '2': 2},
  ],
};

/// Descriptor for `RTKMode`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List rTKModeDescriptor = $convert.base64Decode(
    'CgdSVEtNb2RlEgwKCFJUS19OT05FEAASDQoJUlRLX0ZMT0FUEAESDQoJUlRLX0ZJWEVEEAI=');

@$core.Deprecated('Use gpsCoordinatesDescriptor instead')
const GpsCoordinates$json = {
  '1': 'GpsCoordinates',
  '2': [
    {'1': 'latitude', '3': 1, '4': 1, '5': 1, '10': 'latitude'},
    {'1': 'longitude', '3': 2, '4': 1, '5': 1, '10': 'longitude'},
    {'1': 'altitude', '3': 3, '4': 1, '5': 1, '10': 'altitude'},
    {'1': 'rtkMode', '3': 4, '4': 1, '5': 14, '6': '.RTKMode', '10': 'rtkMode'},
  ],
};

/// Descriptor for `GpsCoordinates`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gpsCoordinatesDescriptor = $convert.base64Decode(
    'Cg5HcHNDb29yZGluYXRlcxIaCghsYXRpdHVkZRgBIAEoAVIIbGF0aXR1ZGUSHAoJbG9uZ2l0dW'
    'RlGAIgASgBUglsb25naXR1ZGUSGgoIYWx0aXR1ZGUYAyABKAFSCGFsdGl0dWRlEiIKB3J0a01v'
    'ZGUYBCABKA4yCC5SVEtNb2RlUgdydGtNb2Rl');

@$core.Deprecated('Use roverPositionDescriptor instead')
const RoverPosition$json = {
  '1': 'RoverPosition',
  '2': [
    {'1': 'gps', '3': 1, '4': 1, '5': 11, '6': '.GpsCoordinates', '10': 'gps'},
    {'1': 'orientation', '3': 2, '4': 1, '5': 11, '6': '.Orientation', '10': 'orientation'},
    {'1': 'version', '3': 3, '4': 1, '5': 11, '6': '.Version', '10': 'version'},
    {'1': 'rtkMessage', '3': 4, '4': 1, '5': 12, '10': 'rtkMessage'},
  ],
};

/// Descriptor for `RoverPosition`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List roverPositionDescriptor = $convert.base64Decode(
    'Cg1Sb3ZlclBvc2l0aW9uEiEKA2dwcxgBIAEoCzIPLkdwc0Nvb3JkaW5hdGVzUgNncHMSLgoLb3'
    'JpZW50YXRpb24YAiABKAsyDC5PcmllbnRhdGlvblILb3JpZW50YXRpb24SIgoHdmVyc2lvbhgD'
    'IAEoCzIILlZlcnNpb25SB3ZlcnNpb24SHgoKcnRrTWVzc2FnZRgEIAEoDFIKcnRrTWVzc2FnZQ'
    '==');

