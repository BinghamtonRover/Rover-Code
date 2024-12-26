import "dart:io";

import "devices.dart";

const filename = "15-rover.rules";

const header =
"""
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

void main() async {
  final buffer = StringBuffer();
  buffer.writeln(header);
  for (final device in devices) {
    // Comment line
    buffer.writeln("# ${device.humanName}: /dev/${device.alias}");

    // Line 1 matches the device
    final varName = "is_${device.alias}";
    buffer.write('SUBSYSTEMS=="usb", ');
    if (device.manufacturer != null) buffer.write('ATTRS{manufacturer}=="${device.manufacturer}", ');
    if (device.product != null) buffer.write('ATTRS{product}=="${device.product}", ');
    if (device.port != null) buffer.write('KERNELS=="${device.port}", ');
    if (device.interface != null) buffer.write('ATTRS{interface}=="${device.interface}", ');
    buffer.writeln('ENV{$varName}="t"');

    // Line 2 generates the symlink for the device
    buffer.write('${device.type.key}=="${device.subsystem}", ');
    if (device.index != null) buffer.write('ATTR{index}=="${device.index}", ');
    buffer.writeln('ENV{$varName}=="t", SYMLINK+="${device.alias}"');
    buffer.writeln();
  }

  final contents = buffer.toString();
  await File(filename).writeAsString(contents);

  print("Generated $filename with ${devices.length} devices");
}
