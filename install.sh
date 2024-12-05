#!/bin/bash
# All stdout here is redirected to /dev/null, but leave stderr alone!
set -e  # Any error will cause the script to fail

echo "Cloning submodules..."
git submodule update --init > /dev/null

echo "Building Subsystems..."
cd Subsystems/src
make >/dev/null
cd ../..

echo "Compiling the Subsystems program. This could take about 1 minute..."
cd Subsystems
dart pub get --offline > /dev/null
dart compile exe bin/subsystems.dart -o ~/subsystems.exe > /dev/null
cd ..

echo "Installing configuration files..."
sudo cp ./11-subsystems.rules /etc/udev/rules.d
sudo cp ./subsystems.service /etc/systemd/system
sudo systemctl enable subsystems > /dev/null
sudo systemctl start subsystems > /dev/null
sudo udevadm control --reload-rules
sudo udevadm trigger

echo ""
echo "Done! Here's what just happened"
echo "- SocketCan and libserialport were built and installed as dynamic libraries"
echo "- The subsystems program was compiled to ~/subsystems.exe"
echo "- udev will auto-detect the IMU and GPS when plugged in"
echo "- systemd will auto-start the subsystems program on boot"



# Redirects output on &3 to /dev/null unless -v or --verbose is passed 
if [ "$1" = "-v" ]; then
  exec 3>&1
else
  exec 3>/dev/null
fi

echo "Cloning submodules..."
git submodule update --init >&3

echo "Building OpenCV. This could take up to 10 minutes..."
cd opencv_ffi
./build.sh >&3
cd ..

cd video/src
if [ ! -f /usr/local/lib/librealsense2.so ]
then
  echo "Compiling librealsense. This could take up to 45 minutes..."
  sh build.sh
fi
echo "Compiling RealSense FFI..."
make shared
cd ../..

echo "Compiling the video program. This could take up to a minute..."
cd video
dart pub get >&3
dart compile exe bin/video.dart -o ~/video.exe >&3
cd ..

echo "Installing configuration files..."
sudo cp ./10-cameras.rules /etc/udev/rules.d
sudo cp ./video.service /etc/systemd/system
sudo systemctl enable video >&3
sudo systemctl start video >&3
sudo udevadm control --reload-rules
sudo udevadm trigger

echo ""
echo "Done! Here's what just happened"
echo "- OpenCV was built and installed as a dynamic library"
echo "- The video program was compiled to ~/video.exe"
echo "- udev will auto-detect cameras when plugged in"
echo "- systemd will auto-start the video program on boot"