import "dart:io";
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
  device.stream.listen(processAscii);
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
    await device.dispose();
    return;
  }
  logger.info("Connected? ${device.isReady}. Listening...");
  constructor = getDataConstructor(device.device);
  if (constructor == null) {
    logger.error("Unsupported serial device: ${device.device.name}");
    await device.dispose();
    return;
  }
  device.rawStream.listen(processFirmware);
}

typedef ProtoConstructor = Message Function(List<int> data);

ProtoConstructor? getDataConstructor(Device device) => switch (device) {
  Device.DRIVE => DriveData.fromBuffer,
  Device.ARM => ArmData.fromBuffer,
  Device.GRIPPER => GripperData.fromBuffer,
  Device.SCIENCE => GripperData.fromBuffer,
  _ => null,
};

ProtoConstructor? constructor;

void main(List<String> args) async {
  if (args.isEmpty) {
    logger.info("Ports: ${SerialPort.availablePorts}");
    return;
  } else if (args.contains("-h") || args.contains("--help")) {
    logger.info("Usage: dart run -r :serial [-a | --ascii] [port]");
    return;
  }
  var port = args.first;
  if (!Platform.isWindows && !port.startsWith("/dev")) port = "/dev/$port";
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

void processFirmware(Uint8List buffer) {
  try {
    final data = constructor!(buffer);
    logger.debug("Got data: ${data.toProto3Json()}");
  } catch (error) {
    logger.error("Could not decode DriveData: $error\n  Buffer: $buffer");
  }
}

void processAscii(Uint8List buffer) {
  final s = String.fromCharCodes(buffer).trim();
  logger.debug("Got string: $s");
}
