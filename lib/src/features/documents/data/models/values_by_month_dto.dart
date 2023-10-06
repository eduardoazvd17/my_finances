import 'package:equatable/equatable.dart';

import '../enums/month_enum.dart';

class ValuesByMonthDTO extends Equatable {
  final Map<MonthEnum, double?> values;
  const ValuesByMonthDTO(this.values);

  double? get(MonthEnum month) => values[month];

  factory ValuesByMonthDTO.fromMap(Map<String, String> map) {
    final Map<MonthEnum, double?> values = {};
    for (final String key in map.keys) {
      final MonthEnum month = MonthEnum.values[int.parse(key)];
      final double? value = double.tryParse(map[key] ?? '');
      values[month] = value;
    }
    return ValuesByMonthDTO(values);
  }

  factory ValuesByMonthDTO.withDefaultValue(
      Set<MonthEnum> months, double? value) {
    final Map<MonthEnum, double?> values = {};
    for (final MonthEnum month in months) {
      values[month] = value;
    }
    return ValuesByMonthDTO(values);
  }

  factory ValuesByMonthDTO.empty() {
    return const ValuesByMonthDTO({});
  }

  Map<String, String> toMap() {
    final Map<String, String> map = {};
    for (final MonthEnum month in values.keys) {
      final String value = values[month]?.toStringAsFixed(2) ?? '';
      map[month.index.toString()] = value;
    }
    return map;
  }

  @override
  List<Object?> get props => [values, values.keys, values.values];
}
