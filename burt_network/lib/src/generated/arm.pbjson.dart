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

@$core.Deprecated('Use jointAngleDataDescriptor instead')
const JointAngleData$json = {
  '1': 'JointAngleData',
  '2': [
    {'1': 'swivel_single', '3': 1, '4': 1, '5': 2, '10': 'swivelSingle'},
    {'1': 'shoulder_single', '3': 2, '4': 1, '5': 2, '10': 'shoulderSingle'},
    {'1': 'elbow_single', '3': 3, '4': 1, '5': 2, '10': 'elbowSingle'},
    {'1': 'roll_single', '3': 4, '4': 1, '5': 2, '10': 'rollSingle'},
    {
      '1': 'wrist_pitch_single',
      '3': 5,
      '4': 1,
      '5': 2,
      '10': 'wristPitchSingle'
    },
    {'1': 'swivel_multi', '3': 6, '4': 1, '5': 2, '10': 'swivelMulti'},
    {'1': 'shoulder_multi', '3': 7, '4': 1, '5': 2, '10': 'shoulderMulti'},
    {'1': 'elbow_multi', '3': 8, '4': 1, '5': 2, '10': 'elbowMulti'},
    {'1': 'roll_multi', '3': 9, '4': 1, '5': 2, '10': 'rollMulti'},
    {
      '1': 'wrist_pitch_multi',
      '3': 10,
      '4': 1,
      '5': 2,
      '10': 'wristPitchMulti'
    },
  ],
};

/// Descriptor for `JointAngleData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List jointAngleDataDescriptor = $convert.base64Decode(
    'Cg5Kb2ludEFuZ2xlRGF0YRIjCg1zd2l2ZWxfc2luZ2xlGAEgASgCUgxzd2l2ZWxTaW5nbGUSJw'
    'oPc2hvdWxkZXJfc2luZ2xlGAIgASgCUg5zaG91bGRlclNpbmdsZRIhCgxlbGJvd19zaW5nbGUY'
    'AyABKAJSC2VsYm93U2luZ2xlEh8KC3JvbGxfc2luZ2xlGAQgASgCUgpyb2xsU2luZ2xlEiwKEn'
    'dyaXN0X3BpdGNoX3NpbmdsZRgFIAEoAlIQd3Jpc3RQaXRjaFNpbmdsZRIhCgxzd2l2ZWxfbXVs'
    'dGkYBiABKAJSC3N3aXZlbE11bHRpEiUKDnNob3VsZGVyX211bHRpGAcgASgCUg1zaG91bGRlck'
    '11bHRpEh8KC2VsYm93X211bHRpGAggASgCUgplbGJvd011bHRpEh0KCnJvbGxfbXVsdGkYCSAB'
    'KAJSCXJvbGxNdWx0aRIqChF3cmlzdF9waXRjaF9tdWx0aRgKIAEoAlIPd3Jpc3RQaXRjaE11bH'
    'Rp');

@$core.Deprecated('Use wristDataDescriptor instead')
const WristData$json = {
  '1': 'WristData',
  '2': [
    {'1': 'pitch_angle', '3': 1, '4': 1, '5': 2, '10': 'pitchAngle'},
    {'1': 'roll_angle', '3': 2, '4': 1, '5': 2, '10': 'rollAngle'},
    {'1': 'motorA', '3': 3, '4': 1, '5': 11, '6': '.MotorData', '10': 'motorA'},
    {'1': 'motorB', '3': 4, '4': 1, '5': 11, '6': '.MotorData', '10': 'motorB'},
    {
      '1': 'is_moving',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'isMoving'
    },
    {
      '1': 'is_calibrated',
      '3': 6,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'isCalibrated'
    },
    {'1': 'version', '3': 7, '4': 1, '5': 11, '6': '.Version', '10': 'version'},
  ],
};

/// Descriptor for `WristData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List wristDataDescriptor = $convert.base64Decode(
    'CglXcmlzdERhdGESHwoLcGl0Y2hfYW5nbGUYASABKAJSCnBpdGNoQW5nbGUSHQoKcm9sbF9hbm'
    'dsZRgCIAEoAlIJcm9sbEFuZ2xlEiIKBm1vdG9yQRgDIAEoCzIKLk1vdG9yRGF0YVIGbW90b3JB'
    'EiIKBm1vdG9yQhgEIAEoCzIKLk1vdG9yRGF0YVIGbW90b3JCEicKCWlzX21vdmluZxgFIAEoDj'
    'IKLkJvb2xTdGF0ZVIIaXNNb3ZpbmcSLwoNaXNfY2FsaWJyYXRlZBgGIAEoDjIKLkJvb2xTdGF0'
    'ZVIMaXNDYWxpYnJhdGVkEiIKB3ZlcnNpb24YByABKAsyCC5WZXJzaW9uUgd2ZXJzaW9u');

@$core.Deprecated('Use armDataDescriptor instead')
const ArmData$json = {
  '1': 'ArmData',
  '2': [
    {
      '1': 'current_pose',
      '3': 17,
      '4': 1,
      '5': 11,
      '6': '.Pose3d',
      '10': 'currentPose'
    },
    {
      '1': 'target_pose',
      '3': 18,
      '4': 1,
      '5': 11,
      '6': '.Pose3d',
      '10': 'targetPose'
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
    {'1': 'roll', '3': 13, '4': 1, '5': 11, '6': '.MotorData', '10': 'roll'},
    {'1': 'version', '3': 6, '4': 1, '5': 11, '6': '.Version', '10': 'version'},
    {'1': 'uss_distance', '3': 7, '4': 1, '5': 2, '10': 'ussDistance'},
    {'1': 'lift', '3': 8, '4': 1, '5': 11, '6': '.MotorData', '10': 'lift'},
    {'1': 'rotate', '3': 9, '4': 1, '5': 11, '6': '.MotorData', '10': 'rotate'},
    {'1': 'wrist', '3': 15, '4': 1, '5': 11, '6': '.WristData', '10': 'wrist'},
    {'1': 'pinch', '3': 10, '4': 1, '5': 11, '6': '.MotorData', '10': 'pinch'},
    {'1': 'servo_angle', '3': 11, '4': 1, '5': 5, '10': 'servoAngle'},
    {
      '1': 'laser_state',
      '3': 12,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'laserState'
    },
    {
      '1': 'joint_angles',
      '3': 14,
      '4': 1,
      '5': 11,
      '6': '.JointAngleData',
      '10': 'jointAngles'
    },
    {
      '1': 'using_ik',
      '3': 16,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'usingIk'
    },
  ],
  '9': [
    {'1': 1, '2': 2},
    {'1': 2, '2': 3},
  ],
};

/// Descriptor for `ArmData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List armDataDescriptor = $convert.base64Decode(
    'CgdBcm1EYXRhEioKDGN1cnJlbnRfcG9zZRgRIAEoCzIHLlBvc2UzZFILY3VycmVudFBvc2USKA'
    'oLdGFyZ2V0X3Bvc2UYEiABKAsyBy5Qb3NlM2RSCnRhcmdldFBvc2USHgoEYmFzZRgDIAEoCzIK'
    'Lk1vdG9yRGF0YVIEYmFzZRImCghzaG91bGRlchgEIAEoCzIKLk1vdG9yRGF0YVIIc2hvdWxkZX'
    'ISIAoFZWxib3cYBSABKAsyCi5Nb3RvckRhdGFSBWVsYm93Eh4KBHJvbGwYDSABKAsyCi5Nb3Rv'
    'ckRhdGFSBHJvbGwSIgoHdmVyc2lvbhgGIAEoCzIILlZlcnNpb25SB3ZlcnNpb24SIQoMdXNzX2'
    'Rpc3RhbmNlGAcgASgCUgt1c3NEaXN0YW5jZRIeCgRsaWZ0GAggASgLMgouTW90b3JEYXRhUgRs'
    'aWZ0EiIKBnJvdGF0ZRgJIAEoCzIKLk1vdG9yRGF0YVIGcm90YXRlEiAKBXdyaXN0GA8gASgLMg'
    'ouV3Jpc3REYXRhUgV3cmlzdBIgCgVwaW5jaBgKIAEoCzIKLk1vdG9yRGF0YVIFcGluY2gSHwoL'
    'c2Vydm9fYW5nbGUYCyABKAVSCnNlcnZvQW5nbGUSKwoLbGFzZXJfc3RhdGUYDCABKA4yCi5Cb2'
    '9sU3RhdGVSCmxhc2VyU3RhdGUSMgoMam9pbnRfYW5nbGVzGA4gASgLMg8uSm9pbnRBbmdsZURh'
    'dGFSC2pvaW50QW5nbGVzEiUKCHVzaW5nX2lrGBAgASgOMgouQm9vbFN0YXRlUgd1c2luZ0lrSg'
    'QIARACSgQIAhAD');

@$core.Deprecated('Use wristCommandDescriptor instead')
const WristCommand$json = {
  '1': 'WristCommand',
  '2': [
    {'1': 'stop', '3': 1, '4': 1, '5': 8, '10': 'stop'},
    {'1': 'calibrate', '3': 2, '4': 1, '5': 8, '10': 'calibrate'},
    {
      '1': 'pitch',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.MotorCommand',
      '10': 'pitch'
    },
    {'1': 'roll', '3': 4, '4': 1, '5': 11, '6': '.MotorCommand', '10': 'roll'},
    {'1': 'version', '3': 5, '4': 1, '5': 11, '6': '.Version', '10': 'version'},
  ],
};

/// Descriptor for `WristCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List wristCommandDescriptor = $convert.base64Decode(
    'CgxXcmlzdENvbW1hbmQSEgoEc3RvcBgBIAEoCFIEc3RvcBIcCgljYWxpYnJhdGUYAiABKAhSCW'
    'NhbGlicmF0ZRIjCgVwaXRjaBgDIAEoCzINLk1vdG9yQ29tbWFuZFIFcGl0Y2gSIQoEcm9sbBgE'
    'IAEoCzINLk1vdG9yQ29tbWFuZFIEcm9sbBIiCgd2ZXJzaW9uGAUgASgLMgguVmVyc2lvblIHdm'
    'Vyc2lvbg==');

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
    {'1': 'roll', '3': 21, '4': 1, '5': 11, '6': '.MotorCommand', '10': 'roll'},
    {'1': 'ik_pose', '3': 24, '4': 1, '5': 11, '6': '.Pose3d', '10': 'ikPose'},
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
      '1': 'start_uss',
      '3': 12,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'startUss'
    },
    {
      '1': 'rotate',
      '3': 14,
      '4': 1,
      '5': 11,
      '6': '.MotorCommand',
      '10': 'rotate'
    },
    {
      '1': 'wrist',
      '3': 22,
      '4': 1,
      '5': 11,
      '6': '.WristCommand',
      '10': 'wrist'
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
    {'1': 'servo_angle', '3': 19, '4': 1, '5': 5, '10': 'servoAngle'},
    {
      '1': 'laser_state',
      '3': 20,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'laserState'
    },
    {
      '1': 'using_ik',
      '3': 23,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'usingIk'
    },
  ],
  '9': [
    {'1': 6, '2': 10},
    {'1': 13, '2': 14},
  ],
};

/// Descriptor for `ArmCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List armCommandDescriptor = $convert.base64Decode(
    'CgpBcm1Db21tYW5kEhIKBHN0b3AYASABKAhSBHN0b3ASHAoJY2FsaWJyYXRlGAIgASgIUgljYW'
    'xpYnJhdGUSJQoGc3dpdmVsGAMgASgLMg0uTW90b3JDb21tYW5kUgZzd2l2ZWwSKQoIc2hvdWxk'
    'ZXIYBCABKAsyDS5Nb3RvckNvbW1hbmRSCHNob3VsZGVyEiMKBWVsYm93GAUgASgLMg0uTW90b3'
    'JDb21tYW5kUgVlbGJvdxIhCgRyb2xsGBUgASgLMg0uTW90b3JDb21tYW5kUgRyb2xsEiAKB2lr'
    'X3Bvc2UYGCABKAsyBy5Qb3NlM2RSBmlrUG9zZRIQCgNqYWIYCiABKAhSA2phYhIiCgd2ZXJzaW'
    '9uGAsgASgLMgguVmVyc2lvblIHdmVyc2lvbhInCglzdGFydF91c3MYDCABKA4yCi5Cb29sU3Rh'
    'dGVSCHN0YXJ0VXNzEiUKBnJvdGF0ZRgOIAEoCzINLk1vdG9yQ29tbWFuZFIGcm90YXRlEiMKBX'
    'dyaXN0GBYgASgLMg0uV3Jpc3RDb21tYW5kUgV3cmlzdBIjCgVwaW5jaBgPIAEoCzINLk1vdG9y'
    'Q29tbWFuZFIFcGluY2gSEgoEb3BlbhgQIAEoCFIEb3BlbhIUCgVjbG9zZRgRIAEoCFIFY2xvc2'
    'USEgoEc3BpbhgSIAEoCFIEc3BpbhIfCgtzZXJ2b19hbmdsZRgTIAEoBVIKc2Vydm9BbmdsZRIr'
    'CgtsYXNlcl9zdGF0ZRgUIAEoDjIKLkJvb2xTdGF0ZVIKbGFzZXJTdGF0ZRIlCgh1c2luZ19pax'
    'gXIAEoDjIKLkJvb2xTdGF0ZVIHdXNpbmdJa0oECAYQCkoECA0QDg==');
