cd src
# git submodule update
cd ..

mkdir -p build

cd build
cmake ../src
cmake --build . -j 1
cd ..

cp build/liblidar_ffi.so dist/liblidar_ffi.so
