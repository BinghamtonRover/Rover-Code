//
//  Generated code. Do not modify.
//  source: gps.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class RTKMode extends $pb.ProtobufEnum {
  static const RTKMode RTK_NONE = RTKMode._(0, _omitEnumNames ? '' : 'RTK_NONE');
  static const RTKMode RTK_FLOAT = RTKMode._(1, _omitEnumNames ? '' : 'RTK_FLOAT');
  static const RTKMode RTK_FIXED = RTKMode._(2, _omitEnumNames ? '' : 'RTK_FIXED');

  static const $core.List<RTKMode> values = <RTKMode> [
    RTK_NONE,
    RTK_FLOAT,
    RTK_FIXED,
  ];

  static final $core.Map<$core.int, RTKMode> _byValue = $pb.ProtobufEnum.initByValue(values);
  static RTKMode? valueOf($core.int value) => _byValue[value];

  const RTKMode._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
