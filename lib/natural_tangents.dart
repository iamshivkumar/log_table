import 'models/log_data.dart';
import 'dart:math' as math;

class NaturalTangents {
  static double tan(int value, double number) {
    return math.tan((value + number) * math.pi / 180);
  }

  static double mean(int value, int minute) {
    return double.parse((tan(value, 0.5 + minute * 1 / 60) - tan(value, 0.5))
        .toStringAsFixed(4));
  }

  static Log tanCell(int value, double number) {
    final result = tan(value, number);
    final String prefix = number == 0.0 ? '.' : '';
    final fixed = result.toStringAsFixed(4);
    return Log(
      label: double.parse(fixed) >= 1
          ? double.parse(fixed).toStringAsFixed(i(double.parse(fixed)))
          : (prefix + fixed.split('.').last),
      value: result,
    );
  }

 static int i(double value){
    if(value>=100){
      return 1;
    } else if(value>=10){
      return 2;
    } else {
      return 3;
    }
  }

  static Mean meanCell(int value, int minute) {
    final result = mean(value, minute);
    if (value > 76) {
      return Mean(label: '', value: 0);
    }
    return Mean(
      label: int.parse(result.toStringAsFixed(4).split('.').last).toString(),
      value: result,
    );
  }
}
