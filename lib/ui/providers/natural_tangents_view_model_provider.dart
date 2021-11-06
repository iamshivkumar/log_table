import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:log_table/natural_tangents.dart';

final naturalTangentsModelProvider = ChangeNotifierProvider(
  (ref) => NaturalSinesViewModel(),
);

class NaturalSinesViewModel extends ChangeNotifier {
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
          NaturalTangents.tanCell(_rowIndex!, _logIndex! / 10).value;
      if (_meanIndex != null) {
        final String q = "${_rowIndex}°${_logIndex! * 6 + _meanIndex!}'";
        final double mean =
            NaturalTangents.meanCell(_rowIndex!, _meanIndex!).value;
        return "tan($q) = " + 
            (double.parse((log + mean).toStringAsFixed(4)) >= 1
                ? (log + mean).toStringAsFixed(3)
                : (log + mean).toStringAsFixed(4));
      } else {
        final String q = "${_rowIndex}°${_logIndex! * 6}'";
        return "tan($q) = " +   (double.parse(log.toStringAsFixed(4)) >= 1
                ? log.toStringAsFixed(3)
                : log.toStringAsFixed(4));
      }
    }
  }
}
