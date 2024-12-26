#!/bin/bash

# AUTO-GENERATED FILE. DO NOT EDIT.
# To re-generate this file, edit `all_programs.dart` and run `dart run :compile`
#
# This file compiles all programs and loads them into the home directory

set -e  # Any error will cause the script to fail

# Redirects output on &3 to /dev/null unless -v or --verbose is passed
if [ "$1" = "-v" ]; then
  exec 3>&1
else
  exec 3>/dev/null
fi

echo "Compiling the video program. This could take a few minutes..."
cd video
dart compile exe bin/video.dart -o ~/video
bash src/build.sh >&3
cd ..

echo "Compiling the subsystems program. This could take a few minutes..."
cd subsystems
dart compile exe bin/subsystems.dart -o ~/subsystems
make -C src >&3
cd ..

echo "Compiling the autonomy program. This could take a few minutes..."
cd autonomy
dart compile exe bin/autonomy.dart -o ~/autonomy
cd ..

echo "Compiling the cv program. This could take a few minutes..."
cd cv
echo "#!/bin/bash\n" > ~/cv
echo "cd /home/pi/rover/cv\n" >> ~/cv
echo "python -m bin.cv\n" >> ~/cv
cd ..
