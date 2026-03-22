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
      '1': 'middle_left_motor',
      '3': 6,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'middleLeftMotor'
    },
    {
      '1': 'middle_right_motor',
      '3': 7,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'middleRightMotor'
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
    {
      '1': 'bypass',
      '3': 11,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'bypass'
    },
  ],
  '9': [
    {'1': 10, '2': 11},
  ],
};

/// Descriptor for `RelaysCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List relaysCommandDescriptor = $convert.base64Decode(
    'Cg1SZWxheXNDb21tYW5kEiIKB3ZlcnNpb24YASABKAsyCC5WZXJzaW9uUgd2ZXJzaW9uEjIKD2'
    'JhY2tfbGVmdF9tb3RvchgCIAEoDjIKLkJvb2xTdGF0ZVINYmFja0xlZnRNb3RvchI0ChBiYWNr'
    'X3JpZ2h0X21vdG9yGAMgASgOMgouQm9vbFN0YXRlUg5iYWNrUmlnaHRNb3RvchI0ChBmcm9udF'
    '9sZWZ0X21vdG9yGAQgASgOMgouQm9vbFN0YXRlUg5mcm9udExlZnRNb3RvchI2ChFmcm9udF9y'
    'aWdodF9tb3RvchgFIAEoDjIKLkJvb2xTdGF0ZVIPZnJvbnRSaWdodE1vdG9yEjYKEW1pZGRsZV'
    '9sZWZ0X21vdG9yGAYgASgOMgouQm9vbFN0YXRlUg9taWRkbGVMZWZ0TW90b3ISOAoSbWlkZGxl'
    'X3JpZ2h0X21vdG9yGAcgASgOMgouQm9vbFN0YXRlUhBtaWRkbGVSaWdodE1vdG9yEhwKA2FybR'
    'gIIAEoDjIKLkJvb2xTdGF0ZVIDYXJtEiQKB3NjaWVuY2UYCSABKA4yCi5Cb29sU3RhdGVSB3Nj'
    'aWVuY2USIgoGYnlwYXNzGAsgASgOMgouQm9vbFN0YXRlUgZieXBhc3NKBAgKEAs=');

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
      '1': 'middle_left_motor',
      '3': 6,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'middleLeftMotor'
    },
    {
      '1': 'middle_right_motor',
      '3': 7,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'middleRightMotor'
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
  '9': [
    {'1': 10, '2': 11},
  ],
};

/// Descriptor for `RelaysData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List relaysDataDescriptor = $convert.base64Decode(
    'CgpSZWxheXNEYXRhEiIKB3ZlcnNpb24YASABKAsyCC5WZXJzaW9uUgd2ZXJzaW9uEjIKD2JhY2'
    'tfbGVmdF9tb3RvchgCIAEoDjIKLkJvb2xTdGF0ZVINYmFja0xlZnRNb3RvchI0ChBiYWNrX3Jp'
    'Z2h0X21vdG9yGAMgASgOMgouQm9vbFN0YXRlUg5iYWNrUmlnaHRNb3RvchI0ChBmcm9udF9sZW'
    'Z0X21vdG9yGAQgASgOMgouQm9vbFN0YXRlUg5mcm9udExlZnRNb3RvchI2ChFmcm9udF9yaWdo'
    'dF9tb3RvchgFIAEoDjIKLkJvb2xTdGF0ZVIPZnJvbnRSaWdodE1vdG9yEjYKEW1pZGRsZV9sZW'
    'Z0X21vdG9yGAYgASgOMgouQm9vbFN0YXRlUg9taWRkbGVMZWZ0TW90b3ISOAoSbWlkZGxlX3Jp'
    'Z2h0X21vdG9yGAcgASgOMgouQm9vbFN0YXRlUhBtaWRkbGVSaWdodE1vdG9yEhwKA2FybRgIIA'
    'EoDjIKLkJvb2xTdGF0ZVIDYXJtEiQKB3NjaWVuY2UYCSABKA4yCi5Cb29sU3RhdGVSB3NjaWVu'
    'Y2USJwoPYmF0dGVyeV92b2x0YWdlGA0gASgCUg5iYXR0ZXJ5Vm9sdGFnZRIiCgZieXBhc3MYCy'
    'ABKA4yCi5Cb29sU3RhdGVSBmJ5cGFzcxI7ChNtZWNoYW5pY2FsX292ZXJyaWRlGAwgASgOMgou'
    'Qm9vbFN0YXRlUhJtZWNoYW5pY2FsT3ZlcnJpZGVKBAgKEAs=');
