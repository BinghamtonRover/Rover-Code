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

  PWM? _fan1PWM;
  PWM? _fan2PWM;

  @override
  Future<bool> init() async {
    // PWM fan control is only supported on Linux
    if (!Platform.isLinux) {
      return true;
    }
    try {
      _fan1PWM = PWM(0, 1);
      _fan2PWM = PWM(0, 7);

      _fan1PWM!.setFrequency(fanPWMFrequency);
      _fan2PWM!.setFrequency(fanPWMFrequency);
    } catch (e) {
      _fan1PWM?.dispose();
      _fan2PWM?.dispose();

      _fan1PWM = null;
      _fan2PWM = null;

      logger.error("Error initializing PWM fans: $e");

      return false;
    }
    return true;
  }

  @override
  Future<void> dispose() async {
    _fan1PWM?.disable();
    _fan2PWM?.disable();

    _fan1PWM?.dispose();
    _fan2PWM?.dispose();

    _fan1PWM = null;
    _fan2PWM = null;
  }

  /// Manually set the duty cycle speed of the fans
  void setSpeed(double dutyCycle) {
    _fan1PWM?.setDutyCycle(dutyCycle);
    _fan2PWM?.setDutyCycle(dutyCycle);

    // Disable PWM output if the speed is being set to < 0.5%
    if (dutyCycle.abs() < 0.005) {
      _fan1PWM?.disable();
      _fan2PWM?.disable();
    } else {
      _fan1PWM?.enable();
      _fan2PWM?.enable();
    }
  }
}
