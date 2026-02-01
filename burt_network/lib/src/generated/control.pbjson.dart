// This is a generated file - do not edit.
//
// Generated from control.proto.

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

@$core.Deprecated('Use controlCommandDescriptor instead')
const ControlCommand$json = {
  '1': 'ControlCommand',
  '2': [
    {'1': 'version', '3': 1, '4': 1, '5': 11, '6': '.Version', '10': 'version'},
    {
      '1': 'drive',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.DriveCommand',
      '9': 0,
      '10': 'drive',
      '17': true
    },
    {
      '1': 'relays',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.RelaysCommand',
      '9': 1,
      '10': 'relays',
      '17': true
    },
  ],
  '8': [
    {'1': '_drive'},
    {'1': '_relays'},
  ],
};

/// Descriptor for `ControlCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List controlCommandDescriptor = $convert.base64Decode(
    'Cg5Db250cm9sQ29tbWFuZBIiCgd2ZXJzaW9uGAEgASgLMgguVmVyc2lvblIHdmVyc2lvbhIoCg'
    'Vkcml2ZRgCIAEoCzINLkRyaXZlQ29tbWFuZEgAUgVkcml2ZYgBARIrCgZyZWxheXMYAyABKAsy'
    'Di5SZWxheXNDb21tYW5kSAFSBnJlbGF5c4gBAUIICgZfZHJpdmVCCQoHX3JlbGF5cw==');

@$core.Deprecated('Use controlDataDescriptor instead')
const ControlData$json = {
  '1': 'ControlData',
  '2': [
    {'1': 'version', '3': 1, '4': 1, '5': 11, '6': '.Version', '10': 'version'},
    {
      '1': 'drive',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.DriveData',
      '9': 0,
      '10': 'drive',
      '17': true
    },
    {
      '1': 'relays',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.RelaysData',
      '9': 1,
      '10': 'relays',
      '17': true
    },
  ],
  '8': [
    {'1': '_drive'},
    {'1': '_relays'},
  ],
};

/// Descriptor for `ControlData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List controlDataDescriptor = $convert.base64Decode(
    'CgtDb250cm9sRGF0YRIiCgd2ZXJzaW9uGAEgASgLMgguVmVyc2lvblIHdmVyc2lvbhIlCgVkcm'
    'l2ZRgCIAEoCzIKLkRyaXZlRGF0YUgAUgVkcml2ZYgBARIoCgZyZWxheXMYAyABKAsyCy5SZWxh'
    'eXNEYXRhSAFSBnJlbGF5c4gBAUIICgZfZHJpdmVCCQoHX3JlbGF5cw==');
