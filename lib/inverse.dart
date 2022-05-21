
import 'models/log_data.dart';

class Inverse {
  static double log(double value) {
    return 1/value;
  }

  static double mean(double value, int number) {
    final start = "$value${5}$number";
    final end = "$value${50}";
    return log(double.parse(end)) - log(double.parse(start));
  }

  static Log logCell(int value, int number) {
    final updated = double.parse("${value/10}$number");
    final logResult = log(updated);
    return Log(
      label: (logResult).toStringAsFixed(4),
      value: double.parse(logResult.toStringAsFixed(4)),
    );
  }

  static Mean meanCell(int value, int number) {
    final meanResult = mean(value/10, number);
    return Mean(
      label: (meanResult * 10000).toStringAsFixed(0),
      value: double.parse(meanResult.toStringAsFixed(4)),
    );
  }
}
