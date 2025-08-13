// ignore_for_file: avoid_print

import "dart:io";
import "dart:typed_data";

import "package:burt_network/udp.dart";

void main() async {
  final socket = UdpSocket(port: 8004);
  await socket.init();
  socket.stream.listen(temp);
  while (true) {
    await Future<void>.delayed(const Duration(seconds: 1));
  }
}

void temp(Datagram packet) {
  final data = Float64List.sublistView(packet.data);
  final processed = [
    for (final number in data)
      //if (!number.isNaN)
      number.toStringAsFixed(3),
  ];
  print("------------------------------------------");
  if (processed.length == 271) {
    print("Angle Data");
  } else if (processed.length == 542) {
    //return;
    print("Coordinate Data");
  }
  print(processed);
}
