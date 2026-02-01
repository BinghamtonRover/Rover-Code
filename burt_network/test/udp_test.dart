import "dart:async";
import "dart:io";
import "package:burt_network/burt_network.dart";
import "package:test/test.dart";

import "udp_sockets.dart";

final logger = BurtLogger();
const heartbeatDelay = Duration(milliseconds: 100);

SocketInfo withPort(int port) => SocketInfo(address: InternetAddress.loopbackIPv4, port: port);

void main() => group("ProtoSocket:", () {
  Logger.level = LogLevel.off;

  test("Socket can be safely reset", () async {
    final socket = RoverSocket(port: 8000, device: Device.SUBSYSTEMS);
    await socket.init();
    await socket.dispose();
    await socket.init();
    expect(socket.port, 8000);
  });

  test("Heartbeats received by both client and server", () async {
    final server = TestServer(port: 8001);
    final client = TestClient(port: 8002, destination: withPort(8001));
    await server.init();
    await client.init();
    await Future<void>.delayed(heartbeatDelay * 5);
    expect(server.isConnected, isTrue);
    expect(client.isConnected, isTrue);
    await server.dispose();
    await client.dispose();
  });

  test("onConnect and onDisconnect are called", () async {
    final server = TestServer(port: 8003);
    final client = TestClient(port: 8004, destination: withPort(8003));
    await server.init();
    await client.init();
    client.shouldSendHeartbeats = true;
    await server.waitForConnection();
    client.shouldSendHeartbeats = false;
    await Future<void>.delayed(heartbeatDelay);
    expect(server.onDisconnectCalled, isTrue);
    await server.dispose();
    await client.dispose();
  });

  test("Data makes it across", () async {
    final data = ScienceData(co2: 3);
    final server = TestServer(port: 8005);
    final client = TestClient(port: 8006, destination: withPort(8005));
    await server.init();
    await client.init();
    client.sendMessage(data);
    await Future<void>.delayed(heartbeatDelay);
    expect(server.data, equals(data));
    await server.dispose();
    await client.dispose();
  });

  test("Data arrives after a socket is reset", () async {
    var data = ScienceData();
    final data1 = ScienceData(co2: 1);
    final data2 = ScienceData(co2: 2);
    final server = TestServer(port: 8007);
    final client = TestClient(port: 8008, destination: withPort(8007));
    // Initialize both sockets
    await server.init();
    await client.init();
    server.messages.onMessage(
      name: ScienceData().messageName,
      constructor: ScienceData.fromBuffer,
      callback: (d) => data = d,
    );
    // Send the first packet
    client.sendMessage(data1);
    await Future<void>.delayed(heartbeatDelay);
    expect(data, equals(data1));
    expect(server.data, equals(data1));
    // Reset the server
    await server.dispose();
    await server.init();
    await Future<void>.delayed(heartbeatDelay);
    // Send the second packet
    client.sendMessage(data2);
    await Future<void>.delayed(heartbeatDelay);
    expect(data, equals(data2));
    expect(server.data, equals(data2));
    await server.dispose();
    await client.dispose();
  });

  test("Multiple handlers can be registered", () async {
    var science1 = ScienceData();
    var science2 = ScienceData();
    var orientation = Orientation();
    final scienceTest = ScienceData(co2: 5);
    final orientationTest = Orientation(x: 5);
    final server = TestServer(port: 8009);
    final client = TestClient(port: 8010, destination: withPort(8009));
    server.messages.onMessage(
      name: ScienceData().messageName,
      constructor: ScienceData.fromBuffer,
      callback: (x) => science1 = x,
    );
    server.messages.onMessage(
      name: ScienceData().messageName,
      constructor: ScienceData.fromBuffer,
      callback: (x) => science2 = x,
    );
    server.messages.onMessage(
      name: Orientation().messageName,
      constructor: Orientation.fromBuffer,
      callback: (x) => orientation = x,
    );
    await server.init();
    await client.init();
    await Future<void>.delayed(heartbeatDelay);
    client.sendMessage(scienceTest);
    client.sendMessage(orientationTest);
    await Future<void>.delayed(heartbeatDelay);
    expect(science1, scienceTest);
    expect(science2, scienceTest);
    expect(orientation, orientationTest);
    await server.dispose();
    await client.dispose();
  });

  test("Heartbeats are filtered out of the regular stream", () async {
    var receivedHeartbeat = false;
    final server = TestServer(port: 8011);
    final client = UdpSocket(port: 8012, destination: withPort(8012));
    server.messages.onMessage(
      name: Heartbeat().messageName,
      constructor: Heartbeat.fromBuffer,
      callback: (_) => receivedHeartbeat = true,
    );
    await server.init();
    await client.init();
    await Future<void>.delayed(heartbeatDelay);
    client.sendMessage(Heartbeat(sender: Device.DASHBOARD, receiver: Device.SUBSYSTEMS));
    await Future<void>.delayed(heartbeatDelay);
    expect(receivedHeartbeat, false);
    await server.dispose();
    await client.dispose();
  });

  test("Server calls Service methods", skip: false, () async {
    final service = TestService();  // do not call init!
    final server = TestServer(port: 8011, collection: service);
    final client = TestClient(port: 8012, destination: withPort(8011));
    expect(service.initCalled, false);
    expect(service.disposeCalled, false);
    expect(service.onDisconnectCalled, false);

    // Ensure the client and server are connected
    RoverSettings.isTest = true;
    await server.init();
    await client.init();
    await server.waitForConnection();

    // Send a restart command
    client.sendMessage(NetworkSettings(status: RoverStatus.RESTART));
    await Future<void>.delayed(heartbeatDelay * 5);
    expect(service.initCalled, true);
    expect(service.disposeCalled, true);

    // Send a shutdown command
    service.initCalled = false;
    service.disposeCalled = false;
    client.sendMessage(NetworkSettings(status: RoverStatus.POWER_OFF));
    await Future<void>.delayed(heartbeatDelay);
    expect(service.initCalled, false);
    expect(service.disposeCalled, true);

    // Let the client and server disconnect
    client.shouldSendHeartbeats = false;
    await Future<void>.delayed(heartbeatDelay * 2);
    expect(server.isConnected, false);
    expect(server.onDisconnectCalled, true);
    expect(service.onDisconnectCalled, true);

    RoverSettings.isTest = false;
    await client.dispose();
    await server.dispose();
  });

  test("Only one restart happens at a time", () async {
    final restartService = RestartTrackingService();
    final socket = RoverSocket(
      collection: restartService,
      device: Device.DEVICE_UNDEFINED,
      port: 8013,
    );

    final restartFuture = socket.restart();
    unawaited(socket.restart());

    expect(restartService.disposedCount, 1);
    expect(restartService.initCount, 0);

    await restartFuture;

    expect(restartService.disposedCount, 1);
    expect(restartService.initCount, 1);

    // Restarts can happen after each other
    await socket.restart();

    expect(restartService.disposedCount, 2);
    expect(restartService.initCount, 2);
  });

  group("tryHandshake", () {
    test("works with successful handshakes", () async {
      final socket1Info = SocketInfo(address: InternetAddress.loopbackIPv4, port: 8014);
      final socket2Info = SocketInfo(address: InternetAddress.loopbackIPv4, port: 8015);
      final socket1 = TestServer(port: 8014);
      final socket2 = EchoSocket(port: 8015, destination: socket1Info);
      await socket1.init();
      await socket2.init();

      final result = await socket1.tryHandshake(
        message: SubsystemsCommand(zeroImu: true),
        timeout: const Duration(seconds: 1),
        constructor: SubsystemsCommand.fromBuffer,
        destination: socket2Info,
      );
      expect(result, isTrue);

      await socket1.dispose();
      await socket2.dispose();
    });

    test("catches missed handshakes", () async {
      final socket2Info = SocketInfo(address: InternetAddress.loopbackIPv4, port: 8016);
      final socket1 = TestServer(port: 8015);
      await socket1.init();

      final result = await socket1.tryHandshake(
        message: SubsystemsCommand(zeroImu: true),
        timeout: const Duration(seconds: 1),
        constructor: SubsystemsCommand.fromBuffer,
        destination: socket2Info,
      );
      expect(result, isFalse);

      await socket1.dispose();
    });
  });
});
