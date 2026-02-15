import "package:autonomy/autonomy.dart";

/// Constant variables for Autonomy.
///
/// These constants control the tolerances and behaviors of the
/// pathfinding and path following, such as move lengths, maximum
/// error distance allowed, timeouts, etc.
class Constants {
  /// Private internal constructor for constants
  Constants._();

  /// The maximum error (in degrees) of our GPS
  static const gpsError = 0.00003;

  /// The maximum error or "tolerance" for reaching the end goal
  static const double maxErrorMeters = 1;

  /// The closest distance the pathfinding algorithm will allow
  /// the rover to go near an obstacle
  static const double obstacleAvoidanceRadius = 0.75;

  /// How close the rover should get to a drive coordinate before
  /// continuing with the path
  static const double intermediateStepTolerance = 0.25;

  /// The amount of meters to move per path step
  static const double moveLengthMeters = 1;

  /// Replan the path if the rover's position is this far away from the path
  static const double replanErrorMeters = 3;

  /// The IMU angle tolerance for a turn during autonomy
  static const double turnEpsilon = 3;

  /// The IMU angle tolerance when turning to re-correct to the
  /// proper orientation before driving forward
  static const double driveRealignmentEpsilon = 5;

  /// The maximum time to spend waiting for the drive to reach a desired GPS coordinate.
  ///
  /// Only applies to individual "drive forward" steps, to prevent indefinite driving
  /// if it never reaches within [maxErrorMeters] of its desired position.
  static const Duration driveGPSTimeout = Duration(
    seconds: 4,
    milliseconds: 500,
  );

  /// The maximum time to spend searching for an aruco tag
  static const Duration arucoSearchTimeout = Duration(seconds: 20);

  /// The camera that should be used to detect Aruco tags
  static const CameraName arucoDetectionCamera = CameraName.ROVER_FRONT;

  /// How close (in degrees) the detected object yaw must be to center
  static const double visionCenterYawEpsilon = 3.0;

  /// How close (in pixels) the detected object center must be to frame center
  static const int visionCenterPixelEpsilon = 20;

  /// How close (normalized -1..1) the detected object x position must be
  static const double visionCenterXPositionEpsilon = 0.1;

  /// How many consecutive frames the target can be missing before we stop
  static const int visionMissingFramesToArrive = 3;
}
