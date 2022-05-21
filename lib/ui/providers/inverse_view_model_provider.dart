import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:log_table/calculate.dart';
import 'package:log_table/inverse.dart';

final inverseViewModelProvider = ChangeNotifierProvider((ref) => InverseViewModel());

class InverseViewModel extends ChangeNotifier {
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
      final double log = Inverse.logCell(_rowIndex!, _logIndex!).value;
      if (_meanIndex != null) {
        final String q = "${_rowIndex! / 10}$_logIndex$_meanIndex";
        final double mean = Inverse.meanCell(_rowIndex!, _meanIndex!).value;
        return "1/$q = ${(log + mean).toStringAsFixed(4)}";
      } else {
        final String q = "${_rowIndex! / 10}$_logIndex";

        return "1/$q = $log";
      }
    }
  }
}
