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
      '1': 'current_position',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.Coordinates',
      '10': 'currentPosition'
    },
    {
      '1': 'current_orientation',
      '3': 17,
      '4': 1,
      '5': 11,
      '6': '.Orientation',
      '10': 'currentOrientation'
    },
    {
      '1': 'target_position',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.Coordinates',
      '10': 'targetPosition'
    },
    {
      '1': 'target_orientation',
      '3': 18,
      '4': 1,
      '5': 11,
      '6': '.Orientation',
      '10': 'targetOrientation'
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
};

/// Descriptor for `ArmData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List armDataDescriptor = $convert.base64Decode(
    'CgdBcm1EYXRhEjcKEGN1cnJlbnRfcG9zaXRpb24YASABKAsyDC5Db29yZGluYXRlc1IPY3Vycm'
    'VudFBvc2l0aW9uEj0KE2N1cnJlbnRfb3JpZW50YXRpb24YESABKAsyDC5PcmllbnRhdGlvblIS'
    'Y3VycmVudE9yaWVudGF0aW9uEjUKD3RhcmdldF9wb3NpdGlvbhgCIAEoCzIMLkNvb3JkaW5hdG'
    'VzUg50YXJnZXRQb3NpdGlvbhI7ChJ0YXJnZXRfb3JpZW50YXRpb24YEiABKAsyDC5PcmllbnRh'
    'dGlvblIRdGFyZ2V0T3JpZW50YXRpb24SHgoEYmFzZRgDIAEoCzIKLk1vdG9yRGF0YVIEYmFzZR'
    'ImCghzaG91bGRlchgEIAEoCzIKLk1vdG9yRGF0YVIIc2hvdWxkZXISIAoFZWxib3cYBSABKAsy'
    'Ci5Nb3RvckRhdGFSBWVsYm93Eh4KBHJvbGwYDSABKAsyCi5Nb3RvckRhdGFSBHJvbGwSIgoHdm'
    'Vyc2lvbhgGIAEoCzIILlZlcnNpb25SB3ZlcnNpb24SIQoMdXNzX2Rpc3RhbmNlGAcgASgCUgt1'
    'c3NEaXN0YW5jZRIeCgRsaWZ0GAggASgLMgouTW90b3JEYXRhUgRsaWZ0EiIKBnJvdGF0ZRgJIA'
    'EoCzIKLk1vdG9yRGF0YVIGcm90YXRlEiAKBXdyaXN0GA8gASgLMgouV3Jpc3REYXRhUgV3cmlz'
    'dBIgCgVwaW5jaBgKIAEoCzIKLk1vdG9yRGF0YVIFcGluY2gSHwoLc2Vydm9fYW5nbGUYCyABKA'
    'VSCnNlcnZvQW5nbGUSKwoLbGFzZXJfc3RhdGUYDCABKA4yCi5Cb29sU3RhdGVSCmxhc2VyU3Rh'
    'dGUSMgoMam9pbnRfYW5nbGVzGA4gASgLMg8uSm9pbnRBbmdsZURhdGFSC2pvaW50QW5nbGVzEi'
    'UKCHVzaW5nX2lrGBAgASgOMgouQm9vbFN0YXRlUgd1c2luZ0lr');

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
    {'1': 'ik_pitch', '3': 24, '4': 1, '5': 2, '10': 'ikPitch'},
    {'1': 'ik_yaw', '3': 25, '4': 1, '5': 2, '10': 'ikYaw'},
    {'1': 'pose', '3': 26, '4': 1, '5': 11, '6': '.Pose3d', '10': 'pose'},
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
};

/// Descriptor for `ArmCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List armCommandDescriptor = $convert.base64Decode(
    'CgpBcm1Db21tYW5kEhIKBHN0b3AYASABKAhSBHN0b3ASHAoJY2FsaWJyYXRlGAIgASgIUgljYW'
    'xpYnJhdGUSJQoGc3dpdmVsGAMgASgLMg0uTW90b3JDb21tYW5kUgZzd2l2ZWwSKQoIc2hvdWxk'
    'ZXIYBCABKAsyDS5Nb3RvckNvbW1hbmRSCHNob3VsZGVyEiMKBWVsYm93GAUgASgLMg0uTW90b3'
    'JDb21tYW5kUgVlbGJvdxIhCgRyb2xsGBUgASgLMg0uTW90b3JDb21tYW5kUgRyb2xsEjAKDGdy'
    'aXBwZXJfbGlmdBgGIAEoCzINLk1vdG9yQ29tbWFuZFILZ3JpcHBlckxpZnQSEQoEaWtfeBgHIA'
    'EoAlIDaWtYEhEKBGlrX3kYCCABKAJSA2lrWRIRCgRpa196GAkgASgCUgNpa1oSGQoIaWtfcGl0'
    'Y2gYGCABKAJSB2lrUGl0Y2gSFQoGaWtfeWF3GBkgASgCUgVpa1lhdxIbCgRwb3NlGBogASgLMg'
    'cuUG9zZTNkUgRwb3NlEhAKA2phYhgKIAEoCFIDamFiEiIKB3ZlcnNpb24YCyABKAsyCC5WZXJz'
    'aW9uUgd2ZXJzaW9uEicKCXN0YXJ0X3VzcxgMIAEoDjIKLkJvb2xTdGF0ZVIIc3RhcnRVc3MSIQ'
    'oEbGlmdBgNIAEoCzINLk1vdG9yQ29tbWFuZFIEbGlmdBIlCgZyb3RhdGUYDiABKAsyDS5Nb3Rv'
    'ckNvbW1hbmRSBnJvdGF0ZRIjCgV3cmlzdBgWIAEoCzINLldyaXN0Q29tbWFuZFIFd3Jpc3QSIw'
    'oFcGluY2gYDyABKAsyDS5Nb3RvckNvbW1hbmRSBXBpbmNoEhIKBG9wZW4YECABKAhSBG9wZW4S'
    'FAoFY2xvc2UYESABKAhSBWNsb3NlEhIKBHNwaW4YEiABKAhSBHNwaW4SHwoLc2Vydm9fYW5nbG'
    'UYEyABKAVSCnNlcnZvQW5nbGUSKwoLbGFzZXJfc3RhdGUYFCABKA4yCi5Cb29sU3RhdGVSCmxh'
    'c2VyU3RhdGUSJQoIdXNpbmdfaWsYFyABKA4yCi5Cb29sU3RhdGVSB3VzaW5nSWs=');
