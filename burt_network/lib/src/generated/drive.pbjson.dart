//
//  Generated code. Do not modify.
//  source: drive.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use driveMotorDescriptor instead')
const DriveMotor$json = {
  '1': 'DriveMotor',
  '2': [
    {'1': 'FRONT_LEFT', '2': 0},
    {'1': 'FRONT_RIGHT', '2': 1},
    {'1': 'MIDDLE_LEFT', '2': 3},
    {'1': 'MIDDLE_RIGHT', '2': 4},
    {'1': 'BACK_LEFT', '2': 5},
    {'1': 'BACK_RIGHT', '2': 6},
  ],
};

/// Descriptor for `DriveMotor`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List driveMotorDescriptor = $convert.base64Decode(
    'CgpEcml2ZU1vdG9yEg4KCkZST05UX0xFRlQQABIPCgtGUk9OVF9SSUdIVBABEg8KC01JRERMRV'
    '9MRUZUEAMSEAoMTUlERExFX1JJR0hUEAQSDQoJQkFDS19MRUZUEAUSDgoKQkFDS19SSUdIVBAG');

@$core.Deprecated('Use protoColorDescriptor instead')
const ProtoColor$json = {
  '1': 'ProtoColor',
  '2': [
    {'1': 'PROTO_COLOR_UNDEFINED', '2': 0},
    {'1': 'RED', '2': 1},
    {'1': 'GREEN', '2': 2},
    {'1': 'BLUE', '2': 3},
    {'1': 'UNLIT', '2': 4},
  ],
};

/// Descriptor for `ProtoColor`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List protoColorDescriptor = $convert.base64Decode(
    'CgpQcm90b0NvbG9yEhkKFVBST1RPX0NPTE9SX1VOREVGSU5FRBAAEgcKA1JFRBABEgkKBUdSRU'
    'VOEAISCAoEQkxVRRADEgkKBVVOTElUEAQ=');

@$core.Deprecated('Use motorErrorCodeDescriptor instead')
const MotorErrorCode$json = {
  '1': 'MotorErrorCode',
  '2': [
    {'1': 'NO_FAULT', '2': 0},
    {'1': 'OVER_TEMP', '2': 1},
    {'1': 'OVER_CURRENT', '2': 2},
    {'1': 'OVER_VOLTAGE', '2': 3},
    {'1': 'UNDER_VOLTAGE', '2': 4},
    {'1': 'ENCODER_FAULT', '2': 5},
    {'1': 'MOSFET_OVER_TEMP', '2': 6},
    {'1': 'UNKNOWN_ERROR', '2': 7},
  ],
};

/// Descriptor for `MotorErrorCode`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List motorErrorCodeDescriptor = $convert.base64Decode(
    'Cg5Nb3RvckVycm9yQ29kZRIMCghOT19GQVVMVBAAEg0KCU9WRVJfVEVNUBABEhAKDE9WRVJfQ1'
    'VSUkVOVBACEhAKDE9WRVJfVk9MVEFHRRADEhEKDVVOREVSX1ZPTFRBR0UQBBIRCg1FTkNPREVS'
    'X0ZBVUxUEAUSFAoQTU9TRkVUX09WRVJfVEVNUBAGEhEKDVVOS05PV05fRVJST1IQBw==');

@$core.Deprecated('Use driveCommandDescriptor instead')
const DriveCommand$json = {
  '1': 'DriveCommand',
  '2': [
    {'1': 'throttle', '3': 1, '4': 1, '5': 2, '10': 'throttle'},
    {'1': 'left', '3': 2, '4': 1, '5': 2, '10': 'left'},
    {'1': 'right', '3': 3, '4': 1, '5': 2, '10': 'right'},
    {'1': 'set_left', '3': 4, '4': 1, '5': 8, '10': 'setLeft'},
    {'1': 'set_right', '3': 5, '4': 1, '5': 8, '10': 'setRight'},
    {'1': 'set_throttle', '3': 6, '4': 1, '5': 8, '10': 'setThrottle'},
    {'1': 'front_swivel', '3': 7, '4': 1, '5': 2, '10': 'frontSwivel'},
    {'1': 'front_tilt', '3': 8, '4': 1, '5': 2, '10': 'frontTilt'},
    {'1': 'rear_swivel', '3': 9, '4': 1, '5': 2, '10': 'rearSwivel'},
    {'1': 'rear_tilt', '3': 10, '4': 1, '5': 2, '10': 'rearTilt'},
    {'1': 'status', '3': 11, '4': 1, '5': 14, '6': '.RoverStatus', '10': 'status'},
    {'1': 'version', '3': 12, '4': 1, '5': 11, '6': '.Version', '10': 'version'},
    {'1': 'color', '3': 13, '4': 1, '5': 14, '6': '.ProtoColor', '10': 'color'},
    {'1': 'blink', '3': 14, '4': 1, '5': 14, '6': '.BoolState', '10': 'blink'},
  ],
};

/// Descriptor for `DriveCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List driveCommandDescriptor = $convert.base64Decode(
    'CgxEcml2ZUNvbW1hbmQSGgoIdGhyb3R0bGUYASABKAJSCHRocm90dGxlEhIKBGxlZnQYAiABKA'
    'JSBGxlZnQSFAoFcmlnaHQYAyABKAJSBXJpZ2h0EhkKCHNldF9sZWZ0GAQgASgIUgdzZXRMZWZ0'
    'EhsKCXNldF9yaWdodBgFIAEoCFIIc2V0UmlnaHQSIQoMc2V0X3Rocm90dGxlGAYgASgIUgtzZX'
    'RUaHJvdHRsZRIhCgxmcm9udF9zd2l2ZWwYByABKAJSC2Zyb250U3dpdmVsEh0KCmZyb250X3Rp'
    'bHQYCCABKAJSCWZyb250VGlsdBIfCgtyZWFyX3N3aXZlbBgJIAEoAlIKcmVhclN3aXZlbBIbCg'
    'lyZWFyX3RpbHQYCiABKAJSCHJlYXJUaWx0EiQKBnN0YXR1cxgLIAEoDjIMLlJvdmVyU3RhdHVz'
    'UgZzdGF0dXMSIgoHdmVyc2lvbhgMIAEoCzIILlZlcnNpb25SB3ZlcnNpb24SIQoFY29sb3IYDS'
    'ABKA4yCy5Qcm90b0NvbG9yUgVjb2xvchIgCgVibGluaxgOIAEoDjIKLkJvb2xTdGF0ZVIFYmxp'
    'bms=');

@$core.Deprecated('Use driveMotorDataDescriptor instead')
const DriveMotorData$json = {
  '1': 'DriveMotorData',
  '2': [
    {'1': 'speed', '3': 1, '4': 1, '5': 2, '10': 'speed'},
    {'1': 'current', '3': 2, '4': 1, '5': 2, '10': 'current'},
    {'1': 'temperature', '3': 3, '4': 1, '5': 5, '10': 'temperature'},
    {'1': 'error', '3': 4, '4': 1, '5': 14, '6': '.MotorErrorCode', '10': 'error'},
  ],
};

/// Descriptor for `DriveMotorData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List driveMotorDataDescriptor = $convert.base64Decode(
    'Cg5Ecml2ZU1vdG9yRGF0YRIUCgVzcGVlZBgBIAEoAlIFc3BlZWQSGAoHY3VycmVudBgCIAEoAl'
    'IHY3VycmVudBIgCgt0ZW1wZXJhdHVyZRgDIAEoBVILdGVtcGVyYXR1cmUSJQoFZXJyb3IYBCAB'
    'KA4yDy5Nb3RvckVycm9yQ29kZVIFZXJyb3I=');

@$core.Deprecated('Use driveDataDescriptor instead')
const DriveData$json = {
  '1': 'DriveData',
  '2': [
    {'1': 'throttle', '3': 1, '4': 1, '5': 2, '10': 'throttle'},
    {'1': 'left', '3': 2, '4': 1, '5': 2, '10': 'left'},
    {'1': 'right', '3': 3, '4': 1, '5': 2, '10': 'right'},
    {'1': 'set_left', '3': 4, '4': 1, '5': 8, '10': 'setLeft'},
    {'1': 'set_right', '3': 5, '4': 1, '5': 8, '10': 'setRight'},
    {'1': 'set_throttle', '3': 6, '4': 1, '5': 8, '10': 'setThrottle'},
    {'1': 'front_swivel', '3': 7, '4': 1, '5': 2, '10': 'frontSwivel'},
    {'1': 'front_tilt', '3': 8, '4': 1, '5': 2, '10': 'frontTilt'},
    {'1': 'rear_swivel', '3': 9, '4': 1, '5': 2, '10': 'rearSwivel'},
    {'1': 'rear_tilt', '3': 10, '4': 1, '5': 2, '10': 'rearTilt'},
    {'1': 'battery_voltage', '3': 11, '4': 1, '5': 2, '10': 'batteryVoltage'},
    {'1': 'battery_current', '3': 12, '4': 1, '5': 2, '10': 'batteryCurrent'},
    {'1': 'battery_temperature', '3': 13, '4': 1, '5': 2, '10': 'batteryTemperature'},
    {'1': 'version', '3': 14, '4': 1, '5': 11, '6': '.Version', '10': 'version'},
    {'1': 'color', '3': 21, '4': 1, '5': 14, '6': '.ProtoColor', '10': 'color'},
    {'1': 'status', '3': 22, '4': 1, '5': 14, '6': '.RoverStatus', '10': 'status'},
    {'1': 'front_left_motor', '3': 23, '4': 1, '5': 11, '6': '.DriveMotorData', '10': 'frontLeftMotor'},
    {'1': 'middle_left_motor', '3': 24, '4': 1, '5': 11, '6': '.DriveMotorData', '10': 'middleLeftMotor'},
    {'1': 'back_left_motor', '3': 25, '4': 1, '5': 11, '6': '.DriveMotorData', '10': 'backLeftMotor'},
    {'1': 'front_right_motor', '3': 26, '4': 1, '5': 11, '6': '.DriveMotorData', '10': 'frontRightMotor'},
    {'1': 'middle_right_motor', '3': 27, '4': 1, '5': 11, '6': '.DriveMotorData', '10': 'middleRightMotor'},
    {'1': 'back_right_motor', '3': 28, '4': 1, '5': 11, '6': '.DriveMotorData', '10': 'backRightMotor'},
  ],
  '9': [
    {'1': 15, '2': 21},
  ],
};

/// Descriptor for `DriveData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List driveDataDescriptor = $convert.base64Decode(
    'CglEcml2ZURhdGESGgoIdGhyb3R0bGUYASABKAJSCHRocm90dGxlEhIKBGxlZnQYAiABKAJSBG'
    'xlZnQSFAoFcmlnaHQYAyABKAJSBXJpZ2h0EhkKCHNldF9sZWZ0GAQgASgIUgdzZXRMZWZ0EhsK'
    'CXNldF9yaWdodBgFIAEoCFIIc2V0UmlnaHQSIQoMc2V0X3Rocm90dGxlGAYgASgIUgtzZXRUaH'
    'JvdHRsZRIhCgxmcm9udF9zd2l2ZWwYByABKAJSC2Zyb250U3dpdmVsEh0KCmZyb250X3RpbHQY'
    'CCABKAJSCWZyb250VGlsdBIfCgtyZWFyX3N3aXZlbBgJIAEoAlIKcmVhclN3aXZlbBIbCglyZW'
    'FyX3RpbHQYCiABKAJSCHJlYXJUaWx0EicKD2JhdHRlcnlfdm9sdGFnZRgLIAEoAlIOYmF0dGVy'
    'eVZvbHRhZ2USJwoPYmF0dGVyeV9jdXJyZW50GAwgASgCUg5iYXR0ZXJ5Q3VycmVudBIvChNiYX'
    'R0ZXJ5X3RlbXBlcmF0dXJlGA0gASgCUhJiYXR0ZXJ5VGVtcGVyYXR1cmUSIgoHdmVyc2lvbhgO'
    'IAEoCzIILlZlcnNpb25SB3ZlcnNpb24SIQoFY29sb3IYFSABKA4yCy5Qcm90b0NvbG9yUgVjb2'
    'xvchIkCgZzdGF0dXMYFiABKA4yDC5Sb3ZlclN0YXR1c1IGc3RhdHVzEjkKEGZyb250X2xlZnRf'
    'bW90b3IYFyABKAsyDy5Ecml2ZU1vdG9yRGF0YVIOZnJvbnRMZWZ0TW90b3ISOwoRbWlkZGxlX2'
    'xlZnRfbW90b3IYGCABKAsyDy5Ecml2ZU1vdG9yRGF0YVIPbWlkZGxlTGVmdE1vdG9yEjcKD2Jh'
    'Y2tfbGVmdF9tb3RvchgZIAEoCzIPLkRyaXZlTW90b3JEYXRhUg1iYWNrTGVmdE1vdG9yEjsKEW'
    'Zyb250X3JpZ2h0X21vdG9yGBogASgLMg8uRHJpdmVNb3RvckRhdGFSD2Zyb250UmlnaHRNb3Rv'
    'chI9ChJtaWRkbGVfcmlnaHRfbW90b3IYGyABKAsyDy5Ecml2ZU1vdG9yRGF0YVIQbWlkZGxlUm'
    'lnaHRNb3RvchI5ChBiYWNrX3JpZ2h0X21vdG9yGBwgASgLMg8uRHJpdmVNb3RvckRhdGFSDmJh'
    'Y2tSaWdodE1vdG9ySgQIDxAV');

