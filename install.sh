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
echo "- All dependencies were downloaded and cached"
echo "- All USB devices were registered with udev"
echo "- All programs and dependencies were compiled"
echo "- All programs will auto-start on boot"
echo ""
echo "To add, change, or remove a USB device, edit all_devices.dart"
echo "To add, change, or remove a program, edit all_programs.dart"
