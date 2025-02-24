import "dart:async";
import "dart:math";

import "package:burt_network/protobuf.dart";

/// JSON data as a map.
typedef Json = Map<String, dynamic>;

/// Helpful methods on [Stream]s of [WrappedMessage]s.
extension WrappedMessageStream on Stream<WrappedMessage> {
  /// Allows callers to listen only for specific messages.
  ///
  /// To use this, pass the name of the message, a function to create the message
  /// from binary data, and a callback to handle the message. For example,
  /// ```dart
  /// collection.server.messages.onMessage(
  ///   name: ScienceData().messageName,  // equals "ScienceData"
  ///   constructor: ScienceData.fromBuffer,
  ///   callback: (data) => print(data.co2);
  /// )
  /// ```
  ///
  /// This function returns a [StreamSubscription] that you can use to stop listening.
  StreamSubscription<T> onMessage<T extends Message>({
    required String name,
    required T Function(List<int>) constructor,
    required void Function(T) callback,
  }) =>
    where((wrapper) => wrapper.name == name)
    .map((wrapper) => constructor(wrapper.data))
    .listen(callback);

  /// Allows callers to listen only for specific messages, with a specific timestamp.
  ///
  /// To use this, pass the name of the message, a function to create the message
  /// from binary data, and a callback to handle the message and its time. For example,
  /// ```dart
  /// collection.server.messages.onMessageTimestamped(
  ///   name: VideoData().messageName,  // equals "VideoData"
  ///   constructor: VideoData.fromBuffer,
  ///   callback: (data, time) => print("${data.name}\t$time");
  /// )
  /// ```
  ///
  /// This function returns a [StreamSubscription] that you can use to stop listening.
  StreamSubscription<WrappedMessage> onMessageTimestamped<T extends Message>({
    required String name,
    required T Function(List<int>) constructor,
    required void Function(T message, Timestamp timestamp) callback,
  }) =>
      where((wrapper) => wrapper.name == name).listen(
        (wrapper) => callback(constructor(wrapper.data), wrapper.timestamp),
      );
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
  Device.GRIPPER => GripperData().messageName,
  Device.SCIENCE => ScienceData().messageName,
  Device.ANTENNA => AntennaFirmwareData().messageName,
  Device.BASE_STATION => BaseStationData().messageName,
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
