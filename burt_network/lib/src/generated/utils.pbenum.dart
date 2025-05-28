//
//  Generated code. Do not modify.
//  source: utils.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class BoolState extends $pb.ProtobufEnum {
  static const BoolState BOOL_UNDEFINED = BoolState._(0, _omitEnumNames ? '' : 'BOOL_UNDEFINED');
  static const BoolState ON = BoolState._(1, _omitEnumNames ? '' : 'ON');
  static const BoolState OFF = BoolState._(2, _omitEnumNames ? '' : 'OFF');

  static const BoolState YES = ON;
  static const BoolState NO = OFF;
  static const BoolState OPEN = ON;
  static const BoolState CLOSE = OFF;

  static const $core.List<BoolState> values = <BoolState> [
    BOOL_UNDEFINED,
    ON,
    OFF,
  ];

  static final $core.List<BoolState?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 2);
  static BoolState? valueOf($core.int value) =>  value < 0 || value >= _byValue.length ? null : _byValue[value];

  const BoolState._(super.v, super.n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
