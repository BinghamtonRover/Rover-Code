// This is a generated file - do not edit.
//
// Generated from lidar.proto.

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

@$core.Deprecated('Use lidarCartesianPointDescriptor instead')
const LidarCartesianPoint$json = {
  '1': 'LidarCartesianPoint',
  '2': [
    {'1': 'x', '3': 1, '4': 1, '5': 2, '10': 'x'},
    {'1': 'y', '3': 2, '4': 1, '5': 2, '10': 'y'},
  ],
};

/// Descriptor for `LidarCartesianPoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lidarCartesianPointDescriptor =
    $convert.base64Decode(
        'ChNMaWRhckNhcnRlc2lhblBvaW50EgwKAXgYASABKAJSAXgSDAoBeRgCIAEoAlIBeQ==');

@$core.Deprecated('Use lidarPolarPointDescriptor instead')
const LidarPolarPoint$json = {
  '1': 'LidarPolarPoint',
  '2': [
    {'1': 'angle', '3': 1, '4': 1, '5': 2, '10': 'angle'},
    {'1': 'distance', '3': 2, '4': 1, '5': 2, '10': 'distance'},
  ],
};

/// Descriptor for `LidarPolarPoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lidarPolarPointDescriptor = $convert.base64Decode(
    'Cg9MaWRhclBvbGFyUG9pbnQSFAoFYW5nbGUYASABKAJSBWFuZ2xlEhoKCGRpc3RhbmNlGAIgAS'
    'gCUghkaXN0YW5jZQ==');

@$core.Deprecated('Use lidarPointCloudDescriptor instead')
const LidarPointCloud$json = {
  '1': 'LidarPointCloud',
  '2': [
    {
      '1': 'cartesian',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.LidarCartesianPoint',
      '10': 'cartesian'
    },
    {
      '1': 'polar',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.LidarPolarPoint',
      '10': 'polar'
    },
    {'1': 'version', '3': 3, '4': 1, '5': 11, '6': '.Version', '10': 'version'},
  ],
};

/// Descriptor for `LidarPointCloud`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lidarPointCloudDescriptor = $convert.base64Decode(
    'Cg9MaWRhclBvaW50Q2xvdWQSMgoJY2FydGVzaWFuGAEgAygLMhQuTGlkYXJDYXJ0ZXNpYW5Qb2'
    'ludFIJY2FydGVzaWFuEiYKBXBvbGFyGAIgAygLMhAuTGlkYXJQb2xhclBvaW50UgVwb2xhchIi'
    'Cgd2ZXJzaW9uGAMgASgLMgguVmVyc2lvblIHdmVyc2lvbg==');
