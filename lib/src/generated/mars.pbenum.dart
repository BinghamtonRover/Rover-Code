//
//  Generated code. Do not modify.
//  source: mars.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class MarsStatus extends $pb.ProtobufEnum {
  static const MarsStatus MARS_STATUS_UNDEFINED = MarsStatus._(0, _omitEnumNames ? '' : 'MARS_STATUS_UNDEFINED');
  static const MarsStatus PORT_NOT_FOUND = MarsStatus._(1, _omitEnumNames ? '' : 'PORT_NOT_FOUND');
  static const MarsStatus TEENSY_UNRESPONSIVE = MarsStatus._(2, _omitEnumNames ? '' : 'TEENSY_UNRESPONSIVE');
  static const MarsStatus FAILED_HANDSHAKE = MarsStatus._(3, _omitEnumNames ? '' : 'FAILED_HANDSHAKE');
  static const MarsStatus TEENSY_CONNECTED = MarsStatus._(4, _omitEnumNames ? '' : 'TEENSY_CONNECTED');

  static const $core.List<MarsStatus> values = <MarsStatus> [
    MARS_STATUS_UNDEFINED,
    PORT_NOT_FOUND,
    TEENSY_UNRESPONSIVE,
    FAILED_HANDSHAKE,
    TEENSY_CONNECTED,
  ];

  static final $core.Map<$core.int, MarsStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MarsStatus? valueOf($core.int value) => _byValue[value];

  const MarsStatus._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
