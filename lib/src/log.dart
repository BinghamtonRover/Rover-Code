import "dart:io";
import "package:logger/logger.dart";

export "package:logger/logger.dart";

/// An alias for [Level].
typedef LogLevel = Level;

/// Only logs messages at the given [level]. Set [level] to change at any time.
class BurtLogFilter implements LogFilter {
  LogLevel _level;
  @override LogLevel get level => _level;
  @override set level(LogLevel? value) => _level = value ?? LogLevel.info;

  /// Creates a [LogFilter] at the given level. Set [level] to change.
  BurtLogFilter([this._level = LogLevel.info]);

  @override
  bool shouldLog(LogEvent event) => event.level.index >= level.index;

  @override
  void init() { }

  @override
  void destroy() { }
}

/// A filter to decide which messages get logged. Set [LogFilter.level] to change.
final logFilter = BurtLogFilter();
/// The logger to use when running BURT programs. See [LoggerUtils] for usage.
Logger logger = Logger(printer: SimplePrinter(colors: stdout.supportsAnsiEscapes), filter: logFilter);

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
