//
//  Generated code. Do not modify.
//  source: subsystems.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use subsystemsCommandDescriptor instead')
const SubsystemsCommand$json = {
  '1': 'SubsystemsCommand',
  '2': [
    {'1': 'zeroIMU', '3': 1, '4': 1, '5': 8, '10': 'zeroIMU'},
    {'1': 'version', '3': 2, '4': 1, '5': 11, '6': '.Version', '10': 'version'},
  ],
};

/// Descriptor for `SubsystemsCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subsystemsCommandDescriptor = $convert.base64Decode(
    'ChFTdWJzeXN0ZW1zQ29tbWFuZBIYCgd6ZXJvSU1VGAEgASgIUgd6ZXJvSU1VEiIKB3ZlcnNpb2'
    '4YAiABKAsyCC5WZXJzaW9uUgd2ZXJzaW9u');

@$core.Deprecated('Use subsystemsDataDescriptor instead')
const SubsystemsData$json = {
  '1': 'SubsystemsData',
  '2': [
    {'1': 'version', '3': 1, '4': 1, '5': 11, '6': '.Version', '10': 'version'},
    {'1': 'connectedDevices', '3': 2, '4': 3, '5': 14, '6': '.Device', '10': 'connectedDevices'},
    {'1': 'gpsConnected', '3': 3, '4': 1, '5': 14, '6': '.BoolState', '10': 'gpsConnected'},
    {'1': 'imuConnected', '3': 4, '4': 1, '5': 14, '6': '.BoolState', '10': 'imuConnected'},
  ],
};

/// Descriptor for `SubsystemsData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subsystemsDataDescriptor = $convert.base64Decode(
    'Cg5TdWJzeXN0ZW1zRGF0YRIiCgd2ZXJzaW9uGAEgASgLMgguVmVyc2lvblIHdmVyc2lvbhIzCh'
    'Bjb25uZWN0ZWREZXZpY2VzGAIgAygOMgcuRGV2aWNlUhBjb25uZWN0ZWREZXZpY2VzEi4KDGdw'
    'c0Nvbm5lY3RlZBgDIAEoDjIKLkJvb2xTdGF0ZVIMZ3BzQ29ubmVjdGVkEi4KDGltdUNvbm5lY3'
    'RlZBgEIAEoDjIKLkJvb2xTdGF0ZVIMaW11Q29ubmVjdGVk');

