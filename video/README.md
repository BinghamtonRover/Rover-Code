# Video (Dart)

This repository holds our Dart-based implementation of the Video program. In a nutshell, our video program is responsible for managing all USB-connected cameras and streaming them to our dashboard. In more detail, it needs to: 

- open and close cameras on demand
- adjust camera settings
- monitor camera status and notify the dashboard about issues
- perform JPG compression to reduce network traffic
- be resilient against cameras being unplugged and plugged into different ports
- Integrate with our autonomy platform, which needs sole unfettered access to the RealSense camera

## Compiling

### Setting up FFI

This repository uses Dart's FFI, which means it needs to compile C/C++ code into dynamic libraries, which need to be put in the root of this repository. So far the project only uses [`opencv_ffi`](https://github.com/BinghamtonRover/OpenCV-FFI), which has setup instructions in its repository. The necessary DLL files have already been copied over for testing on Windows devices.

### Running the Dart code

To run the main program, simply run `dart run`. You may also wish to compile this program using `dart compile exe bin/video.dart`.
