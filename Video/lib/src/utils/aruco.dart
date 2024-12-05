import "dart:ffi";

import "package:opencv_ffi/opencv_ffi.dart";

/// Detect ArUco tags in the cv::aruco::DICT_4X4_50 dictionary and annotate them
void detectAndAnnotateFrames(Pointer<Mat> image) {
  final Pointer<ArucoMarkers> markers = detectArucoMarkers(image, dictionary: 0);
  drawMarkers(image, markers);
  markers.dispose();
}
