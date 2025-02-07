#!/bin/bash
set -e  # Any error will cause the script to fail

# Redirects output on &3 to /dev/null unless -v or --verbose is passed
if [ "$1" = "-v" ]; then
  exec 3>&1
else
  exec 3>/dev/null
fi

echo "Installing udev configuration files..."
dart run :udev >&3
sudo cp linux/*.rules /etc/udev/rules.d
sudo udevadm control --reload-rules
sudo udevadm trigger
