import 'dart:math' as math;

import 'package:log_table/calculate.dart';

import 'models/log_data.dart';

class LogCosines {
  static double logcosin(int value, double number) {
    return Calculate.log(math.cos((value + number) * math.pi / 180));
  }

  static double mean(int value, int minute) {
    if (value < 4) {
      return 0;
    }
    return double.parse(
        (logcosin(value, 0.5 + minute * 1 / 60) - logcosin(value, 0.5))
            .toStringAsFixed(4));
  }

  static Log logcosinCell(int value, double number) {
    final result = logcosin(value, number);

    return Log(
      label: format(result),
      value: result,
    );
  }

  // static isInfi

  static Mean meanCell(int value, int minute) {
    final result = mean(value, minute);
    return Mean(
      label: value > 85
          ? "-"
          : int.parse(result.toStringAsFixed(4).split('.').last).toString(),
      value: result,
    );
  }

  static String format(double result) {
    if (result < -1000000000000000000) {
      return result.toString();
    }

    double v = result;
    int bar = 0;

    while (v < 0) {
      bar++;
      v++;
    }

    final String s = v.toStringAsFixed(4).split('.').last;

    return "${s.contains('0000') ? '0' : bar}.$s";
  }
}
