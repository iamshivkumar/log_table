import 'dart:math' as math;

import 'package:log_table/models/log_data.dart';

class Calculate {
  static double log(double value) {
    return math.log(value) / math.log(10);
  }

  static double antilog(double value) {
    return math.pow(10, value).toDouble();
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
      label: (logResult).toStringAsFixed(4).split(".").last,
      value: double.parse(logResult.toStringAsFixed(4)),
    );
  }

  static Mean meanCell(int value, int number) {
    final meanResult = mean(value / 10, number);
    return Mean(
      label: (meanResult * 10000).toStringAsFixed(0),
      value: double.parse(meanResult.toStringAsFixed(4)),
    );
  }

  static Antilog antiLogCell(int value, int number) {
    final updated = double.parse("${(value / 100).toStringAsFixed(2)}$number");
    final antilogResult = antilog(updated);
    return Antilog(
      value: double.parse(antilogResult.toStringAsFixed(3)),
      label: (antilogResult * 1000).toStringAsFixed(0),
    );
  }

  static double meanA(String value, int number) {
    final start = "$value${5}$number";
    final end = "$value${50}";
    return antilog(double.parse(start)) - antilog(double.parse(end));
  }

  static Mean meanACell(int value, int number) {
    final meanResult = meanA((value / 100).toStringAsFixed(2), number);
    return Mean(
      label: (meanResult * 1000).toStringAsFixed(0),
      value: double.parse(meanResult.toStringAsFixed(3)),
    );
  }
}
