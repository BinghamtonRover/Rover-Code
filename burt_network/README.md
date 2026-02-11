# BURT Networking (Dart)

A Dart library for UDP communication, featuring our Protobuf data and our awesome heartbeat + handshake protocol.

See the [docs](https://binghamtonrover.github.io/Dart-Networking/burt_network/burt_network-library.html) for details.

## Usage

Use the `RoverSocket` class to handle messages, heartbeats, and logs from the rover. On the Dashboard, subclass `BurtSocket`.

```dart
import "package:burt_network/burt_network.dart";

void main() async {
  final socket = RoverSocket(port: 8001, device: Device.SUBSYSTEMS);
  socket.messages.onMessage(
    name: ScienceData().messageName,
    constructor: ScienceData.fromBuffer,
    callback: (data) => print(data.co2),
  );
}
```
