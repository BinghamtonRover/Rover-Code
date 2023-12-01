import "dart:io";
import "package:burt_network/burt_network.dart";
import "package:burt_network/logging.dart";
import "package:test/test.dart";

final address = InternetAddress.loopbackIPv4;

final serverInfo = SocketInfo(address: address, port: 8000);
final clientInfo = SocketInfo(address: address, port: 8001);

final logger = BurtLogger();

void main() => group("ProtoSocket:", () {
  Logger.level = LogLevel.debug;
  final server = TestServer(port: serverInfo.port, device: Device.SUBSYSTEMS);
  final client = TestClient(
    device: Device.DASHBOARD,
    destination: serverInfo, 
    port: clientInfo.port,
  );

  setUpAll(() async {
    await server.init();
    await client.init();
  });

  test("Heartbeats received by both client and server", () async {
    await Future<void>.delayed(const Duration(seconds: 3));
    expect(server.isConnected, isTrue);
    expect(client.isConnected, isTrue);
  });

  test("onConnect and onDisconnect are called", () async {
    client.shouldSendHeartbeats = false;
    await Future<void>.delayed(const Duration(seconds: 3));
    expect(server.onConnectCalled, isTrue);
    expect(server.onDisconnectCalled, isTrue);
  });

  test("Data makes it across", () async {
    final data = ScienceData(methane: 3);
    client.sendMessage(data);
    await Future<void>.delayed(const Duration(seconds: 1));
    expect(server.data, equals(data));
  });

  tearDownAll(() async {
    await server.dispose();
    await client.dispose();
  });
});

class TestServer extends ServerSocket {
  ScienceData? data;
  bool onConnectCalled = false;
  bool onDisconnectCalled = false;

  TestServer({required super.port, required super.device});

  @override
  void onMessage(WrappedMessage wrapper) => data = ScienceData.fromBuffer(wrapper.data);

  @override
  void onConnect(SocketInfo info) {
    super.onConnect(info);
    onConnectCalled = true;
  }

  @override
  void onDisconnect() {
    super.onDisconnect();
    onDisconnectCalled = true;
  }

  @override
  void onHeartbeat(Connect heartbeat, SocketInfo source) {
    logger.debug("$device received a heartbeat from ${heartbeat.sender}"); 
    super.onHeartbeat(heartbeat, source);
  }
}

class TestClient extends ProtoSocket {
  TestClient({required super.port, required super.device, super.destination}) : super(heartbeatInterval: const Duration(seconds: 1));

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
    logger.debug("$device received a heartbeat from ${heartbeat.sender}"); 
    isConnected = true;
  }

  @override 
  void onMessage(Message message) { }

  @override 
  void updateSettings(UpdateSetting message) { }  
}
