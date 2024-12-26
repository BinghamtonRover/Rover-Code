/// A team-written program on the rover.
///
/// This class will be used to compile the program and register the executable with systemd
/// so it auto-starts when the rover boots up.
class RoverProgram {
  /// The name of this program's directory.
  final String name;

  /// A human-readable description of the program.
  final String description;

  /// The full path to the executable that will result from compiling.
  final String fullPathToExecutable;

  /// Any extra commands to compile native assets.
  final List<String>? extraCommands;

  /// Registers a program to be compiled and ran with systemd.
  const RoverProgram({
    required this.name,
    required this.description,
    required this.fullPathToExecutable,
    this.extraCommands,
  });
}
