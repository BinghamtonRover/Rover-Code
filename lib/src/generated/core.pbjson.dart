//
//  Generated code. Do not modify.
//  source: core.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use deviceDescriptor instead')
const Device$json = {
  '1': 'Device',
  '2': [
    {'1': 'DEVICE_UNDEFINED', '2': 0},
    {'1': 'DASHBOARD', '2': 1},
    {'1': 'SUBSYSTEMS', '2': 2},
    {'1': 'VIDEO', '2': 3},
    {'1': 'AUTONOMY', '2': 4},
    {'1': 'FIRMWARE', '2': 5},
    {'1': 'ARM', '2': 6},
    {'1': 'GRIPPER', '2': 7},
    {'1': 'SCIENCE', '2': 8},
    {'1': 'DRIVE', '2': 9},
    {'1': 'BASE_STATION', '2': 10},
    {'1': 'ANTENNA', '2': 11},
  ],
};

/// Descriptor for `Device`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List deviceDescriptor = $convert.base64Decode(
    'CgZEZXZpY2USFAoQREVWSUNFX1VOREVGSU5FRBAAEg0KCURBU0hCT0FSRBABEg4KClNVQlNZU1'
    'RFTVMQAhIJCgVWSURFTxADEgwKCEFVVE9OT01ZEAQSDAoIRklSTVdBUkUQBRIHCgNBUk0QBhIL'
    'CgdHUklQUEVSEAcSCwoHU0NJRU5DRRAIEgkKBURSSVZFEAkSEAoMQkFTRV9TVEFUSU9OEAoSCw'
    'oHQU5URU5OQRAL');

@$core.Deprecated('Use connectDescriptor instead')
const Connect$json = {
  '1': 'Connect',
  '2': [
    {'1': 'sender', '3': 1, '4': 1, '5': 14, '6': '.Device', '10': 'sender'},
    {'1': 'receiver', '3': 2, '4': 1, '5': 14, '6': '.Device', '10': 'receiver'},
  ],
};

/// Descriptor for `Connect`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List connectDescriptor = $convert.base64Decode(
    'CgdDb25uZWN0Eh8KBnNlbmRlchgBIAEoDjIHLkRldmljZVIGc2VuZGVyEiMKCHJlY2VpdmVyGA'
    'IgASgOMgcuRGV2aWNlUghyZWNlaXZlcg==');

@$core.Deprecated('Use disconnectDescriptor instead')
const Disconnect$json = {
  '1': 'Disconnect',
  '2': [
    {'1': 'sender', '3': 1, '4': 1, '5': 14, '6': '.Device', '10': 'sender'},
  ],
};

/// Descriptor for `Disconnect`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List disconnectDescriptor = $convert.base64Decode(
    'CgpEaXNjb25uZWN0Eh8KBnNlbmRlchgBIAEoDjIHLkRldmljZVIGc2VuZGVy');

