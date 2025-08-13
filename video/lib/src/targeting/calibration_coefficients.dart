import "package:burt_network/burt_network.dart";
import "package:dartcv4/dartcv.dart";

/// A class representing the intrinsics and distortion coefficients of a camera
///
/// These camera coefficients are loaded from a json file in 2 different OpenCV camera
/// calibration formats:
///
/// For calibrations from CalibDb, it will be in the format:
/// ```json
/// {
///   "camera_matrix": {
///     "data": [
///       ...
///     ]
///   }
/// }
/// ```
///
/// For calibrations from WPICal, it will be in the format:
/// ```json
/// {
///   "camera_matrix": [
///     ...
///   ]
/// }
/// ```
class CalibrationCoefficients {
  /// The camera intrinsics matrix, this will always be a 3x3 double matrix
  Mat? intrinsics;

  /// The distortion coefficients matrix, this matrix will always have one row
  Mat? distCoefficients;

  /// Creates the camera calibration coefficients from a Json object
  CalibrationCoefficients.fromJson({required Json json}) {
    if (json["camera_matrix"] is Map) {
      _initIntrinsics((json["camera_matrix"]["data"] as List<Object?>).cast());
    } else if (json["camera_matrix"] is List) {
      _initIntrinsics((json["camera_matrix"] as List<Object?>).cast());
    }

    if (json["distortion_coefficients"] is Map) {
      _initDistCoefficients(
        (json["distortion_coefficients"]["data"] as List<Object?>).cast(),
      );
    } else if (json["distortion_coefficients"] is List) {
      _initDistCoefficients(
        (json["distortion_coefficients"] as List<Object?>).cast(),
      );
    }
  }

  void _initIntrinsics(List<num> intrinsicsMatrix) {
    intrinsics = Mat.fromList(
      3,
      3,
      MatType.CV_64FC1,
      intrinsicsMatrix.map((e) => e.toDouble()).toList(),
    );
  }

  void _initDistCoefficients(List<num> distMatrix) {
    distCoefficients = Mat.fromList(
      1,
      distMatrix.length,
      MatType.CV_64FC1,
      distMatrix.map((e) => e.toDouble()).toList(),
    );
  }
}
