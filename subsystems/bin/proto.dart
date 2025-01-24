import "dart:convert";
import "dart:io";

import "package:csv/csv.dart";
import "package:burt_network/burt_network.dart";
import "package:subsystems/subsystems.dart";

const filename = r"C:\Users\Levi\Downloads\RoverPosition.log";
const outputName = "imu.csv";

extension <E> on Iterable<E> {
  Iterable<(int, E)> get enumerate sync* {
    int i = 0;
    for (final e in this) {
      yield (i++, e);
    }
  }
}

RoverPosition fromBuffer(List<int> buffer) => RoverPosition.fromBuffer(buffer);
bool filter(RoverPosition data) => data.hasOrientation()
  && data.orientation.hasX() && data.orientation.hasY() && data.orientation.hasZ()
  && data.orientation.x.abs() < 400 
  && data.orientation.y.abs() < 400 
  && data.orientation.z.abs() < 400;
List<dynamic> expand(RoverPosition data) => [data.orientation.x, data.orientation.y, data.orientation.z];

void main() async {
  logger.info("Reading log file...");
  final file = File(filename);
  final lines = await file.readAsLines();
  final data = <List<double>>[];
  logger.info("Parsing...");
  for (final (index, line) in lines.enumerate) {
    final buffer = base64Decode(line);
    final wrapper = WrappedMessage.fromBuffer(buffer);
    final entry = fromBuffer(wrapper.data);
    if (!filter(entry)) continue;
    data.add([index.toDouble(), ...expand(entry)]);
  }
  logger.info("Writing...");
  const converter = ListToCsvConverter();
  final csv = converter.convert(data);
  final outputFile = File(outputName);
  await outputFile.writeAsString(csv);
  logger.info("Wrote ${data.length} lines to ${outputFile.absolute}");
}
