import "package:burt_network/logging.dart";

import "package:autonomy/interfaces.dart";

abstract class AutonomyInterface extends Service with Receiver {
  BurtLogger get logger;
  GpsInterface get gps;
  ImuInterface get imu;
  DriveInterface get drive;
  ServerInterface get server;
  PathfindingInterface get pathfinder;
  DetectorInterface get detector;
  RealSenseInterface get realsense;
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
    result &= await realsense.init();
    result &= await orchestrator.init();
    if (result) {
      logger.info("Autonomy initialized");
    } else {
      logger.warning("Autonomy could not initialize");
    }
    return result;
  }
  
  @override
  Future<void> dispose() async {
    await server.dispose();
    await gps.dispose();
    await imu.dispose();
    await drive.dispose();
    await pathfinder.dispose();
    await detector.dispose();
    await realsense.dispose();
    await orchestrator.dispose();
    logger.info("Autonomy disposed");
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
    await realsense.waitForValue();
  }

  @override
  bool get hasValue => gps.hasValue && imu.hasValue && realsense.hasValue;
}
