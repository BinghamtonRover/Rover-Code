import "dart:io";
import "dart:typed_data";
import "package:args/args.dart";
import "package:collection/collection.dart";

import "package:burt_network/burt_network.dart";

typedef ProtoConstructor = Message Function(List<int> data);

const constructors = <Device, ProtoConstructor>{
  Device.DRIVE: DriveData.fromBuffer,
  Device.ARM: ArmData.fromBuffer,
  Device.GRIPPER: GripperData.fromBuffer,
  Device.SCIENCE: GripperData.fromBuffer,
  Device.ANTENNA: AntennaFirmwareData.fromBuffer,
};

final deviceNames = {
  for (final device in constructors.keys)
    device.name.toLowerCase(): device,
};

final logger = BurtLogger();

late bool ascii;
late bool rawMode;
ProtoConstructor? constructor;
String? messageName;

void handlePacket(Uint8List buffer) {
  try {
    if (rawMode) {
      logger.debug("Got packet: $buffer");
    } else if (constructor == null) {
      final string = String.fromCharCodes(buffer).trim();
      logger.debug("Got string: $string");
    } else {
      final message = constructor!(buffer);
      logger.debug("Got $messageName message: ${message.toProto3Json()}");
    }
  } catch (error) {
    logger.error("Could not decode packet: $error\n  Buffer: $buffer");
  }
}

Future<void> listenToDevice(String port, int baudRate) async {
  logger.info("Connecting to $port...");
  final device = SerialDevice(
    portName: port,
    readInterval: const Duration(milliseconds: 100),
    logger: logger,
    baudRate: baudRate,
  );
  if (!await device.init()) {
    logger.critical("Could not connect to $port");
    return;
  }
  logger.info("Connected. Listening...");
  device.stream.listen(handlePacket);
  device.startListening();
}

Future<void> listenToFirmware(String port, int baudRate) async {
  logger.info("Connecting to $port...");
  final device = BurtFirmwareSerial(
    port: port,
    logger: logger,
    baudRate: baudRate,
  );
  if (!await device.init()) {
    logger.critical("Could not connect to $port");
    await device.dispose();
    return;
  }
  logger.info("Connected? ${device.isReady}. Listening...");
  constructor = constructors[device.device];
  if (constructor == null) {
    logger.error("Unsupported serial device: ${device.device.name}");
    await device.dispose();
    return;
  }
  device.rawStream.listen(handlePacket);
}

void printUsage(ArgParser parser) =>
  // ignore: avoid_print
  print("\nUsage: dart run :serial [-h] [-f] [-r | -d <device>] [-b <baud>] <port>\n${parser.usage}");

ArgParser buildParser() => ArgParser()
  ..addFlag("help", abbr: "h", negatable: false, help: "Show this help message")
  ..addFlag("firmware", abbr: "f", negatable: false, help: "Whether to perform the standard firmware handshake")
  ..addFlag("raw", abbr: "r", negatable: false, help: "Whether to print incoming packets as raw bytes")
  ..addOption("baud", abbr: "b", defaultsTo: "9600", help: "The baud rate to listen with")
  ..addOption(
    "device", abbr: "d",
    allowed: deviceNames.keys,
    help: "The device being read. This will attempt to parse data as messages from that device\n"
      "  Note: If -f is passed, this will be ignored and the firmware will identify itself",
  );

Future<void> main(List<String> args) async {
  // Basic arg parsing
  final parser = buildParser();
  final ArgResults results;
  try {
    results = buildParser().parse(args);
  } on FormatException catch (error) {
    logger.error(error.message);
    printUsage(parser);
    return;
  }
  final isFirmware = results.flag("firmware");
  final showHelp = results.flag("help");
  final deviceName = results.option("device");
  final baudRateString = results.option("baud")!;
  final baudRate = int.tryParse(baudRateString);
  rawMode = results.flag("raw");
  var port = results.rest.firstOrNull;
  if (showHelp) {
    printUsage(parser);
    return;
  } else if (port == null) {
    logger.info("Ports: ${SerialDevice.allPorts}");
    return;
  } else if (baudRate == null) {
    logger.critical("Could not parse baud rate as an integer: $baudRateString");
    exit(1);
  } else if (rawMode && deviceName != null) {
    logger.critical("Cannot specify both --raw and --device");
    exit(2);
  }

  // Try to identify a device, if passed.
  final device = deviceNames[deviceName];
  constructor = constructors[device];
  if (constructor != null) {
    final buffer = Uint8List(0);
    messageName = constructor!(buffer).messageName;
    logger.info("Parsing all data as $messageName messages");
  }

  if (!Platform.isWindows && !port.startsWith("/dev")) port = "/dev/$port";
  if (isFirmware) {
    await listenToFirmware(port, baudRate);
  } else {
    await listenToDevice(port, baudRate);
  }
}
