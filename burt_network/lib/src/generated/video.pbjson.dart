// This is a generated file - do not edit.
//
// Generated from video.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use cameraStatusDescriptor instead')
const CameraStatus$json = {
  '1': 'CameraStatus',
  '2': [
    {'1': 'CAMERA_STATUS_UNDEFINED', '2': 0},
    {'1': 'CAMERA_DISCONNECTED', '2': 1},
    {'1': 'CAMERA_ENABLED', '2': 2},
    {'1': 'CAMERA_DISABLED', '2': 3},
    {'1': 'CAMERA_NOT_RESPONDING', '2': 4},
    {'1': 'CAMERA_LOADING', '2': 5},
    {'1': 'FRAME_TOO_LARGE', '2': 6},
    {'1': 'CAMERA_HAS_NO_NAME', '2': 7},
  ],
};

/// Descriptor for `CameraStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List cameraStatusDescriptor = $convert.base64Decode(
    'CgxDYW1lcmFTdGF0dXMSGwoXQ0FNRVJBX1NUQVRVU19VTkRFRklORUQQABIXChNDQU1FUkFfRE'
    'lTQ09OTkVDVEVEEAESEgoOQ0FNRVJBX0VOQUJMRUQQAhITCg9DQU1FUkFfRElTQUJMRUQQAxIZ'
    'ChVDQU1FUkFfTk9UX1JFU1BPTkRJTkcQBBISCg5DQU1FUkFfTE9BRElORxAFEhMKD0ZSQU1FX1'
    'RPT19MQVJHRRAGEhYKEkNBTUVSQV9IQVNfTk9fTkFNRRAH');

@$core.Deprecated('Use cameraNameDescriptor instead')
const CameraName$json = {
  '1': 'CameraName',
  '2': [
    {'1': 'CAMERA_NAME_UNDEFINED', '2': 0},
    {'1': 'ROVER_FRONT', '2': 1},
    {'1': 'ROVER_REAR', '2': 2},
    {'1': 'AUTONOMY_DEPTH', '2': 3},
    {'1': 'SUBSYSTEM1', '2': 4},
    {'1': 'SUBSYSTEM2', '2': 5},
    {'1': 'SUBSYSTEM3', '2': 6},
    {'1': 'BOTTOM_LEFT', '2': 7},
    {'1': 'BOTTOM_RIGHT', '2': 8},
  ],
};

/// Descriptor for `CameraName`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List cameraNameDescriptor = $convert.base64Decode(
    'CgpDYW1lcmFOYW1lEhkKFUNBTUVSQV9OQU1FX1VOREVGSU5FRBAAEg8KC1JPVkVSX0ZST05UEA'
    'ESDgoKUk9WRVJfUkVBUhACEhIKDkFVVE9OT01ZX0RFUFRIEAMSDgoKU1VCU1lTVEVNMRAEEg4K'
    'ClNVQlNZU1RFTTIQBRIOCgpTVUJTWVNURU0zEAYSDwoLQk9UVE9NX0xFRlQQBxIQCgxCT1RUT0'
    '1fUklHSFQQCA==');

@$core.Deprecated('Use cameraDetailsDescriptor instead')
const CameraDetails$json = {
  '1': 'CameraDetails',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 14, '6': '.CameraName', '10': 'name'},
    {'1': 'resolution_width', '3': 2, '4': 1, '5': 5, '10': 'resolutionWidth'},
    {
      '1': 'resolution_height',
      '3': 3,
      '4': 1,
      '5': 5,
      '10': 'resolutionHeight'
    },
    {'1': 'quality', '3': 4, '4': 1, '5': 5, '10': 'quality'},
    {'1': 'fps', '3': 5, '4': 1, '5': 5, '10': 'fps'},
    {
      '1': 'status',
      '3': 6,
      '4': 1,
      '5': 14,
      '6': '.CameraStatus',
      '10': 'status'
    },
    {'1': 'autofocus', '3': 7, '4': 1, '5': 8, '10': 'autofocus'},
    {'1': 'zoom', '3': 8, '4': 1, '5': 5, '10': 'zoom'},
    {'1': 'pan', '3': 9, '4': 1, '5': 5, '10': 'pan'},
    {'1': 'tilt', '3': 10, '4': 1, '5': 5, '10': 'tilt'},
    {'1': 'focus', '3': 11, '4': 1, '5': 5, '10': 'focus'},
    {'1': 'diagonal_fov', '3': 12, '4': 1, '5': 2, '10': 'diagonalFov'},
    {'1': 'horizontal_fov', '3': 13, '4': 1, '5': 2, '10': 'horizontalFov'},
    {'1': 'vertical_fov', '3': 14, '4': 1, '5': 2, '10': 'verticalFov'},
    {'1': 'stream_width', '3': 15, '4': 1, '5': 5, '10': 'streamWidth'},
    {'1': 'stream_height', '3': 16, '4': 1, '5': 5, '10': 'streamHeight'},
  ],
};

/// Descriptor for `CameraDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cameraDetailsDescriptor = $convert.base64Decode(
    'Cg1DYW1lcmFEZXRhaWxzEh8KBG5hbWUYASABKA4yCy5DYW1lcmFOYW1lUgRuYW1lEikKEHJlc2'
    '9sdXRpb25fd2lkdGgYAiABKAVSD3Jlc29sdXRpb25XaWR0aBIrChFyZXNvbHV0aW9uX2hlaWdo'
    'dBgDIAEoBVIQcmVzb2x1dGlvbkhlaWdodBIYCgdxdWFsaXR5GAQgASgFUgdxdWFsaXR5EhAKA2'
    'ZwcxgFIAEoBVIDZnBzEiUKBnN0YXR1cxgGIAEoDjINLkNhbWVyYVN0YXR1c1IGc3RhdHVzEhwK'
    'CWF1dG9mb2N1cxgHIAEoCFIJYXV0b2ZvY3VzEhIKBHpvb20YCCABKAVSBHpvb20SEAoDcGFuGA'
    'kgASgFUgNwYW4SEgoEdGlsdBgKIAEoBVIEdGlsdBIUCgVmb2N1cxgLIAEoBVIFZm9jdXMSIQoM'
    'ZGlhZ29uYWxfZm92GAwgASgCUgtkaWFnb25hbEZvdhIlCg5ob3Jpem9udGFsX2ZvdhgNIAEoAl'
    'INaG9yaXpvbnRhbEZvdhIhCgx2ZXJ0aWNhbF9mb3YYDiABKAJSC3ZlcnRpY2FsRm92EiEKDHN0'
    'cmVhbV93aWR0aBgPIAEoBVILc3RyZWFtV2lkdGgSIwoNc3RyZWFtX2hlaWdodBgQIAEoBVIMc3'
    'RyZWFtSGVpZ2h0');

@$core.Deprecated('Use videoDataDescriptor instead')
const VideoData$json = {
  '1': 'VideoData',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'details',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.CameraDetails',
      '10': 'details'
    },
    {'1': 'frame', '3': 3, '4': 1, '5': 12, '10': 'frame'},
    {'1': 'version', '3': 4, '4': 1, '5': 11, '6': '.Version', '10': 'version'},
    {'1': 'imagePath', '3': 5, '4': 1, '5': 9, '10': 'imagePath'},
    {
      '1': 'detectedObjects',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.DetectedObject',
      '10': 'detectedObjects'
    },
  ],
};

/// Descriptor for `VideoData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List videoDataDescriptor = $convert.base64Decode(
    'CglWaWRlb0RhdGESDgoCaWQYASABKAlSAmlkEigKB2RldGFpbHMYAiABKAsyDi5DYW1lcmFEZX'
    'RhaWxzUgdkZXRhaWxzEhQKBWZyYW1lGAMgASgMUgVmcmFtZRIiCgd2ZXJzaW9uGAQgASgLMggu'
    'VmVyc2lvblIHdmVyc2lvbhIcCglpbWFnZVBhdGgYBSABKAlSCWltYWdlUGF0aBI5Cg9kZXRlY3'
    'RlZE9iamVjdHMYBiADKAsyDy5EZXRlY3RlZE9iamVjdFIPZGV0ZWN0ZWRPYmplY3Rz');

@$core.Deprecated('Use videoCommandDescriptor instead')
const VideoCommand$json = {
  '1': 'VideoCommand',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'details',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.CameraDetails',
      '10': 'details'
    },
    {'1': 'version', '3': 3, '4': 1, '5': 11, '6': '.Version', '10': 'version'},
    {'1': 'takeSnapshot', '3': 4, '4': 1, '5': 8, '10': 'takeSnapshot'},
  ],
};

/// Descriptor for `VideoCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List videoCommandDescriptor = $convert.base64Decode(
    'CgxWaWRlb0NvbW1hbmQSDgoCaWQYASABKAlSAmlkEigKB2RldGFpbHMYAiABKAsyDi5DYW1lcm'
    'FEZXRhaWxzUgdkZXRhaWxzEiIKB3ZlcnNpb24YAyABKAsyCC5WZXJzaW9uUgd2ZXJzaW9uEiIK'
    'DHRha2VTbmFwc2hvdBgEIAEoCFIMdGFrZVNuYXBzaG90');
