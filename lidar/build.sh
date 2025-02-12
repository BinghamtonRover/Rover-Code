set -e

cd lib
git submodule init
git submodule update
cd ..

mkdir -p build

cd build
cmake ../lib

# On WSL (Windows Subsystems for Linux), build as normal.
# On other systems, assume you're on a Pi and conserve memory with -j 1
# Feel free to change this to a more accurate check, or to try out -j 2
# Not using -j at all causes the Pi 5 (8 GB RAM) to run out of memory and halt
if [[ -v CI ]];
then
  echo "Running on CI, building sick_scan with $(nproc) processors"
  cmake --build . -j$(nproc)
else
  echo Running on Pi, using 1 core
  cmake --build . -j 1
fi
cd ..

mkdir -p dist
cp build/*.so dist
cp build/lidar .
cp build/lidar $HOME
cp lidar.launch $HOME
