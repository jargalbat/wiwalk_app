import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

class Log {
  static final Log _logClient = Log._internal();
  final Logger _log = Logger(filter: CustomFilter());

  Logger get log => _log;

  factory Log() {
    return _logClient;
  }

  Log._internal();
}

class CustomFilter extends DevelopmentFilter {
  @override
  bool shouldLog(LogEvent event) {
    // Default
    var shouldLog = false;
    assert(() {
      if (event.level.index >= level!.index) {
        shouldLog = true;
      }
      return true;
    }());
    return shouldLog;
  }
}
