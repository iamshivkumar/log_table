import 'models/log_data.dart';

class Squares {
    static Log logCell(int value, int number) {
    final updated = double.parse("$value$number");
    final logResult = updated * updated;
    return Log(
      label: "${logResult.toInt()}",
      value: logResult,
    );
  }
}