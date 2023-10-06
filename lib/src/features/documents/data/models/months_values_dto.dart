import '../enums/month_enum.dart';

class MonthValuesDTO {
  final Map<MonthEnum, double?> values;
  const MonthValuesDTO(this.values);

  double? get(MonthEnum month) => values[month];

  factory MonthValuesDTO.fromMap(Map<String, String> map) {
    final Map<MonthEnum, double?> values = {};
    for (final String key in map.keys) {
      final MonthEnum month = MonthEnum.values[int.parse(key)];
      final double? value = double.tryParse(map[key] ?? '');
      values[month] = value;
    }
    return MonthValuesDTO(values);
  }

  factory MonthValuesDTO.withDefaultValue(
      Set<MonthEnum> months, double? value) {
    final Map<MonthEnum, double?> values = {};
    for (final MonthEnum month in months) {
      values[month] = value;
    }
    return MonthValuesDTO(values);
  }

  factory MonthValuesDTO.empty() {
    return const MonthValuesDTO({});
  }

  Map<String, String> toMap() {
    final Map<String, String> map = {};
    for (final MonthEnum month in values.keys) {
      final String value = values[month]?.toStringAsFixed(2) ?? '';
      map[month.index.toString()] = value;
    }
    return map;
  }
}
