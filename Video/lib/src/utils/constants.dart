import "package:burt_network/generated.dart";

/// These list maps OpenCV IDs (index) to [CameraName]s.
///
/// This is HIGHLY dependent on the EXACT order of the USB ports.
///
/// Map for MAC or LINUX devices
Map<CameraName, String> cameraNames = {
  CameraName.ROVER_FRONT: "/dev/rover-cam_realsense_rgb",
  CameraName.ROVER_REAR: "/dev/rover-cam_subsystem_3",
  CameraName.AUTONOMY_DEPTH: "/dev/rover-cam_realsense_depth",
  CameraName.SUBSYSTEM1: "/dev/rover-cam_subsystem_1",
  CameraName.SUBSYSTEM2: "/dev/rover-cam_subsystem_2",
  CameraName.SUBSYSTEM3: "/dev/rover-cam_subsystem_3",
};

/// Map for WINDOWS devices
Map<CameraName, int> cameraIndexes = {
  CameraName.ROVER_REAR: 0,
  CameraName.AUTONOMY_DEPTH: 4,
  CameraName.ROVER_FRONT: 5,
  CameraName.SUBSYSTEM1: 1,
  CameraName.SUBSYSTEM2: 2,
  CameraName.SUBSYSTEM3: 3,
};
