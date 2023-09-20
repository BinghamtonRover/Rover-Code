import "dart:io";

import "server.dart";
import "drive.dart";
import "subsystems.dart";

/// The IP address of the subsystems server.
final subsystemsAddress = InternetAddress("192.168.1.20");

/// A collection of all the different services used by the autonomy program.
class AutonomyCollection {
	/// A server to communicate with the dashboard.
	final AutonomyServer dashboard = AutonomyServer(port: 8003);
	/// A server to communicate with the subsystems.
	late final SubsystemsServer subsystems;
	/// A helper class to handle driving the rover.
	final Drive drive = Drive();

	/// Initializes the rover, overriding the [subsystems] server if [tankMode] is true.
	Future<void> init({required bool tankMode}) async {
		subsystems = SubsystemsServer(
			port: 8004, 
			address: tankMode ? InternetAddress.loopbackIPv4 : subsystemsAddress,
		);
		await subsystems.init();
		await dashboard.init();
		drive.init();
	}
}

/// The collection of services used by the autonomy program.
final collection = AutonomyCollection();
