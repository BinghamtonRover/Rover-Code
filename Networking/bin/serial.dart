import "dart:typed_data";
import "package:burt_network/burt_network.dart";
import "package:libserialport/libserialport.dart";

final logger = BurtLogger();

bool ascii = false;

Future<void> listenToDevice(String port) async {
  logger.info("Connecting to $port...");
  final device = SerialDevice(
    portName: port,
    readInterval: const Duration(milliseconds: 100),
    logger: logger,
  );
  if (!await device.init()) {
    logger.critical("Could not connect to $port");
    return;
  }
  logger.info("Connected. Listening...");
  device.stream.listen(process);
  device.startListening();
}

Future<void> listenToFirmware(String port) async {
  logger.info("Connecting to $port...");
  final device = BurtFirmwareSerial(
    port: port,
    logger: logger,
  );
  if (!await device.init()) {
    logger.critical("Could not connect to $port");
    return;
  }
  logger.info("Connected? ${device.isReady}. Listening...");
  device.rawStream.listen(process);
}

void main(List<String> args) async {
  if (args.isEmpty) {
    logger.info("Ports: ${SerialPort.availablePorts}");
    return;
  } else if (args.contains("-h") || args.contains("--help")) {
    logger.info("Usage: dart run -r :serial [port] [-a | --ascii] [-f | --firmware]");
    logger.info("  -a --ascii:    Print data in plain text instead of hex");
    logger.info("  -f --firmware: Perform the firmware handshake first");
    return;
  }
  var port = args.first;
  if (!port.startsWith("/dev")) port = "/dev/$port";
  if (args.contains("-a") || args.contains("--ascii")) {
    logger.info("Running in ASCII mode");
    ascii = true;
  }
  if (args.contains("-f") || args.contains("--firmware")) {
    await listenToFirmware(port);
  } else {
    await listenToDevice(port);
  }
}

void process(Uint8List buffer) {
  if (ascii) {
    final s = String.fromCharCodes(buffer).trim();
    logger.debug("Got string: $s");
  } else {
    try {
      final data = DriveData.fromBuffer(buffer);
      logger.debug("Got data: ${data.toProto3Json()}");
    } catch (error) {
      logger.error("Could not decode DriveData: $error\n  Buffer: $buffer");
    }
  }
}
