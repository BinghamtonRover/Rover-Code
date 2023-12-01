//
//  Generated code. Do not modify.
//  source: core.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'core.pbenum.dart';

export 'core.pbenum.dart';

/// Used for a simple handshake between devices.
class Connect extends $pb.GeneratedMessage {
  factory Connect({
    Device? sender,
    Device? receiver,
  }) {
    final $result = create();
    if (sender != null) {
      $result.sender = sender;
    }
    if (receiver != null) {
      $result.receiver = receiver;
    }
    return $result;
  }
  Connect._() : super();
  factory Connect.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Connect.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Connect', createEmptyInstance: create)
    ..e<Device>(1, _omitFieldNames ? '' : 'sender', $pb.PbFieldType.OE, defaultOrMaker: Device.DEVICE_UNDEFINED, valueOf: Device.valueOf, enumValues: Device.values)
    ..e<Device>(2, _omitFieldNames ? '' : 'receiver', $pb.PbFieldType.OE, defaultOrMaker: Device.DEVICE_UNDEFINED, valueOf: Device.valueOf, enumValues: Device.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Connect clone() => Connect()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Connect copyWith(void Function(Connect) updates) => super.copyWith((message) => updates(message as Connect)) as Connect;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Connect create() => Connect._();
  Connect createEmptyInstance() => create();
  static $pb.PbList<Connect> createRepeated() => $pb.PbList<Connect>();
  @$core.pragma('dart2js:noInline')
  static Connect getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Connect>(create);
  static Connect? _defaultInstance;

  @$pb.TagNumber(1)
  Device get sender => $_getN(0);
  @$pb.TagNumber(1)
  set sender(Device v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSender() => $_has(0);
  @$pb.TagNumber(1)
  void clearSender() => clearField(1);

  @$pb.TagNumber(2)
  Device get receiver => $_getN(1);
  @$pb.TagNumber(2)
  set receiver(Device v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasReceiver() => $_has(1);
  @$pb.TagNumber(2)
  void clearReceiver() => clearField(2);
}

/// Notifies the recipient that the sender will no longer be connected.
class Disconnect extends $pb.GeneratedMessage {
  factory Disconnect({
    Device? sender,
  }) {
    final $result = create();
    if (sender != null) {
      $result.sender = sender;
    }
    return $result;
  }
  Disconnect._() : super();
  factory Disconnect.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Disconnect.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Disconnect', createEmptyInstance: create)
    ..e<Device>(1, _omitFieldNames ? '' : 'sender', $pb.PbFieldType.OE, defaultOrMaker: Device.DEVICE_UNDEFINED, valueOf: Device.valueOf, enumValues: Device.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Disconnect clone() => Disconnect()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Disconnect copyWith(void Function(Disconnect) updates) => super.copyWith((message) => updates(message as Disconnect)) as Disconnect;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Disconnect create() => Disconnect._();
  Disconnect createEmptyInstance() => create();
  static $pb.PbList<Disconnect> createRepeated() => $pb.PbList<Disconnect>();
  @$core.pragma('dart2js:noInline')
  static Disconnect getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Disconnect>(create);
  static Disconnect? _defaultInstance;

  @$pb.TagNumber(1)
  Device get sender => $_getN(0);
  @$pb.TagNumber(1)
  set sender(Device v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSender() => $_has(0);
  @$pb.TagNumber(1)
  void clearSender() => clearField(1);
}

/// / Update a sensitive setting, such as the rover's status.
/// /
/// / This message must be triggered manually and the recipient (usually the subsystems Pi)
/// / must respond with the exact same message to confirm its receipt.
class UpdateSetting extends $pb.GeneratedMessage {
  factory UpdateSetting({
    RoverStatus? status,
    ProtoColor? color,
  }) {
    final $result = create();
    if (status != null) {
      $result.status = status;
    }
    if (color != null) {
      $result.color = color;
    }
    return $result;
  }
  UpdateSetting._() : super();
  factory UpdateSetting.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateSetting.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateSetting', createEmptyInstance: create)
    ..e<RoverStatus>(1, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: RoverStatus.DISCONNECTED, valueOf: RoverStatus.valueOf, enumValues: RoverStatus.values)
    ..aOM<ProtoColor>(2, _omitFieldNames ? '' : 'color', subBuilder: ProtoColor.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateSetting clone() => UpdateSetting()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateSetting copyWith(void Function(UpdateSetting) updates) => super.copyWith((message) => updates(message as UpdateSetting)) as UpdateSetting;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateSetting create() => UpdateSetting._();
  UpdateSetting createEmptyInstance() => create();
  static $pb.PbList<UpdateSetting> createRepeated() => $pb.PbList<UpdateSetting>();
  @$core.pragma('dart2js:noInline')
  static UpdateSetting getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateSetting>(create);
  static UpdateSetting? _defaultInstance;

  @$pb.TagNumber(1)
  RoverStatus get status => $_getN(0);
  @$pb.TagNumber(1)
  set status(RoverStatus v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);

  @$pb.TagNumber(2)
  ProtoColor get color => $_getN(1);
  @$pb.TagNumber(2)
  set color(ProtoColor v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasColor() => $_has(1);
  @$pb.TagNumber(2)
  void clearColor() => clearField(2);
  @$pb.TagNumber(2)
  ProtoColor ensureColor() => $_ensure(1);
}

class ProtoColor extends $pb.GeneratedMessage {
  factory ProtoColor({
    $core.double? red,
    $core.double? green,
    $core.double? blue,
  }) {
    final $result = create();
    if (red != null) {
      $result.red = red;
    }
    if (green != null) {
      $result.green = green;
    }
    if (blue != null) {
      $result.blue = blue;
    }
    return $result;
  }
  ProtoColor._() : super();
  factory ProtoColor.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoColor.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ProtoColor', createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'red', $pb.PbFieldType.OF)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'green', $pb.PbFieldType.OF)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'blue', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoColor clone() => ProtoColor()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoColor copyWith(void Function(ProtoColor) updates) => super.copyWith((message) => updates(message as ProtoColor)) as ProtoColor;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProtoColor create() => ProtoColor._();
  ProtoColor createEmptyInstance() => create();
  static $pb.PbList<ProtoColor> createRepeated() => $pb.PbList<ProtoColor>();
  @$core.pragma('dart2js:noInline')
  static ProtoColor getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoColor>(create);
  static ProtoColor? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get red => $_getN(0);
  @$pb.TagNumber(1)
  set red($core.double v) { $_setFloat(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRed() => $_has(0);
  @$pb.TagNumber(1)
  void clearRed() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get green => $_getN(1);
  @$pb.TagNumber(2)
  set green($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasGreen() => $_has(1);
  @$pb.TagNumber(2)
  void clearGreen() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get blue => $_getN(2);
  @$pb.TagNumber(3)
  set blue($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBlue() => $_has(2);
  @$pb.TagNumber(3)
  void clearBlue() => clearField(3);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
