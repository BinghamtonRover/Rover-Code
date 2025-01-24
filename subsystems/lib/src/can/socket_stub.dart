import "package:subsystems/subsystems.dart";

/// An implementation of the CAN interface that does nothing for platforms that don't support it.
class CanStub extends CanSocket {
	/// Creates a mock CAN interface that does nothing and receives no messages.
	CanStub();

	@override
	Future<bool> init() async {
    logger.warning("Using a mock CAN service");
    return true;
  }

	@override
	Future<void> dispose() async { }

	@override
	void sendMessage({required int id, required List<int> data}) {	}

	@override
	Stream<CanMessage> get incomingMessages => const Stream<CanMessage>.empty();

  @override
  Future<void> reset() async { }
}
