set -e

cd src
# git submodule update
cd ..

mkdir -p build

cd build
cmake ../src

# On WSL (Windows Subsystems for Linux), build as normal.
# On other systems, assume you're on a Pi and conserve memory with -j 1
# Feel free to change this to a more accurate check, or to try out -j 2
# Not using -j at all causes the Pi 5 (8 GB RAM) to run out of memory and halt
if [ -z "$WSL_DISTRO_NAME" ];
then
  cmake --build .
else
  cmake --build . -j 1
fi
cd ..

mkdir -p dist
cp build/*.so dist
cp build/lidar .
