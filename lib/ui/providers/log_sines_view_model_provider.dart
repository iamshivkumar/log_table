import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../log_sines.dart';

final logSinesModelProvider = ChangeNotifierProvider(
  (ref) => LogSinesViewModel(),
);

class LogSinesViewModel extends ChangeNotifier {
  int? _rowIndex;
  int? get rowIndex => _rowIndex;
  set rowIndex(int? rowIndex) {
    _rowIndex = rowIndex;
    notifyListeners();
  }

  int? _logIndex;
  int? get logIndex => _logIndex;
  set logIndex(int? logIndex) {
    _logIndex = logIndex;
    notifyListeners();
  }

  int? _meanIndex;
  int? get meanIndex => _meanIndex;
  set meanIndex(int? meanIndex) {
    _meanIndex = meanIndex;
    notifyListeners();
  }

  String get value {
    if (_rowIndex == null || _logIndex == null) {
      return '';
    } else {
      final double log =
          LogSines.logsinCell(_rowIndex!, _logIndex! / 10).value;
      if (_meanIndex != null) {
        final String q = "${_rowIndex}°${_logIndex! * 6 + _meanIndex!}'";
        final double mean =
            LogSines.meanCell(_rowIndex!, _meanIndex!).value;
        return "log(sin($q)) = "+ LogSines.format(log + mean);
      } else {
        final String q = "${_rowIndex}°${_logIndex! * 6}'";
        return "log(sin($q)) = ${LogSines.format(log)}";
      }
    }
  }
}
