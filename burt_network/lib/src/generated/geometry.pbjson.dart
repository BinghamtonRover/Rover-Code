// This is a generated file - do not edit.
//
// Generated from geometry.proto.

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

@$core.Deprecated('Use translation3dDescriptor instead')
const Translation3d$json = {
  '1': 'Translation3d',
  '2': [
    {'1': 'x', '3': 1, '4': 1, '5': 2, '10': 'x'},
    {'1': 'y', '3': 2, '4': 1, '5': 2, '10': 'y'},
    {'1': 'z', '3': 3, '4': 1, '5': 2, '10': 'z'},
  ],
};

/// Descriptor for `Translation3d`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List translation3dDescriptor = $convert.base64Decode(
    'Cg1UcmFuc2xhdGlvbjNkEgwKAXgYASABKAJSAXgSDAoBeRgCIAEoAlIBeRIMCgF6GAMgASgCUg'
    'F6');

@$core.Deprecated('Use rotation3dDescriptor instead')
const Rotation3d$json = {
  '1': 'Rotation3d',
  '2': [
    {'1': 'pitch', '3': 1, '4': 1, '5': 2, '10': 'pitch'},
    {'1': 'roll', '3': 2, '4': 1, '5': 2, '10': 'roll'},
    {'1': 'yaw', '3': 3, '4': 1, '5': 2, '10': 'yaw'},
  ],
};

/// Descriptor for `Rotation3d`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rotation3dDescriptor = $convert.base64Decode(
    'CgpSb3RhdGlvbjNkEhQKBXBpdGNoGAEgASgCUgVwaXRjaBISCgRyb2xsGAIgASgCUgRyb2xsEh'
    'AKA3lhdxgDIAEoAlIDeWF3');

@$core.Deprecated('Use pose3dDescriptor instead')
const Pose3d$json = {
  '1': 'Pose3d',
  '2': [
    {
      '1': 'translation',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.Translation3d',
      '10': 'translation'
    },
    {
      '1': 'rotation',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.Rotation3d',
      '10': 'rotation'
    },
  ],
};

/// Descriptor for `Pose3d`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pose3dDescriptor = $convert.base64Decode(
    'CgZQb3NlM2QSMAoLdHJhbnNsYXRpb24YASABKAsyDi5UcmFuc2xhdGlvbjNkUgt0cmFuc2xhdG'
    'lvbhInCghyb3RhdGlvbhgCIAEoCzILLlJvdGF0aW9uM2RSCHJvdGF0aW9u');
