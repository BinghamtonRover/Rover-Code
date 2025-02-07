import "dart:io";

/// A language a program can be written in.
///
/// Affects how the program is compiled and executed.
enum Language {
  /// Dart.
  dart,

  /// Python.
  python,
}

class ExtraCommand {
  final String task;
  final String command;
  final List<String> args;
  final bool requiresInternet;

  const ExtraCommand(this.task, this.command, this.args, {this.requiresInternet = false});
}

typedef TerminalCommand = (String, List<String>);

/// A team-written program on the rover.
///
/// This class will be used to compile the program and register the executable with systemd
/// so it auto-starts when the rover boots up.
class RoverProgram {
  /// The name of this program's directory.
  final String name;

  /// A human-readable description of the program.
  final String description;

  /// Any extra commands to compile native assets.
  final List<ExtraCommand>? extraCommands;

  /// What language this program is compiled in.
  final Language language;

  /// Registers a program to be compiled and ran with systemd.
  const RoverProgram({
    required this.name,
    required this.description,
    this.language = Language.dart,
    this.extraCommands,
  });

  /// The path to the generated executable.
  String get executable => switch (language) {
    Language.dart => "${Platform.environment["HOME"] ?? ""}/$name",
    Language.python => "python3 -m bin.$name",
  };

  /// The path to the program's source directory.
  String get sourceDir => "${Directory.current.path}/$name";

  /// The command to compile this program.
  TerminalCommand? get compileCommand => switch (language) {
    Language.dart => ("dart", ["compile", "exe", "bin/$name.dart", "-o", "$homeDir/$name"]),
    Language.python => null,
  };
}

final String homeDir = Platform.environment["HOME"]!;
