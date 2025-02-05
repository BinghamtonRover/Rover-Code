//
//  Generated code. Do not modify.
//  source: lidar.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

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
final $typed_data.Uint8List lidarCartesianPointDescriptor = $convert.base64Decode(
    'ChNMaWRhckNhcnRlc2lhblBvaW50EgwKAXgYASABKAJSAXgSDAoBeRgCIAEoAlIBeQ==');

@$core.Deprecated('Use lidarPointCloudDescriptor instead')
const LidarPointCloud$json = {
  '1': 'LidarPointCloud',
  '2': [
    {'1': 'data', '3': 1, '4': 3, '5': 11, '6': '.LidarCartesianPoint', '10': 'data'},
    {'1': 'version', '3': 2, '4': 1, '5': 11, '6': '.Version', '10': 'version'},
  ],
};

/// Descriptor for `LidarPointCloud`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lidarPointCloudDescriptor = $convert.base64Decode(
    'Cg9MaWRhclBvaW50Q2xvdWQSKAoEZGF0YRgBIAMoCzIULkxpZGFyQ2FydGVzaWFuUG9pbnRSBG'
    'RhdGESIgoHdmVyc2lvbhgCIAEoCzIILlZlcnNpb25SB3ZlcnNpb24=');

