import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:log_table/natural_cosines.dart';

final naturalCosinesModelProvider = ChangeNotifierProvider(
  (ref) => NaturalCosinesViewModel(),
);

class NaturalCosinesViewModel extends ChangeNotifier {
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
          NaturalCosines.cosCell(_rowIndex!, _logIndex! / 10).value;
      if (_meanIndex != null) {
        final String q = "${_rowIndex}°${_logIndex! * 6 + _meanIndex!}'";
        final double mean =
            NaturalCosines.meanCell(_rowIndex!, _meanIndex!).value;
        return "cos($q) = " +
            (double.parse((log + mean).toStringAsFixed(4)) >= 1
                ? (log + mean).toStringAsFixed(3)
                : (log + mean).toStringAsFixed(4));
      } else {
        final String q = "${_rowIndex}°${_logIndex! * 6}'";
        return "cos($q) = " +
            (double.parse(log.toStringAsFixed(4)) >= 1
                ? log.toStringAsFixed(3)
                : log.toStringAsFixed(4));
      }
    }
  }
}
