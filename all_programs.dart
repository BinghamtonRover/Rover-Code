import "package:rover/program.dart";

const programs = [
  RoverProgram(
    name: "video",
    description: "Streams all the cameras and sends the feeds to the Dashboard",
    extraCommands: ["bash src/build.sh"],
  ),
  RoverProgram(
    name: "subsystems",
    description: "Commands all the hardware and sends data to the Dashboard",
    extraCommands: ["make -C src"],
  ),
  RoverProgram(
    name: "autonomy",
    description: "Navigates the field autonomously",
  ),
  RoverProgram(
    name: "cv",
    description: "Analyzes video frames to look for objects of interest",
    language: Language.python,
  ),
];
