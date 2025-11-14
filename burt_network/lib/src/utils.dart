import "dart:async";
import "dart:io";
import "dart:math";

import "package:burt_network/protobuf.dart";
import "package:burt_network/udp.dart";

import "package:coordinate_converter/coordinate_converter.dart";
import "package:meta/meta.dart";

/// A message that has been decoded and contains the message, timestamp, and source.
@immutable
class RoverPacket<T extends Message> {
  /// The decoded message.
  final T message;

  /// The timestamp of the message.
  final Timestamp timestamp;

  /// The source of the message.
  final SocketInfo source;

  /// Const constructor for [RoverPacket]
  const RoverPacket({
    required this.message,
    required this.timestamp,
    required this.source,
  });
}

/// JSON data as a map.
typedef Json = Map<String, dynamic>;

/// Constructor for a Protobuf message
typedef ProtoConstructor<T> = T Function(List<int> data);

/// A Datagram packet which contains a wrapped message
typedef WrapperDatagram = RoverPacket<WrappedMessage>;

/// Utilities for working with a [WrapperDatagram].
extension WrapperDatagramUtil on WrapperDatagram {
  /// The name of the message being held in the wrapper
  String get name => message.name;

  /// Parses the internal [WrappedMessage] into a new [RoverPacket] with a specific message type.
  ///
  /// This is useful when you know the type of the message contained in the wrapper and want
  /// to get a strongly-typed [RoverPacket] back.
  RoverPacket<T> parse<T extends Message>(ProtoConstructor<T> constructor) =>
      RoverPacket(
        message: constructor(message.data),
        timestamp: message.timestamp,
        source: source,
      );
}

/// Helpful methods on [Stream]s of [WrapperDatagram]s
extension WrappedDatagramMessageStream on Stream<WrapperDatagram> {
  /// Allows callers to listen only for specific messages.
  ///
  /// To use this, pass the name of the message, a function to create the message
  /// from binary data, and a callback to handle the message. For example,
  /// ```dart
  /// collection.server.messages.listenFor(
  ///   name: ScienceData().messageName,  // equals "ScienceData"
  ///   constructor: ScienceData.fromBuffer,
  ///   callback: (data) => print(data.co2);
  /// )
  /// ```
  ///
  /// This function returns a [StreamSubscription] that you can use to stop listening.
  StreamSubscription<T> listenFor<T extends Message>({
    required String name,
    required T Function(List<int>) constructor,
    required void Function(T) callback,
  }) => map(
    (e) => e.message,
  ).listenFor(name: name, constructor: constructor, callback: callback);

  /// Listens for a specific message type and unpacks it into a [RoverPacket].
  ///
  /// This is a convenience method that filters the stream by message name,
  /// parses the message, and passes the resulting [RoverPacket] to the callback.
  ///
  /// Example:
  /// ```dart
  /// stream.listenFor<ScienceData>(
  ///   name: ScienceData().messageName,
  ///   constructor: ScienceData.fromBuffer,
  ///   callback: (packet) => print(packet.message.methane),
  /// );
  /// ```
  StreamSubscription<RoverPacket<T>> onPacket<T extends Message>({
    required String name,
    required ProtoConstructor<T> constructor,
    required void Function(RoverPacket<T>) callback,
  }) => where(
    (datagram) => datagram.message.name == name,
  ).map((message) => message.parse(constructor)).listen(callback);
}

/// Helpful methods on [Stream]s of [WrappedMessage]s.
extension WrappedMessageStream on Stream<WrappedMessage> {
  /// Allows callers to listen only for specific messages.
  ///
  /// To use this, pass the name of the message, a function to create the message
  /// from binary data, and a callback to handle the message. For example,
  /// ```dart
  /// collection.server.messages.listenFor(
  ///   name: ScienceData().messageName,  // equals "ScienceData"
  ///   constructor: ScienceData.fromBuffer,
  ///   callback: (data) => print(data.co2);
  /// )
  /// ```
  ///
  /// This function returns a [StreamSubscription] that you can use to stop listening.
  StreamSubscription<T> listenFor<T extends Message>({
    required String name,
    required T Function(List<int>) constructor,
    required void Function(T) callback,
  }) => where(
    (wrapper) => wrapper.name == name,
  ).map((wrapper) => constructor(wrapper.data)).listen(callback);

  /// Allows callers to listen only for specific messages with different callbacks for
  /// different data passed in.
  ///
  /// To use this, pass the name of the message, a function to create the message
  /// from binary data, and a callback to handle the message. For example,
  /// ```dart
  /// collection.server.messages.onPacket(
  ///   name: ScienceData().messageName,  // equals "ScienceData"
  ///   constructor: ScienceData.fromBuffer,
  ///   onMessage: (data) => print(data.co2),
  ///   withTimestamp: (data, time) => print(time),
  /// )
  /// ```
  ///
  /// This function returns a [StreamSubscription] that you can use to stop listening.
  StreamSubscription<RoverPacket<T>> onPacket<T extends Message>({
    required String name,
    required ProtoConstructor<T> constructor,
    required void Function(RoverPacket<T>) callback,
  }) => where((wrapper) => wrapper.name == name)
      .map(
        (wrapper) => RoverPacket(
          message: constructor(wrapper.data),
          timestamp: wrapper.timestamp,
          source: SocketInfo(address: InternetAddress("0.0.0.0"), port: -1),
        ),
      )
      .listen(callback);
}

/// Helpful methods on streams of nullable values.
extension NullableStreamUtils<T> on Stream<T?> {
  /// Transforms a stream of type `T?` to type `T` by filtering out nulls.
  Stream<T> notNull() => where((x) => x != null).cast<T>();
}

/// Returns the type of data message that would be emitted by this device.
String? deviceToDataName(Device device) => switch (device) {
  Device.ARM => ArmData().messageName,
  Device.DRIVE => DriveData().messageName,
  Device.GRIPPER => ArmData().messageName,
  Device.SCIENCE => ScienceData().messageName,
  Device.ANTENNA => AntennaFirmwareData().messageName,
  Device.BASE_STATION => BaseStationData().messageName,
  Device.RELAY => RelaysData().messageName,
  _ => null,
};

/// Helpful extension methods to convert [GpsCoordinates] into meters
extension GpsToMeters on GpsCoordinates {
  /// Number of meters per degree of latitude
  static const metersPerLatitude = 111.32 * 1000;
  /// Number of radians per degree.
  static const radiansPerDegree = pi / 180;

  /// Number of meters per degree longitude at the given latitude.
  ///
  /// While the distance between rings of latitude remains constant all over the Earth, rings of
  /// longitude stretch as you near the equator, and come to a single point at the poles. For that
  /// reason, we need to calculate this number based on your current latitude.
  ///
  /// Source: https://stackoverflow.com/a/39540339/9392211
  static double metersPerLongitude(double latitude) =>
    40075 * cos(latitude * radiansPerDegree ) / 360 * 1000;

  /// Converts [GpsCoordinates] into (lat, long) in meters.
  ({double lat, double long}) get inMeters => (
    lat: latitude * metersPerLatitude,
    long: longitude * metersPerLongitude(latitude),
  );

  /// Converts the current GPS coordinates in the form of [DDCoordinates]
  DDCoordinates toDD() => DDCoordinates(
      latitude: latitude,
      longitude: longitude,
    );

  /// Converts the current GPS coordinates into UTM coordinates
  UTMCoordinates toUTM() => UTMCoordinates.fromDD(toDD());
}

/// Utility methods for converting UTM coordinates into GPS coordinates
extension UTMToGps on UTMCoordinates {
  /// Converts the UTM coordinates into [GpsCoordinates]
  GpsCoordinates toGps() {
    final ddCoordinates = toDD();

    return GpsCoordinates(
      latitude: ddCoordinates.latitude,
      longitude: ddCoordinates.longitude,
    );
  }

  /// Adds 2 UTM coordinates together, this is assuming that the zone number
  /// is the same for the other UTM coordinates
  UTMCoordinates operator +(UTMCoordinates other) => UTMCoordinates(
      x: x + other.x,
      y: y + other.y,
      zoneNumber: zoneNumber,
      isSouthernHemisphere: isSouthernHemisphere,
    );

  /// Substracts 2 UTM coordinates together, this is assuming that the zone number
  /// is the same for the other UTM coordinates
  UTMCoordinates operator -(UTMCoordinates other) => UTMCoordinates(
      x: x - other.x,
      y: y - other.y,
      zoneNumber: zoneNumber,
      isSouthernHemisphere: isSouthernHemisphere,
    );
}

/// Extension to convert coordinates in meters into [GpsCoordinates].
extension MetersToGps on ({num lat, num long}) {
  /// Convert a record of (lat, long) in meters into [GpsCoordinates].
  GpsCoordinates toGps() {
    final degreeLatitude = lat / GpsToMeters.metersPerLatitude;
    final degreeLongitude = long / GpsToMeters.metersPerLongitude(degreeLatitude);
    return GpsCoordinates(latitude: degreeLatitude, longitude: degreeLongitude);
  }
}
