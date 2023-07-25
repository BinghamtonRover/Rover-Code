/// Configures the logging for BURT projects.
library;

import "dart:io";
import "package:logger/logger.dart";

/// An alias for [Level].
typedef LogLevel = Level;

/// Holds the current [LogLevel] for [logger].
class BurtLogger {
  /// The current [LogLevel] for [logger].
  static LogLevel level = LogLevel.info;
}

/// A custom filter to work around a bug with `package:logger`.
/// 
/// See https://github.com/Bungeefan/logger/issues/38.
class BurtFilter extends LogFilter {
  @override 
  bool shouldLog(LogEvent event) => event.level.index >= BurtLogger.level.index;
}

/// The logger to use when running BURT programs. 
/// 
/// See [LoggerUtils] for usage. To change the minimum log level, use [BurtLogger.level].
final logger = Logger(printer: SimplePrinter(colors: stdout.supportsAnsiEscapes), filter: BurtFilter());

/// Helpful aliases for the [Logger] class.
extension LoggerUtils on Logger {
  /// Logs a debug message.
  /// 
  /// Use this to print values you want to inspect later.
  void debug(String message) => d(message);

  /// Logs a verbose message.
  /// 
  /// Use this to print status updates more often than [info].
  void verbose(String message) => v(message);

  /// Logs an info message.
  /// 
  /// Use this to print status updates for the user to see.
  void info(String message) => i(message);

  /// Logs a warning. 
  /// 
  /// Use this to indicate something has gone wrong but can be recovered.
  void warning(String message) => w(message);

  /// Logs an error message.
  /// 
  /// Use this when an error occurs in a try/catch block. This is like a verbose [critical].
  void error(String message, Object error, [StackTrace? stackTrace]) => e(message, error, stackTrace);

  /// Logs a critical message.
  /// 
  /// Use this to indicate that the program cannot recover and must terminate.
  void critical(String message) => wtf(message);  
}
