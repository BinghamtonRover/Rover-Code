import "package:burt_network/burt_network.dart";

/// The type of USB-device, which determines what subsystem it is.
enum DeviceType {
  /// A camera.
  camera("video4linux", "SUBSYSTEMS"),

  /// A serial-interface data device.
  serial("tty", "SUBSYSTEM");

  /// What subsystem this device appears in.
  final String subsystem;

  /// Whether this device is in "SUBSYSTEM" or "SUBSYSTEMS".
  final String key;

  const DeviceType(this.subsystem, this.key);
}

/// A USB device plugged into the rover.
class Device {
  /// The human-readable name for this device.
  final String humanName;

  /// The alias for this device.
  ///
  /// Udev will create a symlink in `/dev/$alias` for this device, and the alias will appear in Udev
  /// code. Only use alphanumeric characters with underscores, not hyphens.
  final String alias;

  /// The type of device.
  final DeviceType type;

  /// The device's manufacturer, if known.
  final String? manufacturer;

  /// The device's product name, if known.
  final String? product;

  /// The USB port this device is on, if known (corresponds to Udev KERNEL).
  final String? port;

  /// The interface this device has, if known.
  final String? interface;

  /// The serial number of the device, if it has one
  final String? serialNumber;

  /// The index of this device, if known.
  final int? index;

  /// Creates a USB device for Udev registration.
  const Device({
    required this.humanName,
    required this.alias,
    required this.type,
    this.manufacturer,
    this.product,
    this.index,
    this.port,
    this.interface,
    this.serialNumber,
  });

  /// Creates a USB device from a JSON configuration.
  factory Device.fromJson(Json json) => Device(
    humanName: json["humanName"] as String,
    alias: json["alias"] as String,
    type: DeviceType.values.byName(json["type"] as String),
    manufacturer: json["manufacturer"] as String?,
    product: json["product"] as String?,
    index: json["index"] as int?,
    port: json["port"] as String?,
    interface: json["interface"] as String?,
    serialNumber: json["serialNumber"] as String?,
  );

  /// Converts this device to a JSON map.
  Json toJson() => {
    "humanName": humanName,
    "alias": alias,
    "type": type.name,
    if (manufacturer != null) "manufacturer": manufacturer,
    if (product != null) "product": product,
    if (index != null) "index": index,
    if (port != null) "port": port,
    if (interface != null) "interface": interface,
    if (serialNumber != null) "serialNumber": serialNumber,
  };
}
