import 'dart:math' as math;

import 'package:log_table/calculate.dart';

import 'models/log_data.dart';

class LogSines {
  static double logsin(int value, double number) {
    return Calculate.log(math.sin((value + number) * math.pi / 180));
  }

  static double mean(int value, int minute) {
    if (value < 4) {
      return 0;
    }
    return double.parse(
        (logsin(value, 0.5 + minute * 1 / 60) - logsin(value, 0.5))
            .toStringAsFixed(4));
  }

  static Log logsinCell(int value, double number) {
    final result = logsin(value, number);

    if (result < -1000000000000000000) {
      return Log(
        label: result.toString(),
        value: result,
      );
    }
    ;

    double v = result;
    int bar = 0;

    while (v < 0) {
      bar++;
      v++;
    }
    
    final String s = v.toStringAsFixed(4).split('.').last;

    final fixed = "${s.contains('0000') ? '0' : bar}.$s";
    return Log(
      label: fixed,
      value: result,
    );
  }

  // static isInfi

  static Mean meanCell(int value, int minute) {
    final result = mean(value, minute);
    return Mean(
      label: value < 4
          ? "-"
          : int.parse(result.toStringAsFixed(4).split('.').last).toString(),
      value: result,
    );
  }
}
