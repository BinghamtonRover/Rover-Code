@REM echo off


@REM # Clone repository sick_scan_xd
@REM git clone -b master https://github.com/SICKAG/sick_scan_xd.git
@REM # Build libraries sick_scan_xd_shared_lib.dll
@REM call "%ProgramFiles(x86)%\Microsoft Visual Studio\2019\Community\Common7\Tools\VsDevCmd.bat" -arch=amd64 -host_arch=amd64
@REM set _os=x64
@REM set _cmake_string=Visual Studio 17
@REM set _msvc=Visual Studio 2022
@REM set _cmake_build_dir=build
@REM @REM cd lidar/sick_scan_xd
@REM if not exist %_cmake_build_dir% mkdir %_cmake_build_dir%
@REM pushd %_cmake_build_dir%
@REM if %ERRORLEVEL% neq 0 ( @echo ERROR building %_cmake_string% sick_scan_xd with cmake & @pause )
@REM cmake --build . --clean-first --config Debug
@REM @REM cmake --build . --clean-first --config Release
@REM cd ..\..

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
copy build\Debug\lidar_ffi.dll ..\dist
copy build\sick_scan_xd\Debug\sick_scan_xd_shared_lib.dll ..\dist