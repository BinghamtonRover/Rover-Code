#!/bin/bash

cd src
# git submodule update
cd ..

# TODO: Check if it exists first
#  If so, don't make it
if [ ! -d "$DIRECTORY" ]; then
  mkdir build
fi

cd build
cmake ../src
cmake --build . -j 1
cd ..