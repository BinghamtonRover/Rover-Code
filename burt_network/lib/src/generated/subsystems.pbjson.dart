// This is a generated file - do not edit.
//
// Generated from subsystems.proto.

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

@$core.Deprecated('Use subsystemsCommandDescriptor instead')
const SubsystemsCommand$json = {
  '1': 'SubsystemsCommand',
  '2': [
    {'1': 'zero_imu', '3': 1, '4': 1, '5': 8, '10': 'zeroImu'},
    {'1': 'version', '3': 2, '4': 1, '5': 11, '6': '.Version', '10': 'version'},
  ],
};

/// Descriptor for `SubsystemsCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subsystemsCommandDescriptor = $convert.base64Decode(
    'ChFTdWJzeXN0ZW1zQ29tbWFuZBIZCgh6ZXJvX2ltdRgBIAEoCFIHemVyb0ltdRIiCgd2ZXJzaW'
    '9uGAIgASgLMgguVmVyc2lvblIHdmVyc2lvbg==');

@$core.Deprecated('Use subsystemsDataDescriptor instead')
const SubsystemsData$json = {
  '1': 'SubsystemsData',
  '2': [
    {'1': 'version', '3': 1, '4': 1, '5': 11, '6': '.Version', '10': 'version'},
    {
      '1': 'connected_devices',
      '3': 2,
      '4': 3,
      '5': 14,
      '6': '.Device',
      '10': 'connectedDevices'
    },
    {
      '1': 'gps_connected',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'gpsConnected'
    },
    {
      '1': 'imu_connected',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'imuConnected'
    },
  ],
};

/// Descriptor for `SubsystemsData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subsystemsDataDescriptor = $convert.base64Decode(
    'Cg5TdWJzeXN0ZW1zRGF0YRIiCgd2ZXJzaW9uGAEgASgLMgguVmVyc2lvblIHdmVyc2lvbhI0Ch'
    'Fjb25uZWN0ZWRfZGV2aWNlcxgCIAMoDjIHLkRldmljZVIQY29ubmVjdGVkRGV2aWNlcxIvCg1n'
    'cHNfY29ubmVjdGVkGAMgASgOMgouQm9vbFN0YXRlUgxncHNDb25uZWN0ZWQSLwoNaW11X2Nvbm'
    '5lY3RlZBgEIAEoDjIKLkJvb2xTdGF0ZVIMaW11Q29ubmVjdGVk');
