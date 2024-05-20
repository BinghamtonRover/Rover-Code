import "package:autonomy/interfaces.dart";
import "package:autonomy/rover.dart";
import "package:autonomy/simulator.dart";

class SensorlessDrive extends DriveInterface {
  final DriveInterface simulatedDrive;
  final DriveInterface realDrive;
  
  SensorlessDrive({required super.collection, bool useGps = true, bool useImu = true}) : 
    simulatedDrive = DriveSimulator(collection: collection),
    realDrive = RoverDrive(collection: collection, useGps: useGps, useImu: useImu);

  @override
  Future<bool> init() async {
    var result = true;
    result &= await simulatedDrive.init();
    result &= await realDrive.init();
    return result;
  }

  @override
  Future<void> dispose() async {
    await simulatedDrive.dispose();
    await realDrive.dispose();
  }

  @override
  Future<void> goForward() async {
    await simulatedDrive.goForward();
    await realDrive.goForward();
  }

  @override
  Future<void> stop() async {
    await simulatedDrive.stop();
    await realDrive.stop();
  }

  @override
  Future<void> faceNorth() async {
    await simulatedDrive.faceNorth();
    await realDrive.faceNorth();
  }

  @override
  Future<void> turnLeft() async {
    await simulatedDrive.turnLeft();
    await realDrive.turnLeft();
  }

  @override
  Future<void> turnRight() async {
    await simulatedDrive.turnRight();
    await realDrive.turnRight();
  }
}
