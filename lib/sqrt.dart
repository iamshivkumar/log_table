import 'dart:math' as math;

import 'models/log_data.dart';

class Sqrt {
  static double log(double value) {
    return math.sqrt(value);
  }

  static double mean(double value, int number) {
    final start = "$value${5}$number";
    final end = "$value${50}";
    return log(double.parse(start)) - log(double.parse(end));
  }

  static Log logCell(int value, int number) {
    final updated = double.parse("${value / 10}$number");
    final logResult = log(updated);
    return Log(
      label: (logResult).toStringAsFixed(3),
      value: double.parse(logResult.toStringAsFixed(3)),
    );
  }

  static Mean meanCell(int value, int number) {
    final meanResult = mean(value / 10, number);
    return Mean(
      label: (meanResult * 1000).toStringAsFixed(0),
      value: double.parse(meanResult.toStringAsFixed(3)),
    );
  }
}
