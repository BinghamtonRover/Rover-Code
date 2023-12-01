/// Configures the logging for BURT projects.
library;

import "dart:io";
import "package:burt_network/burt_network.dart";
import "package:logger/logger.dart";
export "package:logger/logger.dart";

/// An alias for [Level].
typedef LogLevel = Level;

// /// The logger to use when running BURT programs. 
// /// 
// /// See [LoggerUtils] for usage. To change the minimum log level, use [Logger.level].
// final logger = Logger(
//   printer: SimplePrinter(colors: stdout.supportsAnsiEscapes), 
//   filter: ProductionFilter(),
// );

class BurtLogger {
  final Logger logger = Logger(
    printer: SimplePrinter(colors: stdout.supportsAnsiEscapes), 
    filter: ProductionFilter(),
  );

  final ServerSocket? socket;
  BurtLogger([this.socket]);

  String getMessage(String title, String? body) => body == null
    ? title : "$title -- $body".trim();

  /// Logs a debug message.
  /// 
  /// Use this to print values you want to inspect later.
  void trace(String title, {String? body}) {
    logger.t(getMessage(title, body));
    final log = BurtLog(level: BurtLogLevel.trace, title: title, body: body);
    socket?.sendMessage(log);
  }

  /// Logs a verbose message.
  /// 
  /// Use this to print status updates that can help debugging.
  void debug(String title, {String? body}) {
    logger.d(getMessage(title, body));
    final log = BurtLog(level: BurtLogLevel.debug, title: title, body: body);
    socket?.sendMessage(log);
  }

  /// Logs an info message.
  /// 
  /// Use this to print status updates for the user to see.
  void info(String title, {String? body}) {
    logger.i(getMessage(title, body));
    final log = BurtLog(level: BurtLogLevel.info, title: title, body: body);
    socket?.sendMessage(log);
  }

  /// Logs a warning. 
  /// 
  /// Use this to indicate something has gone wrong but can be recovered.
  void warning(String title, {String? body}) {
    logger.w(getMessage(title, body));
    final log = BurtLog(level: BurtLogLevel.warning, title: title, body: body);
    socket?.sendMessage(log);
  }
  
  /// Logs a warning. 
  /// 
  /// Use this to indicate something has gone wrong but can be recovered.
  void error(String title, {String? body}) {
    logger.e(getMessage(title, body));
    final log = BurtLog(level: BurtLogLevel.error, title: title, body: body);
    socket?.sendMessage(log);
  }

  /// Logs a critical message.
  /// 
  /// Use this to indicate that the program cannot recover and must terminate.
  void critical(String title, {String? body}) {
    logger.f(getMessage(title, body));  
    socket?.setError(title, body: body);
  }
}
