// This is a generated file - do not edit.
//
// Generated from motor.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

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

@$core.Deprecated('Use motorDataDescriptor instead')
const MotorData$json = {
  '1': 'MotorData',
  '2': [
    {
      '1': 'is_moving',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'isMoving'
    },
    {
      '1': 'is_limit_switch_pressed',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.BoolState',
      '10': 'isLimitSwitchPressed'
    },
    {
      '1': 'direction',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.MotorDirection',
      '10': 'direction'
    },
    {'1': 'current_step', '3': 4, '4': 1, '5': 5, '10': 'currentStep'},
    {'1': 'target_step', '3': 5, '4': 1, '5': 5, '10': 'targetStep'},
    {'1': 'current_angle', '3': 6, '4': 1, '5': 2, '10': 'currentAngle'},
    {'1': 'target_angle', '3': 7, '4': 1, '5': 2, '10': 'targetAngle'},
  ],
};

/// Descriptor for `MotorData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List motorDataDescriptor = $convert.base64Decode(
    'CglNb3RvckRhdGESJwoJaXNfbW92aW5nGAEgASgOMgouQm9vbFN0YXRlUghpc01vdmluZxJBCh'
    'dpc19saW1pdF9zd2l0Y2hfcHJlc3NlZBgCIAEoDjIKLkJvb2xTdGF0ZVIUaXNMaW1pdFN3aXRj'
    'aFByZXNzZWQSLQoJZGlyZWN0aW9uGAMgASgOMg8uTW90b3JEaXJlY3Rpb25SCWRpcmVjdGlvbh'
    'IhCgxjdXJyZW50X3N0ZXAYBCABKAVSC2N1cnJlbnRTdGVwEh8KC3RhcmdldF9zdGVwGAUgASgF'
    'Ugp0YXJnZXRTdGVwEiMKDWN1cnJlbnRfYW5nbGUYBiABKAJSDGN1cnJlbnRBbmdsZRIhCgx0YX'
    'JnZXRfYW5nbGUYByABKAJSC3RhcmdldEFuZ2xl');

@$core.Deprecated('Use motorCommandDescriptor instead')
const MotorCommand$json = {
  '1': 'MotorCommand',
  '2': [
    {'1': 'move_steps', '3': 1, '4': 1, '5': 5, '10': 'moveSteps'},
    {'1': 'move_radians', '3': 2, '4': 1, '5': 2, '10': 'moveRadians'},
    {'1': 'angle', '3': 3, '4': 1, '5': 2, '10': 'angle'},
  ],
};

/// Descriptor for `MotorCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List motorCommandDescriptor = $convert.base64Decode(
    'CgxNb3RvckNvbW1hbmQSHQoKbW92ZV9zdGVwcxgBIAEoBVIJbW92ZVN0ZXBzEiEKDG1vdmVfcm'
    'FkaWFucxgCIAEoAlILbW92ZVJhZGlhbnMSFAoFYW5nbGUYAyABKAJSBWFuZ2xl');
