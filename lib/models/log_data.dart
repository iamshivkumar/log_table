import 'package:flutter/rendering.dart';

class Mean {
  final String label;
  final double value;
  Mean({
    required this.label,
    required this.value,
  });
}

class Log {
  final String label;
  final double value;
  Log({
    required this.label,
    required this.value,
  });
}

class Antilog {
  final String label;
  final double value;
  Antilog({
    required this.label,
    required this.value,
  });
}

class LogData {
  final String label;
  final double value;
  final bool rowSelected;
  final bool columnSelected;
  final String columnName;
  final VoidCallback onTap;
  
  LogData({
    required this.label,
    required this.value,
    required this.rowSelected,
    required this.columnSelected,
    required this.columnName,
    required this.onTap,
  });
}
