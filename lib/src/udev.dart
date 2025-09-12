
import "package:rover/rover.dart";

/// The header to prepend to the top of all generated udev files.
const udevHeader =
"""
# AUTO-GENERATED FILE. DO NOT EDIT BY HAND.
# To re-generate, edit `all_devices.dart` and run `dart run :udev`
#
# UDev rules for the Subsystems Pi
# This file should be placed in /etc/udev/rules.d
#
# This file allows our USB to be assigned a particular port each time, instead of the default random one.
# Instead of /dev/ttyACM0 and /dev/ttyACM1, we can have /dev/rover-imu and /dev/rover-gps
#
# The general gist of this file is that it reads data about the device (SUBSYSTEM and ATTRS), and,
# based on the below rules, adds an alias for that device (SYMLINK). Each physical device may be
# registered multiple times with the OS, so we use multiple checks (like USB port and video4linux).
#
# Resources:
# - To see info for a device, run `udevadm info -a -n /dev/deviceName`
# - For guidance on writing these kinds of files, see
#   https://bing-rover.gitbook.io/docs/v/software/onboard-computers/video/udev-rules
""";

/// Generates udev rule files for rover programs.
extension UdevGenerator on Device {
  /// The udev rules file for this service.
  ///
  /// For more information, see: https://wiki.archlinux.org/title/Udev
  String get udevRule {
    final buffer = StringBuffer();
    // Comment line
    buffer.writeln("# $humanName: /dev/$alias");

    // Line 1 matches the device
    final varName = "is_$alias";
    buffer.write('SUBSYSTEMS=="usb", ');
    if (manufacturer != null) buffer.write('ATTRS{manufacturer}=="$manufacturer", ');
    if (product != null) buffer.write('ATTRS{product}=="$product", ');
    if (port != null) buffer.write('KERNELS=="$port", ');
    if (interface != null) buffer.write('ATTRS{interface}=="$interface", ');
    if (serialNumber != null) buffer.write('ATTRS{serial}=="$serialNumber", ');
    buffer.writeln('ENV{$varName}="t"');

    // Line 2 generates the symlink for the device
    buffer.write('${type.key}=="${type.subsystem}", ');
    if (index != null) buffer.write('ATTR{index}=="$index", ');
    buffer.writeln('ENV{$varName}=="t", SYMLINK+="$alias"');
    buffer.writeln();
    return buffer.toString();
  }
}
