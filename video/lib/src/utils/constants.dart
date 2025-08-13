import "dart:convert";
import "dart:io";

import "package:burt_network/protobuf.dart";
import "package:dartcv4/dartcv.dart";
import "package:video/video.dart";

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
  CameraName.BOTTOM_LEFT: "/dev/rover-cam_bottom_left",
  CameraName.BOTTOM_RIGHT: "/dev/rover-cam_bottom_right",
};

/// Map for WINDOWS devices
Map<CameraName, int> cameraIndexes = {
  CameraName.ROVER_REAR: 0,
  CameraName.AUTONOMY_DEPTH: 4,
  CameraName.ROVER_FRONT: 5,
  CameraName.SUBSYSTEM1: 10,
  CameraName.SUBSYSTEM2: 2,
  CameraName.SUBSYSTEM3: 3,
  CameraName.BOTTOM_LEFT: 6,
  CameraName.BOTTOM_RIGHT: 7,
};

/// Frames from this camera will be send to the vision program for further analysis.
const findObjectsInCameraFeed = CameraName.CAMERA_NAME_UNDEFINED;

/// Returns the camera depending on device program is running
///
/// Uses [cameraNames] or [cameraIndexes]
VideoCapture getCamera(CameraName name) => Platform.isWindows
    ? VideoCapture.fromDevice(cameraIndexes[name]!)
    : VideoCapture.fromFile(cameraNames[name]!);

/// Loads camera details for a specific camera
///
/// If there is no camera config file found or there were
/// missing fields in the config json, it will return the value of [baseDetails]
CameraDetails loadCameraDetails(CameraDetails baseDetails, CameraName name) {
  final cameraDetails = baseDetails;
  final configFile = File(
    "${CameraIsolate.baseDirectory}/camera_details/${name.name}.json",
  );
  if (!configFile.existsSync()) {
    return cameraDetails;
  }
  try {
    cameraDetails.mergeFromProto3Json(
      jsonDecode(configFile.readAsStringSync()),
    );
  } catch (e) {
    collection.videoServer.logger.error(
      "Error while loading config for camera $name",
      body: e.toString(),
    );
  }

  // Ignore the status specified in the json
  cameraDetails.status = CameraStatus.CAMERA_ENABLED;

  return cameraDetails;
}

/// Default details for a camera
///
/// Used when first creating the camera objects
CameraDetails getDefaultDetails(CameraName name) => CameraDetails(
  name: name,
  resolutionWidth: 300,
  resolutionHeight: 300,
  quality: 75,
  fps: 24,
  diagonalFov: 64.9826,
  horizontalFov: 51.4074485655,
  verticalFov: 39.749374449,
  status: CameraStatus.CAMERA_ENABLED,
);

/// Default details for the RealSense camera.
///
/// These settings are balanced between autonomy depth and normal RGB.
CameraDetails getRealsenseDetails(CameraName name) => CameraDetails(
  name: name,
  resolutionWidth: 640,
  resolutionHeight: 480,
  quality: 50,
  fps: 0,
  horizontalFov: 69,
  verticalFov: 42,
  status: CameraStatus.CAMERA_ENABLED,
);

/// The default [RoverArucoConfig] for detecting Aruco markers
final RoverArucoConfig defaultArucoConfig = RoverArucoConfig(
  markerSize: 6.00 / 39.37,
  dictionary: ArucoDictionary.predefined(PredefinedDictionaryType.DICT_4X4_50),
  detectorParams: ArucoDetectorParameters.empty(),
  arucoColor: Scalar.fromRgb(0, 255, 0),
);
