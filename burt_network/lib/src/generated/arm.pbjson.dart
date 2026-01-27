// This is a generated file - do not edit.
//
// Generated from arm.proto.

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

@$core.Deprecated('Use armMotorDescriptor instead')
const ArmMotor$json = {
  '1': 'ArmMotor',
  '2': [
    {'1': 'ARM_MOTOR_UNDEFINED', '2': 0},
    {'1': 'SWIVEL', '2': 1},
    {'1': 'SHOULDER', '2': 2},
    {'1': 'ELBOW', '2': 3},
    {'1': 'WRIST', '2': 4},
  ],
};

/// Descriptor for `ArmMotor`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List armMotorDescriptor = $convert.base64Decode(
    'CghBcm1Nb3RvchIXChNBUk1fTU9UT1JfVU5ERUZJTkVEEAASCgoGU1dJVkVMEAESDAoIU0hPVU'
    'xERVIQAhIJCgVFTEJPVxADEgkKBVdSSVNUEAQ=');

@$core.Deprecated('Use armDataDescriptor instead')
const ArmData$json = {
  '1': 'ArmData',
  '2': [
    {
      '1': 'currentPosition',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.Coordinates',
      '10': 'currentPosition'
    },
    {
      '1': 'targetPosition',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.Coordinates',
      '10': 'targetPosition'
    },
    {'1': 'base', '3': 3, '4': 1, '5': 11, '6': '.MotorData', '10': 'base'},
    {
      '1': 'shoulder',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.MotorData',
      '10': 'shoulder'
    },
    {'1': 'elbow', '3': 5, '4': 1, '5': 11, '6': '.MotorData', '10': 'elbow'},
    {'1': 'version', '3': 6, '4': 1, '5': 11, '6': '.Version', '10': 'version'},
    {'1': 'USS_distance', '3': 7, '4': 1, '5': 2, '10': 'USSDistance'},
    {'1': 'lift', '3': 8, '4': 1, '5': 11, '6': '.MotorData', '10': 'lift'},
    {'1': 'rotate', '3': 9, '4': 1, '5': 11, '6': '.MotorData', '10': 'rotate'},
    {'1': 'pinch', '3': 10, '4': 1, '5': 11, '6': '.MotorData', '10': 'pinch'},
    {'1': 'servoAngle', '3': 11, '4': 1, '5': 5, '10': 'servoAngle'},
    {
      '1': 'laserState',
      '3': 12,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'laserState'
    },
  ],
};

/// Descriptor for `ArmData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List armDataDescriptor = $convert.base64Decode(
    'CgdBcm1EYXRhEjYKD2N1cnJlbnRQb3NpdGlvbhgBIAEoCzIMLkNvb3JkaW5hdGVzUg9jdXJyZW'
    '50UG9zaXRpb24SNAoOdGFyZ2V0UG9zaXRpb24YAiABKAsyDC5Db29yZGluYXRlc1IOdGFyZ2V0'
    'UG9zaXRpb24SHgoEYmFzZRgDIAEoCzIKLk1vdG9yRGF0YVIEYmFzZRImCghzaG91bGRlchgEIA'
    'EoCzIKLk1vdG9yRGF0YVIIc2hvdWxkZXISIAoFZWxib3cYBSABKAsyCi5Nb3RvckRhdGFSBWVs'
    'Ym93EiIKB3ZlcnNpb24YBiABKAsyCC5WZXJzaW9uUgd2ZXJzaW9uEiEKDFVTU19kaXN0YW5jZR'
    'gHIAEoAlILVVNTRGlzdGFuY2USHgoEbGlmdBgIIAEoCzIKLk1vdG9yRGF0YVIEbGlmdBIiCgZy'
    'b3RhdGUYCSABKAsyCi5Nb3RvckRhdGFSBnJvdGF0ZRIgCgVwaW5jaBgKIAEoCzIKLk1vdG9yRG'
    'F0YVIFcGluY2gSHgoKc2Vydm9BbmdsZRgLIAEoBVIKc2Vydm9BbmdsZRIqCgpsYXNlclN0YXRl'
    'GAwgASgOMgouQm9vbFN0YXRlUgpsYXNlclN0YXRl');

@$core.Deprecated('Use armCommandDescriptor instead')
const ArmCommand$json = {
  '1': 'ArmCommand',
  '2': [
    {'1': 'stop', '3': 1, '4': 1, '5': 8, '10': 'stop'},
    {'1': 'calibrate', '3': 2, '4': 1, '5': 8, '10': 'calibrate'},
    {
      '1': 'swivel',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.MotorCommand',
      '10': 'swivel'
    },
    {
      '1': 'shoulder',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.MotorCommand',
      '10': 'shoulder'
    },
    {
      '1': 'elbow',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.MotorCommand',
      '10': 'elbow'
    },
    {
      '1': 'gripper_lift',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.MotorCommand',
      '10': 'gripperLift'
    },
    {'1': 'ik_x', '3': 7, '4': 1, '5': 2, '10': 'ikX'},
    {'1': 'ik_y', '3': 8, '4': 1, '5': 2, '10': 'ikY'},
    {'1': 'ik_z', '3': 9, '4': 1, '5': 2, '10': 'ikZ'},
    {'1': 'jab', '3': 10, '4': 1, '5': 8, '10': 'jab'},
    {
      '1': 'version',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.Version',
      '10': 'version'
    },
    {
      '1': 'start_USS',
      '3': 12,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'startUSS'
    },
    {'1': 'lift', '3': 13, '4': 1, '5': 11, '6': '.MotorCommand', '10': 'lift'},
    {
      '1': 'rotate',
      '3': 14,
      '4': 1,
      '5': 11,
      '6': '.MotorCommand',
      '10': 'rotate'
    },
    {
      '1': 'pinch',
      '3': 15,
      '4': 1,
      '5': 11,
      '6': '.MotorCommand',
      '10': 'pinch'
    },
    {'1': 'open', '3': 16, '4': 1, '5': 8, '10': 'open'},
    {'1': 'close', '3': 17, '4': 1, '5': 8, '10': 'close'},
    {'1': 'spin', '3': 18, '4': 1, '5': 8, '10': 'spin'},
    {'1': 'servoAngle', '3': 19, '4': 1, '5': 5, '10': 'servoAngle'},
    {
      '1': 'laserState',
      '3': 20,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'laserState'
    },
  ],
};

/// Descriptor for `ArmCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List armCommandDescriptor = $convert.base64Decode(
    'CgpBcm1Db21tYW5kEhIKBHN0b3AYASABKAhSBHN0b3ASHAoJY2FsaWJyYXRlGAIgASgIUgljYW'
    'xpYnJhdGUSJQoGc3dpdmVsGAMgASgLMg0uTW90b3JDb21tYW5kUgZzd2l2ZWwSKQoIc2hvdWxk'
    'ZXIYBCABKAsyDS5Nb3RvckNvbW1hbmRSCHNob3VsZGVyEiMKBWVsYm93GAUgASgLMg0uTW90b3'
    'JDb21tYW5kUgVlbGJvdxIwCgxncmlwcGVyX2xpZnQYBiABKAsyDS5Nb3RvckNvbW1hbmRSC2dy'
    'aXBwZXJMaWZ0EhEKBGlrX3gYByABKAJSA2lrWBIRCgRpa195GAggASgCUgNpa1kSEQoEaWtfeh'
    'gJIAEoAlIDaWtaEhAKA2phYhgKIAEoCFIDamFiEiIKB3ZlcnNpb24YCyABKAsyCC5WZXJzaW9u'
    'Ugd2ZXJzaW9uEicKCXN0YXJ0X1VTUxgMIAEoDjIKLkJvb2xTdGF0ZVIIc3RhcnRVU1MSIQoEbG'
    'lmdBgNIAEoCzINLk1vdG9yQ29tbWFuZFIEbGlmdBIlCgZyb3RhdGUYDiABKAsyDS5Nb3RvckNv'
    'bW1hbmRSBnJvdGF0ZRIjCgVwaW5jaBgPIAEoCzINLk1vdG9yQ29tbWFuZFIFcGluY2gSEgoEb3'
    'BlbhgQIAEoCFIEb3BlbhIUCgVjbG9zZRgRIAEoCFIFY2xvc2USEgoEc3BpbhgSIAEoCFIEc3Bp'
    'bhIeCgpzZXJ2b0FuZ2xlGBMgASgFUgpzZXJ2b0FuZ2xlEioKCmxhc2VyU3RhdGUYFCABKA4yCi'
    '5Cb29sU3RhdGVSCmxhc2VyU3RhdGU=');
