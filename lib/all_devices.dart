import "package:rover/src/device.dart";

/// All USB devices that need a udev rule.
///
/// For more inforamtion, see [Device].
const devices = <Device>[
  // ==================== Drive Cameras ====================
  Device(
    humanName: "Front Camera",
    alias: "rover_cam_front",
    type: DeviceType.camera,
    port: "3-2:1.0",
    index: 0,
  ),
  Device(
    humanName: "Rear Camera",
    alias: "rover_cam_rear",
    type: DeviceType.camera,
    port: "1-2.4:1.0",
    index: 0,
  ),
  Device(
    humanName: "Bottom Left Camera",
    alias: "rover_cam_bottom_left",
    type: DeviceType.camera,
    port: "1-2.3:1.0",
    index: 0,
  ),
  Device(
    humanName: "Bottom Right Camera",
    alias: "rover_cam_bottom_right",
    type: DeviceType.camera,
    port: "1-2.2:1.0",
    index: 0,
  ),
  // ==================== Subsystems Cameras ====================
  Device(
    humanName: "Subsystems Camera 1",
    alias: "rover_cam_subsystem_1",
    type: DeviceType.camera,
    port: "3-1.2:1.0",
    index: 0,
  ),
  Device(
    humanName: "Subsystems Camera 2",
    alias: "rover_cam_subsystem_2",
    type: DeviceType.camera,
    port: "3-1.3:1.0",
    index: 0,
  ),
  Device(
    humanName: "Subsystems Camera 3",
    alias: "rover_cam_subsystem_3",
    type: DeviceType.camera,
    port: "3-1.4:1.0",
    index: 0,
  ),
  // ==================== Sensors ====================
  Device(
    humanName: "RealSense RGB",
    alias: "rover_realsense_rgb",
    type: DeviceType.camera,
    interface: "Intel(R) RealSense(TM) Depth Camera 435i RGB",
    index: 0,
  ),
  Device(
    humanName: "RealSense Depth",
    alias: "rover_realsense_depth",
    type: DeviceType.camera,
    interface: "Intel(R) RealSense(TM) Depth Camera 435i Depth",
    index: 2,
  ),
  Device(
    humanName: "GPS",
    alias: "rover_gps",
    type: DeviceType.serial,
    manufacturer: "u-blox AG - www.u-blox.com",
  ),
  Device(
    humanName: "IMU",
    alias: "rover_imu",
    type: DeviceType.serial,
    product: "CDC + MSD Demo",
  ),
];
