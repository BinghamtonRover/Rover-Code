import "dart:ffi";
import "dart:io";
import "dart:typed_data";

import "package:burt_network/burt_network.dart";
import "package:lidar/lidar.dart";
import "package:ffi/ffi.dart";
import "generated/lidar_bindings.dart";
import "package:dartcv4/dartcv.dart";
import "lidar.dart";

/// Useful methods on OpenCV images.
extension MatrixUtils on Mat {
  /// Encodes this image as a JPG with the given quality.
  Uint8List? encodeJpg({required int quality}) {
    //final params = VecI32.fromList([IMWRITE_JPEG_QUALITY, quality]);
    final (success, frame) = imencode(".jpg", this); //, params: params);
    return success ? frame : null;
  }
}
/// The resolution of an image.
typedef Resolution = ({int width, int height});

/// Converts raw data in native memory to an OpenCV image.
extension Uint8ToMat on Pointer<Uint8> {
  /// Reads this 1-dimensional list as an OpenCV image.
  Mat toOpenCVMat(Resolution resolution, {required int length}) {
    return Mat.fromList(resolution.height, resolution.width, MatType.CV_8UC3, asTypedList(length));
  }
}

class LidarStub extends Lidar {
  final LidarBindings bindings;
  Pointer<LidarHandle>? handle;

  LidarStub() : bindings = Platform.isWindows ? LidarBindings(DynamicLibrary.open("dist/lidar_ffi.dll")) : LidarBindings(DynamicLibrary.open("dist/liblidar_ffi.so"));
    
  bool getStatus() {
    if (handle == null) return false;
    bindings.getStatus(handle!);
    return handle!.ref.statusCode == 0;
  }
  
  @override
  Future<bool> init({int timeout = 15}) async {
    handle = bindings.Lidar_create();
    print("Done with C++ init()");
    int status = 5; // 5 is failure
    for(int i = 0; i < timeout; i++){ // Attemp to connect for 15 seconds
      bindings.getStatus(handle!);
      status = handle!.ref.statusCode;
      print("Trying to connect ($i/$timeout)...");
      if(status == 0){
        break;
      }
      await Future<void>.delayed(const Duration(seconds: 1));
    }
    print("Done with Dart init");
    return status == 0;
  }

  @override
  Future<void> dispose() async {
    if (handle == null) return;
    bindings.Lidar_delete(handle!);
    handle = null;
    print("Disposed of lidar");
  }

  @override
  Future<VideoData?> readFrame() async {

    bindings.getStatus(handle!);
    if (handle!.ref.statusCode != 0) {
      print("API returned non-zero status code: ${handle!.ref.statusCode} (${handle!.ref.statusBuffer.toDartString()}");
      if (handle!.ref.statusCode == 4) {
        print("API has quit");
        await dispose();
        exit(0);
      }
      return null;
    }  
    if (handle!.ref.isReady == 0) {
      print("NO image loaded");
      return null;
    }
    while(handle!.ref.lock == 0){ // locked
      print("locked");
      await Future<void>.delayed(const Duration(milliseconds: 10));
    }
    handle!.ref.lock = 0;
    final image = handle!.ref.image;
    print("latest image is: ${image.height}, image width ${image.width}, image data ${image.data}");


    final length = 3 * image.height * image.width;
    final nativeArray = image.data.asTypedList(length);
    final arena = Arena();
    final copyPointer = arena<Uint8>(length);
    for (int index = 0; index < length; index++) {
      copyPointer[index] = nativeArray[index];
    }
    print("Copied $length bytes");

    print("making matrix");
    //final res = (height: image.height, width: image.width);
    final matrix = Mat.fromList(image.height, image.width,  MatType.CV_8UC3, copyPointer.asTypedList(length));
    print("Got matrix: Ptr=${matrix.dataPtr}, length=${matrix.data.toList().length}");
    print("encoding... (matrix: $matrix)");
    final jpg = matrix.encodeJpg(quality: 75);
     
     
    //final matrix = image.data.toOpenCVMat(res, length: 3 * image.height * image.width);
    handle!.ref.lock = 1;
    //matrix.dispose();
    bindings.registerCallback(handle!);
    return VideoData(
      id: "CameraName.LIDAR",
      // TODO: Add CameraName.LIDAR
      //frame: jpg,
      details: CameraDetails(name: CameraName.AUTONOMY_DEPTH, status: CameraStatus.CAMERA_ENABLED),
    );
  }
}
