//
//  Generated code. Do not modify.
//  source: vision.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

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
    {'1': 'cameraToTarget', '3': 1, '4': 1, '5': 11, '6': '.Pose3d', '10': 'cameraToTarget'},
    {'1': 'reprojectionError', '3': 2, '4': 1, '5': 1, '10': 'reprojectionError'},
  ],
};

/// Descriptor for `PnpResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pnpResultDescriptor = $convert.base64Decode(
    'CglQbnBSZXN1bHQSLwoOY2FtZXJhVG9UYXJnZXQYASABKAsyBy5Qb3NlM2RSDmNhbWVyYVRvVG'
    'FyZ2V0EiwKEXJlcHJvamVjdGlvbkVycm9yGAIgASgBUhFyZXByb2plY3Rpb25FcnJvcg==');

@$core.Deprecated('Use detectedObjectDescriptor instead')
const DetectedObject$json = {
  '1': 'DetectedObject',
  '2': [
    {'1': 'objectType', '3': 1, '4': 1, '5': 14, '6': '.DetectedObjectType', '10': 'objectType'},
    {'1': 'arucoTagId', '3': 2, '4': 1, '5': 5, '10': 'arucoTagId'},
    {'1': 'xPosition', '3': 4, '4': 1, '5': 2, '10': 'xPosition'},
    {'1': 'relativeSize', '3': 5, '4': 1, '5': 2, '10': 'relativeSize'},
    {'1': 'centerX', '3': 6, '4': 1, '5': 5, '10': 'centerX'},
    {'1': 'centerY', '3': 7, '4': 1, '5': 5, '10': 'centerY'},
    {'1': 'yaw', '3': 8, '4': 1, '5': 2, '10': 'yaw'},
    {'1': 'pitch', '3': 9, '4': 1, '5': 2, '10': 'pitch'},
    {'1': 'bestPnpResult', '3': 10, '4': 1, '5': 11, '6': '.PnpResult', '10': 'bestPnpResult'},
    {'1': 'alternatePnpResult', '3': 11, '4': 1, '5': 11, '6': '.PnpResult', '10': 'alternatePnpResult'},
  ],
};

/// Descriptor for `DetectedObject`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List detectedObjectDescriptor = $convert.base64Decode(
    'Cg5EZXRlY3RlZE9iamVjdBIzCgpvYmplY3RUeXBlGAEgASgOMhMuRGV0ZWN0ZWRPYmplY3RUeX'
    'BlUgpvYmplY3RUeXBlEh4KCmFydWNvVGFnSWQYAiABKAVSCmFydWNvVGFnSWQSHAoJeFBvc2l0'
    'aW9uGAQgASgCUgl4UG9zaXRpb24SIgoMcmVsYXRpdmVTaXplGAUgASgCUgxyZWxhdGl2ZVNpem'
    'USGAoHY2VudGVyWBgGIAEoBVIHY2VudGVyWBIYCgdjZW50ZXJZGAcgASgFUgdjZW50ZXJZEhAK'
    'A3lhdxgIIAEoAlIDeWF3EhQKBXBpdGNoGAkgASgCUgVwaXRjaBIwCg1iZXN0UG5wUmVzdWx0GA'
    'ogASgLMgouUG5wUmVzdWx0Ug1iZXN0UG5wUmVzdWx0EjoKEmFsdGVybmF0ZVBucFJlc3VsdBgL'
    'IAEoCzIKLlBucFJlc3VsdFISYWx0ZXJuYXRlUG5wUmVzdWx0');

