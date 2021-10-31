import 'dart:math' as math;

import 'package:log_table/models/log_data.dart';

class NaturalCosines {
  static double cos(int value, double number) {
    return math.cos((value + number) * math.pi / 180);
  }

  static double mean(int value, int minute) {
    return double.parse((cos(value, 0.5 + minute * 1 / 60) - cos(value, 0.5))
        .toStringAsFixed(4));
  }

  static Log cosCell(int value, double number) {
    final result = cos(value, number);
    final String prefix = number == 0.0 ? '.' : '';
    final fixed = result.toStringAsFixed(4);
    return Log(
      label: double.parse(fixed)>=1? double.parse(fixed).toStringAsFixed(3):(prefix + fixed.split('.').last),
      value: result,
    );
  }

  static Mean meanCell(int value, int minute) {
    final result = mean(value, minute);
    return Mean(
      label:"-"+ int.parse(result.toStringAsFixed(4).split('.').last).toString(),
      value: result,
    );
  }
}
