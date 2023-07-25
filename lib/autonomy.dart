import "package:burt_network/burt_network.dart";

/// A server to handle incoming [AutonomyCommand]s and send [AutonomyData]s.
class AutonomyServer extends ServerSocket {
  /// Creates an autonomy server at the given port.
  AutonomyServer({required super.port}) : super(device: Device.AUTONOMY);

  @override
  void onMessage(WrappedMessage wrapper) {
    logger.info("Received message: $wrapper");
  }
}
