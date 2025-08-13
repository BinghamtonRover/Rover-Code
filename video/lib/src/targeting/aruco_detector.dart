import "dart:math";

import "package:burt_network/protobuf.dart";
import "package:dartcv4/dartcv.dart";
import "package:video/video.dart";

/// The raw 3d output from opencv solvepnp
typedef ArucoRaw3DResult = ({
  int rval,
  VecMat rvecs,
  VecMat tvecs,
  Mat reprojectionError,
});

/// Utility methods for raw 3d solvepnp outputs
extension ArucoRaw3DUtil on ArucoRaw3DResult {
  /// Disposes all native resources used by the result objects
  void dispose() {
    rvecs.dispose();
    tvecs.dispose();
    reprojectionError.dispose();
  }
}

/// Class to store the configuration
class RoverArucoConfig {
  /// The size of the aruco marker in meters
  final double markerSize;

  /// Whether or not to draw detected aruco markers
  final bool draw;

  /// The native Mat of the object's corners in a 3D coordinate space
  late final Mat _objectPoints = Mat.fromVec(
    VecPoint3f.fromList([
      Point3f(-markerSize / 2, markerSize / 2, 0),
      Point3f(markerSize / 2, markerSize / 2, 0),
      Point3f(markerSize / 2, -markerSize / 2, 0),
      Point3f(-markerSize / 2, -markerSize / 2, 0),
    ]),
    rows: 4,
    cols: 1,
    type: MatType.CV_32FC3,
  );

  /// The Aruco dictionary to use for marker detection
  final ArucoDictionary dictionary;

  /// The Aruco detection parameters
  final ArucoDetectorParameters detectorParams;

  /// The color to use to draw the frames of the markers
  final Scalar arucoColor;

  /// Const constructor for rover aruco config
  RoverArucoConfig({
    required this.markerSize,
    required this.dictionary,
    required this.detectorParams,
    required this.arucoColor,
    this.draw = true,
  });
}

/// Class to handle Aruco marker detection and processing
class RoverArucoDetector {
  /// The configuration for the aruco detection
  final RoverArucoConfig config;

  /// The native OpenCV aruco detector object
  late final ArucoDetector _arucoDetector = ArucoDetector.create(
    config.dictionary,
    config.detectorParams,
  );

  /// Const constructor for Rover Aruco Detector
  RoverArucoDetector({required this.config});

  /// Processes an incoming [Mat] and returns any detected Aruco tags in view
  ///
  /// Calculations for the tag's 2d (or 3d) position will be made using the camera
  /// intrinsics from the provided [frameProperties]
  ///
  /// 3D calculations are made using the SolvePnP Algorithm,
  /// documentation of which can be found here: https://docs.opencv.org/4.x/d5/d1f/calib3d_solvePnP.html
  ///
  /// If the [config] specifies to draw, an indicator will be drawn around the detected markers
  Future<List<DetectedObject>> process(
    Mat image,
    FrameProperties frameProperties,
  ) async {
    // Get the raw aruco detections
    final (corners, ids, rejected) = await _arucoDetector.detectMarkersAsync(
      image,
    );

    // If there's no markers, save time and return nothing
    if (ids.isEmpty) {
      return [];
    }

    if (config.draw) {
      await arucoDrawDetectedMarkersAsync(
        image,
        corners,
        ids,
        config.arucoColor,
      );
    }

    final detectedMarkers = <DetectedObject>[];

    // Iterate through each of the detections and perform the
    // target calculations on each of them
    for (int i = 0; i < ids.length; i++) {
      var centerX = 0.0;
      var centerY = 0.0;
      for (final corner in corners[i]) {
        centerX += corner.x;
        centerY += corner.y;
      }
      centerX /= 4;
      centerY /= 4;

      final (:yaw, :pitch) = calculateYawPitch(
        frameProperties,
        centerX,
        centerY,
      );

      final pnpResult = _calculateRaw3DPose(frameProperties, corners[i]);
      Pose3d? bestCameraToTarget;
      double? bestReprojectionError;

      if (pnpResult != null) {
        // (0, 0) of each respective matrix is the best pnp result
        // (1, 0) of each respective matrix is the alternate PnP result

        // Translation vector is [x, y, z], where +x is to the right,
        // +y is down, and +z is away from the camera
        final bestTranslation = pnpResult.tvecs[0].at<Vec3d>(0, 0);
        // Rotation vector is [x, y, z], for yaw, pitch, and roll respectively
        final bestRotation = pnpResult.rvecs[0].at<Vec3d>(0, 0);

        bestCameraToTarget = Pose3d(
          translation: Coordinates(
            x: bestTranslation.val1,
            y: -bestTranslation.val2,
            z: bestTranslation.val3,
          ),
          rotation: Orientation(
            x: bestRotation.val1 * (180 / pi),
            y: bestRotation.val2 * (180 / pi),
            z: bestRotation.val3 * (180 / pi),
          ),
        );
        bestReprojectionError = pnpResult.reprojectionError.at<double>(0, 0);

        if (config.draw) {
          drawFrameAxes(
            image,
            frameProperties.calibrationData!.intrinsics!,
            frameProperties.calibrationData!.distCoefficients!,
            pnpResult.rvecs[0],
            pnpResult.tvecs[0],
            config.markerSize,
          );
        }
      }

      // Create a vector of the corners of the aruco marker to determine the total area
      final cornerVec = VecPoint.generate(
        corners[i].length,
        (idx) => Point(corners[i][idx].x.toInt(), corners[i][idx].y.toInt()),
      );
      final area = contourArea(cornerVec);

      cornerVec.dispose();

      // Create the proto message from the target calculations
      PnpResult? pnpResultProto;
      if (bestCameraToTarget != null) {
        pnpResultProto = PnpResult(
          cameraToTarget: bestCameraToTarget,
          reprojectionError: bestReprojectionError,
        );
      }

      detectedMarkers.add(
        DetectedObject(
          objectType: DetectedObjectType.ARUCO,
          arucoTagId: ids[i],
          yaw: yaw,
          pitch: pitch,
          centerX: centerX.toInt(),
          centerY: centerY.toInt(),
          relativeSize: area / (image.width * image.height),
          bestPnpResult: pnpResultProto,
        ),
      );

      pnpResult?.dispose();
    }
    corners.dispose();
    ids.dispose();
    rejected.dispose();
    return detectedMarkers;
  }

  /// Calculates the 3D pose from the frame properties and target corners
  ///
  /// If the frame properties does not contain a calibration, this will return null
  ArucoRaw3DResult? _calculateRaw3DPose(
    FrameProperties properties,
    VecPoint2f corners,
  ) {
    if (properties.calibrationData == null) {
      return null;
    }

    final (rval, rvecs, tvecs, reprojectionError) = solvePnPGeneric(
      config._objectPoints,
      Mat.fromVec(corners),
      properties.calibrationData!.intrinsics!,
      properties.calibrationData!.distCoefficients!,
      flags: SOLVEPNP_IPPE_SQUARE,
    );

    return (
      rval: rval,
      rvecs: rvecs,
      tvecs: tvecs,
      reprojectionError: reprojectionError,
    );
  }
}
