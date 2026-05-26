import "package:burt_network/burt_network.dart";

import "package:autonomy/interfaces.dart";

abstract class AutonomyInterface extends Service with Receiver {
  BurtLogger get logger;
  GpsInterface get gps;
  ImuInterface get imu;
  DriveInterface get drive;
  RoverSocket get server;
  PathfindingInterface get pathfinder;
  DetectorInterface get detector;
  VideoInterface get video;
  OrchestratorInterface get orchestrator;

  @override
  Future<bool> init() async {
    var result = true;
    result &= await gps.init();
    result &= await imu.init();
    result &= await drive.init();
    result &= await server.init();
    result &= await pathfinder.init();
    result &= await detector.init();
    result &= await video.init();
    logger.info("Init orchestrator");
    await orchestrator.init();
    logger.info("Init orchestrator done");
    if (result) {
      logger.info("Autonomy initialized");
    } else {
      logger.warning("Autonomy could not initialize");
    }
    return result;
  }

  @override
  Future<void> dispose() async {
    await gps.dispose();
    await imu.dispose();
    await drive.dispose();
    await pathfinder.dispose();
    await detector.dispose();
    await video.dispose();
    await orchestrator.dispose();
    logger.info("Autonomy disposed");
    await server.dispose();
  }

  Future<void> restart() async {
    await dispose();
    await init();
  }

  @override
  Future<void> waitForValue() async {
    logger.info("Waiting for readings...");
    await gps.waitForValue();
    await imu.waitForValue();
    await video.waitForValue();
    logger.info("Received GPS and IMU values");
  }

  @override
  bool get hasValue => gps.hasValue && imu.hasValue && video.hasValue;
}
