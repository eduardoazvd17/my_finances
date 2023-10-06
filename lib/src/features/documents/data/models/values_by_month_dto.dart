import 'package:equatable/equatable.dart';

import '../enums/month_enum.dart';

class ValuesByMonthDTO extends Equatable {
  final Map<MonthEnum, double?> data;
  const ValuesByMonthDTO(this.data);

  double? value(MonthEnum month) => data[month];

  factory ValuesByMonthDTO.fromMap(Map<String, String> map) {
    final Map<MonthEnum, double?> values = {};
    for (final String key in map.keys) {
      final MonthEnum month = MonthEnum.values[int.parse(key)];
      final double? value = double.tryParse(map[key] ?? '');
      values[month] = value;
    }
    return ValuesByMonthDTO(values);
  }

  factory ValuesByMonthDTO.fromMonths(Set<MonthEnum> months) {
    final Map<MonthEnum, double?> values = {};
    for (final MonthEnum month in months) {
      values.putIfAbsent(month, () => null);
    }
    return ValuesByMonthDTO(values);
  }

  ValuesByMonthDTO changeOnlyMonths(
    ValuesByMonthDTO? newValuesByMonth,
  ) {
    if (newValuesByMonth == null) return this;
    final Map<MonthEnum, double?> newValues = {};
    for (final MonthEnum month in newValuesByMonth.data.keys) {
      newValues[month] = value(month);
    }
    return ValuesByMonthDTO(newValues);
  }

  Map<String, String> toMap() {
    final Map<String, String> map = {};
    for (final MonthEnum month in data.keys) {
      final String value = data[month]?.toStringAsFixed(2) ?? '';
      map[month.index.toString()] = value;
    }
    return map;
  }

  @override
  List<Object?> get props => [data, data.keys, data.values];
}
