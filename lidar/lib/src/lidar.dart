// ignore_for_file: avoid_print

import "dart:ffi";
import "dart:io";

import "package:burt_network/burt_network.dart";
import "package:ffi/ffi.dart";
import "package:dartcv4/dartcv.dart";
import "package:opencv_ffi/opencv_ffi.dart";

import "lidar_bindings.g.dart";

///// Useful methods on OpenCV images.
//extension MatrixUtils on Mat {
//  /// Encodes this image as a JPG with the given quality.
//  Uint8List? encodeJpg({required int quality}) {
//    //final params = VecI32.fromList([IMWRITE_JPEG_QUALITY, quality]);
//    final (success, frame) = imencode(".jpg", this); //, params: params);
//    return success ? frame : null;
//  }
//}
///// The resolution of an image.
//typedef Resolution = ({int width, int height});

///// Converts raw data in native memory to an OpenCV image.
//extension Uint8ToMat on Pointer<Uint8> {
//  /// Reads this 1-dimensional list as an OpenCV image.
//  Mat toOpenCVMat(Resolution resolution, {required int length}) {
//    return Mat.fromList(resolution.height, resolution.width, MatType.CV_8UC3, asTypedList(length));
//  }
//}

typedef LidarStatus = SickScanApiErrorCodes;

extension on LidarStatus {
  bool get isOk => this == LidarStatus.SICK_SCAN_API_SUCCESS;
}

/// Interfaces with the lidar via native C++ code.
class Lidar extends Service {
  /// Allows access to the C functions defined in src/lidar.h
  static final LidarBindings bindings =  Platform.isWindows
    ? LidarBindings(DynamicLibrary.open("dist/lidar_ffi.dll"))
    : LidarBindings(DynamicLibrary.open("dist/liblidar_ffi.so"));

  Pointer<NativeLidar>? _lidar;

  /// Creates a new lidar object
  Lidar();

  /// Returns whether the lidar is working right now.
  bool getStatus() {
    if (_lidar == null) return false;
    bindings.updateStatus(_lidar!);
    return _lidar!.ref.statusCode.isOk;
  }

  @override
  Future<bool> init({int timeout = 15}) async {
    _lidar = malloc<NativeLidar>();
    bindings.init(_lidar!);
    print("Done with C++ init()");
    var status = LidarStatus.SICK_SCAN_API_ERROR; // 5 is failure
    for(var i = 0; i < timeout; i++){ // Attempt to connect for 15 seconds
      await Future<void>.delayed(const Duration(seconds: 1));
      bindings.updateStatus(_lidar!);
      status = _lidar!.ref.statusCode;
      print("Trying to connect ($i/$timeout)...");
      if (status.isOk) {
        break;
      }
    }
    print("Done with Dart init");
    return status.isOk;
  }

  @override
  Future<void> dispose() async {
    if (_lidar == null) return;
    bindings.dispose(_lidar!);
    malloc.free(_lidar!);
    _lidar = null;
    print("Disposed of lidar");
  }

  /// Reads data from the lidar and returns a JPG representing the results visually.
  Future<VideoData?> readFrame() async {
    bindings.updateStatus(_lidar!);
    if (!_lidar!.ref.statusCode.isOk) {
      print("API returned non-zero status code: ${_lidar!.ref.statusCode} (${_lidar!.ref.statusBuffer.toDartString()}");
      if(_lidar!.ref.statusCode == LidarStatus.SICK_SCAN_API_NOT_IMPLEMENTED) {
        print("API has quit");
        await dispose();
        exit(0);
      }
      if(_lidar!.ref.statusCode == LidarStatus.SICK_SCAN_API_NOT_LOADED){
        print("restarting API");
        await dispose();
        await init();
      }
      return null;
    }
    if (_lidar!.ref.hasNewData) {
      print("NO image loaded");
      return null;
    }
    final image = _lidar!.ref.image;
    print("latest image is: ${image.height}, image width ${image.width}, image data ${image.data}");


    final length = 3 * image.height * image.width;
    final nativeArray = image.data.asTypedList(length);
    final arena = Arena();
    final copyPointer = arena<Uint8>(length);
    for (var index = 0; index < length; index++) {
      copyPointer[index] = nativeArray[index];
    }
    print("Copied $length bytes");

    // ---------- opencv_ffi
    print("making matrix");
    final matrix = getMatrix(image.height, image.width, image.data);
    //await Future<void>.delayed(Duration(seconds: 1));
    print("Made matrix: ${matrix.address.toRadixString(16)}");
    print("Encoding...");
    final jpg = encodeJpg(matrix);
    if (jpg == null) {
      print("Could not encode JPG");
      return null;
    }
    print("Got JPG: ${jpg.pointer.address.toRadixString(16)}");
    final length2 = jpg.data.toList().length;
    print("  length=$length2");
    final jpgCopy = arena<Uint8>(length2);
    print("Copying");
    for (var i = 0; i < length2; i++) {
      jpgCopy[i] = jpg.data[i];
    }
    print("Done copying: ");
    //arena.releaseAll();

    //------- opencv_dart
    //print("making matrix");
    ////final res = (height: image.height, width: image.width);
    //final matrix = Mat.fromList(image.height, image.width,  MatType.CV_8UC3, copyPointer.asTypedList(length));
    //print("Got matrix: Ptr=${matrix.dataPtr}, length=${matrix.data.toList().length}");
    //print("encoding... (matrix: $matrix)");
    //final jpg = matrix.encodeJpg(quality: 75);


    //final matrix = image.data.toOpenCVMat(res, length: 3 * image.height * image.width);
    //matrix.dispose();
    //bindings.registerCallback(_lidar!);
    return VideoData(
      id: "CameraName.LIDAR",
      // TODO(Aidan): Add CameraName.LIDAR
      frame: jpgCopy.asTypedList(length2),
      details: CameraDetails(name: CameraName.AUTONOMY_DEPTH, status: CameraStatus.CAMERA_ENABLED),
    );
  }
}
