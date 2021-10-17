import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:log_table/calculate.dart';

final logViewModelProvider = ChangeNotifierProvider((ref) => LogViewModel());

class LogViewModel extends ChangeNotifier {
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
      final double log = Calculate.logCell(_rowIndex!, _logIndex!).value;
      if (_meanIndex != null) {
        final String q = "${_rowIndex! / 10}$_logIndex$_meanIndex";
        final double mean = Calculate.meanCell(_rowIndex!, _meanIndex!).value;
        return "Log($q) = " + (log + mean).toStringAsFixed(4);
      } else {
        final String q = "${_rowIndex! / 10}$_logIndex";

        return "Log($q) = " + log.toString();
      }
    }
  }
}
