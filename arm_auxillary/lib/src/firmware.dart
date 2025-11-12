import "package:burt_network/burt_network.dart";

/// Service to manage communication from the arm auxillary board to EA and HREI devices
class FirmwareManager extends Service {
  @override
  Future<bool> init() async {
    // TODO: implement init, finding all serial devices and attempting to connect to them
    return false;
  }

  @override
  Future<void> dispose() async {
    // TODO: implement dispose
  }
}
