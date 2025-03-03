import 'log.dart';

class LogImplement implements Log {
  bool is_debug = true;
  @override
  void i(String tag, String context) {
  if (is_debug) print('[$tag] context]');
  }

  @override
  void i1(String tag, String context) {
    if (is_debug) print('[Error][$tag] context]');
  }

  @override
  void i2(String tag, String context) {
    if (is_debug) print('[$tag] context]');
  }
    
}