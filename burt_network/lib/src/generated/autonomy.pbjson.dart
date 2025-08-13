// This is a generated file - do not edit.
//
// Generated from autonomy.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use autonomyStateDescriptor instead')
const AutonomyState$json = {
  '1': 'AutonomyState',
  '2': [
    {'1': 'AUTONOMY_STATE_UNDEFINED', '2': 0},
    {'1': 'PATHING', '2': 2},
    {'1': 'APPROACHING', '2': 3},
    {'1': 'AT_DESTINATION', '2': 4},
    {'1': 'DRIVING', '2': 5},
    {'1': 'SEARCHING', '2': 6},
    {'1': 'NO_SOLUTION', '2': 7},
    {'1': 'ABORTING', '2': 8},
  ],
};

/// Descriptor for `AutonomyState`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List autonomyStateDescriptor = $convert.base64Decode(
    'Cg1BdXRvbm9teVN0YXRlEhwKGEFVVE9OT01ZX1NUQVRFX1VOREVGSU5FRBAAEgsKB1BBVEhJTk'
    'cQAhIPCgtBUFBST0FDSElORxADEhIKDkFUX0RFU1RJTkFUSU9OEAQSCwoHRFJJVklORxAFEg0K'
    'CVNFQVJDSElORxAGEg8KC05PX1NPTFVUSU9OEAcSDAoIQUJPUlRJTkcQCA==');

@$core.Deprecated('Use autonomyTaskDescriptor instead')
const AutonomyTask$json = {
  '1': 'AutonomyTask',
  '2': [
    {'1': 'AUTONOMY_TASK_UNDEFINED', '2': 0},
    {'1': 'GPS_ONLY', '2': 1},
    {'1': 'VISUAL_MARKER', '2': 2},
    {'1': 'BETWEEN_GATES', '2': 3},
  ],
};

/// Descriptor for `AutonomyTask`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List autonomyTaskDescriptor = $convert.base64Decode(
    'CgxBdXRvbm9teVRhc2sSGwoXQVVUT05PTVlfVEFTS19VTkRFRklORUQQABIMCghHUFNfT05MWR'
    'ABEhEKDVZJU1VBTF9NQVJLRVIQAhIRCg1CRVRXRUVOX0dBVEVTEAM=');

@$core.Deprecated('Use autonomyDataDescriptor instead')
const AutonomyData$json = {
  '1': 'AutonomyData',
  '2': [
    {
      '1': 'state',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.AutonomyState',
      '10': 'state'
    },
    {
      '1': 'destination',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.GpsCoordinates',
      '10': 'destination'
    },
    {
      '1': 'obstacles',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.GpsCoordinates',
      '10': 'obstacles'
    },
    {
      '1': 'path',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.GpsCoordinates',
      '10': 'path'
    },
    {'1': 'task', '3': 5, '4': 1, '5': 14, '6': '.AutonomyTask', '10': 'task'},
    {'1': 'crash', '3': 6, '4': 1, '5': 8, '10': 'crash'},
    {'1': 'version', '3': 7, '4': 1, '5': 11, '6': '.Version', '10': 'version'},
  ],
};

/// Descriptor for `AutonomyData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List autonomyDataDescriptor = $convert.base64Decode(
    'CgxBdXRvbm9teURhdGESJAoFc3RhdGUYASABKA4yDi5BdXRvbm9teVN0YXRlUgVzdGF0ZRIxCg'
    'tkZXN0aW5hdGlvbhgCIAEoCzIPLkdwc0Nvb3JkaW5hdGVzUgtkZXN0aW5hdGlvbhItCglvYnN0'
    'YWNsZXMYAyADKAsyDy5HcHNDb29yZGluYXRlc1IJb2JzdGFjbGVzEiMKBHBhdGgYBCADKAsyDy'
    '5HcHNDb29yZGluYXRlc1IEcGF0aBIhCgR0YXNrGAUgASgOMg0uQXV0b25vbXlUYXNrUgR0YXNr'
    'EhQKBWNyYXNoGAYgASgIUgVjcmFzaBIiCgd2ZXJzaW9uGAcgASgLMgguVmVyc2lvblIHdmVyc2'
    'lvbg==');

@$core.Deprecated('Use autonomyCommandDescriptor instead')
const AutonomyCommand$json = {
  '1': 'AutonomyCommand',
  '2': [
    {
      '1': 'destination',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.GpsCoordinates',
      '10': 'destination'
    },
    {'1': 'task', '3': 2, '4': 1, '5': 14, '6': '.AutonomyTask', '10': 'task'},
    {'1': 'aruco_id', '3': 3, '4': 1, '5': 5, '10': 'arucoId'},
    {'1': 'abort', '3': 4, '4': 1, '5': 8, '10': 'abort'},
    {'1': 'version', '3': 5, '4': 1, '5': 11, '6': '.Version', '10': 'version'},
  ],
};

/// Descriptor for `AutonomyCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List autonomyCommandDescriptor = $convert.base64Decode(
    'Cg9BdXRvbm9teUNvbW1hbmQSMQoLZGVzdGluYXRpb24YASABKAsyDy5HcHNDb29yZGluYXRlc1'
    'ILZGVzdGluYXRpb24SIQoEdGFzaxgCIAEoDjINLkF1dG9ub215VGFza1IEdGFzaxIZCghhcnVj'
    'b19pZBgDIAEoBVIHYXJ1Y29JZBIUCgVhYm9ydBgEIAEoCFIFYWJvcnQSIgoHdmVyc2lvbhgFIA'
    'EoCzIILlZlcnNpb25SB3ZlcnNpb24=');
