// This is a generated file - do not edit.
//
// Generated from relays.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use relaysCommandDescriptor instead')
const RelaysCommand$json = {
  '1': 'RelaysCommand',
  '2': [
    {
      '1': 'backLeftMotor',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'backLeftMotor'
    },
    {
      '1': 'backRightMotor',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'backRightMotor'
    },
    {
      '1': 'frontLeftMotor',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'frontLeftMotor'
    },
    {
      '1': 'frontRightMotor',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'frontRightMotor'
    },
    {'1': 'arm', '3': 5, '4': 1, '5': 14, '6': '.BoolState', '10': 'arm'},
    {
      '1': 'science',
      '3': 6,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'science'
    },
    {'1': 'drive', '3': 7, '4': 1, '5': 14, '6': '.BoolState', '10': 'drive'},
    {'1': 'bypass', '3': 8, '4': 1, '5': 14, '6': '.BoolState', '10': 'bypass'},
  ],
};

/// Descriptor for `RelaysCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List relaysCommandDescriptor = $convert.base64Decode(
    'Cg1SZWxheXNDb21tYW5kEjAKDWJhY2tMZWZ0TW90b3IYASABKA4yCi5Cb29sU3RhdGVSDWJhY2'
    'tMZWZ0TW90b3ISMgoOYmFja1JpZ2h0TW90b3IYAiABKA4yCi5Cb29sU3RhdGVSDmJhY2tSaWdo'
    'dE1vdG9yEjIKDmZyb250TGVmdE1vdG9yGAMgASgOMgouQm9vbFN0YXRlUg5mcm9udExlZnRNb3'
    'RvchI0Cg9mcm9udFJpZ2h0TW90b3IYBCABKA4yCi5Cb29sU3RhdGVSD2Zyb250UmlnaHRNb3Rv'
    'chIcCgNhcm0YBSABKA4yCi5Cb29sU3RhdGVSA2FybRIkCgdzY2llbmNlGAYgASgOMgouQm9vbF'
    'N0YXRlUgdzY2llbmNlEiAKBWRyaXZlGAcgASgOMgouQm9vbFN0YXRlUgVkcml2ZRIiCgZieXBh'
    'c3MYCCABKA4yCi5Cb29sU3RhdGVSBmJ5cGFzcw==');

@$core.Deprecated('Use relaysDataDescriptor instead')
const RelaysData$json = {
  '1': 'RelaysData',
  '2': [
    {
      '1': 'backLeftMotor',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'backLeftMotor'
    },
    {
      '1': 'backRightMotor',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'backRightMotor'
    },
    {
      '1': 'frontLeftMotor',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'frontLeftMotor'
    },
    {
      '1': 'frontRightMotor',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'frontRightMotor'
    },
    {'1': 'arm', '3': 5, '4': 1, '5': 14, '6': '.BoolState', '10': 'arm'},
    {
      '1': 'science',
      '3': 6,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'science'
    },
    {'1': 'drive', '3': 7, '4': 1, '5': 14, '6': '.BoolState', '10': 'drive'},
    {'1': 'bypass', '3': 8, '4': 1, '5': 14, '6': '.BoolState', '10': 'bypass'},
    {
      '1': 'mechanicalOverride',
      '3': 9,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'mechanicalOverride'
    },
  ],
};

/// Descriptor for `RelaysData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List relaysDataDescriptor = $convert.base64Decode(
    'CgpSZWxheXNEYXRhEjAKDWJhY2tMZWZ0TW90b3IYASABKA4yCi5Cb29sU3RhdGVSDWJhY2tMZW'
    'Z0TW90b3ISMgoOYmFja1JpZ2h0TW90b3IYAiABKA4yCi5Cb29sU3RhdGVSDmJhY2tSaWdodE1v'
    'dG9yEjIKDmZyb250TGVmdE1vdG9yGAMgASgOMgouQm9vbFN0YXRlUg5mcm9udExlZnRNb3Rvch'
    'I0Cg9mcm9udFJpZ2h0TW90b3IYBCABKA4yCi5Cb29sU3RhdGVSD2Zyb250UmlnaHRNb3RvchIc'
    'CgNhcm0YBSABKA4yCi5Cb29sU3RhdGVSA2FybRIkCgdzY2llbmNlGAYgASgOMgouQm9vbFN0YX'
    'RlUgdzY2llbmNlEiAKBWRyaXZlGAcgASgOMgouQm9vbFN0YXRlUgVkcml2ZRIiCgZieXBhc3MY'
    'CCABKA4yCi5Cb29sU3RhdGVSBmJ5cGFzcxI6ChJtZWNoYW5pY2FsT3ZlcnJpZGUYCSABKA4yCi'
    '5Cb29sU3RhdGVSEm1lY2hhbmljYWxPdmVycmlkZQ==');
