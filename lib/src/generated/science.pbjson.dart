//
//  Generated code. Do not modify.
//  source: science.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use pumpStateDescriptor instead')
const PumpState$json = {
  '1': 'PumpState',
  '2': [
    {'1': 'PUMP_STATE_UNDEFINED', '2': 0},
    {'1': 'PUMP_ON', '2': 1},
    {'1': 'PUMP_OFF', '2': 2},
  ],
};

/// Descriptor for `PumpState`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List pumpStateDescriptor = $convert.base64Decode(
    'CglQdW1wU3RhdGUSGAoUUFVNUF9TVEFURV9VTkRFRklORUQQABILCgdQVU1QX09OEAESDAoIUF'
    'VNUF9PRkYQAg==');

@$core.Deprecated('Use dirtReleaseStateDescriptor instead')
const DirtReleaseState$json = {
  '1': 'DirtReleaseState',
  '2': [
    {'1': 'DIRT_RELEASE_STATE_UNDEFINED', '2': 0},
    {'1': 'OPEN_DIRT', '2': 1},
    {'1': 'CLOSE_DIRT', '2': 2},
  ],
};

/// Descriptor for `DirtReleaseState`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List dirtReleaseStateDescriptor = $convert.base64Decode(
    'ChBEaXJ0UmVsZWFzZVN0YXRlEiAKHERJUlRfUkVMRUFTRV9TVEFURV9VTkRFRklORUQQABINCg'
    'lPUEVOX0RJUlQQARIOCgpDTE9TRV9ESVJUEAI=');

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

@$core.Deprecated('Use scienceCommandDescriptor instead')
const ScienceCommand$json = {
  '1': 'ScienceCommand',
  '2': [
    {'1': 'dirt_carousel', '3': 1, '4': 1, '5': 2, '10': 'dirtCarousel'},
    {'1': 'dirt_linear', '3': 2, '4': 1, '5': 2, '10': 'dirtLinear'},
    {'1': 'science_linear', '3': 3, '4': 1, '5': 2, '10': 'scienceLinear'},
    {'1': 'vacuum_linear', '3': 4, '4': 1, '5': 2, '10': 'vacuumLinear'},
    {'1': 'vacuum', '3': 5, '4': 1, '5': 14, '6': '.PumpState', '10': 'vacuum'},
    {'1': 'dirtRelease', '3': 7, '4': 1, '5': 14, '6': '.DirtReleaseState', '10': 'dirtRelease'},
    {'1': 'pump1', '3': 8, '4': 1, '5': 14, '6': '.PumpState', '10': 'pump1'},
    {'1': 'pump2', '3': 9, '4': 1, '5': 14, '6': '.PumpState', '10': 'pump2'},
    {'1': 'pump3', '3': 10, '4': 1, '5': 14, '6': '.PumpState', '10': 'pump3'},
    {'1': 'pump4', '3': 11, '4': 1, '5': 14, '6': '.PumpState', '10': 'pump4'},
    {'1': 'calibrate', '3': 12, '4': 1, '5': 8, '10': 'calibrate'},
    {'1': 'stop', '3': 13, '4': 1, '5': 8, '10': 'stop'},
    {'1': 'next_tube', '3': 14, '4': 1, '5': 8, '10': 'nextTube'},
    {'1': 'next_section', '3': 15, '4': 1, '5': 8, '10': 'nextSection'},
    {'1': 'sample', '3': 16, '4': 1, '5': 5, '10': 'sample'},
    {'1': 'state', '3': 17, '4': 1, '5': 14, '6': '.ScienceState', '10': 'state'},
  ],
};

/// Descriptor for `ScienceCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scienceCommandDescriptor = $convert.base64Decode(
    'Cg5TY2llbmNlQ29tbWFuZBIjCg1kaXJ0X2Nhcm91c2VsGAEgASgCUgxkaXJ0Q2Fyb3VzZWwSHw'
    'oLZGlydF9saW5lYXIYAiABKAJSCmRpcnRMaW5lYXISJQoOc2NpZW5jZV9saW5lYXIYAyABKAJS'
    'DXNjaWVuY2VMaW5lYXISIwoNdmFjdXVtX2xpbmVhchgEIAEoAlIMdmFjdXVtTGluZWFyEiIKBn'
    'ZhY3V1bRgFIAEoDjIKLlB1bXBTdGF0ZVIGdmFjdXVtEjMKC2RpcnRSZWxlYXNlGAcgASgOMhEu'
    'RGlydFJlbGVhc2VTdGF0ZVILZGlydFJlbGVhc2USIAoFcHVtcDEYCCABKA4yCi5QdW1wU3RhdG'
    'VSBXB1bXAxEiAKBXB1bXAyGAkgASgOMgouUHVtcFN0YXRlUgVwdW1wMhIgCgVwdW1wMxgKIAEo'
    'DjIKLlB1bXBTdGF0ZVIFcHVtcDMSIAoFcHVtcDQYCyABKA4yCi5QdW1wU3RhdGVSBXB1bXA0Eh'
    'wKCWNhbGlicmF0ZRgMIAEoCFIJY2FsaWJyYXRlEhIKBHN0b3AYDSABKAhSBHN0b3ASGwoJbmV4'
    'dF90dWJlGA4gASgIUghuZXh0VHViZRIhCgxuZXh0X3NlY3Rpb24YDyABKAhSC25leHRTZWN0aW'
    '9uEhYKBnNhbXBsZRgQIAEoBVIGc2FtcGxlEiMKBXN0YXRlGBEgASgOMg0uU2NpZW5jZVN0YXRl'
    'UgVzdGF0ZQ==');

@$core.Deprecated('Use scienceDataDescriptor instead')
const ScienceData$json = {
  '1': 'ScienceData',
  '2': [
    {'1': 'co2', '3': 1, '4': 1, '5': 2, '10': 'co2'},
    {'1': 'humidity', '3': 2, '4': 1, '5': 2, '10': 'humidity'},
    {'1': 'methane', '3': 3, '4': 1, '5': 2, '10': 'methane'},
    {'1': 'pH', '3': 4, '4': 1, '5': 2, '10': 'pH'},
    {'1': 'temperature', '3': 5, '4': 1, '5': 2, '10': 'temperature'},
    {'1': 'sample', '3': 6, '4': 1, '5': 5, '10': 'sample'},
    {'1': 'state', '3': 7, '4': 1, '5': 14, '6': '.ScienceState', '10': 'state'},
  ],
};

/// Descriptor for `ScienceData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scienceDataDescriptor = $convert.base64Decode(
    'CgtTY2llbmNlRGF0YRIQCgNjbzIYASABKAJSA2NvMhIaCghodW1pZGl0eRgCIAEoAlIIaHVtaW'
    'RpdHkSGAoHbWV0aGFuZRgDIAEoAlIHbWV0aGFuZRIOCgJwSBgEIAEoAlICcEgSIAoLdGVtcGVy'
    'YXR1cmUYBSABKAJSC3RlbXBlcmF0dXJlEhYKBnNhbXBsZRgGIAEoBVIGc2FtcGxlEiMKBXN0YX'
    'RlGAcgASgOMg0uU2NpZW5jZVN0YXRlUgVzdGF0ZQ==');

