import '../enums/month_enum.dart';

class MultipleMonthsValues {
  final Map<MonthEnum, double?> values;
  const MultipleMonthsValues(this.values);

  double? value(MonthEnum month) => values[month];

  factory MultipleMonthsValues.fromMap(Map<int, String> map) {
    final Map<MonthEnum, double?> values = {};
    for (final int key in map.keys) {
      final MonthEnum month = MonthEnum.values[key];
      final double? value = double.tryParse(map[key] ?? '');
      values[month] = value;
    }
    return MultipleMonthsValues(values);
  }

  Map<int, String> toMap() {
    final Map<int, String> map = {};
    for (final MonthEnum month in values.keys) {
      final String value = values[month]?.toStringAsFixed(2) ?? '';
      map[month.index] = value;
    }
    return map;
  }
}
