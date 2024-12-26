#!/bin/bash
set -e  # Any error will cause the script to fail

# Redirects output on &3 to /dev/null unless -v or --verbose is passed
if [ "$1" = "-v" ]; then
  exec 3>&1
else
  exec 3>/dev/null
fi

echo "Installing udev configuration files..."
dart run :udev
sudo cp linux/*.rules /etc/udev/rules.d
sudo udevadm control --reload-rules
sudo udevadm trigger

echo "Installing systemd configuration files..."
dart run :systemd  # generate the service files
for service in $(find linux -name "*.service" -print0 | xargs -0 basename -a -s .service)
do
  # Stop the service, overwrite it, re-enable it
  sudo systemctl stop $service    >&3
  sudo systemctl disable $service >&3
  sudo cp $service.service /etc/systemd/system >&3
  sudo systemctl enable $service  >&3
  sudo systemctl start $service   >&3
done
