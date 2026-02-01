// This is a generated file - do not edit.
//
// Generated from science.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use servoStateDescriptor instead')
const ServoState$json = {
  '1': 'ServoState',
  '2': [
    {'1': 'SERVO_STATE_UNDEFINED', '2': 0},
    {'1': 'SERVO_OPEN', '2': 1},
    {'1': 'SERVO_CLOSE', '2': 2},
  ],
};

/// Descriptor for `ServoState`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List servoStateDescriptor = $convert.base64Decode(
    'CgpTZXJ2b1N0YXRlEhkKFVNFUlZPX1NUQVRFX1VOREVGSU5FRBAAEg4KClNFUlZPX09QRU4QAR'
    'IPCgtTRVJWT19DTE9TRRAC');

@$core.Deprecated('Use pumpStateDescriptor instead')
const PumpState$json = {
  '1': 'PumpState',
  '2': [
    {'1': 'PUMP_STATE_UNDEFINED', '2': 0},
    {'1': 'PUMP_ON', '2': 1},
    {'1': 'PUMP_OFF', '2': 2},
    {'1': 'FILL', '2': 3},
  ],
};

/// Descriptor for `PumpState`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List pumpStateDescriptor = $convert.base64Decode(
    'CglQdW1wU3RhdGUSGAoUUFVNUF9TVEFURV9VTkRFRklORUQQABILCgdQVU1QX09OEAESDAoIUF'
    'VNUF9PRkYQAhIICgRGSUxMEAM=');

@$core.Deprecated('Use scienceStateDescriptor instead')
const ScienceState$json = {
  '1': 'ScienceState',
  '2': [
    {'1': 'SCIENCE_STATE_UNDEFINED', '2': 0},
    {'1': 'COLLECT_DATA', '2': 1},
    {'1': 'STOP_COLLECTING', '2': 2},
  ],
};

/// Descriptor for `ScienceState`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List scienceStateDescriptor = $convert.base64Decode(
    'CgxTY2llbmNlU3RhdGUSGwoXU0NJRU5DRV9TVEFURV9VTkRFRklORUQQABIQCgxDT0xMRUNUX0'
    'RBVEEQARITCg9TVE9QX0NPTExFQ1RJTkcQAg==');

@$core.Deprecated('Use carouselCommandDescriptor instead')
const CarouselCommand$json = {
  '1': 'CarouselCommand',
  '2': [
    {'1': 'CAROUSEL_COMMAND_UNDEFINED', '2': 0},
    {'1': 'NEXT_TUBE', '2': 1},
    {'1': 'PREV_TUBE', '2': 2},
    {'1': 'NEXT_SECTION', '2': 3},
    {'1': 'PREV_SECTION', '2': 4},
    {'1': 'FILL_TUBE', '2': 5},
    {'1': 'FILL_SECTION', '2': 6},
  ],
};

/// Descriptor for `CarouselCommand`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List carouselCommandDescriptor = $convert.base64Decode(
    'Cg9DYXJvdXNlbENvbW1hbmQSHgoaQ0FST1VTRUxfQ09NTUFORF9VTkRFRklORUQQABINCglORV'
    'hUX1RVQkUQARINCglQUkVWX1RVQkUQAhIQCgxORVhUX1NFQ1RJT04QAxIQCgxQUkVWX1NFQ1RJ'
    'T04QBBINCglGSUxMX1RVQkUQBRIQCgxGSUxMX1NFQ1RJT04QBg==');

@$core.Deprecated('Use scienceCommandDescriptor instead')
const ScienceCommand$json = {
  '1': 'ScienceCommand',
  '2': [
    {'1': 'carousel_motor', '3': 1, '4': 1, '5': 2, '10': 'carouselMotor'},
    {'1': 'subsurface_motor', '3': 3, '4': 1, '5': 2, '10': 'subsurfaceMotor'},
    {'1': 'pumps', '3': 4, '4': 1, '5': 14, '6': '.PumpState', '10': 'pumps'},
    {
      '1': 'funnel',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.ServoState',
      '10': 'funnel'
    },
    {
      '1': 'carousel',
      '3': 7,
      '4': 1,
      '5': 14,
      '6': '.CarouselCommand',
      '10': 'carousel'
    },
    {'1': 'calibrate', '3': 8, '4': 1, '5': 8, '10': 'calibrate'},
    {'1': 'stop', '3': 9, '4': 1, '5': 8, '10': 'stop'},
    {'1': 'sample', '3': 10, '4': 1, '5': 5, '10': 'sample'},
    {
      '1': 'state',
      '3': 11,
      '4': 1,
      '5': 14,
      '6': '.ScienceState',
      '10': 'state'
    },
    {
      '1': 'version',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.Version',
      '10': 'version'
    },
  ],
};

/// Descriptor for `ScienceCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scienceCommandDescriptor = $convert.base64Decode(
    'Cg5TY2llbmNlQ29tbWFuZBIlCg5jYXJvdXNlbF9tb3RvchgBIAEoAlINY2Fyb3VzZWxNb3Rvch'
    'IpChBzdWJzdXJmYWNlX21vdG9yGAMgASgCUg9zdWJzdXJmYWNlTW90b3ISIAoFcHVtcHMYBCAB'
    'KA4yCi5QdW1wU3RhdGVSBXB1bXBzEiMKBmZ1bm5lbBgFIAEoDjILLlNlcnZvU3RhdGVSBmZ1bm'
    '5lbBIsCghjYXJvdXNlbBgHIAEoDjIQLkNhcm91c2VsQ29tbWFuZFIIY2Fyb3VzZWwSHAoJY2Fs'
    'aWJyYXRlGAggASgIUgljYWxpYnJhdGUSEgoEc3RvcBgJIAEoCFIEc3RvcBIWCgZzYW1wbGUYCi'
    'ABKAVSBnNhbXBsZRIjCgVzdGF0ZRgLIAEoDjINLlNjaWVuY2VTdGF0ZVIFc3RhdGUSIgoHdmVy'
    'c2lvbhgMIAEoCzIILlZlcnNpb25SB3ZlcnNpb24=');

@$core.Deprecated('Use scienceDataDescriptor instead')
const ScienceData$json = {
  '1': 'ScienceData',
  '2': [
    {'1': 'sample', '3': 1, '4': 1, '5': 5, '10': 'sample'},
    {
      '1': 'state',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.ScienceState',
      '10': 'state'
    },
    {'1': 'co2', '3': 3, '4': 1, '5': 2, '10': 'co2'},
    {'1': 'humidity', '3': 4, '4': 1, '5': 2, '10': 'humidity'},
    {'1': 'temperature', '3': 5, '4': 1, '5': 2, '10': 'temperature'},
    {'1': 'version', '3': 6, '4': 1, '5': 11, '6': '.Version', '10': 'version'},
  ],
};

/// Descriptor for `ScienceData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scienceDataDescriptor = $convert.base64Decode(
    'CgtTY2llbmNlRGF0YRIWCgZzYW1wbGUYASABKAVSBnNhbXBsZRIjCgVzdGF0ZRgCIAEoDjINLl'
    'NjaWVuY2VTdGF0ZVIFc3RhdGUSEAoDY28yGAMgASgCUgNjbzISGgoIaHVtaWRpdHkYBCABKAJS'
    'CGh1bWlkaXR5EiAKC3RlbXBlcmF0dXJlGAUgASgCUgt0ZW1wZXJhdHVyZRIiCgd2ZXJzaW9uGA'
    'YgASgLMgguVmVyc2lvblIHdmVyc2lvbg==');
