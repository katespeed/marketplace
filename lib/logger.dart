import 'package:flutter/foundation.dart';
import 'package:simple_logger/simple_logger.dart';

Logger get logger => SimpleLoggerAdapter(SimpleLogger());

abstract class Logger {
  void d(String message);
  void i(String message);
  void w(String message);
  void e(String message, {Object? error, StackTrace? stackTrace});
}

class SimpleLoggerAdapter extends Logger {
  SimpleLoggerAdapter(this._logger) {
    _logger.setLevel( 
      kDebugMode ? Level.ALL : Level.OFF,
    );
  }

  final SimpleLogger _logger;

  @override
  void d(String message) {
    _logger.fine(message);
  }

  @override
  void i(String message) {
    _logger.info(message);
  }

  @override
  void w(String message) {
    _logger.warning(message);
  }

  @override
  void e(String message, {Object? error, StackTrace? stackTrace}) {
    _logger.severe(message);
  }
}
