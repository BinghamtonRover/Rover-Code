import "package:rover/src/program.dart";

const programs = [
  RoverProgram(
    name: "video",
    description: "Streams all the cameras and sends the feeds to the Dashboard",
    extraCommands: [
      ExtraCommand("Build RealSense SDK", "bash", ["src/build.sh"]),
    ],
  ),
  RoverProgram(
    name: "subsystems",
    description: "Commands all the hardware and sends data to the Dashboard",
    extraCommands: [
      ExtraCommand("Build libserialport library", "make", ["-C", "src"]),
    ],
  ),
  RoverProgram(
    name: "autonomy",
    description: "Navigates the field autonomously",
  ),
  RoverProgram(
    name: "cv",
    description: "Analyzes video frames to look for objects of interest",
    language: Language.python,
    extraCommands: [
      ExtraCommand("Install dependencies", "python", ["-m", "pip", "install", "-r", "requirements.txt"]),
    ],
  ),
];
