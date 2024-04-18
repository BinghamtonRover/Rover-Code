//
//  Generated code. Do not modify.
//  source: drive.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use driveCommandDescriptor instead')
const DriveCommand$json = {
  '1': 'DriveCommand',
  '2': [
    {'1': 'throttle', '3': 1, '4': 1, '5': 2, '10': 'throttle'},
    {'1': 'left', '3': 2, '4': 1, '5': 2, '10': 'left'},
    {'1': 'right', '3': 3, '4': 1, '5': 2, '10': 'right'},
    {'1': 'set_left', '3': 4, '4': 1, '5': 8, '10': 'setLeft'},
    {'1': 'set_right', '3': 5, '4': 1, '5': 8, '10': 'setRight'},
    {'1': 'set_throttle', '3': 6, '4': 1, '5': 8, '10': 'setThrottle'},
    {'1': 'front_swivel', '3': 7, '4': 1, '5': 2, '10': 'frontSwivel'},
    {'1': 'front_tilt', '3': 8, '4': 1, '5': 2, '10': 'frontTilt'},
    {'1': 'rear_swivel', '3': 9, '4': 1, '5': 2, '10': 'rearSwivel'},
    {'1': 'rear_tilt', '3': 10, '4': 1, '5': 2, '10': 'rearTilt'},
    {'1': 'status', '3': 11, '4': 1, '5': 14, '6': '.RoverStatus', '10': 'status'},
  ],
};

/// Descriptor for `DriveCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List driveCommandDescriptor = $convert.base64Decode(
    'CgxEcml2ZUNvbW1hbmQSGgoIdGhyb3R0bGUYASABKAJSCHRocm90dGxlEhIKBGxlZnQYAiABKA'
    'JSBGxlZnQSFAoFcmlnaHQYAyABKAJSBXJpZ2h0EhkKCHNldF9sZWZ0GAQgASgIUgdzZXRMZWZ0'
    'EhsKCXNldF9yaWdodBgFIAEoCFIIc2V0UmlnaHQSIQoMc2V0X3Rocm90dGxlGAYgASgIUgtzZX'
    'RUaHJvdHRsZRIhCgxmcm9udF9zd2l2ZWwYByABKAJSC2Zyb250U3dpdmVsEh0KCmZyb250X3Rp'
    'bHQYCCABKAJSCWZyb250VGlsdBIfCgtyZWFyX3N3aXZlbBgJIAEoAlIKcmVhclN3aXZlbBIbCg'
    'lyZWFyX3RpbHQYCiABKAJSCHJlYXJUaWx0EiQKBnN0YXR1cxgLIAEoDjIMLlJvdmVyU3RhdHVz'
    'UgZzdGF0dXM=');

@$core.Deprecated('Use driveDataDescriptor instead')
const DriveData$json = {
  '1': 'DriveData',
  '2': [
    {'1': 'throttle', '3': 1, '4': 1, '5': 2, '10': 'throttle'},
    {'1': 'left', '3': 2, '4': 1, '5': 2, '10': 'left'},
    {'1': 'right', '3': 3, '4': 1, '5': 2, '10': 'right'},
    {'1': 'set_left', '3': 4, '4': 1, '5': 8, '10': 'setLeft'},
    {'1': 'set_right', '3': 5, '4': 1, '5': 8, '10': 'setRight'},
    {'1': 'set_throttle', '3': 6, '4': 1, '5': 8, '10': 'setThrottle'},
    {'1': 'front_swivel', '3': 7, '4': 1, '5': 2, '10': 'frontSwivel'},
    {'1': 'front_tilt', '3': 8, '4': 1, '5': 2, '10': 'frontTilt'},
    {'1': 'rear_swivel', '3': 9, '4': 1, '5': 2, '10': 'rearSwivel'},
    {'1': 'rear_tilt', '3': 10, '4': 1, '5': 2, '10': 'rearTilt'},
    {'1': 'battery_voltage', '3': 11, '4': 1, '5': 2, '10': 'batteryVoltage'},
    {'1': 'battery_current', '3': 12, '4': 1, '5': 2, '10': 'batteryCurrent'},
    {'1': 'battery_temperature', '3': 13, '4': 1, '5': 2, '10': 'batteryTemperature'},
  ],
};

/// Descriptor for `DriveData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List driveDataDescriptor = $convert.base64Decode(
    'CglEcml2ZURhdGESGgoIdGhyb3R0bGUYASABKAJSCHRocm90dGxlEhIKBGxlZnQYAiABKAJSBG'
    'xlZnQSFAoFcmlnaHQYAyABKAJSBXJpZ2h0EhkKCHNldF9sZWZ0GAQgASgIUgdzZXRMZWZ0EhsK'
    'CXNldF9yaWdodBgFIAEoCFIIc2V0UmlnaHQSIQoMc2V0X3Rocm90dGxlGAYgASgIUgtzZXRUaH'
    'JvdHRsZRIhCgxmcm9udF9zd2l2ZWwYByABKAJSC2Zyb250U3dpdmVsEh0KCmZyb250X3RpbHQY'
    'CCABKAJSCWZyb250VGlsdBIfCgtyZWFyX3N3aXZlbBgJIAEoAlIKcmVhclN3aXZlbBIbCglyZW'
    'FyX3RpbHQYCiABKAJSCHJlYXJUaWx0EicKD2JhdHRlcnlfdm9sdGFnZRgLIAEoAlIOYmF0dGVy'
    'eVZvbHRhZ2USJwoPYmF0dGVyeV9jdXJyZW50GAwgASgCUg5iYXR0ZXJ5Q3VycmVudBIvChNiYX'
    'R0ZXJ5X3RlbXBlcmF0dXJlGA0gASgCUhJiYXR0ZXJ5VGVtcGVyYXR1cmU=');

