// This is a generated file - do not edit.
//
// Generated from vision.proto.

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

@$core.Deprecated('Use detectedObjectTypeDescriptor instead')
const DetectedObjectType$json = {
  '1': 'DetectedObjectType',
  '2': [
    {'1': 'DETECTION_TYPE_UNDEFINED', '2': 0},
    {'1': 'ARUCO', '2': 1},
    {'1': 'HAMMER', '2': 2},
    {'1': 'BOTTLE', '2': 3},
  ],
};

/// Descriptor for `DetectedObjectType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List detectedObjectTypeDescriptor = $convert.base64Decode(
    'ChJEZXRlY3RlZE9iamVjdFR5cGUSHAoYREVURUNUSU9OX1RZUEVfVU5ERUZJTkVEEAASCQoFQV'
    'JVQ08QARIKCgZIQU1NRVIQAhIKCgZCT1RUTEUQAw==');

@$core.Deprecated('Use pnpResultDescriptor instead')
const PnpResult$json = {
  '1': 'PnpResult',
  '2': [
    {
      '1': 'camera_to_target',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.Pose3d',
      '10': 'cameraToTarget'
    },
    {
      '1': 'reprojection_error',
      '3': 2,
      '4': 1,
      '5': 1,
      '10': 'reprojectionError'
    },
  ],
};

/// Descriptor for `PnpResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pnpResultDescriptor = $convert.base64Decode(
    'CglQbnBSZXN1bHQSMQoQY2FtZXJhX3RvX3RhcmdldBgBIAEoCzIHLlBvc2UzZFIOY2FtZXJhVG'
    '9UYXJnZXQSLQoScmVwcm9qZWN0aW9uX2Vycm9yGAIgASgBUhFyZXByb2plY3Rpb25FcnJvcg==');

@$core.Deprecated('Use detectedObjectDescriptor instead')
const DetectedObject$json = {
  '1': 'DetectedObject',
  '2': [
    {
      '1': 'object_type',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.DetectedObjectType',
      '10': 'objectType'
    },
    {'1': 'aruco_tag_id', '3': 2, '4': 1, '5': 5, '10': 'arucoTagId'},
    {'1': 'x_position', '3': 4, '4': 1, '5': 2, '10': 'xPosition'},
    {'1': 'relative_size', '3': 5, '4': 1, '5': 2, '10': 'relativeSize'},
    {'1': 'center_x', '3': 6, '4': 1, '5': 5, '10': 'centerX'},
    {'1': 'center_y', '3': 7, '4': 1, '5': 5, '10': 'centerY'},
    {'1': 'yaw', '3': 8, '4': 1, '5': 2, '10': 'yaw'},
    {'1': 'pitch', '3': 9, '4': 1, '5': 2, '10': 'pitch'},
    {
      '1': 'best_pnp_result',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.PnpResult',
      '10': 'bestPnpResult'
    },
    {
      '1': 'alternate_pnp_result',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.PnpResult',
      '10': 'alternatePnpResult'
    },
  ],
};

/// Descriptor for `DetectedObject`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List detectedObjectDescriptor = $convert.base64Decode(
    'Cg5EZXRlY3RlZE9iamVjdBI0CgtvYmplY3RfdHlwZRgBIAEoDjITLkRldGVjdGVkT2JqZWN0VH'
    'lwZVIKb2JqZWN0VHlwZRIgCgxhcnVjb190YWdfaWQYAiABKAVSCmFydWNvVGFnSWQSHQoKeF9w'
    'b3NpdGlvbhgEIAEoAlIJeFBvc2l0aW9uEiMKDXJlbGF0aXZlX3NpemUYBSABKAJSDHJlbGF0aX'
    'ZlU2l6ZRIZCghjZW50ZXJfeBgGIAEoBVIHY2VudGVyWBIZCghjZW50ZXJfeRgHIAEoBVIHY2Vu'
    'dGVyWRIQCgN5YXcYCCABKAJSA3lhdxIUCgVwaXRjaBgJIAEoAlIFcGl0Y2gSMgoPYmVzdF9wbn'
    'BfcmVzdWx0GAogASgLMgouUG5wUmVzdWx0Ug1iZXN0UG5wUmVzdWx0EjwKFGFsdGVybmF0ZV9w'
    'bnBfcmVzdWx0GAsgASgLMgouUG5wUmVzdWx0UhJhbHRlcm5hdGVQbnBSZXN1bHQ=');
