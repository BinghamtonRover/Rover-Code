// This is a generated file - do not edit.
//
// Generated from base_station.proto.

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

@$core.Deprecated('Use antennaControlModeDescriptor instead')
const AntennaControlMode$json = {
  '1': 'AntennaControlMode',
  '2': [
    {'1': 'ANTENNA_CONTROL_MODE_UNDEFINED', '2': 0},
    {'1': 'TRACK_ROVER', '2': 1},
    {'1': 'MANUAL_CONTROL', '2': 2},
  ],
};

/// Descriptor for `AntennaControlMode`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List antennaControlModeDescriptor = $convert.base64Decode(
    'ChJBbnRlbm5hQ29udHJvbE1vZGUSIgoeQU5URU5OQV9DT05UUk9MX01PREVfVU5ERUZJTkVEEA'
    'ASDwoLVFJBQ0tfUk9WRVIQARISCg5NQU5VQUxfQ09OVFJPTBAC');

@$core.Deprecated('Use antennaFirmwareCommandDescriptor instead')
const AntennaFirmwareCommand$json = {
  '1': 'AntennaFirmwareCommand',
  '2': [
    {'1': 'version', '3': 1, '4': 1, '5': 11, '6': '.Version', '10': 'version'},
    {
      '1': 'swivel',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.MotorCommand',
      '10': 'swivel'
    },
    {'1': 'stop', '3': 3, '4': 1, '5': 8, '10': 'stop'},
    {'1': 'calibrate', '3': 4, '4': 1, '5': 8, '10': 'calibrate'},
  ],
};

/// Descriptor for `AntennaFirmwareCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List antennaFirmwareCommandDescriptor = $convert.base64Decode(
    'ChZBbnRlbm5hRmlybXdhcmVDb21tYW5kEiIKB3ZlcnNpb24YASABKAsyCC5WZXJzaW9uUgd2ZX'
    'JzaW9uEiUKBnN3aXZlbBgCIAEoCzINLk1vdG9yQ29tbWFuZFIGc3dpdmVsEhIKBHN0b3AYAyAB'
    'KAhSBHN0b3ASHAoJY2FsaWJyYXRlGAQgASgIUgljYWxpYnJhdGU=');

@$core.Deprecated('Use antennaFirmwareDataDescriptor instead')
const AntennaFirmwareData$json = {
  '1': 'AntennaFirmwareData',
  '2': [
    {'1': 'version', '3': 1, '4': 1, '5': 11, '6': '.Version', '10': 'version'},
    {'1': 'swivel', '3': 2, '4': 1, '5': 11, '6': '.MotorData', '10': 'swivel'},
  ],
};

/// Descriptor for `AntennaFirmwareData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List antennaFirmwareDataDescriptor = $convert.base64Decode(
    'ChNBbnRlbm5hRmlybXdhcmVEYXRhEiIKB3ZlcnNpb24YASABKAsyCC5WZXJzaW9uUgd2ZXJzaW'
    '9uEiIKBnN3aXZlbBgCIAEoCzIKLk1vdG9yRGF0YVIGc3dpdmVs');

@$core.Deprecated('Use baseStationCommandDescriptor instead')
const BaseStationCommand$json = {
  '1': 'BaseStationCommand',
  '2': [
    {'1': 'version', '3': 1, '4': 1, '5': 11, '6': '.Version', '10': 'version'},
    {
      '1': 'mode',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.AntennaControlMode',
      '10': 'mode'
    },
    {
      '1': 'rover_coordinates',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.GpsCoordinates',
      '10': 'roverCoordinates'
    },
    {
      '1': 'base_station_coordinates',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.GpsCoordinates',
      '10': 'baseStationCoordinates'
    },
    {
      '1': 'rover_coordinates_override',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.GpsCoordinates',
      '10': 'roverCoordinatesOverride'
    },
    {
      '1': 'manual_command',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.AntennaFirmwareCommand',
      '10': 'manualCommand'
    },
    {'1': 'angle_tolerance', '3': 7, '4': 1, '5': 2, '10': 'angleTolerance'},
  ],
};

/// Descriptor for `BaseStationCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List baseStationCommandDescriptor = $convert.base64Decode(
    'ChJCYXNlU3RhdGlvbkNvbW1hbmQSIgoHdmVyc2lvbhgBIAEoCzIILlZlcnNpb25SB3ZlcnNpb2'
    '4SJwoEbW9kZRgCIAEoDjITLkFudGVubmFDb250cm9sTW9kZVIEbW9kZRI8ChFyb3Zlcl9jb29y'
    'ZGluYXRlcxgDIAEoCzIPLkdwc0Nvb3JkaW5hdGVzUhByb3ZlckNvb3JkaW5hdGVzEkkKGGJhc2'
    'Vfc3RhdGlvbl9jb29yZGluYXRlcxgEIAEoCzIPLkdwc0Nvb3JkaW5hdGVzUhZiYXNlU3RhdGlv'
    'bkNvb3JkaW5hdGVzEk0KGnJvdmVyX2Nvb3JkaW5hdGVzX292ZXJyaWRlGAUgASgLMg8uR3BzQ2'
    '9vcmRpbmF0ZXNSGHJvdmVyQ29vcmRpbmF0ZXNPdmVycmlkZRI+Cg5tYW51YWxfY29tbWFuZBgG'
    'IAEoCzIXLkFudGVubmFGaXJtd2FyZUNvbW1hbmRSDW1hbnVhbENvbW1hbmQSJwoPYW5nbGVfdG'
    '9sZXJhbmNlGAcgASgCUg5hbmdsZVRvbGVyYW5jZQ==');

@$core.Deprecated('Use baseStationDataDescriptor instead')
const BaseStationData$json = {
  '1': 'BaseStationData',
  '2': [
    {'1': 'version', '3': 1, '4': 1, '5': 11, '6': '.Version', '10': 'version'},
    {
      '1': 'mode',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.AntennaControlMode',
      '10': 'mode'
    },
    {
      '1': 'antenna',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.AntennaFirmwareData',
      '10': 'antenna'
    },
    {
      '1': 'base_station_coordinates',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.GpsCoordinates',
      '10': 'baseStationCoordinates'
    },
    {
      '1': 'rtk_connected',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'rtkConnected'
    },
  ],
};

/// Descriptor for `BaseStationData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List baseStationDataDescriptor = $convert.base64Decode(
    'Cg9CYXNlU3RhdGlvbkRhdGESIgoHdmVyc2lvbhgBIAEoCzIILlZlcnNpb25SB3ZlcnNpb24SJw'
    'oEbW9kZRgCIAEoDjITLkFudGVubmFDb250cm9sTW9kZVIEbW9kZRIuCgdhbnRlbm5hGAMgASgL'
    'MhQuQW50ZW5uYUZpcm13YXJlRGF0YVIHYW50ZW5uYRJJChhiYXNlX3N0YXRpb25fY29vcmRpbm'
    'F0ZXMYBCABKAsyDy5HcHNDb29yZGluYXRlc1IWYmFzZVN0YXRpb25Db29yZGluYXRlcxIvCg1y'
    'dGtfY29ubmVjdGVkGAUgASgOMgouQm9vbFN0YXRlUgxydGtDb25uZWN0ZWQ=');
