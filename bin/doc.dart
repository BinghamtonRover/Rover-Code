// ignore_for_file: avoid_print

import "dart:io";

import "package:args/args.dart";
import "package:pubspec_parse/pubspec_parse.dart";
import "package:dhttpd/dhttpd.dart";
import "package:cli_spin/cli_spin.dart";

void main(List<String> args) async {
  print("");

  // Get list of valid Dart packages
  final pubspecFile = File("pubspec.yaml");
  final pubspec = Pubspec.parse(await pubspecFile.readAsString());
  final packages = pubspec.workspace!;

  // Get the user's choice of package
  final parser = ArgParser()
    ..addOption("package", abbr: "p", help: "The package to document", mandatory: true)
    ..addFlag("help", abbr: "h", help: "Show this help message and exits", negatable: false);

  final results = parser.parse(args);
  final package = results.option("package");
  final showHelp = results.flag("help");

  if (showHelp) {
    print("Usage: dart run :doc --package <package> [--help]\n${parser.usage}");
    return;
  } else if (package == null) {
    print("Usage: dart run :doc -p <package>");
    print(parser.usage);
    return;
  } else if (!packages.contains(package)) {
    print("Please choose one of the following packages: ");
    print("  ${packages.join(", ")}");
    return;
  }

  // Document the package
  final spinner = CliSpin(text: "Documenting $package...", color: CliSpinnerColor.white);
  spinner.start();
  const docCommand = "dart";
  final docArgs = ["doc", package, "-o", "docs"];
  final result = await Process.run(docCommand, docArgs);
  if (result.exitCode != 0) {
    spinner.fail("Could not document $package");
    print(result.stderr);
    return;
  }
  spinner.success("Done!");

  // Open the docs
  await Dhttpd.start(path: "docs", port: 8888);
  print("Serving documentation at http://localhost:8888");
  print("Press CTRL+C to exit.");
}
