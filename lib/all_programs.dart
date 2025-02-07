import "package:rover/src/program.dart";

/// All programs written by the rover team that need to be compiled.
///
/// For more information, see [RoverProgram].
const programs = [
  RoverProgram(
    name: "video",
    description: "Streams all the cameras and sends the feeds to the Dashboard",
    extraCommands: [
      ExtraCommand("Download the RealSense SDK", "git", ["submodule", "update", "--init"], requiresInternet: true),
      ExtraCommand("Building RealSense SDK", "bash", ["build.sh"]),
    ],
  ),
  RoverProgram(
    name: "subsystems",
    description: "Commands all the hardware and sends data to the Dashboard",
    extraCommands: [
      ExtraCommand("Building libserialport library", "make", ["-C", "src"]),
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
      ExtraCommand(
        "Installing pip",
        "sudo",
        ["apt-get", "install", "python3-pip", "-y"],
        requiresInternet: true,
      ),
      ExtraCommand(
        "Installing dependencies",
        "python3",
        ["-m", "pip", "install", "-r", "requirements.txt", "--break-system-packages"],
        requiresInternet: true,
      ),
    ],
  ),
];
