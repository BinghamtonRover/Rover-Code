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
  });
}
