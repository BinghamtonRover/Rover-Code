import "dart:io";
import "package:burt_network/burt_network.dart";
import "package:test/test.dart";

final address = InternetAddress.loopbackIPv4;

final serverInfo = SocketInfo(address: address, port: 8000);
final clientInfo = SocketInfo(address: address, port: 8001);

final logger = BurtLogger();

void main() => group("ProtoSocket:", () {
  Logger.level = LogLevel.off;
  final server = TestServer(port: serverInfo.port, device: Device.SUBSYSTEMS);
  final client = TestClient(
    device: Device.DASHBOARD,
    port: clientInfo.port,
  );
  client.destination = serverInfo;

  setUpAll(() async {
    await server.init();
    await client.init();
  });

  test("Heartbeats received by both client and server", () async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    expect(server.isConnected, isTrue);
    expect(client.isConnected, isTrue);
  });

  test("onConnect and onDisconnect are called", () async {
    final serverInfo = SocketInfo(port: 8002, address: InternetAddress.loopbackIPv4);
    final clientInfo = SocketInfo(port: 8003, address: InternetAddress.loopbackIPv4);
    final server2 = TestServer(port: serverInfo.port, device: Device.SUBSYSTEMS);
    final client2 = TestClient(port: clientInfo.port, device: Device.DASHBOARD);
    client2.destination = serverInfo;
    await server2.init();
    await client2.init();
    client2.shouldSendHeartbeats = true;
    await Future<void>.delayed(const Duration(milliseconds: 50));
    expect(server2.onConnectCalled, isTrue);
    client2.shouldSendHeartbeats = false;
    await Future<void>.delayed(const Duration(milliseconds: 50));
    expect(server2.onDisconnectCalled, isTrue);
    await server2.dispose();
    await client2.dispose();
  });

  test("Data makes it across", () async {
    final data = ScienceData(co2: 3);
    client.sendMessage(data);
    await Future<void>.delayed(const Duration(milliseconds: 50));
    expect(server.data, equals(data));
  });

  tearDownAll(() async {
    await server.dispose();
    await client.dispose();
  });
});

class TestServer extends RoverServer {
  ScienceData? data;
  bool onConnectCalled = false;
  bool onDisconnectCalled = false;

  TestServer({required super.port, required super.device});

  @override
  Duration get heartbeatInterval => const Duration(milliseconds: 10);

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
  Future<void> onShutdown() async { }

  @override
  Future<void> restart() async { }
}

class TestClient extends BurtUdpProtocol {
  @override
  Duration get heartbeatInterval => const Duration(milliseconds: 10);
  
  TestClient({required super.port, required super.device});

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
    logger.debug("$device received a heartbeat from ${heartbeat.sender}"); 
    isConnected = true;
  }

  @override 
  void onMessage(Message message) { }
}
