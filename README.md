# BURT Networking (Dart)

A Dart library for UDP communication, featuring our Protobuf data and our heartbeat + handshake protocol.

See the [docs](https://binghamtonrover.github.io/Dart-Networking/burt_network/burt_network-library.html) for details.

## Usage

Extends the `ProtoSocket` or `ServerSocket` classes to handle different types of events. Import the `generated` library for access to all our Protobuf data.

```dart
import "package:burt_network/burt_network.dart";
import "package:burt_network/generated.dart";

class MyServer extends ServerSocket {
  MyServer({required super.port, required super.device});

  @override
  void onMessage(WrappedMessage wrapper) => print(wrapper.data);

  @override
  void onConnect(SocketInfo info) {
    super.onConnect(info);
    print("Dashboard is connected");
  }

  @override
  void onDisconnect() {
    super.onDisconnect();
    print("Dashboard is disconnected");
  }
}
```
