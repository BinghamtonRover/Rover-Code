#!/bin/bash
# All stdout here is redirected to /dev/null, but leave stderr alone!
set -e  # Any error will cause the script to fail

# Redirects output on &3 to /dev/null unless -v or --verbose is passed
if [ "$1" = "-v" ]; then
  exec 3>&1
else
  exec 3>/dev/null
fi

echo "Cloning submodules..."
git submodule update --init --recursive >&3

echo "Configuring Linux files..."
bash scripts/linux.sh $1

echo "Compiling all rover programs..."
dart run :compile >&3
bash scripts/compile.sh $1

echo ""
echo "Done! Here's what just happened"
echo "- OpenCV was built and installed as a dynamic library"
echo "- The video program was compiled to ~/video.exe"
echo "- udev will auto-detect cameras when plugged in"
echo "- systemd will auto-start the video program on boot"
echo "- SocketCan and libserialport were built and installed as dynamic libraries"
echo "- The subsystems program was compiled to ~/subsystems.exe"
echo "- udev will auto-detect the IMU and GPS when plugged in"
echo "- systemd will auto-start the subsystems program on boot"
