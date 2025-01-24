import "dart:io";

import "package:burt_network/burt_network.dart";

import "message.dart";
import "socket_stub.dart";
import "socket_ffi.dart";

/// A CAN socket that supports reading and writing CAN messages.
///
/// This class uses the [CAN bus](https://en.wikipedia.org/wiki/CAN_bus) protocol to interface with
/// other devices on the CAN bus. Each message should have an ID and a payload. The ID is used to
/// identify the purpose of the message, and the receiving device can filter incoming messages
/// based on its ID. The payload is limited to 8 bytes, or 64 bytes if using CAN FD.
///
/// - Use [sendMessage] to send a message to all devices on the bus
/// - Listen to [incomingMessages] to receive messages from other devices on the bus
abstract class CanSocket extends Service {
  /// A default constructor for a [CanSocket].
  CanSocket();

  /// Chooses the right implementation for the platform. Uses a stub on non-Linux platforms.
  factory CanSocket.forPlatform() => Platform.isLinux ? CanFFI() : CanStub();

  /// Sends a CAN message with the given ID and data.
  void sendMessage({required int id, required List<int> data}) {  }

  /// A stream of incoming CAN messages. Use [Stream.listen] to handle them.
  ///
  /// This stream returns [CanMessage] objects, which are wrappers around native structs, which
  /// needs to be freed after use. Be sure to call [CanMessage.dispose] when you're done using it.
  Stream<CanMessage> get incomingMessages;

  /// Resets the CAN bus.
  Future<void> reset();
}
