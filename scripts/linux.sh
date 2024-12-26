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

echo "Installing systemd configuration files..."
dart run :systemd  >&3
for service in $(find linux -name "*.service" -print0 | xargs -0 basename -a -s .service)
do
  if [[ $(sudo systemctl is-active $service) == "active" ]]; then
    sudo systemctl stop $service    >&3
    sudo systemctl disable $service >&3
  fi
  sudo cp linux/$service.service /etc/systemd/system >&3
  sudo systemctl enable $service  >&3
  sudo systemctl start $service   >&3
done
