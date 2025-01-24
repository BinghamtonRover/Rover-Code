#!/bin/bash
# All stdout here is redirected to /dev/null, but leave stderr alone!
set -e  # Any error will cause the script to fail

# Redirects output on &3 to /dev/null unless -v or --verbose is passed
if [ "$1" = "-v" ]; then
  exec 3>&1
else
  exec 3>/dev/null
fi

if [[ $(which samba) ]]; then
    echo "Samba already installed"
else
    echo "Installing Samba"
    sudo apt install samba -y

    echo "Creating shared directory"
    mkdir "/home/pi/shared"

    echo "Copying RoverShare config"
    sudo echo ../linux/rover-share.conf >> "etc/samba/smb.conf"

    echo "Enabling SMBD system service"
    sudo systemctl enable --now smbd
    sudo systemctl restart smbd
fi