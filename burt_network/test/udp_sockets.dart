
import "dart:async";

import "package:burt_network/burt_network.dart";

class TestService extends Service {
  @override
  Future<bool> init() async {
    initCalled = true;
    return true;
  }

  @override
  Future<void> dispose() async { disposeCalled = true; }

  bool onDisconnectCalled = false;
  bool initCalled = false;
  bool disposeCalled = false;

  @override
  Future<void> onDisconnect() async {
    await super.onDisconnect();
    onDisconnectCalled = true;
  }
}

class TestServer extends RoverSocket {
  ScienceData? data;
  bool onConnectCalled = false;
  bool onDisconnectCalled = false;

  TestServer({required super.port, super.collection}) : super(device: Device.SUBSYSTEMS);

  @override
  Duration get heartbeatInterval => const Duration(milliseconds: 20);

  @override
  Future<bool> init() async {
    await super.init();
    messages.onMessage(
      name: ScienceData().messageName,
      constructor: ScienceData.fromBuffer,
      callback: (x) => data = x,
    );
    return true;
  }

  @override
  void onConnect(SocketInfo info) {
    super.onConnect(info);
    onConnectCalled = true;
  }

  @override
  Future<void> onDisconnect() async {
    await super.onDisconnect();
    onDisconnectCalled = true;
  }
}

class EchoSocket extends RoverSocket {
  EchoSocket({
    required super.port,
    required super.destination,
    super.destinations,
  }) : super(device: Device.SUBSYSTEMS, keepDestination: true);

  StreamSubscription<WrappedMessage>? _subscription;

  @override
  Future<bool> init() async {
    await super.init();
    _subscription = messages.listen(echoBack);
    return true;
  }

  @override
  Future<void> dispose() async {
    await _subscription?.cancel();
    await super.dispose();
  }

  void echoBack(WrappedMessage wrapper) => sendWrapper(wrapper);
}

class TestClient extends BurtSocket {
  @override
  Duration get heartbeatInterval => const Duration(milliseconds: 10);

  TestClient({required super.port, super.destination, super.destinations})
    : super(device: Device.DASHBOARD);

  @override
  bool isConnected = false;
  bool shouldSendHeartbeats = true;

  @override
  Future<void> checkHeartbeats() async {
    if (!shouldSendHeartbeats) return;
    final heartbeat = Connect(sender: Device.DASHBOARD, receiver: Device.SUBSYSTEMS);
    sendMessage(heartbeat);
  }

  @override
  void onHeartbeat(Connect heartbeat, SocketInfo source) {
    logger.debug("$port received a heartbeat from ${source.port}");
    isConnected = true;
  }

  @override
  void onSettings(UpdateSetting settings) { }
  
  @override
  bool get shouldSendTimesync => false;
}

class RestartTrackingService extends Service {
  int disposedCount = 0;
  int initCount = 0;

  @override
  Future<bool> init() async {
    initCount++;
    return true;
  }

  @override
  Future<void> dispose() async {
    disposedCount++;
    await Future<void>.delayed(const Duration(milliseconds: 500));
  }
}
