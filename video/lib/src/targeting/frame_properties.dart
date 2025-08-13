import "dart:convert";
import "dart:io";
import "dart:math" hide Point;

import "package:burt_network/protobuf.dart";
import "package:dartcv4/dartcv.dart" show Point;
import "package:video/video.dart";

/// A class to store the intrinsics of a camera, such as the FoV, focal length, and calibration data.
///
/// Each camera has unique properties in how objects appear as pixels. For most cameras,
/// these will differ due to tiny manufacturing inconsitencies in the lenses. For simple
/// 2D calculations, this isn't bad, but for 3D calculations where more info is needed to
/// detect, a calibration is necessary.
class FrameProperties {
  /// The width of the image being taken by the camera
  final int captureWidth;

  /// The height of the image being taken by the camera
  final int captureHeight;

  /// The diagonal field of view of the camera
  late final double diagonalFoV;

  /// The x coordinate of the center point of the iamge
  late final double centerX;

  /// The y coordinate of the center point of the image
  late final double centerY;

  /// The center of the image represented as a [Point]
  late final Point center = Point(centerX.toInt(), centerY.toInt());

  /// The focal length of the camera
  late final double focalLength;

  /// The horizontal focal length of the image frame
  late final double horizontalFoV;

  /// The vertical focal length of the image frame
  late final double verticalFoV;

  /// The calibration data of the camera, null if there is no calibration for the specified resolution
  late final CalibrationCoefficients? calibrationData;

  /// Constructor for frame properties where the horizontal FoV and focal length are known
  ///
  /// Initializes capture resolutions, fov, and calculates the horizontal
  /// and vertical focal lengths
  FrameProperties({
    required this.captureWidth,
    required this.captureHeight,
    required this.horizontalFoV,
    required this.verticalFoV,
    this.calibrationData,
  }) {
    centerX = (captureWidth / 2.0) - 0.5;
    centerY = (captureHeight / 2.0) - 0.5;

    final (:diagonal, :focal) = calculateDiagonalFoV(
      horizontalFoV: horizontalFoV,
      captureWidth: captureWidth,
      captureHeight: captureHeight,
    );
    diagonalFoV = diagonal;
    focalLength = focal;
  }

  /// Constructor for frame properties from raw calibration data
  ///
  /// Calculates the fov and focal length from the calibration data
  FrameProperties.fromCalibrationData({
    required this.captureWidth,
    required this.captureHeight,
    required this.calibrationData,
  }) {
    centerX = calibrationData!.intrinsics!.at(0, 2);
    centerY = calibrationData!.intrinsics!.at(1, 2);
    horizontalFoV =
        2 *
        atan(captureWidth / (2 * calibrationData!.intrinsics!.at(0, 0))) *
        (180 / pi);
    verticalFoV =
        2 *
        atan(captureHeight / (2 * calibrationData!.intrinsics!.at(1, 1))) *
        (180 / pi);

    final (:diagonal, :focal) = calculateDiagonalFoV(
      horizontalFoV: horizontalFoV,
      captureWidth: captureWidth,
      captureHeight: captureHeight,
    );
    diagonalFoV = diagonal;
    focalLength = focal;
  }

  /// Constructor for frame properties, initializes capture resolutions, FOV,
  /// and determines the horizontal and vertical focal lengths from the provided
  /// [diagonalFoV] and [captureWidth] + [captureHeight]
  FrameProperties.fromDiagonalFoV({
    required this.captureWidth,
    required this.captureHeight,
    required this.diagonalFoV,
  }) {
    centerX = (captureWidth / 2.0) - 0.5;
    centerY = (captureHeight / 2.0) - 0.5;
    final (:horizontal, :vertical, :focal) = calculateHorizontalVerticalFoV(
      diagonalFoV,
      captureWidth,
      captureHeight,
    );
    horizontalFoV = horizontal;
    verticalFoV = vertical;
    focalLength = focal;
  }

  /// A factory constructor for frame properties which initializes the camera settings based on the camera details
  ///
  /// This will search for a calibration file under the calibrations directory for the
  /// specified resolution. If a json file is found, it will attempt to load the calibration data.
  ///
  /// If the details has a horizontal and vertical fov, then it will initialize
  /// based on the horizontal and vertical fov, otherwise, it will assume the
  /// details have a diagonal fov
  factory FrameProperties.fromFrameDetails({
    required int captureWidth,
    required int captureHeight,
    required CameraDetails details,
  }) {
    final calibrationFile = File(
      "${CameraIsolate.baseDirectory}/calibrations/${details.name}/${captureWidth}x$captureHeight.json",
    );
    if (calibrationFile.existsSync()) {
      try {
        final calibrationJson = jsonDecode(calibrationFile.readAsStringSync());
        final calibrationCoefficients = CalibrationCoefficients.fromJson(
          json: calibrationJson,
        );

        if (calibrationCoefficients.intrinsics != null &&
            calibrationCoefficients.distCoefficients != null) {
          return FrameProperties.fromCalibrationData(
            captureWidth: captureWidth,
            captureHeight: captureHeight,
            calibrationData: calibrationCoefficients,
          );
        }
      } catch (e) {
        collection.videoServer.logger.error(
          "Error while trying to read calibration data for ${details.name.name} at $captureWidth x $captureHeight",
          body: e.toString(),
        );
      }
    }

    if (details.hasHorizontalFov() && details.hasVerticalFov()) {
      return FrameProperties(
        captureWidth: captureWidth,
        captureHeight: captureHeight,
        horizontalFoV: details.horizontalFov,
        verticalFoV: details.verticalFov,
      );
    }

    return FrameProperties.fromDiagonalFoV(
      captureWidth: captureWidth,
      captureHeight: captureHeight,
      diagonalFoV: details.diagonalFov,
    );
  }

  /// Determines the horizontal and vertical focal lengths of the camera based on the diagonal FOV and capture resolution
  ({double horizontal, double vertical, double focal})
  calculateHorizontalVerticalFoV(
    double diagonalFoV,
    int captureWidth,
    int captureHeight,
  ) {
    // Math taken from PhotonVision:
    // https://github.com/PhotonVision/photonvision/blob/5df189d306be89a80b14e6bee9e9df2c31f7f589/photon-core/src/main/java/org/photonvision/vision/frame/FrameStaticProperties.java#L127
    final diagonalRadians = diagonalFoV * (pi / 180);
    final diagonalAspect = sqrt(
      captureWidth * captureWidth + captureHeight * captureHeight,
    );

    final horizontalView =
        atan(tan(diagonalRadians / 2) * (captureWidth / diagonalAspect)) * 2;
    final verticalView =
        atan(tan(diagonalRadians / 2) * (captureHeight / diagonalAspect)) * 2;
    final focalLength = captureWidth / (2 * tan(horizontalView / 2));

    return (
      horizontal: horizontalView * (180 / pi),
      vertical: verticalView * (180 / pi),
      focal: focalLength,
    );
  }

  /// Determines the diagonal FoV and focal length from the capture resolution and horizontal FoV
  ///
  /// [horizontalFoV] should be in degrees
  ///
  /// Math derived from https://www.litchiutilities.com/docs/fov.php
  ({double diagonal, double focal}) calculateDiagonalFoV({
    required double horizontalFoV,
    required int captureWidth,
    required int captureHeight,
  }) {
    final horizontalFoVRad = horizontalFoV * (pi / 180);

    final aspectDiag = sqrt(
      captureWidth * captureWidth + captureHeight * captureHeight,
    );
    final diagonalFoV =
        atan(tan(horizontalFoVRad / 2) * (aspectDiag / captureWidth)) *
        2 *
        (180 / pi);
    final focalLength = captureWidth / (2 * tan(horizontalFoVRad / 2));

    return (diagonal: diagonalFoV, focal: focalLength);
  }
}
