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

@$core.Deprecated('Use augerCommandDescriptor instead')
const AugerCommand$json = {
  '1': 'AugerCommand',
  '2': [
    {
      '1': 'speed_rpm',
      '3': 1,
      '4': 1,
      '5': 2,
      '9': 0,
      '10': 'speedRpm',
      '17': true
    },
    {
      '1': 'upper_servo',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.ServoState',
      '10': 'upperServo'
    },
    {
      '1': 'lower_servo',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.ServoState',
      '10': 'lowerServo'
    },
  ],
  '8': [
    {'1': '_speed_rpm'},
  ],
};

/// Descriptor for `AugerCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List augerCommandDescriptor = $convert.base64Decode(
    'CgxBdWdlckNvbW1hbmQSIAoJc3BlZWRfcnBtGAEgASgCSABSCHNwZWVkUnBtiAEBEiwKC3VwcG'
    'VyX3NlcnZvGAIgASgOMgsuU2Vydm9TdGF0ZVIKdXBwZXJTZXJ2bxIsCgtsb3dlcl9zZXJ2bxgD'
    'IAEoDjILLlNlcnZvU3RhdGVSCmxvd2VyU2Vydm9CDAoKX3NwZWVkX3JwbQ==');

@$core.Deprecated('Use augerDataDescriptor instead')
const AugerData$json = {
  '1': 'AugerData',
  '2': [
    {
      '1': 'lower_servo',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.ServoState',
      '10': 'lowerServo'
    },
    {
      '1': 'upper_servo',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.ServoState',
      '10': 'upperServo'
    },
    {
      '1': 'distance_to_ground_cm',
      '3': 3,
      '4': 1,
      '5': 2,
      '10': 'distanceToGroundCm'
    },
    {'1': 'current', '3': 4, '4': 1, '5': 2, '10': 'current'},
  ],
};

/// Descriptor for `AugerData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List augerDataDescriptor = $convert.base64Decode(
    'CglBdWdlckRhdGESLAoLbG93ZXJfc2Vydm8YASABKA4yCy5TZXJ2b1N0YXRlUgpsb3dlclNlcn'
    'ZvEiwKC3VwcGVyX3NlcnZvGAIgASgOMgsuU2Vydm9TdGF0ZVIKdXBwZXJTZXJ2bxIxChVkaXN0'
    'YW5jZV90b19ncm91bmRfY20YAyABKAJSEmRpc3RhbmNlVG9Hcm91bmRDbRIYCgdjdXJyZW50GA'
    'QgASgCUgdjdXJyZW50');

@$core.Deprecated('Use scienceCommandDescriptor instead')
const ScienceCommand$json = {
  '1': 'ScienceCommand',
  '2': [
    {'1': 'carousel_motor', '3': 1, '4': 1, '5': 2, '10': 'carouselMotor'},
    {'1': 'linear_slider', '3': 3, '4': 1, '5': 2, '10': 'linearSlider'},
    {
      '1': 'auger',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.AugerCommand',
      '10': 'auger'
    },
    {'1': 'pumps', '3': 4, '4': 1, '5': 14, '6': '.PumpState', '10': 'pumps'},
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
  '9': [
    {'1': 2, '2': 3},
    {'1': 5, '2': 7},
  ],
};

/// Descriptor for `ScienceCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scienceCommandDescriptor = $convert.base64Decode(
    'Cg5TY2llbmNlQ29tbWFuZBIlCg5jYXJvdXNlbF9tb3RvchgBIAEoAlINY2Fyb3VzZWxNb3Rvch'
    'IjCg1saW5lYXJfc2xpZGVyGAMgASgCUgxsaW5lYXJTbGlkZXISIwoFYXVnZXIYDSABKAsyDS5B'
    'dWdlckNvbW1hbmRSBWF1Z2VyEiAKBXB1bXBzGAQgASgOMgouUHVtcFN0YXRlUgVwdW1wcxIsCg'
    'hjYXJvdXNlbBgHIAEoDjIQLkNhcm91c2VsQ29tbWFuZFIIY2Fyb3VzZWwSHAoJY2FsaWJyYXRl'
    'GAggASgIUgljYWxpYnJhdGUSEgoEc3RvcBgJIAEoCFIEc3RvcBIWCgZzYW1wbGUYCiABKAVSBn'
    'NhbXBsZRIjCgVzdGF0ZRgLIAEoDjINLlNjaWVuY2VTdGF0ZVIFc3RhdGUSIgoHdmVyc2lvbhgM'
    'IAEoCzIILlZlcnNpb25SB3ZlcnNpb25KBAgCEANKBAgFEAc=');

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
    {'1': 'auger', '3': 7, '4': 1, '5': 11, '6': '.AugerData', '10': 'auger'},
  ],
};

/// Descriptor for `ScienceData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scienceDataDescriptor = $convert.base64Decode(
    'CgtTY2llbmNlRGF0YRIWCgZzYW1wbGUYASABKAVSBnNhbXBsZRIjCgVzdGF0ZRgCIAEoDjINLl'
    'NjaWVuY2VTdGF0ZVIFc3RhdGUSEAoDY28yGAMgASgCUgNjbzISGgoIaHVtaWRpdHkYBCABKAJS'
    'CGh1bWlkaXR5EiAKC3RlbXBlcmF0dXJlGAUgASgCUgt0ZW1wZXJhdHVyZRIiCgd2ZXJzaW9uGA'
    'YgASgLMgguVmVyc2lvblIHdmVyc2lvbhIgCgVhdWdlchgHIAEoCzIKLkF1Z2VyRGF0YVIFYXVn'
    'ZXI=');
