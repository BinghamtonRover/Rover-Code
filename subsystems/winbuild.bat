@echo off

rem Clean
if exist build @rmdir /s /q build

rem Check if CMake is not on the path
where cmake 1>NUL 2>NUL
if errorlevel 1 (
	echo You must run this script with cmake on your PATH
	echo The easiest way to do this is to install Visual Studio, which you did if you're using Flutter for Windows,
	echo and run this script from the Developer Command Prompt for Visual Studio. Search that in your Start menu
	exit /b 1
)

rem Build OpenCV and opencv_ffi
if not exist build mkdir build
cd build
cmake ../src
cmake --build .
cd ..

rem Copy DLLs to the project directory
copy build\Debug\*.dll .

echo Done! Your files are in the project directory.
