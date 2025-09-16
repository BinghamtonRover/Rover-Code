import "dart:io";

import "package:burt_network/burt_network.dart";
import "package:dart_periphery/dart_periphery.dart";
import "package:subsystems/subsystems.dart";

/// Controls the output to the Rover's PWM fans connected to the Jetson
class FanController extends Service {
  /// The fan's nominal frequency are 25 KHz
  ///
  /// https://support.arctic.de/S8038-10K#toc-107
  static const double fanPWMFrequency = 25000;

  PWM? _fanPWM;

  @override
  Future<bool> init() async {
    // PWM fan control is only supported on Linux
    if (!Platform.isLinux) {
      return true;
    }
    try {
      _fanPWM = PWM(0, 0);

      _fanPWM!.setFrequency(fanPWMFrequency);
    } catch (e) {
      _fanPWM?.dispose();

      _fanPWM = null;

      logger.error("Error initializing PWM fans: $e");

      return false;
    }
    return true;
  }

  @override
  Future<void> dispose() async {
    _fanPWM?.disable();

    _fanPWM?.dispose();

    _fanPWM = null;
  }

  /// Manually set the duty cycle speed of the fans
  void setSpeed(double dutyCycle) {
    _fanPWM?.setDutyCycle(dutyCycle);
  }
}
