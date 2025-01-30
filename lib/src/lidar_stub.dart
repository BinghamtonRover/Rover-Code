import "dart:ffi";
import "dart:io";
import "dart:typed_data";

import "package:burt_network/burt_network.dart";
import "package:lidar/lidar.dart";
import "generated/lidar_bindings.dart";
import "package:dartcv4/dartcv.dart";
import "lidar.dart";

/// Useful methods on OpenCV images.
extension MatrixUtils on Mat {
  /// Encodes this image as a JPG with the given quality.
  Uint8List? encodeJpg({required int quality}) {
    final params = VecI32.fromList([IMWRITE_JPEG_QUALITY, quality]);
    final (success, frame) = imencode(".jpg", this, params: params);
    return success ? frame : null;
  }
}
/// The resolution of an image.
typedef Resolution = ({int width, int height});

/// Converts raw data in native memory to an OpenCV image.
extension Uint8ToMat on Pointer<Uint8> {
  /// Reads this 1-dimensional list as an OpenCV image.
  Mat toOpenCVMat(Resolution resolution, {int? length}) {
    length ??= resolution.width * resolution.height;
    return Mat.fromList(resolution.height, resolution.width, MatType.CV_8UC3, asTypedList(length));
  }
}

class LidarStub extends Lidar {
  final LidarBindings bindings;

  LidarStub() : bindings = Platform.isWindows ? LidarBindings(DynamicLibrary.open("dist/lidar_ffi.dll")) : LidarBindings(DynamicLibrary.open("dist/liblidar_ffi.so"));
    
  bool getStatus() => bindings.getStatus() == 0;
  
  @override
  Future<bool> init() async {
    bindings.init();
    int status = 5; // 5 is failure
    for(int i = 0; i < 15; i++){ // Attemp to connect for 15 seconds
      status = bindings.getStatus();
      if(status == 0){
        break;
      }
      await Future<void>.delayed(const Duration(seconds: 1));
    }
    return status == 0;
  }

  @override
  Future<void> dispose() async {
    bindings.dispose();
  }

  @override
  Future<VideoData> readFrame() async {
    final image = bindings.getLatestImage();

    print("latest image is: ${image.height}, image width ${image.width}");
    final res = (height: image.height, width: image.width);
    final matrix = image.data.toOpenCVMat(res, length: 3 * image.height * image.width);
    final jpg = matrix.encodeJpg(quality: 75);
    return VideoData(
      // TODO: Add CameraName.LIDAR
      frame: jpg,
      details: CameraDetails(name: CameraName.AUTONOMY_DEPTH, status: CameraStatus.CAMERA_ENABLED),
    );
  }
}
