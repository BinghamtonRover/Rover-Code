//
//  Generated code. Do not modify.
//  source: drive.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ProtoColor extends $pb.ProtobufEnum {
  static const ProtoColor PROTO_COLOR_UNDEFINED = ProtoColor._(0, _omitEnumNames ? '' : 'PROTO_COLOR_UNDEFINED');
  static const ProtoColor RED = ProtoColor._(1, _omitEnumNames ? '' : 'RED');
  static const ProtoColor GREEN = ProtoColor._(2, _omitEnumNames ? '' : 'GREEN');
  static const ProtoColor BLUE = ProtoColor._(3, _omitEnumNames ? '' : 'BLUE');
  static const ProtoColor UNLIT = ProtoColor._(4, _omitEnumNames ? '' : 'UNLIT');

  static const $core.List<ProtoColor> values = <ProtoColor> [
    PROTO_COLOR_UNDEFINED,
    RED,
    GREEN,
    BLUE,
    UNLIT,
  ];

  static final $core.Map<$core.int, ProtoColor> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ProtoColor? valueOf($core.int value) => _byValue[value];

  const ProtoColor._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
