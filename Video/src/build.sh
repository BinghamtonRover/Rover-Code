#!/bin/bash
set -e  # Any error will cause the script to fail

# See https://dev.intelrealsense.com/docs/compiling-librealsense-for-linux-ubuntu-guide

# Install dependencies
sudo apt-get install libssl-dev libusb-1.0-0-dev libudev-dev pkg-config libgtk-3-dev
sudo apt-get install git wget cmake build-essential
sudo apt-get install libglfw3-dev libgl1-mesa-dev libglu1-mesa-dev at

# Build the RealSense SDK
cd librealsense
mkdir -p build
cd build
cmake .. -DFORCE_LIBUVC=true -DCMAKE_POSITION_INDEPENDENT_CODE=true -DBUILD_EXAMPLES=true -DBUILD_GRAPHICAL_EXAMPLES=true -DBUILD_GLSL_EXTENSIONS=true -DBUILD_TOOLS=true -DBUILD_WITH_OPENMP=true -DBUILD_SHARED_LIBS=true -DCMAKE_BUILD_TYPE=Release 
make -j8
sudo make install
cd ../..

# Build our FFI wrappers
make clean
make shared
