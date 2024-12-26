import "package:rover/program.dart";

const programs = [
  RoverProgram(
    name: "video",
    description: "Streams all the cameras and sends the feeds to the Dashboard",
    fullPathToExecutable: "/home/pi/video.exe",
  ),
  RoverProgram(
    name: "subsystems",
    description: "Commands all the hardware and sends data to the Dashboard",
    fullPathToExecutable: "/home/pi/subsystems.exe",
  ),
  RoverProgram(
    name: "autonomy",
    description: "Navigates the field autonomously",
    fullPathToExecutable: "/home/pi/autonomy.exe",
  ),
];
