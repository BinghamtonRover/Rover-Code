class RoverProgram {
  final String name;
  final String description;
  final String fullPathToExecutable;

  final List<String>? extraCommands;

  const RoverProgram({
    required this.name,
    required this.description,
    required this.fullPathToExecutable,
    this.extraCommands,
  });
}
