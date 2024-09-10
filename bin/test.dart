import "package:autonomy/autonomy.dart";
import "package:burt_network/logging.dart";
import "package:autonomy/src/rover/gps.dart";
import "package:autonomy/src/rover/imu.dart";

void main() async {
  Logger.level = LogLevel.all;
  final rover = RoverAutonomy();
  rover.gps = RoverGps(collection: rover);
  rover.imu = RoverImu(collection: rover);
  rover.drive = RoverDrive(collection: rover, useGps: false, useImu: false);
  
  await rover.init();

  // rover.logger.info("Done");
  // await rover.dispose();
}
