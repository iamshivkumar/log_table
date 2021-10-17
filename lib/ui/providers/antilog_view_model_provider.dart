import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:log_table/calculate.dart';

final antilogViewModelProvider = ChangeNotifierProvider((ref) => AntiLogViewModel());

class AntiLogViewModel extends ChangeNotifier {
  int? _rowIndex;
  int? get rowIndex => _rowIndex;
  set rowIndex(int? rowIndex) {
    _rowIndex = rowIndex;
    notifyListeners();
  }

  int? _antilogIndex;
  int? get antilogIndex => _antilogIndex;
  set antilogIndex(int? antilogIndex) {
    _antilogIndex = antilogIndex;
    notifyListeners();
  }

  int? _meanIndex;
  int? get meanIndex => _meanIndex;
  set meanIndex(int? meanIndex) {
    _meanIndex = meanIndex;
    notifyListeners();
  }

    String get value {
    if (_rowIndex == null || _antilogIndex == null) {
      return '';
    } else {
      final double log = Calculate.antiLogCell(_rowIndex!, _antilogIndex!).value;
      if (_meanIndex != null) {
        final String q = "${_rowIndex! / 100}$_antilogIndex$_meanIndex";
        final double mean = Calculate.meanACell(_rowIndex!, _meanIndex!).value;
        return "Antilog($q) = " + (log + mean).toStringAsFixed(3);
      } else {
        final String q = "${_rowIndex! / 10}$_antilogIndex";
        return "Antilog($q) = " + log.toString();
      }
    }
  }
}
