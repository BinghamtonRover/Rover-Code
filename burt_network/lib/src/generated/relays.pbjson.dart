// This is a generated file - do not edit.
//
// Generated from relays.proto.

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

@$core.Deprecated('Use relaysCommandDescriptor instead')
const RelaysCommand$json = {
  '1': 'RelaysCommand',
  '2': [
    {'1': 'version', '3': 1, '4': 1, '5': 11, '6': '.Version', '10': 'version'},
    {
      '1': 'back_left_motor',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'backLeftMotor'
    },
    {
      '1': 'back_right_motor',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'backRightMotor'
    },
    {
      '1': 'front_left_motor',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'frontLeftMotor'
    },
    {
      '1': 'front_right_motor',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'frontRightMotor'
    },
    {
      '1': 'left_dampening_motor',
      '3': 6,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'leftDampeningMotor'
    },
    {
      '1': 'right_dampening_motor',
      '3': 7,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'rightDampeningMotor'
    },
    {'1': 'arm', '3': 8, '4': 1, '5': 14, '6': '.BoolState', '10': 'arm'},
    {
      '1': 'science',
      '3': 9,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'science'
    },
    {'1': 'drive', '3': 10, '4': 1, '5': 14, '6': '.BoolState', '10': 'drive'},
    {
      '1': 'bypass',
      '3': 11,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'bypass'
    },
  ],
};

/// Descriptor for `RelaysCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List relaysCommandDescriptor = $convert.base64Decode(
    'Cg1SZWxheXNDb21tYW5kEiIKB3ZlcnNpb24YASABKAsyCC5WZXJzaW9uUgd2ZXJzaW9uEjIKD2'
    'JhY2tfbGVmdF9tb3RvchgCIAEoDjIKLkJvb2xTdGF0ZVINYmFja0xlZnRNb3RvchI0ChBiYWNr'
    'X3JpZ2h0X21vdG9yGAMgASgOMgouQm9vbFN0YXRlUg5iYWNrUmlnaHRNb3RvchI0ChBmcm9udF'
    '9sZWZ0X21vdG9yGAQgASgOMgouQm9vbFN0YXRlUg5mcm9udExlZnRNb3RvchI2ChFmcm9udF9y'
    'aWdodF9tb3RvchgFIAEoDjIKLkJvb2xTdGF0ZVIPZnJvbnRSaWdodE1vdG9yEjwKFGxlZnRfZG'
    'FtcGVuaW5nX21vdG9yGAYgASgOMgouQm9vbFN0YXRlUhJsZWZ0RGFtcGVuaW5nTW90b3ISPgoV'
    'cmlnaHRfZGFtcGVuaW5nX21vdG9yGAcgASgOMgouQm9vbFN0YXRlUhNyaWdodERhbXBlbmluZ0'
    '1vdG9yEhwKA2FybRgIIAEoDjIKLkJvb2xTdGF0ZVIDYXJtEiQKB3NjaWVuY2UYCSABKA4yCi5C'
    'b29sU3RhdGVSB3NjaWVuY2USIAoFZHJpdmUYCiABKA4yCi5Cb29sU3RhdGVSBWRyaXZlEiIKBm'
    'J5cGFzcxgLIAEoDjIKLkJvb2xTdGF0ZVIGYnlwYXNz');

@$core.Deprecated('Use relaysDataDescriptor instead')
const RelaysData$json = {
  '1': 'RelaysData',
  '2': [
    {'1': 'version', '3': 1, '4': 1, '5': 11, '6': '.Version', '10': 'version'},
    {
      '1': 'back_left_motor',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'backLeftMotor'
    },
    {
      '1': 'back_right_motor',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'backRightMotor'
    },
    {
      '1': 'front_left_motor',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'frontLeftMotor'
    },
    {
      '1': 'front_right_motor',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'frontRightMotor'
    },
    {
      '1': 'left_dampening_motor',
      '3': 6,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'leftDampeningMotor'
    },
    {
      '1': 'right_dampening_motor',
      '3': 7,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'rightDampeningMotor'
    },
    {'1': 'arm', '3': 8, '4': 1, '5': 14, '6': '.BoolState', '10': 'arm'},
    {
      '1': 'science',
      '3': 9,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'science'
    },
    {'1': 'drive', '3': 10, '4': 1, '5': 14, '6': '.BoolState', '10': 'drive'},
    {'1': 'battery_voltage', '3': 13, '4': 1, '5': 2, '10': 'batteryVoltage'},
    {
      '1': 'bypass',
      '3': 11,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'bypass'
    },
    {
      '1': 'mechanical_override',
      '3': 12,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'mechanicalOverride'
    },
  ],
};

/// Descriptor for `RelaysData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List relaysDataDescriptor = $convert.base64Decode(
    'CgpSZWxheXNEYXRhEiIKB3ZlcnNpb24YASABKAsyCC5WZXJzaW9uUgd2ZXJzaW9uEjIKD2JhY2'
    'tfbGVmdF9tb3RvchgCIAEoDjIKLkJvb2xTdGF0ZVINYmFja0xlZnRNb3RvchI0ChBiYWNrX3Jp'
    'Z2h0X21vdG9yGAMgASgOMgouQm9vbFN0YXRlUg5iYWNrUmlnaHRNb3RvchI0ChBmcm9udF9sZW'
    'Z0X21vdG9yGAQgASgOMgouQm9vbFN0YXRlUg5mcm9udExlZnRNb3RvchI2ChFmcm9udF9yaWdo'
    'dF9tb3RvchgFIAEoDjIKLkJvb2xTdGF0ZVIPZnJvbnRSaWdodE1vdG9yEjwKFGxlZnRfZGFtcG'
    'VuaW5nX21vdG9yGAYgASgOMgouQm9vbFN0YXRlUhJsZWZ0RGFtcGVuaW5nTW90b3ISPgoVcmln'
    'aHRfZGFtcGVuaW5nX21vdG9yGAcgASgOMgouQm9vbFN0YXRlUhNyaWdodERhbXBlbmluZ01vdG'
    '9yEhwKA2FybRgIIAEoDjIKLkJvb2xTdGF0ZVIDYXJtEiQKB3NjaWVuY2UYCSABKA4yCi5Cb29s'
    'U3RhdGVSB3NjaWVuY2USIAoFZHJpdmUYCiABKA4yCi5Cb29sU3RhdGVSBWRyaXZlEicKD2JhdH'
    'Rlcnlfdm9sdGFnZRgNIAEoAlIOYmF0dGVyeVZvbHRhZ2USIgoGYnlwYXNzGAsgASgOMgouQm9v'
    'bFN0YXRlUgZieXBhc3MSOwoTbWVjaGFuaWNhbF9vdmVycmlkZRgMIAEoDjIKLkJvb2xTdGF0ZV'
    'ISbWVjaGFuaWNhbE92ZXJyaWRl');
