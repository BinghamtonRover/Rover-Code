//
//  Generated code. Do not modify.
//  source: arm.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use motorDirectionDescriptor instead')
const MotorDirection$json = {
  '1': 'MotorDirection',
  '2': [
    {'1': 'MOTOR_DIRECTION_UNDEFINED', '2': 0},
    {'1': 'UP', '2': 1},
    {'1': 'DOWN', '2': 2},
    {'1': 'LEFT', '2': 3},
    {'1': 'RIGHT', '2': 4},
    {'1': 'CLOCKWISE', '2': 5},
    {'1': 'COUNTER_CLOCKWISE', '2': 6},
    {'1': 'OPENING', '2': 7},
    {'1': 'CLOSING', '2': 8},
    {'1': 'NOT_MOVING', '2': 9},
  ],
};

/// Descriptor for `MotorDirection`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List motorDirectionDescriptor = $convert.base64Decode(
    'Cg5Nb3RvckRpcmVjdGlvbhIdChlNT1RPUl9ESVJFQ1RJT05fVU5ERUZJTkVEEAASBgoCVVAQAR'
    'IICgRET1dOEAISCAoETEVGVBADEgkKBVJJR0hUEAQSDQoJQ0xPQ0tXSVNFEAUSFQoRQ09VTlRF'
    'Ul9DTE9DS1dJU0UQBhILCgdPUEVOSU5HEAcSCwoHQ0xPU0lORxAIEg4KCk5PVF9NT1ZJTkcQCQ'
    '==');

@$core.Deprecated('Use coordinatesDescriptor instead')
const Coordinates$json = {
  '1': 'Coordinates',
  '2': [
    {'1': 'x', '3': 1, '4': 1, '5': 2, '10': 'x'},
    {'1': 'y', '3': 2, '4': 1, '5': 2, '10': 'y'},
    {'1': 'z', '3': 3, '4': 1, '5': 2, '10': 'z'},
  ],
};

/// Descriptor for `Coordinates`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List coordinatesDescriptor = $convert.base64Decode(
    'CgtDb29yZGluYXRlcxIMCgF4GAEgASgCUgF4EgwKAXkYAiABKAJSAXkSDAoBehgDIAEoAlIBeg'
    '==');

@$core.Deprecated('Use motorDataDescriptor instead')
const MotorData$json = {
  '1': 'MotorData',
  '2': [
    {'1': 'is_moving', '3': 1, '4': 1, '5': 8, '10': 'isMoving'},
    {'1': 'is_limit_switch_pressed', '3': 2, '4': 1, '5': 8, '10': 'isLimitSwitchPressed'},
    {'1': 'direction', '3': 3, '4': 1, '5': 14, '6': '.MotorDirection', '10': 'direction'},
    {'1': 'current_step', '3': 4, '4': 1, '5': 5, '10': 'currentStep'},
    {'1': 'target_step', '3': 5, '4': 1, '5': 5, '10': 'targetStep'},
    {'1': 'angle', '3': 6, '4': 1, '5': 2, '10': 'angle'},
  ],
};

/// Descriptor for `MotorData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List motorDataDescriptor = $convert.base64Decode(
    'CglNb3RvckRhdGESGwoJaXNfbW92aW5nGAEgASgIUghpc01vdmluZxI1Chdpc19saW1pdF9zd2'
    'l0Y2hfcHJlc3NlZBgCIAEoCFIUaXNMaW1pdFN3aXRjaFByZXNzZWQSLQoJZGlyZWN0aW9uGAMg'
    'ASgOMg8uTW90b3JEaXJlY3Rpb25SCWRpcmVjdGlvbhIhCgxjdXJyZW50X3N0ZXAYBCABKAVSC2'
    'N1cnJlbnRTdGVwEh8KC3RhcmdldF9zdGVwGAUgASgFUgp0YXJnZXRTdGVwEhQKBWFuZ2xlGAYg'
    'ASgCUgVhbmdsZQ==');

@$core.Deprecated('Use motorCommandDescriptor instead')
const MotorCommand$json = {
  '1': 'MotorCommand',
  '2': [
    {'1': 'move_steps', '3': 1, '4': 1, '5': 5, '10': 'moveSteps'},
    {'1': 'move_radians', '3': 2, '4': 1, '5': 2, '10': 'moveRadians'},
  ],
};

/// Descriptor for `MotorCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List motorCommandDescriptor = $convert.base64Decode(
    'CgxNb3RvckNvbW1hbmQSHQoKbW92ZV9zdGVwcxgBIAEoBVIJbW92ZVN0ZXBzEiEKDG1vdmVfcm'
    'FkaWFucxgCIAEoAlILbW92ZVJhZGlhbnM=');

@$core.Deprecated('Use armDataDescriptor instead')
const ArmData$json = {
  '1': 'ArmData',
  '2': [
    {'1': 'currentPosition', '3': 1, '4': 1, '5': 11, '6': '.Coordinates', '10': 'currentPosition'},
    {'1': 'targetPosition', '3': 2, '4': 1, '5': 11, '6': '.Coordinates', '10': 'targetPosition'},
    {'1': 'base', '3': 3, '4': 1, '5': 11, '6': '.MotorData', '10': 'base'},
    {'1': 'shoulder', '3': 4, '4': 1, '5': 11, '6': '.MotorData', '10': 'shoulder'},
    {'1': 'elbow', '3': 5, '4': 1, '5': 11, '6': '.MotorData', '10': 'elbow'},
    {'1': 'version', '3': 6, '4': 1, '5': 11, '6': '.Version', '10': 'version'},
  ],
};

/// Descriptor for `ArmData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List armDataDescriptor = $convert.base64Decode(
    'CgdBcm1EYXRhEjYKD2N1cnJlbnRQb3NpdGlvbhgBIAEoCzIMLkNvb3JkaW5hdGVzUg9jdXJyZW'
    '50UG9zaXRpb24SNAoOdGFyZ2V0UG9zaXRpb24YAiABKAsyDC5Db29yZGluYXRlc1IOdGFyZ2V0'
    'UG9zaXRpb24SHgoEYmFzZRgDIAEoCzIKLk1vdG9yRGF0YVIEYmFzZRImCghzaG91bGRlchgEIA'
    'EoCzIKLk1vdG9yRGF0YVIIc2hvdWxkZXISIAoFZWxib3cYBSABKAsyCi5Nb3RvckRhdGFSBWVs'
    'Ym93EiIKB3ZlcnNpb24YBiABKAsyCC5WZXJzaW9uUgd2ZXJzaW9u');

@$core.Deprecated('Use armCommandDescriptor instead')
const ArmCommand$json = {
  '1': 'ArmCommand',
  '2': [
    {'1': 'stop', '3': 1, '4': 1, '5': 8, '10': 'stop'},
    {'1': 'calibrate', '3': 2, '4': 1, '5': 8, '10': 'calibrate'},
    {'1': 'swivel', '3': 3, '4': 1, '5': 11, '6': '.MotorCommand', '10': 'swivel'},
    {'1': 'shoulder', '3': 4, '4': 1, '5': 11, '6': '.MotorCommand', '10': 'shoulder'},
    {'1': 'elbow', '3': 5, '4': 1, '5': 11, '6': '.MotorCommand', '10': 'elbow'},
    {'1': 'gripper_lift', '3': 6, '4': 1, '5': 11, '6': '.MotorCommand', '10': 'gripperLift'},
    {'1': 'ik_x', '3': 7, '4': 1, '5': 2, '10': 'ikX'},
    {'1': 'ik_y', '3': 8, '4': 1, '5': 2, '10': 'ikY'},
    {'1': 'ik_z', '3': 9, '4': 1, '5': 2, '10': 'ikZ'},
    {'1': 'jab', '3': 10, '4': 1, '5': 8, '10': 'jab'},
    {'1': 'version', '3': 11, '4': 1, '5': 11, '6': '.Version', '10': 'version'},
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
    'Ugd2ZXJzaW9u');

@$core.Deprecated('Use gripperDataDescriptor instead')
const GripperData$json = {
  '1': 'GripperData',
  '2': [
    {'1': 'lift', '3': 1, '4': 1, '5': 11, '6': '.MotorData', '10': 'lift'},
    {'1': 'rotate', '3': 2, '4': 1, '5': 11, '6': '.MotorData', '10': 'rotate'},
    {'1': 'pinch', '3': 3, '4': 1, '5': 11, '6': '.MotorData', '10': 'pinch'},
    {'1': 'version', '3': 4, '4': 1, '5': 11, '6': '.Version', '10': 'version'},
  ],
};

/// Descriptor for `GripperData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gripperDataDescriptor = $convert.base64Decode(
    'CgtHcmlwcGVyRGF0YRIeCgRsaWZ0GAEgASgLMgouTW90b3JEYXRhUgRsaWZ0EiIKBnJvdGF0ZR'
    'gCIAEoCzIKLk1vdG9yRGF0YVIGcm90YXRlEiAKBXBpbmNoGAMgASgLMgouTW90b3JEYXRhUgVw'
    'aW5jaBIiCgd2ZXJzaW9uGAQgASgLMgguVmVyc2lvblIHdmVyc2lvbg==');

@$core.Deprecated('Use gripperCommandDescriptor instead')
const GripperCommand$json = {
  '1': 'GripperCommand',
  '2': [
    {'1': 'stop', '3': 1, '4': 1, '5': 8, '10': 'stop'},
    {'1': 'calibrate', '3': 2, '4': 1, '5': 8, '10': 'calibrate'},
    {'1': 'lift', '3': 3, '4': 1, '5': 11, '6': '.MotorCommand', '10': 'lift'},
    {'1': 'rotate', '3': 4, '4': 1, '5': 11, '6': '.MotorCommand', '10': 'rotate'},
    {'1': 'pinch', '3': 5, '4': 1, '5': 11, '6': '.MotorCommand', '10': 'pinch'},
    {'1': 'open', '3': 6, '4': 1, '5': 8, '10': 'open'},
    {'1': 'close', '3': 7, '4': 1, '5': 8, '10': 'close'},
    {'1': 'spin', '3': 8, '4': 1, '5': 8, '10': 'spin'},
    {'1': 'version', '3': 9, '4': 1, '5': 11, '6': '.Version', '10': 'version'},
  ],
};

/// Descriptor for `GripperCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gripperCommandDescriptor = $convert.base64Decode(
    'Cg5HcmlwcGVyQ29tbWFuZBISCgRzdG9wGAEgASgIUgRzdG9wEhwKCWNhbGlicmF0ZRgCIAEoCF'
    'IJY2FsaWJyYXRlEiEKBGxpZnQYAyABKAsyDS5Nb3RvckNvbW1hbmRSBGxpZnQSJQoGcm90YXRl'
    'GAQgASgLMg0uTW90b3JDb21tYW5kUgZyb3RhdGUSIwoFcGluY2gYBSABKAsyDS5Nb3RvckNvbW'
    '1hbmRSBXBpbmNoEhIKBG9wZW4YBiABKAhSBG9wZW4SFAoFY2xvc2UYByABKAhSBWNsb3NlEhIK'
    'BHNwaW4YCCABKAhSBHNwaW4SIgoHdmVyc2lvbhgJIAEoCzIILlZlcnNpb25SB3ZlcnNpb24=');

