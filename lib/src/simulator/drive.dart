// ignore_for_file: cascade_invocations

import "package:autonomy/interfaces.dart";
import "package:burt_network/generated.dart";

class DriveSimulator extends DriveInterface {
  final bool shouldDelay;
  DriveSimulator({required super.collection, this.shouldDelay = false});

  @override
  Future<bool> init() async => true;

  @override
  Future<void> dispose() async { }

  @override
  Future<void> goForward() async {
    final position = collection.gps.coordinates;
    final orientation = collection.imu.orientation;
    final newPosition = position.goForward(orientation);
    collection.logger.debug("Going forward");
    collection.logger.trace("  Old position: ${position.prettyPrint()}");
    collection.logger.trace("  Orientation: ${orientation.heading}");
    collection.logger.trace("  New position: ${newPosition.prettyPrint()}");
    collection.gps.update(newPosition);
    if (shouldDelay) await Future<void>.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> turnLeft() async  {
    collection.logger.debug("Turning left");
    final heading = collection.imu.heading;
    final orientation = Orientation(z: heading + 90);
    collection.imu.update(orientation);
    if (shouldDelay) await Future<void>.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> turnRight() async  {
    collection.logger.debug("Turning right");
    final heading = collection.imu.heading;
    final orientation = Orientation(z: heading - 90);
    collection.imu.update(orientation);
    if (shouldDelay) await Future<void>.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> stop() async => collection.logger.debug("Stopping");
}
