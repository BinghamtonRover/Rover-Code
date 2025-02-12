import "dart:io";

/// A language a program can be written in.
///
/// Affects how the program is compiled and executed.
enum Language {
  /// Dart.
  dart,

  /// Python.
  python,

  /// C++
  cpp,
}

/// An extra command to run before compiling a program.
///
/// Assumes all submodules have already been initialized. The format of [command] and [args] follow
/// [Process.run] and [Process.start].
class ExtraCommand {
  /// The task being performed, eg, "Installing dependencies..."
  final String task;

  /// The command to run. This should be the first "word" of the command, including `sudo`.
  final String command;

  /// The arguments of the command, as a list.
  final List<String> args;

  /// Whether this step requires internet. This can be skipped by passing `--offline`.
  final bool requiresInternet;

  /// Holds information for an extra command.
  const ExtraCommand(this.task, this.command, this.args, {this.requiresInternet = false});
}

/// A team-written program on the rover.
///
/// This class will be used to compile the program and register the executable with systemd
/// so it auto-starts when the rover boots up.
class RoverProgram {
  /// The name of this program's directory.
  final String name;

  /// A human-readable description of the program.
  final String description;

  /// Any extra commands that need to be run before compiling the program.
  ///
  /// Use [homeDir] instead of `~`. These will be run in the [sourceDir].
  final List<ExtraCommand>? extraCommands;

  /// What language this program is written in.
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
    Language.dart => "$homeDir/$name",
    Language.python => "python3 -m bin.main",
    Language.cpp => "$homeDir/$name",
  };

  /// The path to the program's source directory.
  String get sourceDir => "${Directory.current.path}/$name";

  /// The command to compile this program.
  (String, List<String>)? get compileCommand => switch (language) {
    Language.dart => ("dart", ["compile", "exe", "bin/$name.dart", "-o", "$homeDir/$name"]),
    Language.python => null,
    Language.cpp => ("bash", ["build.sh"]),
  };
}

/// The user's home directory.
///
/// The `~` symbol is only parsed in a shell setting. When running commands with [Process.run], the
/// `~` symbol is not expanded and programs can get confused. Use this variable instead.
final String homeDir = Platform.environment["HOME"]!;
