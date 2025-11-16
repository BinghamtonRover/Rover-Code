//
//  Generated code. Do not modify.
//  source: geometry.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use coordinatesDescriptor instead')
const Coordinates$json = {
  '1': 'Coordinates',
  '2': [
    {'1': 'x', '3': 1, '4': 1, '5': 2, '10': 'x'},
    {'1': 'y', '3': 2, '4': 1, '5': 2, '10': 'y'},
    {'1': 'z', '3': 3, '4': 1, '5': 2, '10': 'z'},
  ],
};

/// Descriptor for `Coordinates`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List coordinatesDescriptor = $convert.base64Decode(
    'CgtDb29yZGluYXRlcxIMCgF4GAEgASgCUgF4EgwKAXkYAiABKAJSAXkSDAoBehgDIAEoAlIBeg'
    '==');

@$core.Deprecated('Use orientationDescriptor instead')
const Orientation$json = {
  '1': 'Orientation',
  '2': [
    {'1': 'x', '3': 1, '4': 1, '5': 2, '10': 'x'},
    {'1': 'y', '3': 2, '4': 1, '5': 2, '10': 'y'},
    {'1': 'z', '3': 3, '4': 1, '5': 2, '10': 'z'},
  ],
};

/// Descriptor for `Orientation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List orientationDescriptor = $convert.base64Decode(
    'CgtPcmllbnRhdGlvbhIMCgF4GAEgASgCUgF4EgwKAXkYAiABKAJSAXkSDAoBehgDIAEoAlIBeg'
    '==');

@$core.Deprecated('Use pose3dDescriptor instead')
const Pose3d$json = {
  '1': 'Pose3d',
  '2': [
    {'1': 'translation', '3': 1, '4': 1, '5': 11, '6': '.Coordinates', '10': 'translation'},
    {'1': 'rotation', '3': 2, '4': 1, '5': 11, '6': '.Orientation', '10': 'rotation'},
  ],
};

/// Descriptor for `Pose3d`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pose3dDescriptor = $convert.base64Decode(
    'CgZQb3NlM2QSLgoLdHJhbnNsYXRpb24YASABKAsyDC5Db29yZGluYXRlc1ILdHJhbnNsYXRpb2'
    '4SKAoIcm90YXRpb24YAiABKAsyDC5PcmllbnRhdGlvblIIcm90YXRpb24=');

