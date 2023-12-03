/// Configures the logging for BURT projects.
library;

import "dart:io";
import "package:burt_network/burt_network.dart";
import "package:logger/logger.dart";
export "package:logger/logger.dart";

/// An alias for [Level].
typedef LogLevel = Level;

/// Logs messages to the console and also sends a log to the dashboard.
class BurtLogger {
  /// The default console logger.
  final Logger logger = Logger(
    printer: SimplePrinter(colors: stdout.supportsAnsiEscapes), 
    filter: ProductionFilter(),
  );

  /// The device that's sending these logs.
  final Device? device;
  /// The [ServerSocket] that will be used to send the log to the Dashboard.
  final ServerSocket? socket;
  /// Creates a logger capable of sending network messages over the given socket.
  BurtLogger({this.socket}) : device = socket?.device;

  /// Formats a message with an optional body for more info.
  String getMessage(String title, String? body) => body == null
    ? title : "$title\n  $body".trim();

  /// Logs a trace message.
  /// 
  /// Use this to print values you want to inspect later.
  void trace(String title, {String? body}) {
    logger.t(getMessage(title, body));
    final log = BurtLog(level: BurtLogLevel.trace, title: title, body: body, device: device);
    socket?.sendMessage(log);
  }

  /// Logs a debug message.
  /// 
  /// Use this to print status updates that can help debugging.
  void debug(String title, {String? body}) {
    logger.d(getMessage(title, body));
    final log = BurtLog(level: BurtLogLevel.debug, title: title, body: body, device: device);
    socket?.sendMessage(log);
  }

  /// Logs an info message.
  /// 
  /// Use this to print status updates for the user to see.
  void info(String title, {String? body}) {
    logger.i(getMessage(title, body));
    final log = BurtLog(level: BurtLogLevel.info, title: title, body: body, device: device);
    socket?.sendLog(log);
  }

  /// Logs a warning. 
  /// 
  /// Use this to indicate something has gone wrong but can be recovered.
  void warning(String title, {String? body}) {
    logger.w(getMessage(title, body));
    final log = BurtLog(level: BurtLogLevel.warning, title: title, body: body, device: device);
    socket?.sendLog(log);
  }
  
  /// Logs an error. 
  /// 
  /// Use this to indicate that a user-requested action has failed.
  void error(String title, {String? body}) {
    logger.e(getMessage(title, body));
    final log = BurtLog(level: BurtLogLevel.error, title: title, body: body, device: device);
    socket?.sendLog(log);
  }

  /// Logs a critical message.
  /// 
  /// Use this to indicate that the program cannot recover and must terminate.
  void critical(String title, {String? body}) {
    logger.f(getMessage(title, body));
    final log = BurtLog(level: BurtLogLevel.critical, title: title, body: body, device: device);
    socket?.sendLog(log);
  }
}
