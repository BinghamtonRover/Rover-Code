@echo off

rem Build lidar_ffi_wrapper
cd src
git submodule init
git submodule update
cd ..
if not exist build mkdir build
cd build
cmake ../src
if %ERRORLEVEL% == 1 exit /b
cmake --build .
cd ..
if not exist dist mkdir dist
cd build
copy Debug\lidar_ffi.dll ..\dist
copy sick_scan_xd\Debug\sick_scan_xd_shared_lib.dll ..\dist
cd ..
dart run ffigen --config lidar.yaml -v severe
