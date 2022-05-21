import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:log_table/models/log_data.dart';
import 'package:log_table/squares.dart';

final squaresViewModelProvider = ChangeNotifierProvider((ref) => SquaresViewModel());

class SquaresViewModel extends ChangeNotifier {
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

  String get value {
    if (_rowIndex == null || _logIndex == null) {
      return '';
    } else {
      final Log log = Squares.logCell(_rowIndex!, _logIndex!);
      return "($rowIndex$logIndex)**2 = ${log.label}";
    }
  }
}
