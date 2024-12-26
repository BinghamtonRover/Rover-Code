enum DeviceType {
  camera("video4linux", "SUBSYSTEMS"),
  serial("tty", "SUBSYSTEM");

  final String subsystem;
  final String key;
  const DeviceType(this.subsystem, this.key);
}

class Device {
  final String humanName;
  final String alias;
  final DeviceType type;

  final String? manufacturer;
  final String? product;
  final String? port;
  final String? interface;
  final int? index;

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

  String get subsystem => type.subsystem;
}
