//
//  Generated code. Do not modify.
//  source: subsystems.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class SubsystemsCommand extends $pb.GeneratedMessage {
  factory SubsystemsCommand({
    $core.bool? zeroIMU,
  }) {
    final $result = create();
    if (zeroIMU != null) {
      $result.zeroIMU = zeroIMU;
    }
    return $result;
  }
  SubsystemsCommand._() : super();
  factory SubsystemsCommand.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubsystemsCommand.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SubsystemsCommand', createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'zeroIMU', protoName: 'zeroIMU')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubsystemsCommand clone() => SubsystemsCommand()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubsystemsCommand copyWith(void Function(SubsystemsCommand) updates) => super.copyWith((message) => updates(message as SubsystemsCommand)) as SubsystemsCommand;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubsystemsCommand create() => SubsystemsCommand._();
  SubsystemsCommand createEmptyInstance() => create();
  static $pb.PbList<SubsystemsCommand> createRepeated() => $pb.PbList<SubsystemsCommand>();
  @$core.pragma('dart2js:noInline')
  static SubsystemsCommand getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubsystemsCommand>(create);
  static SubsystemsCommand? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get zeroIMU => $_getBF(0);
  @$pb.TagNumber(1)
  set zeroIMU($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasZeroIMU() => $_has(0);
  @$pb.TagNumber(1)
  void clearZeroIMU() => clearField(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
