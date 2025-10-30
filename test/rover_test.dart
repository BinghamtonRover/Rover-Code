import "package:test/test.dart";

import "package:burt_network/logging.dart";

import "package:autonomy/interfaces.dart";
import "package:autonomy/rover.dart";

import "test_util.dart";

void main() => group("[Rover]", tags: ["rover"], () {
  test("Can be restarted", () async {
    Logger.level = LogLevel.off;
    final rover = RoverAutonomy();
    await rover.init();
    await rover.restart();
    await rover.dispose();
  });

  test("Waits for sensor data", () async {
    final rover = RoverAutonomy();
    final orientation = Orientation();
    final data = VideoData();

    await rover.init();

    expect(rover.hasValue, isFalse);
    expect(rover.gps.hasValue, isFalse);
    rover.gps.forceUpdate(origin);
    expect(rover.gps.hasValue, isTrue);
    expect(rover.hasValue, isFalse);

    expect(rover.hasValue, isFalse);
    expect(rover.imu.hasValue, isFalse);
    rover.imu.forceUpdate(orientation);
    expect(rover.imu.hasValue, isTrue);
    expect(rover.hasValue, isFalse);

    expect(rover.hasValue, isFalse);
    expect(rover.video.hasValue, isFalse);
    rover.video.updateFrame(data);
    expect(rover.video.hasValue, isTrue);
    expect(rover.hasValue, isTrue);

    await rover.dispose();
  });
});
