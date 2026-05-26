import "package:autonomy/autonomy.dart";

void main() async {
  final rover = RoverAutonomy();
	rover.drive = RoverDrive(collection: rover, useImu: false, useGps: false);
  await rover.init();
  //await rover.waitForValue();
  final didSeeAruco = await rover.drive.spinForAruco();
  if (didSeeAruco) {
    rover.logger.info("Found aruco");
    await rover.drive.approachAruco();
  } else {
    rover.logger.warning("COuld not find aruco");
  }
  rover.logger.info("Done");
}
