import "dart:math";

import "package:dartcv4/dartcv.dart";
import "package:video/video.dart";

/// Calculates the yaw and pitch of a coordinate in pixels using the undistorted center
/// and camera focal length
///
/// Math taken from FRC Team 254: https://www.team254.com/documents/vision-control/
({double yaw, double pitch}) calculateYawPitch(
  FrameProperties properties,
  double tagCenterX,
  double tagCenterY,
) {
  double centerX = tagCenterX;
  double centerY = tagCenterY;

  /// If there's calibration data, undistort the tag's center
  if (properties.calibrationData != null) {
    final centerVec = VecPoint2f.fromList([Point2f(tagCenterX, tagCenterY)]);
    final temp = Mat.fromVec(centerVec);
    final result = undistortPoints(
      temp,
      properties.calibrationData!.intrinsics!,
      properties.calibrationData!.distCoefficients!,
      criteria: (TERM_COUNT + TERM_EPS, 30, 1e-6),
    );
    final undistortedVec = result.at<Vec2f>(0, 0);

    // The output coordinates are normalized, see: https://stackoverflow.com/a/65861232
    if (undistortedVec.val1.isFinite) {
      centerX =
          undistortedVec.val1 * properties.focalLength + properties.centerX;
    }
    if (undistortedVec.val2.isFinite) {
      centerY =
          undistortedVec.val2 * properties.focalLength + properties.centerY;
    }

    centerVec.dispose();
    temp.dispose();
    result.dispose();
  }

  // Source: https://www.team254.com/documents/vision-control/
  final yaw = atan((centerX - properties.centerX) / properties.focalLength);
  final pitch = atan((properties.centerY - centerY) / properties.focalLength);

  return (yaw: yaw * (180 / pi), pitch: pitch * (180 / pi));
}
