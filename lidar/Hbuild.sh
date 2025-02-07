#!/bin/bash

# exit on any error (i was not aware of this)
set -e
export ROS_VERSION=0
export CXXFLAGS=-fPIC

mkdir -p build
cd build

echo "building sick_scan_xd..."
cmake ../src/sick_scan_xd/
make -j

pwd

echo "building lidar_ffi..."

g++ -fPIC -shared \
    -I../src/sick_scan_xd/include \
    ../src/lidar.cpp \
    -o liblidar_ffi.so \
    ./libsick_scan_xd_lib.a

mkdir -p include
cp ../src/lidar.h include/
cp ../src/sick_scan_api.h include/

echo "Done."