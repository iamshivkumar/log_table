import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:log_table/sqrt2.dart';

final sqrt2ViewModelProvider = ChangeNotifierProvider((ref) => Sqrt2ViewModel());

class Sqrt2ViewModel extends ChangeNotifier {
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
      final double log = Sqrt2.logCell(_rowIndex!, _logIndex!).value;
      if (_meanIndex != null) {
        final String q = "${_rowIndex!}.$_logIndex$_meanIndex";
        final double mean = Sqrt2.meanCell(_rowIndex!, _meanIndex!).value;
        return "Sqrt($q) = " + (log + mean).toStringAsFixed(3);
      } else {
        final String q = "${_rowIndex!}.$_logIndex";

        return "Sqrt($q) = " + log.toString();
      }
    }
  }
}
