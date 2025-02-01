cd src
# git submodule update
cd ..

mkdir -p build

cd build
cmake ../src
cmake --build . -j 1
cd ..