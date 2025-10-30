import "package:test/test.dart";

import "package:autonomy/autonomy.dart";
import "package:burt_network/burt_network.dart";

void main() => group("[Simulator]", tags: ["simulator"], () {
  test("Simulator can be restarted", () async {
    Logger.level = LogLevel.off;
    final simulator = AutonomySimulator();
    expect(simulator.isInitialized, isFalse);
    await simulator.init();
    expect(simulator.isInitialized, isTrue);
    await simulator.restart();
    expect(simulator.isInitialized, isTrue);
    await simulator.dispose();
    expect(simulator.isInitialized, isFalse);
  });

  test("Already has values", () async {
    final simulator = AutonomySimulator();
    expect(simulator.hasValue, isFalse);
    await simulator.init();
    expect(simulator.hasValue, isTrue);
    await simulator.dispose();
  });
});
